From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] sound: fix incorrect use of
	platform_device_register()
Date: Sat, 21 Apr 2007 16:23:39 +0900
Message-ID: <20070421072339.GA3699@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B665243CA
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2007 09:29:03 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so873750nzf
	for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2007 00:29:02 -0700 (PDT)
Content-Disposition: inline
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
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

The platform_device allocated by platform_device_alloc()
should be added to the device hierarchy by platform_device_add()
instead of platform_device_register().

Otherwise it will hit WARN_ON() in platform_device_register().
by illegal refcount.

This patch fixes such incorrect usages in portman2x4 and mts64 drivers.
Also it removes unnecessary trailing whitespaces.

Cc: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: 2.6-mm/sound/drivers/portman2x4.c
===================================================================
--- 2.6-mm.orig/sound/drivers/portman2x4.c
+++ 2.6-mm/sound/drivers/portman2x4.c
@@ -676,13 +676,13 @@ static void __devinit snd_portman_attach
 	struct platform_device *device;
 
 	device = platform_device_alloc(PLATFORM_DRIVER, device_count);
-	if (!device) 
+	if (!device)
 		return;
 
 	/* Temporary assignment to forward the parport */
 	platform_set_drvdata(device, p);
 
-	if (platform_device_register(device) < 0) {
+	if (platform_device_add(device) < 0) {
 		platform_device_put(device);
 		return;
 	}
Index: 2.6-mm/sound/drivers/mts64.c
===================================================================
--- 2.6-mm.orig/sound/drivers/mts64.c
+++ 2.6-mm/sound/drivers/mts64.c
@@ -892,13 +892,13 @@ static void __devinit snd_mts64_attach(s
 	struct platform_device *device;
 
 	device = platform_device_alloc(PLATFORM_DRIVER, device_count);
-	if (!device) 
+	if (!device)
 		return;
 
 	/* Temporary assignment to forward the parport */
 	platform_set_drvdata(device, p);
 
-	if (platform_device_register(device) < 0) {
+	if (platform_device_add(device) < 0) {
 		platform_device_put(device);
 		return;
 	}
