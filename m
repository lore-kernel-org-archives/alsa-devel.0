From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 1/1] Kirkwood/ASoC: Add support for OpenRD
	Ultimate
Date: Sat, 13 Nov 2010 18:51:53 +0100
Message-ID: <20101113175219.282546527@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 00C841037F3
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 18:55:35 +0100 (CET)
Content-Disposition: inline; filename=ultimate.patch
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
Cc: Robas Teodor <teodor.robas@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Pitre <nico@fluxnic.net>
List-Id: alsa-devel@alsa-project.org


OpenRD Ultimate & Client are similar machines so enable OpenRD client sound
support on Ultimate too

Tested-by: Robas Teodor <teodor.robas@gmail.com>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Index: sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/openrd-setup.c	2010-11-12 17:58:41.000000000 +0100
+++ sound-2.6/arch/arm/mach-kirkwood/openrd-setup.c	2010-11-12 17:59:06.000000000 +0100
@@ -94,7 +94,7 @@
 
 	kirkwood_i2c_init();
 
-	if (machine_is_openrd_client()) {
+	if (machine_is_openrd_client() || machine_is_openrd_ultimate()) {
 		i2c_register_board_info(0, i2c_board_info,
 			ARRAY_SIZE(i2c_board_info));
 		kirkwood_audio_init();
Index: sound-2.6/sound/soc/kirkwood/kirkwood-openrd.c
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/kirkwood-openrd.c	2010-11-12 17:59:17.000000000 +0100
+++ sound-2.6/sound/soc/kirkwood/kirkwood-openrd.c	2010-11-12 17:59:31.000000000 +0100
@@ -86,7 +86,7 @@
 {
 	int ret;
 
-	if (!machine_is_openrd_client())
+	if (!machine_is_openrd_client() && !machine_is_openrd_ultimate())
 		return 0;
 
 	openrd_client_snd_device = platform_device_alloc("soc-audio", -1);
Index: sound-2.6/sound/soc/kirkwood/Kconfig
===================================================================
--- sound-2.6.orig/sound/soc/kirkwood/Kconfig	2010-11-12 17:59:51.000000000 +0100
+++ sound-2.6/sound/soc/kirkwood/Kconfig	2010-11-12 18:00:27.000000000 +0100
@@ -11,7 +11,7 @@
 
 config SND_KIRKWOOD_SOC_OPENRD
 	tristate "SoC Audio support for Kirkwood Openrd Client"
-	depends on SND_KIRKWOOD_SOC && MACH_OPENRD_CLIENT
+	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE)
 	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_CS42L51
 	help
