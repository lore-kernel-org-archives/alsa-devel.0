From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: rsnd: indicates Channel and Mode for
	debug
Date: Tue, 4 Dec 2018 07:59:05 +0000
Message-ID: <87k1kp3f5k.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410131.outbound.protection.outlook.com [40.107.141.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 1191D267ACB
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 08:59:10 +0100 (CET)
Content-Language: en-US
Content-ID: <AD5D36D31F7E5F47B6F567532CE5367B@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

For TDM debug purpose, indicating Channel and Mode is very
useful. This patch indicate it if it has #define DEBUG

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/ssi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 6439a74..45ef295 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -329,7 +329,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	ssi->rate = rate;
 	ssi->chan = chan;
 
-	dev_dbg(dev, "%s outputs %u Hz\n", rsnd_mod_name(mod), rate);
+	dev_dbg(dev, "%s outputs %d chan %u Hz\n",
+		rsnd_mod_name(mod), chan, rate);
 
 	return 0;
 }
@@ -360,6 +361,8 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 				struct rsnd_dai_stream *io)
 {
 	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
+	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	u32 cr_own	= ssi->cr_own;
@@ -371,6 +374,11 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 	is_tdm		= rsnd_runtime_is_tdm(io);
 	is_tdm_split	= rsnd_runtime_is_tdm_split(io);
 
+	if (is_tdm)
+		dev_dbg(dev, "TDM mode\n");
+	if (is_tdm_split)
+		dev_dbg(dev, "TDM Split mode\n");
+
 	cr_own |= FORCE | rsnd_rdai_width_to_swl(rdai);
 
 	if (rdai->bit_clk_inv)
-- 
2.7.4
