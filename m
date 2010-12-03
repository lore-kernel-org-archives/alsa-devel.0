From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 1/3] ASoC: SAMSUNG: Fix initial return value
Date: Fri,  3 Dec 2010 18:27:33 +0900
Message-ID: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id AD503243D3
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 10:43:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch fixed intial return value to be a '0' as asuccess on
set_audio_clock_heirachy(). This avoids unintended error on initialize.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/smdk_spdif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
index c8bd904..cb658d1 100644
--- a/sound/soc/s3c24xx/smdk_spdif.c
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -28,7 +28,7 @@
 static int set_audio_clock_heirachy(struct platform_device *pdev)
 {
 	struct clk *fout_epll, *mout_epll, *sclk_audio0, *sclk_spdif;
-	int ret;
+	int ret = 0;
 
 	fout_epll = clk_get(NULL, "fout_epll");
 	if (IS_ERR(fout_epll)) {
-- 
1.6.2.5
