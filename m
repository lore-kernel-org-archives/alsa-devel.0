From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_mod_id() return -1 if mod
	was NULL" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:34 +0100
Message-ID: <E1ZFqRK-0002nS-K1@finisterre>
References: <87y4ihvqym.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0627426683A
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:40 +0200 (CEST)
In-Reply-To: <87y4ihvqym.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rsnd_mod_id() return -1 if mod was NULL

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

>From 72413c107e81386a7da438bcf888ee2af5d3b72f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:10:43 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_mod_id() return -1 if mod was NULL

enabling to use same method for exception case is useful.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 9ecd151..46eb4da 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -316,7 +316,7 @@ struct rsnd_mod {
 
 #define rsnd_mod_to_priv(mod) ((mod)->priv)
 #define rsnd_mod_to_dma(mod) (&(mod)->dma)
-#define rsnd_mod_id(mod) ((mod)->id)
+#define rsnd_mod_id(mod) ((mod) ? (mod)->id : -1)
 #define rsnd_mod_hw_start(mod)	clk_enable((mod)->clk)
 #define rsnd_mod_hw_stop(mod)	clk_disable((mod)->clk)
 
-- 
2.1.4
