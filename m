From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] soc - wm9712: Remove unneeded
	AC97_EXTENDED_MID updates
Date: Wed, 16 Apr 2008 10:57:50 +0100
Message-ID: <1208339870-29020-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0E46247A9
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 11:57:50 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9712.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 524f745..d2d79e1 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -581,22 +581,14 @@ static int wm9712_dapm_event(struct snd_soc_codec *codec, int event)
 
 	switch (event) {
 	case SNDRV_CTL_POWER_D0: /* full On */
-		/* liam - maybe enable thermal shutdown */
-		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0xdfff;
-		ac97_write(codec, AC97_EXTENDED_MID, reg);
-		break;
 	case SNDRV_CTL_POWER_D1: /* partial On */
 	case SNDRV_CTL_POWER_D2: /* partial On */
 		break;
 	case SNDRV_CTL_POWER_D3hot: /* Off, with power */
-		/* enable master bias and vmid */
-		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0xbbff;
-		ac97_write(codec, AC97_EXTENDED_MID, reg);
 		ac97_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
 	case SNDRV_CTL_POWER_D3cold: /* Off, without power */
 		/* disable everything including AC link */
-		ac97_write(codec, AC97_EXTENDED_MID, 0xffff);
 		ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
 		ac97_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
-- 
1.5.5
