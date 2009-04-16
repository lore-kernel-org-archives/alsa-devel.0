From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] ASoC: Fix jive_wm8750.c build problems
Date: Thu, 16 Apr 2009 10:32:20 +0100
Message-ID: <1239874343-7280-2-git-send-email-ben-linux@fluff.org>
References: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 4302410394C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:36:13 +0200 (CEST)
In-Reply-To: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Fix build errors in sound/soc/s3c24xx/jive_wm8750.c
from changes to ASoC.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 sound/soc/s3c24xx/jive_wm8750.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 3206379..93e6c87 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -69,8 +69,8 @@ static int jive_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	s3c_i2sv2_calc_rate(&div, NULL, params_rate(params),
-			    s3c2412_get_iisclk());
+	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
+				s3c2412_get_iisclk());
 
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
@@ -145,8 +145,9 @@ static struct snd_soc_dai_link jive_dai = {
 };
 
 /* jive audio machine driver */
-static struct snd_soc_machine snd_soc_machine_jive = {
+static struct snd_soc_card snd_soc_machine_jive = {
 	.name		= "Jive",
+	.platform	= &s3c24xx_soc_platform,
 	.dai_link	= &jive_dai,
 	.num_links	= 1,
 };
@@ -157,9 +158,8 @@ static struct wm8750_setup_data jive_wm8750_setup = {
 
 /* jive audio subsystem */
 static struct snd_soc_device jive_snd_devdata = {
-	.machine	= &snd_soc_machine_jive,
-	.platform	= &s3c24xx_soc_platform,
-	.codec_dev	= &soc_codec_dev_wm8750_spi,
+	.card		= &snd_soc_machine_jive,
+	.codec_dev	= &soc_codec_dev_wm8750,
 	.codec_data	= &jive_wm8750_setup,
 };
 
-- 
1.5.6.5
