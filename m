From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap: Remove needless prints from
	machine drivers
Date: Wed,  6 Oct 2010 16:47:26 +0300
Message-ID: <1286372846-10238-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 69C7D10381D
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 15:46:53 +0200 (CEST)
Received: by eye27 with SMTP id 27so2863626eye.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Oct 2010 06:46:50 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

It is currently completely normal to execute these machine drivers code on
different boards if the kernel includes support for multiple boards so no
error message should be printed if the machine_is_xxx does not match with
the machine driver.

Therefore remove these pr_err and pr_debug prints in those cases.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/am3517evm.c   |    4 +---
 sound/soc/omap/igep0020.c    |    4 +---
 sound/soc/omap/omap2evm.c    |    4 +---
 sound/soc/omap/omap3beagle.c |    4 +---
 sound/soc/omap/omap3evm.c    |    4 +---
 sound/soc/omap/sdp3430.c     |    4 +---
 sound/soc/omap/sdp4430.c     |    4 +---
 sound/soc/omap/zoom2.c       |    4 +---
 8 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 68bd902..979dd50 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -157,10 +157,8 @@ static int __init am3517evm_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3517evm()) {
-		pr_err("Not OMAP3517 / AM3517 EVM!\n");
+	if (!machine_is_omap3517evm())
 		return -ENODEV;
-	}
 	pr_info("OMAP3517 / AM3517 EVM SoC init\n");
 
 	am3517evm_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
index d296cfc..fd3a40f 100644
--- a/sound/soc/omap/igep0020.c
+++ b/sound/soc/omap/igep0020.c
@@ -101,10 +101,8 @@ static int __init igep2_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_igep0020()) {
-		pr_debug("Not IGEP v2!\n");
+	if (!machine_is_igep0020())
 		return -ENODEV;
-	}
 	printk(KERN_INFO "IGEP v2 SoC init\n");
 
 	igep2_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index 38cd189..cf3fc8a 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -103,10 +103,8 @@ static int __init omap2evm_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap2evm()) {
-		pr_debug("Not omap2evm!\n");
+	if (!machine_is_omap2evm())
 		return -ENODEV;
-	}
 	printk(KERN_INFO "omap2evm SoC init\n");
 
 	omap2evm_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 7c11e1a..e56832b 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -112,10 +112,8 @@ static int __init omap3beagle_soc_init(void)
 {
 	int ret;
 
-	if (!(machine_is_omap3_beagle() || machine_is_devkit8000())) {
-		pr_debug("Not OMAP3 Beagle or Devkit8000!\n");
+	if (!(machine_is_omap3_beagle() || machine_is_devkit8000()))
 		return -ENODEV;
-	}
 	pr_info("OMAP3 Beagle/Devkit8000 SoC init\n");
 
 	omap3beagle_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 1ac5bab..810f1e3 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -99,10 +99,8 @@ static int __init omap3evm_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3evm()) {
-		pr_err("Not OMAP3 EVM!\n");
+	if (!machine_is_omap3evm())
 		return -ENODEV;
-	}
 	pr_info("OMAP3 EVM SoC init\n");
 
 	omap3evm_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 76ce77b..07fbcf7 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -296,10 +296,8 @@ static int __init sdp3430_soc_init(void)
 	int ret;
 	u8 pin_mux;
 
-	if (!machine_is_omap_3430sdp()) {
-		pr_debug("Not SDP3430!\n");
+	if (!machine_is_omap_3430sdp())
 		return -ENODEV;
-	}
 	printk(KERN_INFO "SDP3430 SoC init\n");
 
 	sdp3430_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 62f6a62..4b4463d 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -186,10 +186,8 @@ static int __init sdp4430_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap_4430sdp()) {
-		pr_debug("Not SDP4430!\n");
+	if (!machine_is_omap_4430sdp())
 		return -ENODEV;
-	}
 	printk(KERN_INFO "SDP4430 SoC init\n");
 
 	sdp4430_snd_device = platform_device_alloc("soc-audio", -1);
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 338dc95..718031e 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -245,10 +245,8 @@ static int __init zoom2_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap_zoom2()) {
-		pr_debug("Not Zoom2!\n");
+	if (!machine_is_omap_zoom2())
 		return -ENODEV;
-	}
 	printk(KERN_INFO "Zoom2 SoC init\n");
 
 	zoom2_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.7.1
