From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_spdif: STL and STR registers are non
	volatile
Date: Mon, 26 Oct 2015 15:19:04 +0800
Message-ID: <1445843945-13319-3-git-send-email-zidan.wang@freescale.com>
References: <1445843945-13319-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 by alsa0.perex.cz (Postfix) with ESMTP id DD79A2604A9
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:17:21 +0100 (CET)
In-Reply-To: <1445843945-13319-1-git-send-email-zidan.wang@freescale.com>
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

STL and STR registers are writable and not readable. So they are non volatile.
Remove them from volatile list, and add default register value for them.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3d59bb6..28a8823 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1006,12 +1006,14 @@ static const struct snd_soc_component_driver fsl_spdif_component = {
 
 /* FSL SPDIF REGMAP */
 static const struct reg_default fsl_spdif_reg_defaults[] = {
-	{0x0,  0x00000400},
-	{0x4,  0x00000000},
-	{0xc,  0x00000000},
-	{0x34, 0x00000000},
-	{0x38, 0x00000000},
-	{0x50, 0x00020f00},
+	{REG_SPDIF_SCR,    0x00000400},
+	{REG_SPDIF_SRCD,   0x00000000},
+	{REG_SPDIF_SIE,	   0x00000000},
+	{REG_SPDIF_STL,	   0x00000000},
+	{REG_SPDIF_STR,	   0x00000000},
+	{REG_SPDIF_STCSCH, 0x00000000},
+	{REG_SPDIF_STCSCL, 0x00000000},
+	{REG_SPDIF_STC,	   0x00020f00},
 };
 
 static bool fsl_spdif_readable_reg(struct device *dev, unsigned int reg)
@@ -1049,8 +1051,6 @@ static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int reg)
 	case REG_SPDIF_SRCSL:
 	case REG_SPDIF_SRU:
 	case REG_SPDIF_SRQ:
-	case REG_SPDIF_STL:
-	case REG_SPDIF_STR:
 	case REG_SPDIF_SRFM:
 		return true;
 	default:
-- 
1.9.1
