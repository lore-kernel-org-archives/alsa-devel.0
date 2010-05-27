From: apatard@mandriva.com
Subject: [patch 2/6] openrd-client: initialise audio
Date: Thu, 27 May 2010 14:57:39 +0200
Message-ID: <20100527130338.244016052@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id BC4C7103A54
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 15:03:44 +0200 (CEST)
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
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch is reponsible for enabling audio on the openrd client board

Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-27 14:09:33.076174419 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-27 14:09:42.067694397 +0200
@@ -15,6 +15,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
+#include <linux/i2c.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -60,6 +61,12 @@ static unsigned int openrd_mpp_config[]
 	0
 };
 
+static struct i2c_board_info i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("cs42l51", 0x4a),
+	},
+};
+
 static void __init openrd_init(void)
 {
 	/*
@@ -80,6 +87,12 @@ static void __init openrd_init(void)
 	kirkwood_sdio_init(&openrd_mvsdio_data);
 
 	kirkwood_i2c_init();
+
+	if (machine_is_openrd_client()) {
+		i2c_register_board_info(0, i2c_board_info,
+			ARRAY_SIZE(i2c_board_info));
+		kirkwood_audio_init();
+	}
 }
 
 static int __init openrd_pci_init(void)
