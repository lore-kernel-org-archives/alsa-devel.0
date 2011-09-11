From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 5/7] ARM: ep93xx: simone: register audio
	platform device
Date: Sun, 11 Sep 2011 12:28:53 +0300
Message-ID: <a5aee908e7772299753f4faf95c38ca903534084.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EE5E1038CB
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 11:29:16 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id zu17so740221bkb.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 02:29:16 -0700 (PDT)
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1315732452.git.mika.westerberg@iki.fi>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
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
Cc: rmallon@gmail.com, Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, hsweeten@visionengravers.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since the ASoC machine driver is now a platform driver we need to register
a matching platform device.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/simone.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 8392e95..1445ce5 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -53,6 +53,17 @@ static struct i2c_board_info __initdata simone_i2c_board_info[] = {
 	},
 };
 
+static struct platform_device simone_audio_device = {
+	.name		= "simone-audio",
+	.id		= -1,
+};
+
+static void __init simone_register_audio(void)
+{
+	ep93xx_register_ac97();
+	platform_device_register(&simone_audio_device);
+}
+
 static void __init simone_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -61,7 +72,7 @@ static void __init simone_init_machine(void)
 	ep93xx_register_fb(&simone_fb_info);
 	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
 			    ARRAY_SIZE(simone_i2c_board_info));
-	ep93xx_register_ac97();
+	simone_register_audio();
 }
 
 MACHINE_START(SIM_ONE, "Simplemachines Sim.One Board")
-- 
1.7.5.4
