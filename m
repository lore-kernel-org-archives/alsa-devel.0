From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup rsnd_dmapp_stop() return
	value" to the asoc tree
Date: Wed, 28 Oct 2015 13:57:52 +0900
Message-ID: <E1ZrIo4-00042j-UH@finisterre>
References: <87twpb8vqj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D49DA26586C
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 05:58:05 +0100 (CET)
In-Reply-To: <87twpb8vqj.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup rsnd_dmapp_stop() return value

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

>From 8e1b5e70e7fa7c2c2df1ab37047a8e14ecdbb5ca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Oct 2015 04:31:03 +0000
Subject: [PATCH] ASoC: rsnd: fixup rsnd_dmapp_stop() return value

45a4394d03("ASoC: rsnd: use mod base common method on DMA phase3")
Exchanged "void rsnd_dmapp_stop()" to "int rsnd_dmapp_stop()",
but it returns inverted value. This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index fc70e97..9917b985 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -368,11 +368,11 @@ static int rsnd_dmapp_stop(struct rsnd_mod *mod,
 
 	for (i = 0; i < 1024; i++) {
 		if (0 == rsnd_dmapp_read(dma, PDMACHCR))
-			return -EIO;
+			return 0;
 		udelay(1);
 	}
 
-	return 0;
+	return -EIO;
 }
 
 static int rsnd_dmapp_start(struct rsnd_mod *mod,
-- 
2.6.1
