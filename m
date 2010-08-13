From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 3/5] ASoC: update setting for pxa ssp slave mode
Date: Fri, 13 Aug 2010 21:55:35 +0800
Message-ID: <AANLkTim4BHjyC4=NeVVb-+HnLnzmyBrq8vDE4PCuP7d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DBE51038FC
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 15:55:36 +0200 (CEST)
Received: by wwd20 with SMTP id 20so781390wwd.2
	for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2010 06:55:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From 9f782068c395df2a7b3f8b2de232453ef5f8b96d Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Thu, 12 Aug 2010 11:48:00 +0800
Subject: [PATCH 3/5] ASoC: update setting for pxa ssp slave mode

SCFR bit is required to be always set if pxa ssp is in slave mode. This bit
indicates clock input to SSPSCLK is only active during data transfers.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c4f480d..8dfbcda 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -462,9 +462,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct ssp_priv *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	struct ssp_device *ssp = priv->ssp;
-	u32 sscr0;
-	u32 sscr1;
-	u32 sspsp;
+	u32 sscr0, sscr1, sspsp, scfr;

 	/* check if we need to change anything at all */
 	if (priv->dai_fmt == fmt)
@@ -479,16 +477,16 @@ static int pxa_ssp_set_dai_fmt(struct
snd_soc_dai *cpu_dai,

 	/* reset port settings */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp = 0;

 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR;
+		sscr1 |= SSCR1_SCLKDIR | SSCR1_SFRMDIR | SSCR1_SCFR;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		sscr1 |= SSCR1_SCLKDIR;
+		sscr1 |= SSCR1_SCLKDIR | SSCR1_SCFR;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
@@ -534,6 +532,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
 	pxa_ssp_write_reg(ssp, SSPSP, sspsp);

+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+		scfr = pxa_ssp_read_reg(ssp, SSCR1) | SSCR1_SCFR;
+		pxa_ssp_write_reg(ssp, SSCR1, scfr);
+
+		while (pxa_ssp_read_reg(ssp, SSSR) & SSSR_BSY)
+			cpu_relax();
+		break;
+	}
+
 	dump_registers(ssp);

 	/* Since we are configuring the timings for the format by hand
@@ -583,10 +592,8 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,

 	/* clear selected SSP bits */
 	sscr0 = pxa_ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	pxa_ssp_write_reg(ssp, SSCR0, sscr0);

 	/* bit size */
-	sscr0 = pxa_ssp_read_reg(ssp, SSCR0);
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 #ifdef CONFIG_PXA3xx
-- 
1.5.6.5
