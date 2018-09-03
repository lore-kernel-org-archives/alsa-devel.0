From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssiu: Support to init different
	BUSIF instance" to the asoc tree
Date: Mon,  3 Sep 2018 14:45:07 +0100 (BST)
Message-ID: <20180903134507.3787311227AE@debutante.sirena.org.uk>
References: <87wos3dpye.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BF6082678AF
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:45:07 +0200 (CEST)
In-Reply-To: <87wos3dpye.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: ssiu: Support to init different BUSIF instance

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

>From 2e66d523cd055ac3fa920f7e630c4bfa80d24c24 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Mon, 3 Sep 2018 07:08:37 +0000
Subject: [PATCH] ASoC: rsnd: ssiu: Support to init different BUSIF instance

Currently ssiu's .init is only called once during audio stream.
But SSIU with different BUSIF, shall be initialized each time,
even they are used in the same audio stream.

This patch introduces ssiu_status for BUSIF0 to BUSIF7 in rsnd_ssiu,
to make sure same .init for different BUSIF can always be executed.

To avoid the first stopped stream to stop the whole SSIU,
which may still has other BUSIF instance running, use usrcnt to count
the usage of SSIU, only the last user of SSIU can stop the whole SSIU.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index a9605a0163f2..39b67643b5dc 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -10,9 +10,12 @@
 
 struct rsnd_ssiu {
 	struct rsnd_mod mod;
+	u32 busif_status[8]; /* for BUSIF0 - BUSIF7 */
+	unsigned int usrcnt;
 };
 
 #define rsnd_ssiu_nr(priv) ((priv)->ssiu_nr)
+#define rsnd_mod_to_ssiu(_mod) container_of((_mod), struct rsnd_ssiu, mod)
 #define for_each_rsnd_ssiu(pos, priv, i)				\
 	for (i = 0;							\
 	     (i < rsnd_ssiu_nr(priv)) &&				\
@@ -120,6 +123,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 			       struct rsnd_dai_stream *io,
 			       struct rsnd_priv *priv)
 {
+	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
 	int hdmi = rsnd_ssi_hdmi_port(io);
 	int ret;
 	u32 mode = 0;
@@ -128,6 +132,8 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	ssiu->usrcnt++;
+
 	if (rsnd_runtime_is_ssi_tdm(io)) {
 		/*
 		 * TDM Extend Mode
@@ -255,6 +261,7 @@ static int rsnd_ssiu_stop_gen2(struct rsnd_mod *mod,
 			       struct rsnd_dai_stream *io,
 			       struct rsnd_priv *priv)
 {
+	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
 	int busif = rsnd_ssi_get_busif(io);
 
 	if (!rsnd_ssi_use_busif(io))
@@ -262,6 +269,9 @@ static int rsnd_ssiu_stop_gen2(struct rsnd_mod *mod,
 
 	rsnd_mod_bset(mod, SSI_CTRL, 1 << (busif * 4), 0);
 
+	if (--ssiu->usrcnt)
+		return 0;
+
 	if (rsnd_ssi_multi_slaves_runtime(io))
 		rsnd_mod_write(mod, SSI_CONTROL, 0);
 
@@ -294,6 +304,16 @@ int rsnd_ssiu_attach(struct rsnd_dai_stream *io,
 	return rsnd_dai_connect(mod, io, mod->type);
 }
 
+static u32 *rsnd_ssiu_get_status(struct rsnd_dai_stream *io,
+				 struct rsnd_mod *mod,
+				 enum rsnd_mod_type type)
+{
+	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
+	int busif = rsnd_ssi_get_busif(io);
+
+	return &ssiu->busif_status[busif];
+}
+
 int rsnd_ssiu_probe(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
@@ -317,7 +337,7 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 
 	for_each_rsnd_ssiu(ssiu, priv, i) {
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssiu),
-				    ops, NULL, rsnd_mod_get_status,
+				    ops, NULL, rsnd_ssiu_get_status,
 				    RSND_MOD_SSIU, i);
 		if (ret)
 			return ret;
-- 
2.19.0.rc1
