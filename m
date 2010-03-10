From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 01/20] ASoC: S3C: I2Sv2: Add missing semicolon
Date: Wed, 10 Mar 2010 16:48:50 +0900
Message-ID: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B75A2433E
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
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

Add missing semicolon after s3c2412_i2s_delay

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index aa84f4c..8f08508 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -753,7 +753,7 @@ int s3c_i2sv2_register_dai(struct snd_soc_dai *dai)
 
 	/* Allow overriding by (for example) IISv4 */
 	if (!ops->delay)
-		ops->delay = s3c2412_i2s_delay,
+		ops->delay = s3c2412_i2s_delay;
 
 	dai->suspend = s3c2412_i2s_suspend;
 	dai->resume = s3c2412_i2s_resume;
-- 
1.6.2.5
