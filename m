From: apatard@mandriva.com
Subject: [patch 2/6] openrd-client: initialise audio
Date: Tue, 11 May 2010 18:23:44 +0200
Message-ID: <20100511162601.607632763@mandriva.com>
References: <20100511162342.640158675@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 6AAF8103862
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 18:26:07 +0200 (CEST)
Content-Disposition: inline; filename=openrd_init_audio_dev.patch
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
Cc: Arnaud Patard <apatard@mandriva.com>, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, nico@fluxnic.net, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

This patch is reponsible for enabling audio on the openrd client board

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---
 arch/arm/mach-kirkwood/openrd-setup.c |   11 	11 +	0 -	0 !
 1 file changed, 11 insertions(+)

Index: linux-2.6.33/arch/arm/mach-kirkwood/openrd-setup.c
===================================================================
--- linux-2.6.33.orig/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-11 17:53:34.753650304 +0200
+++ linux-2.6.33/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-11 17:55:13.313650581 +0200
@@ -18,6 +18,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
+#include <mach/audio.h>
 #include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
@@ -47,6 +48,11 @@ static struct mv643xx_eth_platform_data
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(24),
 };
 
+struct kirkwood_soc_platform_data kirkwood_soc_data = {
+	.dram        = &kirkwood_mbus_dram_info,
+};
+EXPORT_SYMBOL_GPL(kirkwood_soc_data);
+
 static struct mv_sata_platform_data openrd_sata_data = {
 	.n_ports	= 2,
 };
@@ -80,6 +86,11 @@ static void __init openrd_init(void)
 	kirkwood_sdio_init(&openrd_mvsdio_data);
 
 	kirkwood_i2c_init();
+
+	if (machine_is_openrd_client()) {
+		kirkwood_soc_data.tclk = kirkwood_tclk,
+		kirkwood_audio_init(&kirkwood_soc_data);
+	}
 }
 
 static int __init openrd_pci_init(void)
