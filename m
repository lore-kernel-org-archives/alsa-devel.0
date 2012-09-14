From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 4/8] ALSA: Add DSP firmware enums and defs to
	CA0132 codec
Date: Thu, 13 Sep 2012 18:15:54 -0700
Message-ID: <1347585358-2403-5-git-send-email-ian_minett@creativelabs.com>
References: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>


Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index da65535..8ea3348 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/firmware.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -34,12 +35,37 @@
 
 #include "ca0132_regs.h"
 
+#define DSP_DMA_WRITE_BUFLEN_INIT (1UL<<18)
+#define DSP_DMA_WRITE_BUFLEN_OVLY (1UL<<15)
+
+#define DMA_TRANSFER_FRAME_SIZE_NWORDS		8
+#define DMA_TRANSFER_MAX_FRAME_SIZE_NWORDS	32
+#define DMA_OVERLAY_FRAME_SIZE_NWORDS		2
+
+#define MASTERCONTROL				0x80
+#define MASTERCONTROL_ALLOC_DMA_CHAN		9
+
 #define WIDGET_CHIP_CTRL      0x15
 #define WIDGET_DSP_CTRL       0x16
 
 #define WUH_MEM_CONNID        10
 #define DSP_MEM_CONNID        16
 
+#define MEM_CONNID_MICIN1     3
+#define MEM_CONNID_MICIN2     5
+#define MEM_CONNID_MICOUT1    12
+#define MEM_CONNID_MICOUT2    14
+#define MEM_CONNID_WUH        10
+#define MEM_CONNID_DSP        16
+#define MEM_CONNID_DMIC       100
+
+#define SCP_SET    0
+#define SCP_GET    1
+
+#define EFX_FILE   "ctefx.bin"
+
+MODULE_FIRMWARE(EFX_FILE);
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
@@ -64,7 +90,11 @@ enum hda_cmd_vendor_io {
 	VENDOR_CHIPIO_HIC_POST_READ          = 0x702,
 	VENDOR_CHIPIO_HIC_READ_DATA          = 0xF03,
 
+	VENDOR_CHIPIO_8051_DATA_WRITE        = 0x707,
+	VENDOR_CHIPIO_8051_DATA_READ         = 0xF07,
+
 	VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE   = 0x70A,
+	VENDOR_CHIPIO_CT_EXTENSIONS_GET      = 0xF0A,
 
 	VENDOR_CHIPIO_PLL_PMU_WRITE          = 0x70C,
 	VENDOR_CHIPIO_PLL_PMU_READ           = 0xF0C,
@@ -72,18 +102,27 @@ enum hda_cmd_vendor_io {
 	VENDOR_CHIPIO_8051_ADDRESS_HIGH      = 0x70E,
 	VENDOR_CHIPIO_FLAG_SET               = 0x70F,
 	VENDOR_CHIPIO_FLAGS_GET              = 0xF0F,
-	VENDOR_CHIPIO_PARAMETER_SET          = 0x710,
-	VENDOR_CHIPIO_PARAMETER_GET          = 0xF10,
+	VENDOR_CHIPIO_PARAM_SET              = 0x710,
+	VENDOR_CHIPIO_PARAM_GET              = 0xF10,
 
 	VENDOR_CHIPIO_PORT_ALLOC_CONFIG_SET  = 0x711,
 	VENDOR_CHIPIO_PORT_ALLOC_SET         = 0x712,
 	VENDOR_CHIPIO_PORT_ALLOC_GET         = 0xF12,
 	VENDOR_CHIPIO_PORT_FREE_SET          = 0x713,
 
-	VENDOR_CHIPIO_PARAMETER_EX_ID_GET    = 0xF17,
-	VENDOR_CHIPIO_PARAMETER_EX_ID_SET    = 0x717,
-	VENDOR_CHIPIO_PARAMETER_EX_VALUE_GET = 0xF18,
-	VENDOR_CHIPIO_PARAMETER_EX_VALUE_SET = 0x718
+	VENDOR_CHIPIO_PARAM_EX_ID_GET        = 0xF17,
+	VENDOR_CHIPIO_PARAM_EX_ID_SET        = 0x717,
+	VENDOR_CHIPIO_PARAM_EX_VALUE_GET     = 0xF18,
+	VENDOR_CHIPIO_PARAM_EX_VALUE_SET     = 0x718,
+
+	VENDOR_CHIPIO_DMIC_CTL_SET           = 0x788,
+	VENDOR_CHIPIO_DMIC_CTL_GET           = 0xF88,
+	VENDOR_CHIPIO_DMIC_PIN_SET           = 0x789,
+	VENDOR_CHIPIO_DMIC_PIN_GET           = 0xF89,
+	VENDOR_CHIPIO_DMIC_MCLK_SET          = 0x78A,
+	VENDOR_CHIPIO_DMIC_MCLK_GET          = 0xF8A,
+
+	VENDOR_CHIPIO_EAPD_SEL_SET           = 0x78D
 };
 
 /*
@@ -133,7 +172,7 @@ enum control_flag_id {
 	/* Impedance for ramp generator on Port_A 16 Ohm/10K Ohm */
 	CONTROL_FLAG_PORT_A_10KOHM_LOAD     = 20,
 	/* Impedance for ramp generator on Port_D, 16 Ohm/10K Ohm */
-	CONTROL_FLAG_PORT_D_10K0HM_LOAD     = 21,
+	CONTROL_FLAG_PORT_D_10KOHM_LOAD     = 21,
 	/* ASI rate is 48kHz/96kHz */
 	CONTROL_FLAG_ASI_96KHZ              = 22,
 	/* DAC power settings able to control attached ports no/yes */
@@ -147,7 +186,7 @@ enum control_flag_id {
 /*
  * Control parameter IDs
  */
-enum control_parameter_id {
+enum control_param_id {
 	/* 0: force HDA, 1: allow DSP if HDA Spdif1Out stream is idle */
 	CONTROL_PARAM_SPDIF1_SOURCE            = 2,
 
-- 
1.7.4.1
