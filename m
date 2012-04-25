From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: bf5xx-ssm2602: Set DAI format
Date: Wed, 25 Apr 2012 11:29:47 +0200
Message-ID: <1335346188-29823-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-093.synserver.de (smtp-out-100.synserver.de
	[212.40.185.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 882D6104837
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 11:27:32 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 980b0bc69 ("ASoC: blackfin: Use dai_fmt") converted the blackfin ASoC
machine drivers to use the dai_links dai_fmt field to setup their DAI format.
For the bf5xx-ssm2602 the commit removed the manual call to snd_soc_dai_set_fmt,
but missed to set the dai_links dai_fmt field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
The commit that introduced the problem is only in 3.4-rc

---
 sound/soc/blackfin/bf5xx-ssm2602.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index df3ac73..b39ad35 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -99,6 +99,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai[] = {
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "ssm2602.0-001b",
 		.ops = &bf5xx_ssm2602_ops,
+		.dai_fmt = BF5XX_SSM2602_DAIFMT,
 	},
 	{
 		.name = "ssm2602",
@@ -108,6 +109,7 @@ static struct snd_soc_dai_link bf5xx_ssm2602_dai[] = {
 		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "ssm2602.0-001b",
 		.ops = &bf5xx_ssm2602_ops,
+		.dai_fmt = BF5XX_SSM2602_DAIFMT,
 	},
 };
 
-- 
1.7.9.5
