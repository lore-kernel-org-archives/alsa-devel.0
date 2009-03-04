From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/4] pxa-ssp: fix name of register bit
Date: Wed,  4 Mar 2009 21:16:57 +0100
Message-ID: <1236197820-21022-1-git-send-email-daniel@caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B81581038C5
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:17:11 +0100 (CET)
In-Reply-To: <20090304201505.GE12183@buzzloop.caiaq.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

A bit in PXA's SSCR0 register was erroneously named ADC but its name is
in fact ADC (audio clock select).

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@kernel.org>
Cc: Tim Ruetz <tim@caiaq.de>
---
 arch/arm/mach-pxa/include/mach/regs-ssp.h |    2 +-
 sound/soc/pxa/pxa-ssp.c                   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/regs-ssp.h b/arch/arm/mach-pxa/include/mach/regs-ssp.h
index 34eda82..70e0b81 100644
--- a/arch/arm/mach-pxa/include/mach/regs-ssp.h
+++ b/arch/arm/mach-pxa/include/mach/regs-ssp.h
@@ -50,7 +50,7 @@
 #define SSCR0_TUM	(1 << 23)	/* Transmit FIFO underrun interrupt mask */
 #define SSCR0_FRDC	(0x07000000)	/* Frame rate divider control (mask) */
 #define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24)	/* Time slots per frame [1..8] */
-#define SSCR0_ADC	(1 << 30)	/* Audio clock select */
+#define SSCR0_ACS	(1 << 30)	/* Audio clock select */
 #define SSCR0_MOD	(1 << 31)	/* Mode (normal or network) */
 #endif
 
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c49bb12..7fc13f0 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -300,7 +300,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	int val;
 
 	u32 sscr0 = ssp_read_reg(ssp, SSCR0) &
-		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ADC);
+		~(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 
 	dev_dbg(&ssp->pdev->dev,
 		"pxa_ssp_set_dai_sysclk id: %d, clk_id %d, freq %d\n",
@@ -328,7 +328,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case PXA_SSP_CLK_AUDIO:
 		priv->sysclk = 0;
 		ssp_set_scr(&priv->dev, 1);
-		sscr0 |= SSCR0_ADC;
+		sscr0 |= SSCR0_ACS;
 		break;
 	default:
 		return -ENODEV;
@@ -524,7 +524,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 	/* reset port settings */
 	sscr0 = ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ADC);
+		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp = 0;
 
-- 
1.6.1.3
