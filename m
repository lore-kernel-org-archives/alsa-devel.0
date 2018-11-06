From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: pxa-ssp: make suspend call resilient
	against multiple invocations
Date: Tue,  6 Nov 2018 12:20:20 +0100
Message-ID: <20181106112020.10901-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 154CD2678DF
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 12:20:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The suspend callback is called twice when the machine is suspended, once
through the ASoC layer and once through the platform device layer. Make sure
not to confuse the clock layer with unbalanced calls, and bail out early if
we are already suspended.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/pxa-ssp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index adcf8ba9d287..fd93706702a6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -51,6 +51,7 @@ struct ssp_priv {
 	uint32_t	cr1;
 	uint32_t	to;
 	uint32_t	psp;
+	bool		suspended;
 #endif
 };
 
@@ -142,6 +143,9 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
 
+	if (priv->suspended)
+		return 0;
+
 	if (!cpu_dai->active)
 		clk_prepare_enable(ssp->clk);
 
@@ -152,6 +156,8 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 
 	pxa_ssp_disable(ssp);
 	clk_disable_unprepare(ssp->clk);
+	priv->suspended = true;
+
 	return 0;
 }
 
@@ -161,6 +167,9 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	struct ssp_device *ssp = priv->ssp;
 	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;
 
+	if (!priv->suspended)
+		return 0;
+
 	clk_prepare_enable(ssp->clk);
 
 	__raw_writel(sssr, ssp->mmio_base + SSSR);
@@ -174,6 +183,8 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	else
 		clk_disable_unprepare(ssp->clk);
 
+	priv->suspended = false;
+
 	return 0;
 }
 
-- 
2.17.2
