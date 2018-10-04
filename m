From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ASoC: pcm186x: Use the standard
	fall-through annotation
Date: Thu,  4 Oct 2018 20:30:03 +0200
Message-ID: <20181004183006.23983-3-tiwai@suse.de>
References: <20181004183006.23983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3D626783D
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:30:09 +0200 (CEST)
In-Reply-To: <20181004183006.23983-1-tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation.
Unfortunately gcc doesn't understand the mixed comment lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/pcm186x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 690c26e7389e..809b7e9f03ca 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -401,7 +401,8 @@ static int pcm186x_set_fmt(struct snd_soc_dai *dai, unsigned int format)
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		priv->tdm_offset += 1;
-		/* Fall through... DSP_A uses the same basic config as DSP_B
+		/* fall through */
+		/* DSP_A uses the same basic config as DSP_B
 		 * except we need to shift the TDM output by one BCK cycle
 		 */
 	case SND_SOC_DAIFMT_DSP_B:
-- 
2.18.0
