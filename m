From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: spdif: Fix DMA filter
	initialization" to the asoc tree
Date: Wed, 02 Nov 2016 10:48:54 -0600
Message-ID: <E1c1yic-0006DE-MS@finisterre>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0282646989419683220=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D96A2659AA
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 17:49:08 +0100 (CET)
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
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============0282646989419683220==
Content-Type: text/plain

The patch

   ASoC: samsung: spdif: Fix DMA filter initialization

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

>From a4513320423a388ed55eb0754353f46b10d05a99 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 2 Nov 2016 12:03:03 +0100
Subject: [PATCH] ASoC: samsung: spdif: Fix DMA filter initialization
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes issues introduced in commit 73f5dfc68316bef2ab7062ec
"ASoC: samsung: get access to DMA engine early to defer probe properly"
and indicated by a following compilation warning:

  CC [M]  sound/soc/samsung/spdif.o
sound/soc/samsung/spdif.c: In function ‘spdif_probe’:
sound/soc/samsung/spdif.c:419:6: warning: ‘filter’ may be used uninitialized
in this function [-Wuninitialized]

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/spdif.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 704b7b12bf8b..779504f54bc0 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -416,6 +416,15 @@ static int spdif_probe(struct platform_device *pdev)
 		goto err3;
 	}
 
+	spdif_stereo_out.addr_width = 2;
+	spdif_stereo_out.addr = mem_res->start + DATA_OUTBUF;
+	filter = NULL;
+	if (spdif_pdata) {
+		spdif_stereo_out.filter_data = spdif_pdata->dma_playback;
+		filter = spdif_pdata->dma_filter;
+	}
+	spdif->dma_playback = &spdif_stereo_out;
+
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
 						 NULL, NULL);
 	if (ret) {
@@ -432,16 +441,6 @@ static int spdif_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
-	spdif_stereo_out.addr_width = 2;
-	spdif_stereo_out.addr = mem_res->start + DATA_OUTBUF;
-	filter = NULL;
-	if (spdif_pdata) {
-		spdif_stereo_out.filter_data = spdif_pdata->dma_playback;
-		filter = spdif_pdata->dma_filter;
-	}
-
-	spdif->dma_playback = &spdif_stereo_out;
-
 	return 0;
 err4:
 	iounmap(spdif->regs);
-- 
2.10.1


--===============0282646989419683220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0282646989419683220==--
