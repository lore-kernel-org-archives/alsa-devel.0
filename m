From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 11/11] ASoC: hdac: Add coefficient init
	callback for RT286
Date: Fri,  2 Sep 2016 16:35:00 +0530
Message-ID: <1472814300-5629-12-git-send-email-subhransu.s.prusty@intel.com>
References: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 3294126809B
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:11:01 +0200 (CEST)
In-Reply-To: <1472814300-5629-1-git-send-email-subhransu.s.prusty@intel.com>
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

Configure the combojack for rt286 with the init callback.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_generic.c | 39 ++++++++++++++++++++++++++++++++-------
 sound/soc/codecs/hdac_generic.h |  5 +++++
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdac_generic.c b/sound/soc/codecs/hdac_generic.c
index 6def114..0db01d5 100644
--- a/sound/soc/codecs/hdac_generic.c
+++ b/sound/soc/codecs/hdac_generic.c
@@ -41,6 +41,7 @@ struct hdac_generic_priv {
 	unsigned int num_adcs;
 	unsigned int num_dacs;
 	unsigned int num_dapm_widgets;
+	struct hdac_generic_vendor_ops *vendor_ops;
 };
 
 /*
@@ -1643,6 +1644,7 @@ static int hdac_generic_dev_probe(struct hdac_ext_device *edev)
 	struct hdac_device *codec = &edev->hdac;
 	struct hdac_generic_priv *hdac_priv;
 	struct snd_soc_dai_driver *codec_dais = NULL;
+	struct hdac_generic_vendor_ops *ops;
 	int num_dais = 0;
 	int ret = 0;
 
@@ -1672,19 +1674,42 @@ static int hdac_generic_dev_probe(struct hdac_ext_device *edev)
 		return ret;
 	}
 
+	/* codec specific init if any */
+	ops = (struct hdac_generic_vendor_ops *)edev->id_entry->driver_data;
+	if (ops && ops->init) {
+		ret = ops->init(edev);
+		if (ret < 0)
+			return ret;
+	}
+
+	hdac_priv->vendor_ops = ops;
+
 	/* ASoC specific initialization */
 	return snd_soc_register_codec(&codec->dev, &hdac_generic_codec,
 						codec_dais, num_dais);
 }
 
-/*
- * TODO:
- * Driver_data will be used to perform any vendor specific init, register
- * specific dai ops.
- * Driver will implement it's own match function to retrieve driver data.
- */
+static void write_def_coeffs(struct hdac_ext_device *edev)
+{
+	snd_hdac_codec_write(&edev->hdac, 0x20, 0,
+			AC_VERB_SET_COEF_INDEX, 0x4f);
+	snd_hdac_codec_write(&edev->hdac, 0x20, 0,
+			AC_VERB_SET_PROC_COEF, 0x5000);
+}
+
+int hdac_realtek_init(struct hdac_ext_device *edev)
+{
+	write_def_coeffs(edev);
+
+	return 0;
+}
+
+struct hdac_generic_vendor_ops realtek_ops = {
+	.init = hdac_realtek_init,
+};
+
 static const struct hda_device_id codec_list[] = {
-	HDA_CODEC_EXT_ENTRY(0x10ec0286, 0x100002, "ALC286", 0),
+	HDA_CODEC_EXT_ENTRY(0x10ec0286, 0x100002, "ALC286", &realtek_ops),
 	{}
 };
 MODULE_DEVICE_TABLE(hdaudio, codec_list);
diff --git a/sound/soc/codecs/hdac_generic.h b/sound/soc/codecs/hdac_generic.h
index 36eafbd..e7cd2e2 100644
--- a/sound/soc/codecs/hdac_generic.h
+++ b/sound/soc/codecs/hdac_generic.h
@@ -25,6 +25,11 @@
 #define AMP_OUT_UNMUTE		0xb000
 #define PIN_OUT			(AC_PINCTL_OUT_EN)
 
+struct hdac_generic_vendor_ops {
+	int (*init)(struct hdac_ext_device *edev);
+	int (*cleanup)(struct hdac_ext_device *edev);
+};
+
 int hdac_generic_machine_control_init(struct snd_soc_dapm_context *dapm,
 					struct snd_soc_codec *codec);
 
-- 
1.9.1
