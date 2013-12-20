From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 1/6] ASoC: fsl_sai: Keep symmetry for
	clk_enable() and clk_disable()
Date: Fri, 20 Dec 2013 16:41:00 +0800
Message-ID: <b5eeb6facf2573f53bebd486b383ecf29e20c15b.1387528048.git.Guangyu.Chen@freescale.com>
References: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A0D265383
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:40:39 +0100 (CET)
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

There are two functions haven't clk_disable_unprepare() if having error.
Thus fix them.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 50a797e..e3e8aa1 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -111,7 +111,7 @@ static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		dev_err(cpu_dai->dev,
 				"Cannot set SAI's transmitter sysclk: %d\n",
 				ret);
-		return ret;
+		goto err_clk;
 	}
 
 	ret = fsl_sai_set_dai_sysclk_tr(cpu_dai, clk_id, freq,
@@ -120,12 +120,13 @@ static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		dev_err(cpu_dai->dev,
 				"Cannot set SAI's receiver sysclk: %d\n",
 				ret);
-		return ret;
+		goto err_clk;
 	}
 
+err_clk:
 	clk_disable_unprepare(sai->clk);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
@@ -222,7 +223,7 @@ static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		dev_err(cpu_dai->dev,
 				"Cannot set SAI's transmitter format: %d\n",
 				ret);
-		return ret;
+		goto err_clk;
 	}
 
 	ret = fsl_sai_set_dai_fmt_tr(cpu_dai, fmt, FSL_FMT_RECEIVER);
@@ -230,12 +231,13 @@ static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		dev_err(cpu_dai->dev,
 				"Cannot set SAI's receiver format: %d\n",
 				ret);
-		return ret;
+		goto err_clk;
 	}
 
+err_clk:
 	clk_disable_unprepare(sai->clk);
 
-	return 0;
+	return ret;
 }
 
 static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
-- 
1.8.4
