From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_ssi_is_multi_slave() macro
	uses rsnd_ssi_multi_slaves()" to the asoc tree
Date: Tue, 09 Feb 2016 18:20:07 +0000
Message-ID: <E1aTCtT-0001RX-8J@debutante>
References: <87io1ynzbc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7CD2612BD
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 19:20:19 +0100 (CET)
In-Reply-To: <87io1ynzbc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nguyen Viet Dung <nv-dung@jinso.co.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rsnd_ssi_is_multi_slave() macro uses rsnd_ssi_multi_slaves()

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

>From c308abe45e2a7bc58e22d9b6d04dccf76a1b2012 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 9 Feb 2016 07:04:09 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_ssi_is_multi_slave() macro uses
 rsnd_ssi_multi_slaves()

b4c83b171 ("ASoC: rsnd: add Multi channel support") added
Multi channel support, and current rsnd_ssi_is_multi_slave()'s check
method is !SSI equals SSIM1/2/3. But, SSI parent also hit to this macro.
Because of this reason, some stream which needs SSI parent clock
can't work correctly. This patch uses rsnd_ssi_multi_slaves() to
solve this issue. This issue was reported by Dung.

Reported-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 803e9ae65915..592505a4bc13 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -94,7 +94,8 @@ struct rsnd_ssi {
 #define rsnd_mod_to_ssi(_mod) container_of((_mod), struct rsnd_ssi, mod)
 #define rsnd_ssi_mode_flags(p) ((p)->flags)
 #define rsnd_ssi_is_parent(ssi, io) ((ssi) == rsnd_io_to_mod_ssip(io))
-#define rsnd_ssi_is_multi_slave(ssi, io) ((mod) != rsnd_io_to_mod_ssi(io))
+#define rsnd_ssi_is_multi_slave(mod, io) \
+	(rsnd_ssi_multi_slaves(io) & (1 << rsnd_mod_id(mod)))
 
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
@@ -167,9 +168,6 @@ static int rsnd_ssi_irq(struct rsnd_mod *mod,
 u32 rsnd_ssi_multi_slaves(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod;
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
 	enum rsnd_mod_type types[] = {
 		RSND_MOD_SSIM1,
 		RSND_MOD_SSIM2,
@@ -177,16 +175,6 @@ u32 rsnd_ssi_multi_slaves(struct rsnd_dai_stream *io)
 	};
 	int i, mask;
 
-	switch (runtime->channels) {
-	case 2: /* Multi channel is not needed for Stereo */
-		return 0;
-	case 6:
-		break;
-	default:
-		dev_err(dev, "unsupported channel\n");
-		return 0;
-	}
-
 	mask = 0;
 	for (i = 0; i < ARRAY_SIZE(types); i++) {
 		mod = rsnd_io_to_mod(io, types[i]);
-- 
2.7.0.rc3
