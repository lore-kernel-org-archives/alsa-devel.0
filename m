From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 4/6] ASoC: fsl_sai: Drop useless ret in
	startup()
Date: Fri, 20 Dec 2013 16:41:03 +0800
Message-ID: <6c05a9f89171d8b33ee088ec9530560f29da5d2b.1387528048.git.Guangyu.Chen@freescale.com>
References: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DB02655DB
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:40:50 +0100 (CET)
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

We can save this ret to make the code neater.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f899e82..d9ce79e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -334,12 +334,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 static int fsl_sai_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
-	int ret;
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 
-	ret = clk_prepare_enable(sai->clk);
-
-	return ret;
+	return clk_prepare_enable(sai->clk);
 }
 
 static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
-- 
1.8.4
