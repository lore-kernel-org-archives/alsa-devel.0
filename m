From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: blackfin: Fix missing break
Date: Wed, 13 Nov 2013 17:15:00 +0100
Message-ID: <1384359300-21219-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D04F264FFF
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 17:15:00 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60768
Fixes: 4b2ffc205cb9 ('ASoC: Blackfin I2S: add 8-bit sample support')
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/blackfin/bf5xx-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 9a174fc47d39..39d774839b3e 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -121,6 +121,7 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		bf5xx_i2s->tcr2 |= 7;
 		bf5xx_i2s->rcr2 |= 7;
 		sport_handle->wdsize = 1;
+		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bf5xx_i2s->tcr2 |= 15;
 		bf5xx_i2s->rcr2 |= 15;
-- 
1.8.4.2
