From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssi: 24bit data needs
	right-aligned settings" to the asoc tree
Date: Tue, 17 Nov 2015 18:54:48 +0000
Message-ID: <E1ZylOy-00041j-IB@debutante>
References: <87io51hw6l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB932652E1
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:53 +0100 (CET)
In-Reply-To: <87io51hw6l.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: ssi: 24bit data needs right-aligned settings

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

>From f46a93b820eb3707faf238cd769a004e2504515f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Nov 2015 08:28:11 +0000
Subject: [PATCH] ASoC: rsnd: ssi: 24bit data needs right-aligned settings

Data left/right aligned is controlled by PDTA bit on SSICR.
But default is left-aligned. Thus 24bit sound will be very small sound
without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 3e814711f301..60ef074082e8 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -39,6 +39,7 @@
 #define	SCKP		(1 << 13)	/* Serial Bit Clock Polarity */
 #define	SWSP		(1 << 12)	/* Serial WS Polarity */
 #define	SDTA		(1 << 10)	/* Serial Data Alignment */
+#define	PDTA		(1 <<  9)	/* Parallel Data Alignment */
 #define	DEL		(1 <<  8)	/* Serial Data Delay */
 #define	CKDV(v)		(v <<  4)	/* Serial Clock Division Ratio */
 #define	TRMD		(1 <<  1)	/* Transmit/Receive Mode Select */
@@ -274,7 +275,7 @@ static int rsnd_ssi_init(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
-	cr = FORCE;
+	cr = FORCE | PDTA;
 
 	/*
 	 * always use 32bit system word for easy clock calculation.
-- 
2.6.2
