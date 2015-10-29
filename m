From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Add missing initialization of ADG
	req_rate" to the asoc tree
Date: Thu, 29 Oct 2015 09:53:59 +0900
Message-ID: <E1ZrbTb-00079u-FA@finisterre>
References: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7B7B264F30
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 01:54:17 +0100 (CET)
In-Reply-To: <1446044628-16924-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Add missing initialization of ADG req_rate

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

>From b212be688128b539bb2c69c5da25b04b5551f421 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 28 Oct 2015 16:03:48 +0100
Subject: [PATCH] ASoC: rsnd: Add missing initialization of ADG req_rate

If the "clock-frequency" DT property is not found, req_rate is used
uninitialized, and the "audio_clkout" clock will be created with an
arbitrary clock rate.

This uninitialized kernel stack data may leak to userspace through
/sys/kernel/debug/clk/clk_summary, cfr. the value in the "rate" column:

       clock     enable_cnt  prepare_cnt        rate   accuracy   phase
    --------------------------------------------------------------------
     audio_clkout         0            0  4001836240          0 0

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 2a5b3a2..b123734 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -437,7 +437,7 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *np = dev->of_node;
 	u32 ckr, rbgx, rbga, rbgb;
-	u32 rate, req_rate, div;
+	u32 rate, req_rate = 0, div;
 	uint32_t count = 0;
 	unsigned long req_48kHz_rate, req_441kHz_rate;
 	int i;
-- 
2.6.1
