From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 11/11] ASoC: twl4030: Pass the twl4030_priv directly to twl4030_can_write_to_chip()
Date: Fri, 3 Jan 2014 15:27:56 +0200
Message-ID: <1388755676-16036-12-git-send-email-peter.ujfalusi@ti.com>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

To avoid another lookup for the twl4030_priv in there.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c3c15f891270..00665ada23e2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -111,10 +111,9 @@ static unsigned int twl4030_read(struct snd_soc_codec *codec, unsigned int reg)
 	return value;
 }
 
-static bool twl4030_can_write_to_chip(struct snd_soc_codec *codec,
+static bool twl4030_can_write_to_chip(struct twl4030_priv *twl4030,
 				      unsigned int reg)
 {
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	bool write_to_reg = false;
 
 	/* Decide if the given register can be written */
@@ -171,7 +170,7 @@ static int twl4030_write(struct snd_soc_codec *codec, unsigned int reg,
 		break;
 	}
 
-	if (twl4030_can_write_to_chip(codec, reg))
+	if (twl4030_can_write_to_chip(twl4030, reg))
 		return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value, reg);
 
 	return 0;
-- 
1.8.5.2
