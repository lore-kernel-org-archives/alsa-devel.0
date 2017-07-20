From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Add the vendor nid for
	Geminilake HDMI" to the asoc tree
Date: Thu, 20 Jul 2017 13:23:54 +0100
Message-ID: <E1dYAUk-00018t-FY@debutante>
References: <1500304529-25804-3-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FB98266CC9
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 14:24:03 +0200 (CEST)
In-Reply-To: <1500304529-25804-3-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Add the vendor nid for Geminilake HDMI

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

>From 5622bc955898f4d5fa2ce8f507e5991b08367824 Mon Sep 17 00:00:00 2001
From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Date: Thu, 20 Jul 2017 11:40:56 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Add the vendor nid for Geminilake HDMI

Geminilake HDMI codec has the different vendor nid. This patch adds the
vendor nid as the part of driver data and uses it.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index bc2e74ff3b2d..eb3ed8c5ed30 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -121,6 +121,10 @@ struct hdac_hdmi_dai_port_map {
 	struct hdac_hdmi_cvt *cvt;
 };
 
+struct hdac_hdmi_drv_data {
+	unsigned int vendor_nid;
+};
+
 struct hdac_hdmi_priv {
 	struct hdac_hdmi_dai_port_map dai_map[HDA_MAX_CVTS];
 	struct list_head pin_list;
@@ -131,6 +135,7 @@ struct hdac_hdmi_priv {
 	int num_ports;
 	struct mutex pin_mutex;
 	struct hdac_chmap chmap;
+	struct hdac_hdmi_drv_data *drv_data;
 };
 
 static struct hdac_hdmi_pcm *
@@ -1321,6 +1326,7 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 }
 
 #define INTEL_VENDOR_NID 0x08
+#define INTEL_GLK_VENDOR_NID 0x0b
 #define INTEL_GET_VENDOR_VERB 0xf81
 #define INTEL_SET_VENDOR_VERB 0x781
 #define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
@@ -1329,14 +1335,17 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdac)
 {
 	unsigned int vendor_param;
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	unsigned int vendor_nid = hdmi->drv_data->vendor_nid;
 
-	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hdac_codec_read(hdac, vendor_nid, 0,
 				INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
 		return;
 
 	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
-	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hdac_codec_read(hdac, vendor_nid, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 	if (vendor_param == -1)
 		return;
@@ -1345,15 +1354,18 @@ static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdac)
 static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
 {
 	unsigned int vendor_param;
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	unsigned int vendor_nid = hdmi->drv_data->vendor_nid;
 
-	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hdac_codec_read(hdac, vendor_nid, 0,
 				INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
 		return;
 
 	/* enable DP1.2 mode */
 	vendor_param |= INTEL_EN_DP12;
-	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hdac_codec_read(hdac, vendor_nid, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 	if (vendor_param == -1)
 		return;
@@ -1927,6 +1939,14 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 	return port->eld.info.spk_alloc;
 }
 
+static struct hdac_hdmi_drv_data intel_glk_drv_data  = {
+	.vendor_nid = INTEL_GLK_VENDOR_NID,
+};
+
+static struct hdac_hdmi_drv_data intel_drv_data  = {
+	.vendor_nid = INTEL_VENDOR_NID,
+};
+
 static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 {
 	struct hdac_device *codec = &edev->hdac;
@@ -1935,6 +1955,8 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	struct hdac_ext_link *hlink = NULL;
 	int num_dais = 0;
 	int ret = 0;
+	struct hdac_driver *hdrv = drv_to_hdac_driver(codec->dev.driver);
+	const struct hda_device_id *hdac_id = hdac_get_device_id(codec, hdrv);
 
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdac.dev));
@@ -1956,6 +1978,12 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	hdmi_priv->chmap.ops.is_pcm_attached = is_hdac_hdmi_pcm_attached;
 	hdmi_priv->chmap.ops.get_spk_alloc = hdac_hdmi_get_spk_alloc;
 
+	if (hdac_id->driver_data)
+		hdmi_priv->drv_data =
+			(struct hdac_hdmi_drv_data *)hdac_id->driver_data;
+	else
+		hdmi_priv->drv_data = &intel_drv_data;
+
 	dev_set_drvdata(&codec->dev, edev);
 
 	INIT_LIST_HEAD(&hdmi_priv->pin_list);
@@ -2127,7 +2155,8 @@ static const struct hda_device_id hdmi_list[] = {
 	HDA_CODEC_EXT_ENTRY(0x80862809, 0x100000, "Skylake HDMI", 0),
 	HDA_CODEC_EXT_ENTRY(0x8086280a, 0x100000, "Broxton HDMI", 0),
 	HDA_CODEC_EXT_ENTRY(0x8086280b, 0x100000, "Kabylake HDMI", 0),
-	HDA_CODEC_EXT_ENTRY(0x8086280d, 0x100000, "Geminilake HDMI", 0),
+	HDA_CODEC_EXT_ENTRY(0x8086280d, 0x100000, "Geminilake HDMI",
+						   &intel_glk_drv_data),
 	{}
 };
 
-- 
2.13.2
