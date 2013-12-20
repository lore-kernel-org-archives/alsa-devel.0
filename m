From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 5/6] ASoC: fsl_sai: Make dev_err information
	neater
Date: Fri, 20 Dec 2013 16:41:04 +0800
Message-ID: <9bae253fe9e848807196a667fd48ccc2954dc915.1387528048.git.Guangyu.Chen@freescale.com>
References: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EAFE26538A
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:40:52 +0100 (CET)
In-Reply-To: <cover.1387528048.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux@arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

Since using dev_err() there's no need to mention SAI any more, it will
print the full name of the driver -- fsl_sai.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d9ce79e..ba59015 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -108,18 +108,14 @@ static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
 					FSL_FMT_TRANSMITTER);
 	if (ret) {
-		dev_err(cpu_dai->dev,
-				"Cannot set SAI's transmitter sysclk: %d\n",
-				ret);
+		dev_err(cpu_dai->dev, "Cannot set tx sysclk: %d\n", ret);
 		goto err_clk;
 	}
 
 	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
 					FSL_FMT_RECEIVER);
 	if (ret) {
-		dev_err(cpu_dai->dev,
-				"Cannot set SAI's receiver sysclk: %d\n",
-				ret);
+		dev_err(cpu_dai->dev, "Cannot set rx sysclk: %d\n", ret);
 		goto err_clk;
 	}
 
@@ -220,17 +216,13 @@ static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 
 	ret = fsl_sai_set_dai_fmt_tr(cpu_dai, fmt, FSL_FMT_TRANSMITTER);
 	if (ret) {
-		dev_err(cpu_dai->dev,
-				"Cannot set SAI's transmitter format: %d\n",
-				ret);
+		dev_err(cpu_dai->dev, "Cannot set tx format: %d\n", ret);
 		goto err_clk;
 	}
 
 	ret = fsl_sai_set_dai_fmt_tr(cpu_dai, fmt, FSL_FMT_RECEIVER);
 	if (ret) {
-		dev_err(cpu_dai->dev,
-				"Cannot set SAI's receiver format: %d\n",
-				ret);
+		dev_err(cpu_dai->dev, "Cannot set rx format: %d\n", ret);
 		goto err_clk;
 	}
 
-- 
1.8.4
