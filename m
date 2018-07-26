From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: Use snd_mask_set_format()" to the
	asoc tree
Date: Thu, 26 Jul 2018 17:11:29 +0100 (BST)
Message-ID: <20180726161129.E893E440080@finisterre.ee.mobilebroadband>
References: <20180725211722.18944-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9972626779D
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:42 +0200 (CEST)
In-Reply-To: <20180725211722.18944-5-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: Use snd_mask_set_format()

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

>From ebc22af0c9268dc4032326c20b02f2f227203330 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 23:17:20 +0200
Subject: [PATCH] ASoC: fsl: Use snd_mask_set_format()

Use the new helper function snd_mask_set_format() for avoiding the
ugly cast with __force prefix.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 07808c6d5461..44433b20435c 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -195,7 +195,7 @@ static int be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	snd_mask_none(mask);
-	snd_mask_set(mask, (__force int)priv->asrc_format);
+	snd_mask_set_format(mask, priv->asrc_format);
 
 	return 0;
 }
-- 
2.18.0
