From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH resend 2/2] ARM: davinci: enable SRAM ping ping
	buffering on DA850
Date: Wed, 17 Oct 2012 16:08:04 +0200
Message-ID: <1350482884-13119-2-git-send-email-zonque@gmail.com>
References: <1350482884-13119-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C08526522C
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 16:08:46 +0200 (CEST)
In-Reply-To: <1350482884-13119-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mporter@ti.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

From: Matt Porter <mporter@ti.com>

Passes the DA850 shared SRAM gen_pool to the McASP driver
and enables the ping-pong buffer DMA support.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 32ee3f8..d9bc3fa 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -762,16 +762,19 @@ static u8 da850_iis_serializer_direction[] = {
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
@@ -1509,6 +1512,7 @@ static __init void da850_evm_init(void)
 		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
 				ret);
 
+	da850_evm_snd_data.sram_pool = sram_get_gen_pool();
 	da8xx_register_mcasp(0, &da850_evm_snd_data);
 
 	ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
-- 
1.7.11.7
