From: Matt Porter <mporter@ti.com>
Subject: [PATCH v2 2/2] ARM: davinci: enable SRAM ping ping buffering on DA850
Date: Thu, 11 Oct 2012 17:33:49 -0400
Message-ID: <1349991229-32107-3-git-send-email-mporter@ti.com>
References: <1349991229-32107-1-git-send-email-mporter@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349991229-32107-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, gururaja.hebbar@ti.com, Sekhar Nori <nsekhar@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Ben Gardiner <bengardiner@nanometrics.ca>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Passes the DA850 shared SRAM gen_pool to the McASP driver
and enables the ping-pong buffer DMA support.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 9e7f954..df87866 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -41,6 +41,7 @@
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
 #include <mach/mux.h>
+#include <mach/sram.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -749,16 +750,19 @@ static u8 da850_iis_serializer_direction[] = {
 };
 
 static struct snd_platform_data da850_evm_snd_data = {
-	.tx_dma_offset	= 0x2000,
-	.rx_dma_offset	= 0x2000,
-	.op_mode	= DAVINCI_MCASP_IIS_MODE,
-	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
-	.tdm_slots	= 2,
-	.serial_dir	= da850_iis_serializer_direction,
-	.asp_chan_q	= EVENTQ_0,
-	.version	= MCASP_VERSION_2,
-	.txnumevt	= 1,
-	.rxnumevt	= 1,
+	.tx_dma_offset		= 0x2000,
+	.rx_dma_offset		= 0x2000,
+	.op_mode		= DAVINCI_MCASP_IIS_MODE,
+	.num_serializer		= ARRAY_SIZE(da850_iis_serializer_direction),
+	.tdm_slots		= 2,
+	.serial_dir		= da850_iis_serializer_direction,
+	.asp_chan_q		= EVENTQ_0,
+	.ram_chan_q		= EVENTQ_1,
+	.version		= MCASP_VERSION_2,
+	.txnumevt		= 1,
+	.rxnumevt		= 1,
+	.sram_size_playback	= SZ_8K,
+	.sram_size_capture	= SZ_8K,
 };
 
 static const short da850_evm_mcasp_pins[] __initconst = {
@@ -1333,6 +1337,7 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
 				ret);
 
+	da850_evm_snd_data.sram_pool = sram_get_gen_pool();
 	da8xx_register_mcasp(0, &da850_evm_snd_data);
 
 	ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
-- 
1.7.9.5
