From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: use different route map
	for AC'97 mode" to the asoc tree
Date: Wed, 23 Dec 2015 00:08:52 +0000
Message-ID: <E1aBWz6-0007Hw-BG@debutante>
References: <567710D5.5040405@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC2DC265DCB
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:04 +0100 (CET)
In-Reply-To: <567710D5.5040405@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: use different route map for AC'97 mode

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

>From 25e5ef974c33f1e4a07a68bf830e6493ee6dab11 Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Sun, 20 Dec 2015 21:34:29 +0100
Subject: [PATCH] ASoC: fsl-asoc-card: use different route map for AC'97 mode

fsl_ssi uses different stream names ("AC97 Playback" / "AC97 Capture")
in AC'97 mode so in this case fsl-asoc-card route map should
also be using them.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 1b05d1c5d9fd..6fb3aed91b44 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -107,6 +107,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"CPU-Capture",  NULL, "Capture"},
 };
 
+static const struct snd_soc_dapm_route audio_map_ac97[] = {
+	{"AC97 Playback",  NULL, "ASRC-Playback"},
+	{"Playback",  NULL, "AC97 Playback"},
+	{"ASRC-Capture",  NULL, "AC97 Capture"},
+	{"AC97 Capture",  NULL, "Capture"},
+};
+
 /* Add all possible widgets into here without being redundant */
 static const struct snd_soc_dapm_widget fsl_asoc_card_dapm_widgets[] = {
 	SND_SOC_DAPM_LINE("Line Out Jack", NULL),
@@ -574,7 +581,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dev = &pdev->dev;
 	priv->card.name = priv->name;
 	priv->card.dai_link = priv->dai_link;
-	priv->card.dapm_routes = audio_map;
+	priv->card.dapm_routes = fsl_asoc_card_is_ac97(priv) ?
+				 audio_map_ac97 : audio_map;
 	priv->card.late_probe = fsl_asoc_card_late_probe;
 	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
 	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
-- 
2.6.2
