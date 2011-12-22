From: linux@audioscience.com
Subject: [PATCH 17/21] Distinguish four different emif init
	errors.
Date: Thu, 22 Dec 2011 13:38:47 +1300
Message-ID: <1324514331-22570-18-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 720A1103C3F
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:18 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:32 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/hpi6205.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index e3d0f55..4f28738 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -45,18 +45,21 @@
 #define HPI6205_ERROR_MSG_RESP_TIMEOUT          1016
 
 /* initialization/bootload errors */
-#define HPI6205_ERROR_6205_NO_IRQ               1002
-#define HPI6205_ERROR_6205_INIT_FAILED          1003
-#define HPI6205_ERROR_6205_REG                  1006
-#define HPI6205_ERROR_6205_DSPPAGE              1007
-#define HPI6205_ERROR_C6713_HPIC                1009
-#define HPI6205_ERROR_C6713_HPIA                1010
-#define HPI6205_ERROR_C6713_PLL                 1011
-#define HPI6205_ERROR_DSP_INTMEM                1012
-#define HPI6205_ERROR_DSP_EXTMEM                1013
-#define HPI6205_ERROR_DSP_PLD                   1014
-#define HPI6205_ERROR_6205_EEPROM               1017
-#define HPI6205_ERROR_DSP_EMIF                  1018
+#define HPI6205_ERROR_6205_NO_IRQ       1002
+#define HPI6205_ERROR_6205_INIT_FAILED  1003
+#define HPI6205_ERROR_6205_REG          1006
+#define HPI6205_ERROR_6205_DSPPAGE      1007
+#define HPI6205_ERROR_C6713_HPIC        1009
+#define HPI6205_ERROR_C6713_HPIA        1010
+#define HPI6205_ERROR_C6713_PLL         1011
+#define HPI6205_ERROR_DSP_INTMEM        1012
+#define HPI6205_ERROR_DSP_EXTMEM        1013
+#define HPI6205_ERROR_DSP_PLD           1014
+#define HPI6205_ERROR_6205_EEPROM       1017
+#define HPI6205_ERROR_DSP_EMIF1         1018
+#define HPI6205_ERROR_DSP_EMIF2         1019
+#define HPI6205_ERROR_DSP_EMIF3         1020
+#define HPI6205_ERROR_DSP_EMIF4         1021
 
 /*****************************************************************************/
 /* for C6205 PCI i/f */
@@ -1612,7 +1615,7 @@ static u16 boot_loader_config_emif(struct hpi_adapter_obj *pao, int dsp_index)
 		boot_loader_write_mem32(pao, dsp_index, 0x01800008, setting);
 		if (setting != boot_loader_read_mem32(pao, dsp_index,
 				0x01800008))
-			return HPI6205_ERROR_DSP_EMIF;
+			return HPI6205_ERROR_DSP_EMIF1;
 
 		/* EMIF CE1 setup - 32 bit async. This is 6713 #1 HPI, */
 		/* which occupies D15..0. 6713 starts at 27MHz, so need */
@@ -1625,7 +1628,7 @@ static u16 boot_loader_config_emif(struct hpi_adapter_obj *pao, int dsp_index)
 		boot_loader_write_mem32(pao, dsp_index, 0x01800004, setting);
 		if (setting != boot_loader_read_mem32(pao, dsp_index,
 				0x01800004))
-			return HPI6205_ERROR_DSP_EMIF;
+			return HPI6205_ERROR_DSP_EMIF2;
 
 		/* EMIF CE2 setup - 32 bit async. This is 6713 #2 HPI, */
 		/* which occupies D15..0. 6713 starts at 27MHz, so need */
@@ -1637,7 +1640,7 @@ static u16 boot_loader_config_emif(struct hpi_adapter_obj *pao, int dsp_index)
 		boot_loader_write_mem32(pao, dsp_index, 0x01800010, setting);
 		if (setting != boot_loader_read_mem32(pao, dsp_index,
 				0x01800010))
-			return HPI6205_ERROR_DSP_EMIF;
+			return HPI6205_ERROR_DSP_EMIF3;
 
 		/* EMIF CE3 setup - 32 bit async. */
 		/* This is the PLD on the ASI5000 cards only */
@@ -1648,7 +1651,7 @@ static u16 boot_loader_config_emif(struct hpi_adapter_obj *pao, int dsp_index)
 		boot_loader_write_mem32(pao, dsp_index, 0x01800014, setting);
 		if (setting != boot_loader_read_mem32(pao, dsp_index,
 				0x01800014))
-			return HPI6205_ERROR_DSP_EMIF;
+			return HPI6205_ERROR_DSP_EMIF4;
 
 		/* set EMIF SDRAM control for 2Mx32 SDRAM (512x32x4 bank) */
 		/*  need to use this else DSP code crashes? */
-- 
1.7.0.4
