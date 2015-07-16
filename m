From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_get_adinr_chan()" to the
	asoc tree
Date: Thu, 16 Jul 2015 22:29:57 +0100
Message-ID: <E1ZFqj7-0004jG-LX@finisterre>
References: <87io9lvqsg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01C712666C0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:03 +0200 (CEST)
In-Reply-To: <87io9lvqsg.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add rsnd_get_adinr_chan()

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

>From bfe1360d79210f9c1d330a07c26a8d5cb202159d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:14:29 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_get_adinr_chan()

Current rsnd driver has rsnd_get_adinr_bit() to get bit settings for
ADINR (= Audio Information Register) of SSIU/SRC/DVC.
This patch adds rsnd_get_adinr_chan() to get channel settings for
ADINR (= Audio Information Register) of CTU/MIX.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 22 ++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 0ca6d02..a3637b9 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -227,6 +227,28 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	return adinr;
 }
 
+u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
+{
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	u32 chan = runtime->channels;
+
+	switch (chan) {
+	case 1:
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		break;
+	default:
+		dev_warn(dev, "not supported channel\n");
+		chan = 0;
+		break;
+	}
+
+	return chan;
+}
 /*
  *	rsnd_dai functions
  */
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 224a4a9..1296b35 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -170,6 +170,7 @@ void rsnd_force_write(struct rsnd_priv *priv, struct rsnd_mod *mod,
 void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 		    u32 mask, u32 data);
 u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
+u32 rsnd_get_adinr_chan(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 void rsnd_path_parse(struct rsnd_priv *priv,
 		     struct rsnd_dai_stream *io);
 
-- 
2.1.4
