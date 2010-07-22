From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] ASoC: multi-component: SAMSUNG: Fix wrong
 field name on Aquila board
Date: Thu, 22 Jul 2010 12:47:03 +0900
Message-ID: <4C47BF37.9090008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A44782445F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 05:48:04 +0200 (CEST)
Received: from epmmp1. (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5X00DPMX6F5P50@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 22 Jul 2010 12:47:03 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net
	(unknown [165.213.149.150])
	by mmp1.samsung.com (Sun Java(tm) System Messaging Server 7u3-15.01
	64bit
	(built Feb 12 2010)) with ESMTPA id <0L5X0021XX6FL910@mmp1.samsung.com>
	for
	alsa-devel@alsa-project.org; Thu, 22 Jul 2010 12:47:03 +0900 (KST)
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
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch modify the wrong field name on Aquila board.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/s3c24xx/aquila_wm8994.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
index f6f0e60..69c41eb 100644
--- a/sound/soc/s3c24xx/aquila_wm8994.c
+++ b/sound/soc/s3c24xx/aquila_wm8994.c
@@ -242,7 +242,7 @@ static struct snd_soc_dai_link aquila_dai[] = {
 }, {
 	.name = "WM8994 Voice",
 	.stream_name = "Voice",
-	.cpu_dai_drv = "aquila-voice-dai",
+	.cpu_dai_name = "aquila-voice-dai",
 	.codec_dai_name = "wm8994-voice",
 	.platform_name = "s3c24xx-pcm-audio",
 	.codec_name = "wm8994-codec",
-- 
1.6.3.3
