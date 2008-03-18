From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92hd71bxxx DMIC nid
Date: Tue, 18 Mar 2008 14:20:59 -0400
Message-ID: <47E0080B.2050302@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.biz.mail.mud.yahoo.com (smtp108.biz.mail.mud.yahoo.com
	[68.142.201.177]) by alsa0.perex.cz (Postfix) with SMTP id 531EB244D1
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 19:21:18 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Added missing DMIC verb to dell_4_1_pin_configs[].

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 6ffc943c3b39 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Mar 18 17:18:18 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Tue Mar 18 14:09:17 2008 -0400
@@ -1317,7 +1317,7 @@ static unsigned int ref92hd71bxx_pin_con
 
 static unsigned int dell_m4_1_pin_configs[13] = {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
-	0x23a1902e, 0x23014250, 0x40f000f0, 0x4f0000f0,
+	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
 	0x40f000f0, 0x4f0000f0,
 };
