From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: Fix a typo in the name of a constant" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:15 +0100 (BST)
Message-ID: <20190723112915.71C2D2742B60@ypsilon.sirena.org.uk>
References: <20190722211528.26600-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722211528.26600-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, gregkh@linuxfoundation.org, kernel-janitors@vger.kernel.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, peter.ujfalusi@ti.com, tglx@linutronix.de, tiwai@suse.com, wang@mentor.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: Fix a typo in the name of a constant

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From f8f85216f8d309daadb37aba8a4b0826783d8747 Mon Sep 17 00:00:00 2001
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 22 Jul 2019 23:15:28 +0200
Subject: [PATCH] ASoC: pcm3168a: Fix a typo in the name of a constant

There is a typo in PCM1368A_MAX_SYSCLK, it should be PCM3168A_MAX_SYSCLK
(1 and 3 switched in 3168)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190722211528.26600-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index f1104d7d6426..5d59ce254821 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -263,7 +263,7 @@ static unsigned int pcm3168a_scki_ratios[] = {
 #define PCM3168A_NUM_SCKI_RATIOS_DAC	ARRAY_SIZE(pcm3168a_scki_ratios)
 #define PCM3168A_NUM_SCKI_RATIOS_ADC	(ARRAY_SIZE(pcm3168a_scki_ratios) - 2)
 
-#define PCM1368A_MAX_SYSCLK		36864000
+#define PCM3168A_MAX_SYSCLK		36864000
 
 static int pcm3168a_reset(struct pcm3168a_priv *pcm3168a)
 {
@@ -296,7 +296,7 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(dai->component);
 	int ret;
 
-	if (freq > PCM1368A_MAX_SYSCLK)
+	if (freq > PCM3168A_MAX_SYSCLK)
 		return -EINVAL;
 
 	ret = clk_set_rate(pcm3168a->scki, freq);
-- 
2.20.1
