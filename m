From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH] ASoC: codecs: tas2552: fix dBscale-min declaration
Date: Mon, 5 Oct 2015 15:00:14 -0500
Message-ID: <1444075214-21206-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Axel Lin <axel.lin@ingics.com>, Lars-Peter Clausen <lars@metafoo.de>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>
List-Id: alsa-devel@alsa-project.org

The minimum volume level for the TAS2552 (control register value 0x00)
is -7dB however the driver declares it as -0.07dB.

Running amixer before the patch reports:
dBscale-min=-0.07dB,step=1.00dB,mute=0

Running amixer with the patch applied reports:
dBscale-min=-7.00dB,step=1.00dB,mute=0

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 sound/soc/codecs/tas2552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index e3a0bca..cc1d398 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -549,7 +549,7 @@ static struct snd_soc_dai_driver tas2552_dai[] = {
 /*
  * DAC digital volumes. From -7 to 24 dB in 1 dB steps
  */
-static DECLARE_TLV_DB_SCALE(dac_tlv, -7, 100, 0);
+static DECLARE_TLV_DB_SCALE(dac_tlv, -700, 100, 0);
 
 static const char * const tas2552_din_source_select[] = {
 	"Muted",
-- 
1.9.1

