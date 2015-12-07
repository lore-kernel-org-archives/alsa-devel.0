From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 04/15] ASoC: hdac_hdmi: Add hotplug
	notification and read eld
Date: Tue,  8 Dec 2015 02:54:18 +0530
Message-ID: <1449523469-4395-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B01326070C
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:04 +0100 (CET)
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch uses i915 component framework to register for hotplug
notification. And once it identifies valid pin sense and valid eld,
reads the eld into the corresponding pin map buffer. For now it
directly sends the verbs and reads the eld. Later this will use
the i915 framework to populate ELD buffer once available.

The eld reading APIs in legacy hda are required for ASoC skylake
hdmi driver as well. So keeping a copy here and will remove once
component ops for reading ELD are merged in hda core.

Also read the monitor present sense during resume and ignore the
ELD notify from graphics during PM as is done in legacy hda,
commit 8ae743e82f0b ("ALSA: hda - Skip ELD notification during
system suspend")

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 216 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index b206d5e..b9d300d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -34,6 +34,9 @@
 
 #define HDA_MAX_CONNECTIONS     32
 
+#define ELD_MAX_SIZE    256
+#define ELD_FIXED_BYTES	20
+
 struct hdac_hdmi_cvt_params {
 	unsigned int channels_min;
 	unsigned int channels_max;
@@ -48,11 +51,22 @@ struct hdac_hdmi_cvt {
 	struct hdac_hdmi_cvt_params params;
 };
 
+struct hdmi_eld {
+	bool	monitor_present;
+	bool	eld_valid;
+	int	eld_size;
+	char    eld_buffer[ELD_MAX_SIZE];
+};
+
 struct hdac_hdmi_pin {
 	struct list_head head;
 	hda_nid_t nid;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
+	struct hdmi_eld eld;
+	struct hdac_ext_device *edev;
+	int repoll_count;
+	struct delayed_work work;
 };
 
 struct hdac_hdmi_dai_pin_map {
@@ -76,6 +90,81 @@ static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 	return container_of(hdac, struct hdac_ext_device, hdac);
 }
 
+ /* HDMI Eld routines */
+static unsigned int hdac_hdmi_get_eld_data(struct hdac_device *codec,
+				hda_nid_t nid, int byte_index)
+{
+	unsigned int val;
+
+	val = snd_hdac_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_ELDD,
+							byte_index);
+
+	dev_dbg(&codec->dev, "HDMI: ELD data byte %d: 0x%x\n",
+			byte_index, val);
+
+	return val;
+}
+
+static int hdac_hdmi_get_eld_size(struct hdac_device *codec, hda_nid_t nid)
+{
+	return snd_hdac_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_DIP_SIZE,
+						 AC_DIPSIZE_ELD_BUF);
+}
+
+/*
+ * This function queries the eld size and eld data and fills in the buffer
+ * passed by user
+ */
+static int hdac_hdmi_get_eld(struct hdac_device *codec, hda_nid_t nid,
+		     unsigned char *buf, int *eld_size)
+{
+	int i;
+	int ret = 0;
+	int size;
+
+	/*
+	 * ELD size is initialized to zero in caller function. If no errors and
+	 * ELD is valid, actual eld_size is assigned.
+	 */
+
+	size = hdac_hdmi_get_eld_size(codec, nid);
+	if (size < ELD_FIXED_BYTES || size > ELD_MAX_SIZE) {
+		dev_info(&codec->dev, "HDMI: invalid ELD buf size %d\n", size);
+		return -ERANGE;
+	}
+
+	/* set ELD buffer */
+	for (i = 0; i < size; i++) {
+		unsigned int val = hdac_hdmi_get_eld_data(codec, nid, i);
+		/*
+		 * Graphics driver might be writing to ELD buffer right now.
+		 * Just abort. The caller will repoll after a while.
+		 */
+		if (!(val & AC_ELDD_ELD_VALID)) {
+			dev_info(&codec->dev, "HDMI: invalid ELD data byte %d\n", i);
+			ret = -EINVAL;
+			goto error;
+		}
+		val &= AC_ELDD_ELD_DATA;
+		/*
+		 * The first byte cannot be zero. This can happen on some DVI
+		 * connections. Some Intel chips may also need some 250ms delay
+		 * to return non-zero ELD data, even when the graphics driver
+		 * correctly writes ELD content before setting ELD_valid bit.
+		 */
+		if (!val && !i) {
+			dev_dbg(&codec->dev, "HDMI: 0 ELD data\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		buf[i] = val;
+	}
+
+	*eld_size = size;
+error:
+	return ret;
+}
+
 static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac,
 				hda_nid_t cvt_nid, hda_nid_t pin_nid,
 				u32 stream_tag, int format)
@@ -246,7 +335,6 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_pin_map *dai_map;
-	int val;
 
 	if (dai->id > 0) {
 		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
@@ -255,12 +343,11 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	val = snd_hdac_codec_read(&hdac->hdac, dai_map->pin->nid, 0,
-					AC_VERB_GET_PIN_SENSE, 0);
-	dev_info(&hdac->hdac.dev, "Val for AC_VERB_GET_PIN_SENSE: %x\n", val);
-
-	if ((!(val & AC_PINSENSE_PRESENCE)) || (!(val & AC_PINSENSE_ELDV))) {
-		dev_err(&hdac->hdac.dev, "Monitor presence invalid with val: %x\n", val);
+	if ((!dai_map->pin->eld.monitor_present) ||
+		(!dai_map->pin->eld.eld_valid)) {
+		dev_err(&hdac->hdac.dev, "Failed: montior present? %d eld valid?: %d\n",
+				dai_map->pin->eld.monitor_present,
+				dai_map->pin->eld.eld_valid);
 		return -ENODEV;
 	}
 
@@ -432,6 +519,70 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 	return hdac_hdmi_query_cvt_params(&edev->hdac, cvt);
 }
 
+static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
+{
+	struct hdac_ext_device *edev = pin->edev;
+	int val;
+
+	if (!edev)
+		return;
+
+	pin->repoll_count = repoll;
+
+	pm_runtime_get_sync(&edev->hdac.dev);
+	val = snd_hdac_codec_read(&edev->hdac, pin->nid, 0,
+					AC_VERB_GET_PIN_SENSE, 0);
+
+	dev_dbg(&edev->hdac.dev, "Pin sense val %x for pin: %d\n",
+			val, pin->nid);
+	pin->eld.monitor_present = !!(val & AC_PINSENSE_PRESENCE);
+	pin->eld.eld_valid = !!(val & AC_PINSENSE_ELDV);
+
+	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
+		dev_info(&edev->hdac.dev, "%s: disconnect or eld_invalid\n",
+				__func__);
+		goto put_hdac_device;
+	}
+
+	if (pin->eld.monitor_present && pin->eld.eld_valid) {
+		/* TODO: Use i915 cmpnt framework when available */
+		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
+				pin->eld.eld_buffer,
+				&pin->eld.eld_size) == 0) {
+			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
+					pin->eld.eld_buffer, pin->eld.eld_size);
+		} else {
+			dev_err(&edev->hdac.dev, "ELD invalid\n");
+			pin->eld.monitor_present = false;
+			pin->eld.eld_valid = false;
+		}
+
+	}
+
+	/*
+	 * Sometimes the pin_sense may present invalid monitor
+	 * present and eld_valid. If eld data is not valid loop, few
+	 * more times to get correct pin sense and valid eld.
+	 */
+	if ((!pin->eld.monitor_present || !pin->eld.eld_valid) && repoll)
+		schedule_delayed_work(&pin->work, msecs_to_jiffies(300));
+
+put_hdac_device:
+	pm_runtime_put_sync(&edev->hdac.dev);
+}
+
+static void hdac_hdmi_repoll_eld(struct work_struct *work)
+{
+	struct hdac_hdmi_pin *pin =
+		container_of(to_delayed_work(work), struct hdac_hdmi_pin, work);
+
+	/* picked from legacy */
+	if (pin->repoll_count++ > 6)
+		pin->repoll_count = 0;
+
+	hdac_hdmi_present_sense(pin, pin->repoll_count);
+}
+
 static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
@@ -446,6 +597,9 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 	list_add_tail(&pin->head, &hdmi->pin_list);
 	hdmi->num_pin++;
 
+	pin->edev = edev;
+	INIT_DELAYED_WORK(&pin->work, hdac_hdmi_repoll_eld);
+
 	return 0;
 }
 
@@ -504,17 +658,64 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	return hdac_hdmi_init_dai_map(edev);
 }
 
+static void hdac_hdmi_eld_notify_cb(void *aptr, int port)
+{
+	struct hdac_ext_device *edev = aptr;
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin;
+	struct snd_soc_codec *codec = edev->scodec;
+	/* Don't know how this mapping is derived */
+	hda_nid_t pin_nid = port + 0x04;
+
+	dev_dbg(&edev->hdac.dev, "%s: for pin: %d\n", __func__, pin_nid);
+
+	/*
+	 * skip notification during system suspend (but not in runtime PM);
+	 * the state will be updated at resume. Also since the ELD and
+	 * connection states are updated in anyway at the end of the resume,
+	 * we can skip it when received during PM process.
+	 */
+	if (snd_power_get_state(codec->component.card->snd_card) !=
+			SNDRV_CTL_POWER_D0)
+		return;
+
+	if (atomic_read(&edev->hdac.in_pm))
+		return;
+
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		if (pin->nid == pin_nid)
+			hdac_hdmi_present_sense(pin, 1);
+	}
+}
+
+static struct i915_audio_component_audio_ops aops = {
+	.pin_eld_notify	= hdac_hdmi_eld_notify_cb,
+};
+
 static int hdmi_codec_probe(struct snd_soc_codec *codec)
 {
 	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
+	struct hdac_hdmi_pin *pin;
+	int ret;
 
 	edev->scodec = codec;
 
 	create_fill_widget_route_map(dapm, &hdmi->dai_map[0]);
 
+	aops.audio_ptr = edev;
+	ret = snd_hdac_i915_register_notifier(&aops);
+	if (ret < 0) {
+		dev_err(&edev->hdac.dev, "notifier register failed: err: %d\n",
+				ret);
+		return ret;
+	}
+
+	list_for_each_entry(pin, &hdmi->pin_list, head)
+		hdac_hdmi_present_sense(pin, 1);
+
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
 
@@ -659,6 +860,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 	if (!bus)
 		return 0;
 
+
 	err = snd_hdac_display_power(bus, true);
 	if (err < 0) {
 		dev_err(bus->dev, "Cannot turn on display power on i915\n");
-- 
1.9.1
