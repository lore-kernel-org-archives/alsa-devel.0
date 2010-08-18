From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Fix device name for AT91SAM9G20-EK
	devices
Date: Wed, 18 Aug 2010 16:30:41 +0100
Message-ID: <1282145442-32678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 792EB2412E
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 17:30:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A couple of typos in the multi-component conversion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 8399ac4..cf029a8 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -183,8 +183,8 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.cpu_dai_name = "atmel-ssc-dai.0",
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
-	.platform_name = "atmel_pcm-audio",
-	.codec_name = "wm8731-codec.0-001a",
+	.platform_name = "atmel-pcm-audio",
+	.codec_name = "wm8731-codec.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
 
-- 
1.7.1
