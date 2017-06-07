From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: Improve counting DAI number" to
	the asoc tree
Date: Wed, 07 Jun 2017 20:31:36 +0100
Message-ID: <E1dIgg4-0003c8-Pe@debutante>
References: <1496813940-6053-1-git-send-email-ryo.kodama.vz@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 178812671DE
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 21:31:43 +0200 (CEST)
In-Reply-To: <1496813940-6053-1-git-send-email-ryo.kodama.vz@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryo Kodama <ryo.kodama.vz@renesas.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: Improve counting DAI number

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

>From 411652982a20ab60957283e9084c81d791cb69f9 Mon Sep 17 00:00:00 2001
From: Ryo Kodama <ryo.kodama.vz@renesas.com>
Date: Wed, 7 Jun 2017 14:39:00 +0900
Subject: [PATCH] ASoC: ak4613: Improve counting DAI number

Add the startup function to count DAI instead of hw_params.
This change matches the number of opened DAIs.
If this change isn't applied, you may get unexpected error due to
mismatching of count. Since the excution number of hw_params and
shutdown may be different, the mismatching happens.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 557ac16d43e2..e3121ca3d1a2 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -252,6 +252,17 @@ static void ak4613_dai_shutdown(struct snd_pcm_substream *substream,
 	mutex_unlock(&priv->lock);
 }
 
+static int ak4613_dai_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+
+	priv->cnt++;
+
+	return 0;
+}
+
 static int ak4613_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -349,7 +360,6 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	if ((priv->iface == NULL) ||
 	    (priv->iface == iface)) {
 		priv->iface = iface;
-		priv->cnt++;
 		ret = 0;
 	}
 	mutex_unlock(&priv->lock);
@@ -398,6 +408,7 @@ static int ak4613_set_bias_level(struct snd_soc_codec *codec,
 }
 
 static const struct snd_soc_dai_ops ak4613_dai_ops = {
+	.startup	= ak4613_dai_startup,
 	.shutdown	= ak4613_dai_shutdown,
 	.set_fmt	= ak4613_dai_set_fmt,
 	.hw_params	= ak4613_dai_hw_params,
-- 
2.11.0
