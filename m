From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add CTU support" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:47 +0900
Message-ID: <E1acBGJ-0003FY-0L@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2142612C6
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:56 +0100 (CET)
In-Reply-To: 
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

   ASoC: rsnd: add CTU support

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

>From ec2ac01afe001360b911e27c915579fd003339e8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Feb 2016 05:55:23 +0000
Subject: [PATCH] ASoC: rsnd: add CTU support

This patch adds CTU (= Channel Transfer Unit) support on
Renesas R-Car sound driver.
It can Down/Up mixing and splitter. You need to check R-Car datasheet
especially CTUn_CPMDR/CTUn_SV0xR/CTUn_SV1xR/CTUn_SV2xR/CTUn_SV3xR
for setting parameter.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 234 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 197 insertions(+), 37 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index b326966ea407..9dcc1f9db026 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -12,8 +12,74 @@
 #define CTU_NAME_SIZE	16
 #define CTU_NAME "ctu"
 
+/*
+ * User needs to setup CTU by amixer, and its settings are
+ * based on below registers
+ *
+ * CTUn_CPMDR : amixser set "CTU Pass"
+ * CTUn_SV0xR : amixser set "CTU SV0"
+ * CTUn_SV1xR : amixser set "CTU SV1"
+ * CTUn_SV2xR : amixser set "CTU SV2"
+ * CTUn_SV3xR : amixser set "CTU SV3"
+ *
+ * [CTU Pass]
+ * 0000: default
+ * 0001: Connect input data of channel 0
+ * 0010: Connect input data of channel 1
+ * 0011: Connect input data of channel 2
+ * 0100: Connect input data of channel 3
+ * 0101: Connect input data of channel 4
+ * 0110: Connect input data of channel 5
+ * 0111: Connect input data of channel 6
+ * 1000: Connect input data of channel 7
+ * 1001: Connect calculated data by scale values of matrix row 0
+ * 1010: Connect calculated data by scale values of matrix row 1
+ * 1011: Connect calculated data by scale values of matrix row 2
+ * 1100: Connect calculated data by scale values of matrix row 3
+ *
+ * [CTU SVx]
+ * [Output0] = [SV00, SV01, SV02, SV03, SV04, SV05, SV06, SV07]
+ * [Output1] = [SV10, SV11, SV12, SV13, SV14, SV15, SV16, SV17]
+ * [Output2] = [SV20, SV21, SV22, SV23, SV24, SV25, SV26, SV27]
+ * [Output3] = [SV30, SV31, SV32, SV33, SV34, SV35, SV36, SV37]
+ * [Output4] = [ 0,   0,    0,    0,    0,    0,    0,    0   ]
+ * [Output5] = [ 0,   0,    0,    0,    0,    0,    0,    0   ]
+ * [Output6] = [ 0,   0,    0,    0,    0,    0,    0,    0   ]
+ * [Output7] = [ 0,   0,    0,    0,    0,    0,    0,    0   ]
+ *
+ * [SVxx]
+ * Plus					Minus
+ * value	time		dB	value		time		dB
+ * -----------------------------------------------------------------------
+ * H'7F_FFFF	2		6	H'80_0000	2		6
+ * ...
+ * H'40_0000	1		0	H'C0_0000	1		0
+ * ...
+ * H'00_0001	2.38 x 10^-7	-132
+ * H'00_0000	0		Mute	H'FF_FFFF	2.38 x 10^-7	-132
+ *
+ *
+ * Ex) Input ch -> Output ch
+ *	1ch     ->  0ch
+ *	0ch     ->  1ch
+ *
+ *	amixer set "CTU Reset" on
+ *	amixer set "CTU Pass" 9,10
+ *	amixer set "CTU SV0" 0,4194304
+ *	amixer set "CTU SV1" 4194304,0
+ * or
+ *	amixer set "CTU Reset" on
+ *	amixer set "CTU Pass" 2,1
+ */
+
 struct rsnd_ctu {
 	struct rsnd_mod mod;
+	struct rsnd_kctrl_cfg_m pass;
+	struct rsnd_kctrl_cfg_m sv0;
+	struct rsnd_kctrl_cfg_m sv1;
+	struct rsnd_kctrl_cfg_m sv2;
+	struct rsnd_kctrl_cfg_m sv3;
+	struct rsnd_kctrl_cfg_s reset;
 	int channels;
 };
 
@@ -58,51 +124,91 @@ static int rsnd_ctu_probe_(struct rsnd_mod *mod,
 static void rsnd_ctu_value_init(struct rsnd_dai_stream *io,
 			       struct rsnd_mod *mod)
 {
+	struct rsnd_ctu *ctu = rsnd_mod_to_ctu(mod);
+	u32 cpmdr = 0;
+	u32 scmdr = 0;
+	int i;
+
+	for (i = 0; i < RSND_MAX_CHANNELS; i++) {
+		u32 val = ctu->pass.val[i];
+
+		cpmdr |= val << (28 - (i * 4));
+
+		if ((val > 0x8) && (scmdr < (val - 0x8)))
+			scmdr = val - 0x8;
+	}
+
 	rsnd_mod_write(mod, CTU_CTUIR, 1);
 
 	rsnd_mod_write(mod, CTU_ADINR, rsnd_runtime_channel_original(io));
 
-	rsnd_mod_write(mod, CTU_CPMDR, 0);
-	rsnd_mod_write(mod, CTU_SCMDR, 0);
-	rsnd_mod_write(mod, CTU_SV00R, 0);
-	rsnd_mod_write(mod, CTU_SV01R, 0);
-	rsnd_mod_write(mod, CTU_SV02R, 0);
-	rsnd_mod_write(mod, CTU_SV03R, 0);
-	rsnd_mod_write(mod, CTU_SV04R, 0);
-	rsnd_mod_write(mod, CTU_SV05R, 0);
-	rsnd_mod_write(mod, CTU_SV06R, 0);
-	rsnd_mod_write(mod, CTU_SV07R, 0);
-
-	rsnd_mod_write(mod, CTU_SV10R, 0);
-	rsnd_mod_write(mod, CTU_SV11R, 0);
-	rsnd_mod_write(mod, CTU_SV12R, 0);
-	rsnd_mod_write(mod, CTU_SV13R, 0);
-	rsnd_mod_write(mod, CTU_SV14R, 0);
-	rsnd_mod_write(mod, CTU_SV15R, 0);
-	rsnd_mod_write(mod, CTU_SV16R, 0);
-	rsnd_mod_write(mod, CTU_SV17R, 0);
-
-	rsnd_mod_write(mod, CTU_SV20R, 0);
-	rsnd_mod_write(mod, CTU_SV21R, 0);
-	rsnd_mod_write(mod, CTU_SV22R, 0);
-	rsnd_mod_write(mod, CTU_SV23R, 0);
-	rsnd_mod_write(mod, CTU_SV24R, 0);
-	rsnd_mod_write(mod, CTU_SV25R, 0);
-	rsnd_mod_write(mod, CTU_SV26R, 0);
-	rsnd_mod_write(mod, CTU_SV27R, 0);
-
-	rsnd_mod_write(mod, CTU_SV30R, 0);
-	rsnd_mod_write(mod, CTU_SV31R, 0);
-	rsnd_mod_write(mod, CTU_SV32R, 0);
-	rsnd_mod_write(mod, CTU_SV33R, 0);
-	rsnd_mod_write(mod, CTU_SV34R, 0);
-	rsnd_mod_write(mod, CTU_SV35R, 0);
-	rsnd_mod_write(mod, CTU_SV36R, 0);
-	rsnd_mod_write(mod, CTU_SV37R, 0);
+	rsnd_mod_write(mod, CTU_CPMDR, cpmdr);
+
+	rsnd_mod_write(mod, CTU_SCMDR, scmdr);
+
+	if (scmdr > 0) {
+		rsnd_mod_write(mod, CTU_SV00R, ctu->sv0.val[0]);
+		rsnd_mod_write(mod, CTU_SV01R, ctu->sv0.val[1]);
+		rsnd_mod_write(mod, CTU_SV02R, ctu->sv0.val[2]);
+		rsnd_mod_write(mod, CTU_SV03R, ctu->sv0.val[3]);
+		rsnd_mod_write(mod, CTU_SV04R, ctu->sv0.val[4]);
+		rsnd_mod_write(mod, CTU_SV05R, ctu->sv0.val[5]);
+		rsnd_mod_write(mod, CTU_SV06R, ctu->sv0.val[6]);
+		rsnd_mod_write(mod, CTU_SV07R, ctu->sv0.val[7]);
+	}
+	if (scmdr > 1) {
+		rsnd_mod_write(mod, CTU_SV10R, ctu->sv1.val[0]);
+		rsnd_mod_write(mod, CTU_SV11R, ctu->sv1.val[1]);
+		rsnd_mod_write(mod, CTU_SV12R, ctu->sv1.val[2]);
+		rsnd_mod_write(mod, CTU_SV13R, ctu->sv1.val[3]);
+		rsnd_mod_write(mod, CTU_SV14R, ctu->sv1.val[4]);
+		rsnd_mod_write(mod, CTU_SV15R, ctu->sv1.val[5]);
+		rsnd_mod_write(mod, CTU_SV16R, ctu->sv1.val[6]);
+		rsnd_mod_write(mod, CTU_SV17R, ctu->sv1.val[7]);
+	}
+	if (scmdr > 2) {
+		rsnd_mod_write(mod, CTU_SV20R, ctu->sv2.val[0]);
+		rsnd_mod_write(mod, CTU_SV21R, ctu->sv2.val[1]);
+		rsnd_mod_write(mod, CTU_SV22R, ctu->sv2.val[2]);
+		rsnd_mod_write(mod, CTU_SV23R, ctu->sv2.val[3]);
+		rsnd_mod_write(mod, CTU_SV24R, ctu->sv2.val[4]);
+		rsnd_mod_write(mod, CTU_SV25R, ctu->sv2.val[5]);
+		rsnd_mod_write(mod, CTU_SV26R, ctu->sv2.val[6]);
+		rsnd_mod_write(mod, CTU_SV27R, ctu->sv2.val[7]);
+	}
+	if (scmdr > 3) {
+		rsnd_mod_write(mod, CTU_SV30R, ctu->sv3.val[0]);
+		rsnd_mod_write(mod, CTU_SV31R, ctu->sv3.val[1]);
+		rsnd_mod_write(mod, CTU_SV32R, ctu->sv3.val[2]);
+		rsnd_mod_write(mod, CTU_SV33R, ctu->sv3.val[3]);
+		rsnd_mod_write(mod, CTU_SV34R, ctu->sv3.val[4]);
+		rsnd_mod_write(mod, CTU_SV35R, ctu->sv3.val[5]);
+		rsnd_mod_write(mod, CTU_SV36R, ctu->sv3.val[6]);
+		rsnd_mod_write(mod, CTU_SV37R, ctu->sv3.val[7]);
+	}
 
 	rsnd_mod_write(mod, CTU_CTUIR, 0);
 }
 
+static void rsnd_ctu_value_reset(struct rsnd_dai_stream *io,
+				 struct rsnd_mod *mod)
+{
+	struct rsnd_ctu *ctu = rsnd_mod_to_ctu(mod);
+	int i;
+
+	if (!ctu->reset.val)
+		return;
+
+	for (i = 0; i < RSND_MAX_CHANNELS; i++) {
+		ctu->pass.val[i] = 0;
+		ctu->sv0.val[i] = 0;
+		ctu->sv1.val[i] = 0;
+		ctu->sv2.val[i] = 0;
+		ctu->sv3.val[i] = 0;
+	}
+	ctu->reset.val = 0;
+}
+
 static int rsnd_ctu_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
@@ -164,12 +270,66 @@ static int rsnd_ctu_hw_params(struct rsnd_mod *mod,
 	return 0;
 }
 
+static int rsnd_ctu_pcm_new(struct rsnd_mod *mod,
+			    struct rsnd_dai_stream *io,
+			    struct snd_soc_pcm_runtime *rtd)
+{
+	struct rsnd_ctu *ctu = rsnd_mod_to_ctu(mod);
+	int ret;
+
+	/* CTU Pass */
+	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU Pass",
+			       NULL,
+			       &ctu->pass, RSND_MAX_CHANNELS,
+			       0xC);
+
+	/* ROW0 */
+	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV0",
+			       NULL,
+			       &ctu->sv0, RSND_MAX_CHANNELS,
+			       0x00FFFFFF);
+	if (ret < 0)
+		return ret;
+
+	/* ROW1 */
+	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV1",
+			       NULL,
+			       &ctu->sv1, RSND_MAX_CHANNELS,
+			       0x00FFFFFF);
+	if (ret < 0)
+		return ret;
+
+	/* ROW2 */
+	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV2",
+			       NULL,
+			       &ctu->sv2, RSND_MAX_CHANNELS,
+			       0x00FFFFFF);
+	if (ret < 0)
+		return ret;
+
+	/* ROW3 */
+	ret = rsnd_kctrl_new_m(mod, io, rtd, "CTU SV3",
+			       NULL,
+			       &ctu->sv3, RSND_MAX_CHANNELS,
+			       0x00FFFFFF);
+	if (ret < 0)
+		return ret;
+
+	/* Reset */
+	ret = rsnd_kctrl_new_s(mod, io, rtd, "CTU Reset",
+			       rsnd_ctu_value_reset,
+			       &ctu->reset, 1);
+
+	return ret;
+}
+
 static struct rsnd_mod_ops rsnd_ctu_ops = {
 	.name		= CTU_NAME,
 	.probe		= rsnd_ctu_probe_,
 	.init		= rsnd_ctu_init,
 	.quit		= rsnd_ctu_quit,
 	.hw_params	= rsnd_ctu_hw_params,
+	.pcm_new	= rsnd_ctu_pcm_new,
 };
 
 struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
-- 
2.7.0
