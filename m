From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_esai: ETDR and TX0~5 registers are
	non volatile
Date: Mon, 26 Oct 2015 15:19:02 +0800
Message-ID: <1445843945-13319-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 by alsa0.perex.cz (Postfix) with ESMTP id E14692604A1
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:17:14 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org

ETDR and TX0~5 registers are writable and not readable. So they are non
volatile. Remove them from volatile list, and add default register value for
them.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index aab675a..dd5fde4 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -653,21 +653,28 @@ static const struct snd_soc_component_driver fsl_esai_component = {
 };
 
 static const struct reg_default fsl_esai_reg_defaults[] = {
-	{0x8,  0x00000000},
-	{0x10, 0x00000000},
-	{0x18, 0x00000000},
-	{0x98, 0x00000000},
-	{0xd0, 0x00000000},
-	{0xd4, 0x00000000},
-	{0xd8, 0x00000000},
-	{0xdc, 0x00000000},
-	{0xe0, 0x00000000},
-	{0xe4, 0x0000ffff},
-	{0xe8, 0x0000ffff},
-	{0xec, 0x0000ffff},
-	{0xf0, 0x0000ffff},
-	{0xf8, 0x00000000},
-	{0xfc, 0x00000000},
+	{REG_ESAI_ETDR,	 0x00000000},
+	{REG_ESAI_ECR,	 0x00000000},
+	{REG_ESAI_TFCR,	 0x00000000},
+	{REG_ESAI_RFCR,	 0x00000000},
+	{REG_ESAI_TX0,	 0x00000000},
+	{REG_ESAI_TX1,	 0x00000000},
+	{REG_ESAI_TX2,	 0x00000000},
+	{REG_ESAI_TX3,	 0x00000000},
+	{REG_ESAI_TX4,	 0x00000000},
+	{REG_ESAI_TX5,	 0x00000000},
+	{REG_ESAI_TSR,	 0x00000000},
+	{REG_ESAI_SAICR, 0x00000000},
+	{REG_ESAI_TCR,	 0x00000000},
+	{REG_ESAI_TCCR,	 0x00000000},
+	{REG_ESAI_RCR,	 0x00000000},
+	{REG_ESAI_RCCR,	 0x00000000},
+	{REG_ESAI_TSMA,  0x0000ffff},
+	{REG_ESAI_TSMB,  0x0000ffff},
+	{REG_ESAI_RSMA,  0x0000ffff},
+	{REG_ESAI_RSMB,  0x0000ffff},
+	{REG_ESAI_PRRC,  0x00000000},
+	{REG_ESAI_PCRC,  0x00000000},
 };
 
 static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
@@ -705,17 +712,10 @@ static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
 static bool fsl_esai_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case REG_ESAI_ETDR:
 	case REG_ESAI_ERDR:
 	case REG_ESAI_ESR:
 	case REG_ESAI_TFSR:
 	case REG_ESAI_RFSR:
-	case REG_ESAI_TX0:
-	case REG_ESAI_TX1:
-	case REG_ESAI_TX2:
-	case REG_ESAI_TX3:
-	case REG_ESAI_TX4:
-	case REG_ESAI_TX5:
 	case REG_ESAI_RX0:
 	case REG_ESAI_RX1:
 	case REG_ESAI_RX2:
-- 
1.9.1
