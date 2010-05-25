From: apatard@mandriva.com
Subject: [patch 2/5] openrd-client: initialise audio
Date: Tue, 25 May 2010 14:22:38 +0200
Message-ID: <20100525122340.832019972@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 0197A244FF
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 14:22:55 +0200 (CEST)
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
--- sound-2.6.orig/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-15 17:03:48.962586499 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c	2010-05-15 17:04:50.818586283 +0200
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
