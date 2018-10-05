From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm186x: Use the standard fall-through
	annotation" to the asoc tree
Date: Fri,  5 Oct 2018 14:26:28 +0100 (BST)
Message-ID: <20181005132628.90268112229A@debutante.sirena.org.uk>
References: <20181004183006.23983-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2AA267942
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 15:26:29 +0200 (CEST)
In-Reply-To: <20181004183006.23983-3-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm186x: Use the standard fall-through annotation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 641f7f2195735b4fe93b541ea3a792fe4fee2415 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 4 Oct 2018 20:30:03 +0200
Subject: [PATCH] ASoC: pcm186x: Use the standard fall-through annotation

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation.
Unfortunately gcc doesn't understand the mixed comment lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
