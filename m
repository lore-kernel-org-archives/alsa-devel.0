From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source clock id
	and asoc platform device
Date: Fri,  3 Dec 2010 18:37:47 +0900
Message-ID: <1291369067-31429-1-git-send-email-sw.youn@samsung.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FBBC243D6
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 10:53:24 +0100 (CET)
In-Reply-To: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
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

This patch modify to match ids between source clock id and asoc platform
device that spdif driver can find sclk_audio0 with device id.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/smdk_spdif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
index 0e1fe60..b4ad231 100644
--- a/sound/soc/s3c24xx/smdk_spdif.c
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -183,7 +183,7 @@ static int __init smdk_init(void)
 	if (ret)
 		goto err2;
 
-	smdk_snd_spdif_device = platform_device_alloc("soc-audio", -1);
+	smdk_snd_spdif_device = platform_device_alloc("soc-audio", 0);
 	if (!smdk_snd_spdif_device) {
 		ret = -ENOMEM;
 		goto err2;
-- 
1.6.2.5
