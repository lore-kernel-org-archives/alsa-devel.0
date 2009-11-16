From: Dan Carpenter <error27@gmail.com>
Subject: [patch] make some bitfields unsigned
Date: Mon, 16 Nov 2009 11:07:17 +0200 (SAST)
Message-ID: <alpine.DEB.2.00.0911141211450.3704@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BDFF10380A
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 10:07:26 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so1877005eyh.16
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 01:07:26 -0800 (PST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a clean up and doesn't change the behavior.

Bit fields should always be unsigned.  Otherwise pm_suspend_enabled will 
be -1 when you want it to be 1.  The other bad thing is that the sparse 
checker will complain 36 times if they aren't unsigned.

The other bitfields in that struct are unsigned already.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/sound/pci/ice1712/ice1712.h	2009-11-14 12:09:26.000000000 +0200
+++ devel/sound/pci/ice1712/ice1712.h	2009-11-14 12:10:01.000000000 +0200
@@ -382,8 +382,8 @@
 #ifdef CONFIG_PM
 	int (*pm_suspend)(struct snd_ice1712 *);
 	int (*pm_resume)(struct snd_ice1712 *);
-	int pm_suspend_enabled:1;
-	int pm_saved_is_spdif_master:1;
+	unsigned int pm_suspend_enabled:1;
+	unsigned int pm_saved_is_spdif_master:1;
 	unsigned int pm_saved_spdif_ctrl;
 	unsigned char pm_saved_spdif_cfg;
 	unsigned int pm_saved_route;
