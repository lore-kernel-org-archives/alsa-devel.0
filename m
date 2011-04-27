From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix CODEC name in Goni
Date: Wed, 27 Apr 2011 18:21:47 +0100
Message-ID: <1303924907-25708-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88A0124380
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 19:21:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This was typoed at some point in the multi-component merge, though the
driver was added along with that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/goni_wm8994.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index f6b3a3c..3a7861c 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -238,7 +238,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.cpu_dai_name = "samsung-i2s.0",
 	.codec_dai_name = "wm8994-hifi",
 	.platform_name = "samsung-audio",
-	.codec_name = "wm8994-codec.0-0x1a",
+	.codec_name = "wm8994-codec.0-001a",
 	.init = goni_wm8994_init,
 	.ops = &goni_hifi_ops,
 }, {
@@ -247,7 +247,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.cpu_dai_name = "goni-voice-dai",
 	.codec_dai_name = "wm8994-voice",
 	.platform_name = "samsung-audio",
-	.codec_name = "wm8994-codec.0-0x1a",
+	.codec_name = "wm8994-codec.0-001a",
 	.ops = &goni_voice_ops,
 },
 };
-- 
1.7.4.1
