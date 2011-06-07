From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Blackfin: bf5xx-ad1836: Fix codec device
	name
Date: Tue,  7 Jun 2011 10:24:46 +0200
Message-ID: <1307435086-29877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-002.synserver.de (smtp-out-002.synserver.de
	[212.40.185.2]) by alsa0.perex.cz (Postfix) with SMTP id 585B12433B
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:25:41 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Fix the codec_name field of the dai_link to match the actual device name
of the codec. Otherwise the card won't be instantiated.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ad1836.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index ea4951c..f79d165 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -75,7 +75,7 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
 		.cpu_dai_name = "bfin-tdm.0",
 		.codec_dai_name = "ad1836-hifi",
 		.platform_name = "bfin-tdm-pcm-audio",
-		.codec_name = "ad1836.0",
+		.codec_name = "spi0.4",
 		.ops = &bf5xx_ad1836_ops,
 	},
 	{
@@ -84,7 +84,7 @@ static struct snd_soc_dai_link bf5xx_ad1836_dai[] = {
 		.cpu_dai_name = "bfin-tdm.1",
 		.codec_dai_name = "ad1836-hifi",
 		.platform_name = "bfin-tdm-pcm-audio",
-		.codec_name = "ad1836.0",
+		.codec_name = "spi0.4",
 		.ops = &bf5xx_ad1836_ops,
 	},
 };
-- 
1.7.2.5
