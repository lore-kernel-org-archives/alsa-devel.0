From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: mix: rename rsnd_mix_soft_reset()
	to rsnd_mix_activation()" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:59 +0000
Message-ID: <E1a3ttv-000754-Vt@debutante>
References: <87610jub3g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7696C2661EE
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 00:00:04 +0100 (CET)
In-Reply-To: <87610jub3g.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: mix: rename rsnd_mix_soft_reset() to rsnd_mix_activation()

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

>From 4fe32521d706e3541095ef173669e46666df2865 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 30 Nov 2015 08:50:51 +0000
Subject: [PATCH] ASoC: rsnd: mix: rename rsnd_mix_soft_reset() to
 rsnd_mix_activation()

Based on datasheet naming

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/mix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 57ac453adcef..b2f22bd7e3a9 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -24,7 +24,7 @@ struct rsnd_mix {
 		     ((pos) = (struct rsnd_mix *)(priv)->mix + i);	\
 	     i++)
 
-static void rsnd_mix_soft_reset(struct rsnd_mod *mod)
+static void rsnd_mix_activation(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, MIX_SWRSR, 0);
 	rsnd_mod_write(mod, MIX_SWRSR, 1);
@@ -83,7 +83,7 @@ static int rsnd_mix_init(struct rsnd_mod *mod,
 {
 	rsnd_mod_power_on(mod);
 
-	rsnd_mix_soft_reset(mod);
+	rsnd_mix_activation(mod);
 
 	rsnd_mix_volume_init(io, mod);
 
-- 
2.6.2
