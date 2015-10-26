From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl_ssi: using macro for default
	register map
Date: Mon, 26 Oct 2015 15:19:05 +0800
Message-ID: <1445843945-13319-4-git-send-email-zidan.wang@freescale.com>
References: <1445843945-13319-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 53FC22604A1
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:17:27 +0100 (CET)
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

using macro for default register map

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 95d2392..674abf7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -113,17 +113,17 @@ struct fsl_ssi_rxtx_reg_val {
 };
 
 static const struct reg_default fsl_ssi_reg_defaults[] = {
-	{0x10, 0x00000000},
-	{0x18, 0x00003003},
-	{0x1c, 0x00000200},
-	{0x20, 0x00000200},
-	{0x24, 0x00040000},
-	{0x28, 0x00040000},
-	{0x38, 0x00000000},
-	{0x48, 0x00000000},
-	{0x4c, 0x00000000},
-	{0x54, 0x00000000},
-	{0x58, 0x00000000},
+	{CCSR_SSI_SCR,     0x00000000},
+	{CCSR_SSI_SIER,    0x00003003},
+	{CCSR_SSI_STCR,    0x00000200},
+	{CCSR_SSI_SRCR,    0x00000200},
+	{CCSR_SSI_STCCR,   0x00040000},
+	{CCSR_SSI_SRCCR,   0x00040000},
+	{CCSR_SSI_SACNT,   0x00000000},
+	{CCSR_SSI_STMSK,   0x00000000},
+	{CCSR_SSI_SRMSK,   0x00000000},
+	{CCSR_SSI_SACCEN,  0x00000000},
+	{CCSR_SSI_SACCDIS, 0x00000000},
 };
 
 static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
-- 
1.9.1
