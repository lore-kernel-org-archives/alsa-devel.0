From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH] ASoC: multi-component - SAMSUNG - Fix compile
	error
Date: Fri, 23 Jul 2010 09:49:36 +0900
Message-ID: <1279846176-29790-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id BEB68243AE
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 03:01:29 +0200 (CEST)
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch fixes compile error on smdk_wm9713.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/smdk_wm9713.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 849aac1..90108a7 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -48,7 +48,7 @@ static struct snd_soc_dai_link smdk_dai = {
 	.stream_name = "AC97 PCM",
 	.platform_name = "s3c24xx-pcm-audio",
 	.cpu_dai_name = "s3c-ac97-dai",
-	.codec_dai_name = "wm9713-hifi"
+	.codec_dai_name = "wm9713-hifi",
 	.codec_name = "wm9713-codec",
 };
 
-- 
1.6.2.5
