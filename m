From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: [PATCH] ASoC: Fix at32-pcm build breakage with PM
	enabled
Date: Fri, 19 Sep 2008 22:13:26 +0200
Message-ID: <1221855206-2337-1-git-send-email-haavard.skinnemoen@atmel.com>
References: <20080919192513.GA18851@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	by alsa0.perex.cz (Postfix) with ESMTP id E9485246BF
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Sep 2008 22:13:51 +0200 (CEST)
Received: from fribh01.corp.atmel.com (FRIBH01 [10.175.30.10])
	by bagnes.atmel.com (8.13.8+Sun/8.13.8) with ESMTP id m8JK9qNL017219
	for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2008 13:09:52 -0700 (PDT)
In-Reply-To: <20080919192513.GA18851@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
List-Id: alsa-devel@alsa-project.org

s/PDC_PTCR/ATMEL_PDC_PTCR/

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/at32/at32-pcm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/at32/at32-pcm.c b/sound/soc/at32/at32-pcm.c
index 435f1da..c83584f 100644
--- a/sound/soc/at32/at32-pcm.c
+++ b/sound/soc/at32/at32-pcm.c
@@ -434,7 +434,8 @@ static int at32_pcm_suspend(struct platform_device *pdev,
 	params = prtd->params;
 
 	/* Disable the PDC and save the PDC registers */
-	ssc_writex(params->ssc->regs, PDC_PTCR, params->mask->pdc_disable);
+	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR,
+		   params->mask->pdc_disable);
 
 	prtd->pdc_xpr_save = ssc_readx(params->ssc->regs, params->pdc->xpr);
 	prtd->pdc_xcr_save = ssc_readx(params->ssc->regs, params->pdc->xcr);
@@ -464,7 +465,7 @@ static int at32_pcm_resume(struct platform_device *pdev,
 	ssc_writex(params->ssc->regs, params->pdc->xnpr, prtd->pdc_xnpr_save);
 	ssc_writex(params->ssc->regs, params->pdc->xncr, prtd->pdc_xncr_save);
 
-	ssc_writex(params->ssc->regs, PDC_PTCR, params->mask->pdc_enable);
+	ssc_writex(params->ssc->regs, ATMEL_PDC_PTCR, params->mask->pdc_enable);
 	return 0;
 }
 #else /* CONFIG_PM */
-- 
1.5.6.5
