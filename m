From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 1/3] ASoC: S3C: AC97: Remove the -dai suffix
Date: Fri, 10 Sep 2010 16:40:31 +0900
Message-ID: <1284104431-14378-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF3C103932
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:57:24 +0200 (CEST)
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
Cc: sw.youn@samsung.com, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Drop the invalid -dai suffix appended to the Samsung AC97 CPU DAI.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/smdk2443_wm9710.c |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 66f9e22..4613288 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -28,7 +28,7 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "s3c-ac97-dai",
+	.cpu_dai_name = "s3c-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
 	.platform_name = "s3c24xx-pcm-audio",
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 90108a7..11086f8 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -47,7 +47,7 @@ static struct snd_soc_dai_link smdk_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 PCM",
 	.platform_name = "s3c24xx-pcm-audio",
-	.cpu_dai_name = "s3c-ac97-dai",
+	.cpu_dai_name = "s3c-ac97",
 	.codec_dai_name = "wm9713-hifi",
 	.codec_name = "wm9713-codec",
 };
-- 
1.6.2.5
