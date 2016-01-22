From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ctu: add rsnd_ctu_halt()" to the
	asoc tree
Date: Fri, 22 Jan 2016 18:26:41 +0000
Message-ID: <E1aMgPx-00046E-7z@debutante>
References: <87a8nz4rxl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9A932604AF
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:47 +0100 (CET)
In-Reply-To: <87a8nz4rxl.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: ctu: add rsnd_ctu_halt()

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

>From d0658b31c712327e04ddc2621742144de5562962 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:59:12 +0000
Subject: [PATCH] ASoC: rsnd: ctu: add rsnd_ctu_halt()

Based on datasheet process

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 0dc451803eb6..7b482f36cb63 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -31,6 +31,12 @@ static void rsnd_ctu_activation(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, CTU_SWRSR, 1);
 }
 
+static void rsnd_ctu_halt(struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, CTU_CTUIR, 1);
+	rsnd_mod_write(mod, CTU_SWRSR, 0);
+}
+
 #define rsnd_ctu_initialize_lock(mod)	__rsnd_ctu_initialize_lock(mod, 1)
 #define rsnd_ctu_initialize_unlock(mod)	__rsnd_ctu_initialize_lock(mod, 0)
 static void __rsnd_ctu_initialize_lock(struct rsnd_mod *mod, u32 enable)
@@ -66,6 +72,8 @@ static int rsnd_ctu_quit(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
 {
+	rsnd_ctu_halt(mod);
+
 	rsnd_mod_power_off(mod);
 
 	return 0;
-- 
2.7.0.rc3
