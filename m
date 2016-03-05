From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add CTU basic support" to the
	asoc tree
Date: Sat, 05 Mar 2016 21:24:50 +0900
Message-ID: <E1acBGM-0003GX-Dl@finisterre>
References: <871t81732m.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C95E260564
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:54 +0100 (CET)
In-Reply-To: <871t81732m.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add CTU basic support

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

>From 8a3a2211e97395694827f12552bbad7f2caf11ef Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Feb 2016 05:53:00 +0000
Subject: [PATCH] ASoC: rsnd: add CTU basic support

This patch adds Renesas R-Car sound CTU (= Channel Transfer Unit)
very basic support, but not yet enough feature at this point.
Because CTU support needs more complex channel function for
each modules.
To avoid complex patch reviewing, this patch picked up very basic
part only.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index a10d0f7b73fa..784515afefaf 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -14,6 +14,7 @@
 
 struct rsnd_ctu {
 	struct rsnd_mod mod;
+	int channels;
 };
 
 #define rsnd_ctu_nr(priv) ((priv)->ctu_nr)
@@ -23,6 +24,9 @@ struct rsnd_ctu {
 		     ((pos) = (struct rsnd_ctu *)(priv)->ctu + i);	\
 	     i++)
 
+#define rsnd_mod_to_ctu(_mod)	\
+	container_of((_mod), struct rsnd_ctu, mod)
+
 #define rsnd_ctu_get(priv, id) ((struct rsnd_ctu *)(priv->ctu) + id)
 
 static void rsnd_ctu_activation(struct rsnd_mod *mod)
@@ -37,6 +41,13 @@ static void rsnd_ctu_halt(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, CTU_SWRSR, 0);
 }
 
+int rsnd_ctu_converted_channel(struct rsnd_mod *mod)
+{
+	struct rsnd_ctu *ctu = rsnd_mod_to_ctu(mod);
+
+	return ctu->channels;
+}
+
 static int rsnd_ctu_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -116,11 +127,49 @@ static int rsnd_ctu_quit(struct rsnd_mod *mod,
 	return 0;
 }
 
+static int rsnd_ctu_hw_params(struct rsnd_mod *mod,
+			      struct rsnd_dai_stream *io,
+			      struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *fe_params)
+{
+	struct rsnd_ctu *ctu = rsnd_mod_to_ctu(mod);
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+
+	/*
+	 * CTU assumes that it is used under DPCM if user want to use
+	 * channel transfer. Then, CTU should be FE.
+	 * And then, this function will be called *after* BE settings.
+	 * this means, each BE already has fixuped hw_params.
+	 * see
+	 *	dpcm_fe_dai_hw_params()
+	 *	dpcm_be_dai_hw_params()
+	 */
+	ctu->channels = 0;
+	if (fe->dai_link->dynamic) {
+		struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+		struct device *dev = rsnd_priv_to_dev(priv);
+		struct snd_soc_dpcm *dpcm;
+		struct snd_pcm_hw_params *be_params;
+		int stream = substream->stream;
+
+		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+			be_params = &dpcm->hw_params;
+			if (params_channels(fe_params) != params_channels(be_params))
+				ctu->channels = params_channels(be_params);
+		}
+
+		dev_dbg(dev, "CTU convert channels %d\n", ctu->channels);
+	}
+
+	return 0;
+}
+
 static struct rsnd_mod_ops rsnd_ctu_ops = {
 	.name		= CTU_NAME,
 	.probe		= rsnd_ctu_probe_,
 	.init		= rsnd_ctu_init,
 	.quit		= rsnd_ctu_quit,
+	.hw_params	= rsnd_ctu_hw_params,
 };
 
 struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 305cc086a0bc..bbc89bd1e918 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -638,6 +638,7 @@ unsigned int rsnd_src_get_ssi_rate(struct rsnd_priv *priv,
  */
 int rsnd_ctu_probe(struct rsnd_priv *priv);
 void rsnd_ctu_remove(struct rsnd_priv *priv);
+int rsnd_ctu_converted_channel(struct rsnd_mod *mod);
 struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id);
 #define rsnd_ctu_of_node(priv)						\
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,ctu")
-- 
2.7.0
