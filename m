From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/11] ASoC: Clean up WM8731 bias level
	configuration
Date: Wed, 18 Feb 2009 12:02:26 +0000
Message-ID: <1234958553-16049-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CC0C210388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:41 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8731 bias level configuration function was written slightly
obscurely - streamline the code a little and refresh the comments.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 816e5bf..c6db677 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -396,21 +396,19 @@ static int wm8731_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg = wm8731_read_reg_cache(codec, WM8731_PWR) & 0xff7f;
+	u16 reg;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* vref/mid, osc on, dac unmute */
-		wm8731_write(codec, WM8731_PWR, reg);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* everything off except vref/vmid, */
+		/* Clear PWROFF, gate CLKOUT, everything else as-is */
+		reg = wm8731_read_reg_cache(codec, WM8731_PWR) & 0xff7f;
 		wm8731_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
-		/* everything off, dac mute, inactive */
 		wm8731_write(codec, WM8731_ACTIVE, 0x0);
 		wm8731_write(codec, WM8731_PWR, 0xffff);
 		break;
-- 
1.5.6.3
