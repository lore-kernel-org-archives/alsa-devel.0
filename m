From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/11] ASoC: twl4030: Introduce local ctl register cache
Date: Fri, 3 Jan 2014 15:27:52 +0200
Message-ID: <1388755676-16036-8-git-send-email-peter.ujfalusi@ti.com>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Few registers need to be cached in the codec driver level. These registers
should only be written when the path is active to avoid pop noise on the
given path.
This patch adds an array which covers the range where the sensitive registers
are located and uppon loadinf the driver the ctl cache will be initialized.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ab2f22299db2..f88207712d3d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -150,10 +150,22 @@ struct twl4030_priv {
 	u8 earpiece_enabled;
 	u8 predrivel_enabled, predriver_enabled;
 	u8 carkitl_enabled, carkitr_enabled;
+	u8 ctl_cache[TWL4030_REG_PRECKR_CTL - TWL4030_REG_EAR_CTL + 1];
 
 	struct twl4030_codec_data *pdata;
 };
 
+static void tw4030_init_ctl_cache(struct twl4030_priv *twl4030)
+{
+	int i;
+	u8 byte;
+
+	for (i = TWL4030_REG_EAR_CTL; i <= TWL4030_REG_PRECKR_CTL; i++) {
+		twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte, i);
+		twl4030->ctl_cache[i - TWL4030_REG_EAR_CTL] = byte;
+	}
+}
+
 /*
  * read twl4030 register cache
  */
@@ -348,6 +360,9 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 		}
 	}
 
+	/* Initialize the local ctl register cache */
+	tw4030_init_ctl_cache(twl4030);
+
 	/* Refresh APLL_CTL register from HW */
 	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
 			    TWL4030_REG_APLL_CTL);
-- 
1.8.5.2
