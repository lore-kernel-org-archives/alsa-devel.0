From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 02/20] ASoC: S3C: I2Sv2: Reject immidiate
	register value
Date: Wed, 10 Mar 2010 16:48:51 +0900
Message-ID: <1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 88EE424335
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
In-Reply-To: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Towards generalizing CPU driver interface, do not accept direct field
values for the BCLK and RCLK.
The machine driver should simply request the FS-multiple and not provide
the value to be set in divide field of IISMOD.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   68 +++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 8f08508..fd5c842 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -469,29 +469,25 @@ static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 
 	switch (div_id) {
 	case S3C_I2SV2_DIV_BCLK:
-		if (div > 3) {
-			/* convert value to bit field */
-
-			switch (div) {
-			case 16:
-				div = S3C2412_IISMOD_BCLK_16FS;
-				break;
+		switch (div) {
+		case 16:
+			div = S3C2412_IISMOD_BCLK_16FS;
+			break;
 
-			case 32:
-				div = S3C2412_IISMOD_BCLK_32FS;
-				break;
+		case 32:
+			div = S3C2412_IISMOD_BCLK_32FS;
+			break;
 
-			case 24:
-				div = S3C2412_IISMOD_BCLK_24FS;
-				break;
+		case 24:
+			div = S3C2412_IISMOD_BCLK_24FS;
+			break;
 
-			case 48:
-				div = S3C2412_IISMOD_BCLK_48FS;
-				break;
+		case 48:
+			div = S3C2412_IISMOD_BCLK_48FS;
+			break;
 
-			default:
-				return -EINVAL;
-			}
+		default:
+			return -EINVAL;
 		}
 
 		reg = readl(i2s->regs + S3C2412_IISMOD);
@@ -502,29 +498,25 @@ static int s3c2412_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai,
 		break;
 
 	case S3C_I2SV2_DIV_RCLK:
-		if (div > 3) {
-			/* convert value to bit field */
-
-			switch (div) {
-			case 256:
-				div = S3C2412_IISMOD_RCLK_256FS;
-				break;
+		switch (div) {
+		case 256:
+			div = S3C2412_IISMOD_RCLK_256FS;
+			break;
 
-			case 384:
-				div = S3C2412_IISMOD_RCLK_384FS;
-				break;
+		case 384:
+			div = S3C2412_IISMOD_RCLK_384FS;
+			break;
 
-			case 512:
-				div = S3C2412_IISMOD_RCLK_512FS;
-				break;
+		case 512:
+			div = S3C2412_IISMOD_RCLK_512FS;
+			break;
 
-			case 768:
-				div = S3C2412_IISMOD_RCLK_768FS;
-				break;
+		case 768:
+			div = S3C2412_IISMOD_RCLK_768FS;
+			break;
 
-			default:
-				return -EINVAL;
-			}
+		default:
+			return -EINVAL;
 		}
 
 		reg = readl(i2s->regs + S3C2412_IISMOD);
-- 
1.6.2.5
