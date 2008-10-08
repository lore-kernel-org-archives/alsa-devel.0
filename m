From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Check for machine type in GTA01 machine
	driver
Date: Wed,  8 Oct 2008 13:02:20 +0100
Message-ID: <1223467340-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4AC1424591
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 14:02:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since there are now multiple OpenMoko platforms it is more important to
check that the machine driver is running on the correct system.  This
was orgininally generated as part of the initial GTA02 machine port.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index c602674..87ddfef 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -24,6 +24,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
+#include <asm/mach-types.h>
 #include <asm/hardware/scoop.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
@@ -677,6 +678,12 @@ static int __init neo1973_init(void)
 
 	DBG("Entered %s\n", __func__);
 
+	if (!machine_is_neo1973_gta01()) {
+		printk(KERN_INFO
+			"Only GTA01 hardware supported by ASoC driver\n");
+		return -ENODEV;
+	}
+
 	neo1973_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!neo1973_snd_device)
 		return -ENOMEM;
-- 
1.5.6.5
