From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: Update the rtd query" to
	the asoc tree
Date: Fri, 20 Nov 2015 18:20:25 +0000
Message-ID: <E1ZzqIL-0003uP-2l@debutante>
References: <1448039720-1009-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0513A26669A
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:35 +0100 (CET)
In-Reply-To: <1448039720-1009-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: Update the rtd query

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 38f87d0172e485ce68a8e40e55afc0723ffa94f6 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 20 Nov 2015 22:45:20 +0530
Subject: [PATCH] ASoC: fsl-asoc-card: Update the rtd query

sound card rtd was an array and was updated to a list so update
the driver to use a list

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 1b05d1c5d9fd..ccbc9622a75b 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -414,14 +414,16 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd = list_first_entry(
+			&card->rtd_list, struct snd_soc_pcm_runtime, list);
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct codec_priv *codec_priv = &priv->codec_priv;
 	struct device *dev = card->dev;
 	int ret;
 
 	if (fsl_asoc_card_is_ac97(priv)) {
 #if IS_ENABLED(CONFIG_SND_AC97_CODEC)
-		struct snd_soc_codec *codec = card->rtd[0].codec;
+		struct snd_soc_codec *codec = rtd->codec;
 		struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 
 		/*
-- 
2.6.2
