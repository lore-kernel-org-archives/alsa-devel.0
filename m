From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_daidrv_get()" to the
	asoc tree
Date: Mon, 18 Jun 2018 13:00:07 +0100
Message-ID: <E1fUspL-00006z-KP@debutante>
References: <877en4sgi9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DF6EB2676F2
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:10 +0200 (CEST)
In-Reply-To: <877en4sgi9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_daidrv_get()

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

>From a0d847c380ba47886fcca4168698eef51c69f109 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:51:46 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_daidrv_get()

rsnd priv has many parameters. On __rsnd_dai_probe() it uses
rsnd_rdai_get() to get rdai pointer, but is using priv->daidrv
directly to get daidrvhv, but it is confusable for reader.
This patch adds rsnd_daidrv_get() to get daidrv from priv.
Now reader can understand that rdai and daidrv are related.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index eac22fef4543..6091e0916085 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -548,6 +548,15 @@ struct rsnd_dai *rsnd_rdai_get(struct rsnd_priv *priv, int id)
 	return priv->rdai + id;
 }
 
+static struct snd_soc_dai_driver
+*rsnd_daidrv_get(struct rsnd_priv *priv, int id)
+{
+	if ((id < 0) || (id >= rsnd_rdai_nr(priv)))
+		return NULL;
+
+	return priv->daidrv + id;
+}
+
 #define rsnd_dai_to_priv(dai) snd_soc_dai_get_drvdata(dai)
 static struct rsnd_dai *rsnd_dai_to_rdai(struct snd_soc_dai *dai)
 {
@@ -1033,7 +1042,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	int io_i;
 
 	rdai		= rsnd_rdai_get(priv, dai_i);
-	drv		= priv->daidrv + dai_i;
+	drv		= rsnd_daidrv_get(priv, dai_i);
 	io_playback	= &rdai->playback;
 	io_capture	= &rdai->capture;
 
-- 
2.17.1
