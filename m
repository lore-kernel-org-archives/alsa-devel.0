From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Drop use of audio component
	framework to read ELD" to the asoc tree
Date: Mon, 26 Sep 2016 09:15:41 -0700
Message-ID: <E1boYZB-0005Q4-AS@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC0526673A
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:15:53 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Drop use of audio component framework to read ELD

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 88b456b0f4a2a4c10c141a7d83113a8ce2164463 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 26 Sep 2016 08:59:50 -0700
Subject: [PATCH] ASoC: hdac_hdmi: Drop use of audio component framework to
 read ELD

The audio component framework code has not yet landed in the i915 driver
so drop the use of the API for the time being.

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 201 +++++++++++++++++++++++++++++++------------
 1 file changed, 145 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 537f61aa27fa..4e181b270d95 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -46,10 +46,6 @@
 #define ELD_MAX_SIZE    256
 #define ELD_FIXED_BYTES	20
 
-#define ELD_VER_CEA_861D 2
-#define ELD_VER_PARTIAL 31
-#define ELD_MAX_MNL     16
-
 struct hdac_hdmi_cvt_params {
 	unsigned int channels_min;
 	unsigned int channels_max;
@@ -85,6 +81,8 @@ struct hdac_hdmi_pin {
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	struct hdac_hdmi_eld eld;
 	struct hdac_ext_device *edev;
+	int repoll_count;
+	struct delayed_work work;
 	struct mutex lock;
 	bool chmap_set;
 	unsigned char chmap[8]; /* ALSA API channel-map */
@@ -175,6 +173,80 @@ static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
 
 }
 
+ /* HDMI ELD routines */
+static unsigned int hdac_hdmi_get_eld_data(struct hdac_device *codec,
+				hda_nid_t nid, int byte_index)
+{
+	unsigned int val;
+
+	val = snd_hdac_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_ELDD,
+							byte_index);
+
+	dev_dbg(&codec->dev, "HDMI: ELD data byte %d: 0x%x\n",
+					byte_index, val);
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
+ * This function queries the ELD size and ELD data and fills in the buffer
+ * passed by user
+ */
+static int hdac_hdmi_get_eld(struct hdac_device *codec, hda_nid_t nid,
+			     unsigned char *buf, int *eld_size)
+{
+	int i, size, ret = 0;
+
+	/*
+	 * ELD size is initialized to zero in caller function. If no errors and
+	 * ELD is valid, actual eld_size is assigned.
+	 */
+
+	size = hdac_hdmi_get_eld_size(codec, nid);
+	if (size < ELD_FIXED_BYTES || size > ELD_MAX_SIZE) {
+		dev_err(&codec->dev, "HDMI: invalid ELD buf size %d\n", size);
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
+			dev_err(&codec->dev,
+				"HDMI: invalid ELD data byte %d\n", i);
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
+			dev_err(&codec->dev, "HDMI: 0 ELD data\n");
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
@@ -987,59 +1059,32 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 	return hdac_hdmi_query_cvt_params(&edev->hdac, cvt);
 }
 
-static int  hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
+static void hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
 			struct hdac_hdmi_pin *pin)
 {
-	unsigned int ver, mnl;
-
-	ver = (pin->eld.eld_buffer[DRM_ELD_VER] & DRM_ELD_VER_MASK)
-						>> DRM_ELD_VER_SHIFT;
-
-	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
-		dev_dbg(&edev->hdac.dev, "HDMI: Unknown ELD version %d\n", ver);
-		return -EINVAL;
-	}
-
-	mnl = (pin->eld.eld_buffer[DRM_ELD_CEA_EDID_VER_MNL] &
-		DRM_ELD_MNL_MASK) >> DRM_ELD_MNL_SHIFT;
-
-	if (mnl > ELD_MAX_MNL) {
-		dev_dbg(&edev->hdac.dev, "HDMI: MNL Invalid %d\n", mnl);
-		return -EINVAL;
-	}
-
 	pin->eld.info.spk_alloc = pin->eld.eld_buffer[DRM_ELD_SPEAKER];
-
-	return 0;
 }
 
-static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin)
+static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 {
 	struct hdac_ext_device *edev = pin->edev;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
-	int size;
+	int val;
 
-	mutex_lock(&hdmi->pin_mutex);
-	pin->eld.monitor_present = false;
+	pin->repoll_count = repoll;
 
-	size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, -1,
-				&pin->eld.monitor_present, pin->eld.eld_buffer,
-				ELD_MAX_SIZE);
+	pm_runtime_get_sync(&edev->hdac.dev);
+	val = snd_hdac_codec_read(&edev->hdac, pin->nid, 0,
+					AC_VERB_GET_PIN_SENSE, 0);
 
-	if (size > 0) {
-		size = min(size, ELD_MAX_SIZE);
-		if (hdac_hdmi_parse_eld(edev, pin) < 0)
-			size = -EINVAL;
-	}
+	dev_dbg(&edev->hdac.dev, "Pin sense val %x for pin: %d\n",
+						val, pin->nid);
 
-	if (size > 0) {
-		pin->eld.eld_valid = true;
-		pin->eld.eld_size = size;
-	} else {
-		pin->eld.eld_valid = false;
-		pin->eld.eld_size = 0;
-	}
+
+	mutex_lock(&hdmi->pin_mutex);
+	pin->eld.monitor_present = !!(val & AC_PINSENSE_PRESENCE);
+	pin->eld.eld_valid = !!(val & AC_PINSENSE_ELDV);
 
 	pcm = hdac_hdmi_get_pcm(edev, pin);
 
@@ -1061,23 +1106,66 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin)
 		}
 
 		mutex_unlock(&hdmi->pin_mutex);
-		return;
+		goto put_hdac_device;
 	}
 
 	if (pin->eld.monitor_present && pin->eld.eld_valid) {
-		if (pcm) {
-			dev_dbg(&edev->hdac.dev,
-				"jack report for pcm=%d\n",
-				pcm->pcm_id);
+		/* TODO: use i915 component for reading ELD later */
+		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
+				pin->eld.eld_buffer,
+				&pin->eld.eld_size) == 0) {
 
-			snd_jack_report(pcm->jack, SND_JACK_AVOUT);
-		}
+			if (pcm) {
+				dev_dbg(&edev->hdac.dev,
+					"jack report for pcm=%d\n",
+					pcm->pcm_id);
+
+				snd_jack_report(pcm->jack, SND_JACK_AVOUT);
+			}
+			hdac_hdmi_parse_eld(edev, pin);
+
+			print_hex_dump_debug("ELD: ",
+					DUMP_PREFIX_OFFSET, 16, 1,
+					pin->eld.eld_buffer, pin->eld.eld_size,
+					true);
+		} else {
+			pin->eld.monitor_present = false;
+			pin->eld.eld_valid = false;
+
+			if (pcm) {
+				dev_dbg(&edev->hdac.dev,
+					"jack report for pcm=%d\n",
+					pcm->pcm_id);
 
-		print_hex_dump_debug("ELD: ", DUMP_PREFIX_OFFSET, 16, 1,
-			  pin->eld.eld_buffer, pin->eld.eld_size, false);
+				snd_jack_report(pcm->jack, 0);
+			}
+		}
 	}
 
 	mutex_unlock(&hdmi->pin_mutex);
+
+	/*
+	 * Sometimes the pin_sense may present invalid monitor
+	 * present and eld_valid. If ELD data is not valid, loop few
+	 * more times to get correct pin sense and valid ELD.
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
+	/* picked from legacy HDA driver */
+	if (pin->repoll_count++ > 6)
+		pin->repoll_count = 0;
+
+	hdac_hdmi_present_sense(pin, pin->repoll_count);
 }
 
 static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
@@ -1096,6 +1184,7 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 
 	pin->edev = edev;
 	mutex_init(&pin->lock);
+	INIT_DELAYED_WORK(&pin->work, hdac_hdmi_repoll_eld);
 
 	return 0;
 }
@@ -1306,7 +1395,7 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port)
 
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
 		if (pin->nid == pin_nid)
-			hdac_hdmi_present_sense(pin);
+			hdac_hdmi_present_sense(pin, 1);
 	}
 }
 
@@ -1407,7 +1496,7 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	list_for_each_entry(pin, &hdmi->pin_list, head)
-		hdac_hdmi_present_sense(pin);
+		hdac_hdmi_present_sense(pin, 1);
 
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
@@ -1472,7 +1561,7 @@ static void hdmi_codec_complete(struct device *dev)
 	 * all pins here.
 	 */
 	list_for_each_entry(pin, &hdmi->pin_list, head)
-		hdac_hdmi_present_sense(pin);
+		hdac_hdmi_present_sense(pin, 1);
 
 	pm_runtime_put_sync(&edev->hdac.dev);
 }
-- 
2.9.3
