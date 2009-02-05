From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] ASoC: pxa-ssp: disable only when the ssp dai
	is active
Date: Thu, 5 Feb 2009 18:42:13 +0800
Message-ID: <f17812d70902050242h145788b7s34a34d34f6f26c06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id BD6AE1037F4
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 11:42:14 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so179563rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 05 Feb 2009 02:42:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From aa615ac25173dc6f610d8f6ec55cb9d7d8894124 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 5 Feb 2009 18:39:20 +0800
Subject: [PATCH] ASoC: pxa-ssp: disable only when the ssp dai is active

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---

Typo?

 sound/soc/pxa/pxa-ssp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4a973ab..3f12b45 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -238,7 +238,7 @@ static void pxa_ssp_shutdown(struct
snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct ssp_priv *priv = cpu_dai->private_data;

-	if (!cpu_dai->active) {
+	if (cpu_dai->active) {
 		ssp_disable(&priv->dev);
 		clk_disable(priv->dev.ssp->clk);
 	}
-- 
1.6.0.4
