From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Blackfin: bf5xx-ad193x: Fix codec device
	name
Date: Mon,  5 Sep 2011 13:49:57 +0200
Message-ID: <1315223397-18627-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-047.synserver.de
	[212.40.185.47]) by alsa0.perex.cz (Postfix) with SMTP id 4BED824582
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 13:50:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, stable@kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Fix the codec_name field of the dai_link to match the actual device name
of the codec. Otherwise the card won't be instantiated.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@kernel.org
---
 sound/soc/blackfin/bf5xx-ad193x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index a118a0f..5956584 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -103,7 +103,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
 		.cpu_dai_name = "bfin-tdm.0",
 		.codec_dai_name ="ad193x-hifi",
 		.platform_name = "bfin-tdm-pcm-audio",
-		.codec_name = "ad193x.5",
+		.codec_name = "spi0.5",
 		.ops = &bf5xx_ad193x_ops,
 	},
 	{
@@ -112,7 +112,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
 		.cpu_dai_name = "bfin-tdm.1",
 		.codec_dai_name ="ad193x-hifi",
 		.platform_name = "bfin-tdm-pcm-audio",
-		.codec_name = "ad193x.5",
+		.codec_name = "spi0.5",
 		.ops = &bf5xx_ad193x_ops,
 	},
 };
-- 
1.7.2.5
