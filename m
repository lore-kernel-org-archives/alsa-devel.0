From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add .get_id/.get_id_sub" to the
	asoc tree
Date: Mon,  5 Nov 2018 11:57:40 +0000 (GMT)
Message-ID: <20181105115740.4F18B1124D98@debutante.sirena.org.uk>
References: <87d0rrsx37.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 050B02678DD
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:57:40 +0100 (CET)
In-Reply-To: <87d0rrsx37.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add .get_id/.get_id_sub

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

>From c16015f36cc128244c910152663de45c3b99f551 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Oct 2018 07:47:18 +0000
Subject: [PATCH] ASoC: rsnd: add .get_id/.get_id_sub

ID for CTU and SSIU are confusable.
1 CTU has 4 sub nodes. This means, CTU0 has CTU01 - CTU03, CTU1 has
CTU10 - CTU13. SSIU is more confusable. Gen2 SSIU has BUSIF0-3, Gen3
SSIU has BUSIF0-7, but not for all SSIU.
In rsnd driver, each mod drivers are assuming rsnd_mod_id() returns
main device ID (In CTU case CTU0-1, SSIU case SSIU0-9), not serial
number.
This patch adds new .id/.id_sub to handling more detail ID.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 21 +++++++++++++++++++++
 sound/soc/sh/rcar/ctu.c  | 20 ++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  6 +++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5373eba5d572..82d2234840c5 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -144,6 +144,27 @@ u32 *rsnd_mod_get_status(struct rsnd_mod *mod,
 	return &mod->status;
 }
 
+int rsnd_mod_id_raw(struct rsnd_mod *mod)
+{
+	return mod->id;
+}
+
+int rsnd_mod_id(struct rsnd_mod *mod)
+{
+	if ((mod)->ops->id)
+		return (mod)->ops->id(mod);
+
+	return rsnd_mod_id_raw(mod);
+}
+
+int rsnd_mod_id_sub(struct rsnd_mod *mod)
+{
+	if ((mod)->ops->id_sub)
+		return (mod)->ops->id_sub(mod);
+
+	return 0;
+}
+
 int rsnd_mod_init(struct rsnd_priv *priv,
 		  struct rsnd_mod *mod,
 		  struct rsnd_mod_ops *ops,
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 28058474075b..6a948b1fd9ab 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -334,6 +334,24 @@ static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
 	return ret;
 }
 
+static int rsnd_ctu_id(struct rsnd_mod *mod)
+{
+	/*
+	 * ctu00: -> 0, ctu01: -> 0, ctu02: -> 0, ctu03: -> 0
+	 * ctu10: -> 1, ctu11: -> 1, ctu12: -> 1, ctu13: -> 1
+	 */
+	return mod->id / 4;
+}
+
+static int rsnd_ctu_id_sub(struct rsnd_mod *mod)
+{
+	/*
+	 * ctu00: -> 0, ctu01: -> 1, ctu02: -> 2, ctu03: -> 3
+	 * ctu10: -> 0, ctu11: -> 1, ctu12: -> 2, ctu13: -> 3
+	 */
+	return mod->id % 4;
+}
+
 static struct rsnd_mod_ops rsnd_ctu_ops = {
 	.name		= CTU_NAME,
 	.probe		= rsnd_ctu_probe_,
@@ -342,6 +360,8 @@ static struct rsnd_mod_ops rsnd_ctu_ops = {
 	.hw_params	= rsnd_ctu_hw_params,
 	.pcm_new	= rsnd_ctu_pcm_new,
 	.get_status	= rsnd_mod_get_status,
+	.id		= rsnd_ctu_id,
+	.id_sub		= rsnd_ctu_id_sub,
 };
 
 struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index d25fb5c14c2d..fdf007aeac27 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -304,6 +304,8 @@ struct rsnd_mod_ops {
 	u32 *(*get_status)(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   enum rsnd_mod_type type);
+	int (*id)(struct rsnd_mod *mod);
+	int (*id_sub)(struct rsnd_mod *mod);
 };
 
 struct rsnd_dai_stream;
@@ -376,7 +378,6 @@ struct rsnd_mod {
 
 #define rsnd_mod_to_priv(mod)	((mod)->priv)
 #define rsnd_mod_name(mod)	((mod)->ops->name)
-#define rsnd_mod_id(mod)	((mod)->id)
 #define rsnd_mod_power_on(mod)	clk_enable((mod)->clk)
 #define rsnd_mod_power_off(mod)	clk_disable((mod)->clk)
 #define rsnd_mod_get(ip)	(&(ip)->mod)
@@ -396,6 +397,9 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 u32 *rsnd_mod_get_status(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 enum rsnd_mod_type type);
+int rsnd_mod_id(struct rsnd_mod *mod);
+int rsnd_mod_id_raw(struct rsnd_mod *mod);
+int rsnd_mod_id_sub(struct rsnd_mod *mod);
 struct rsnd_mod *rsnd_mod_next(int *iterator,
 			       struct rsnd_dai_stream *io,
 			       enum rsnd_mod_type *array,
-- 
2.19.0.rc2
