From: Adrian Bunk <bunk@stusta.de>
Subject: ALSA initialization still seems to be too late?
Date: Fri, 23 Mar 2007 21:36:27 +0100
Message-ID: <20070323203627.GW752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992561AbXCWUg0@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org
List-Id: alsa-devel@alsa-project.org

The commit below from 2005 (sic) seems to be an example that workarounds 
often have quite a long lifetime.

Can we get this sorted out properly for 2.6.22?

TIA
Adrian


commit c7ac6b42ffba28c350cbcd48268f46689f6eb1cc
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Wed Dec 21 14:52:32 2005 -0800

    Initialize drivers/media/video/saa7134 late
    
    When compiled-in, make sure the sound system has initialized
    before these drivers do.
    
    Reported by Adrian Bunk <bunk@stusta.de>
    
    (The right fix would be to make the sound core use "subsys_initcall()"
    and thus initialize before all normal drivers, but this is the quick
    and limited safe fix for 2.6.15).
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
index 953d5fe..6752dd1 100644
--- a/drivers/media/video/saa7134/saa7134-alsa.c
+++ b/drivers/media/video/saa7134/saa7134-alsa.c
@@ -1028,7 +1028,8 @@ static void saa7134_alsa_exit(void)
 	return;
 }
 
-module_init(saa7134_alsa_init);
+/* We initialize this late, to make sure the sound system is up and running */
+late_initcall(saa7134_alsa_init);
 module_exit(saa7134_alsa_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Ricardo Cerqueira");
diff --git a/drivers/media/video/saa7134/saa7134-oss.c b/drivers/media/video/saa7134/saa7134-oss.c
index 513a699..c450d57 100644
--- a/drivers/media/video/saa7134/saa7134-oss.c
+++ b/drivers/media/video/saa7134/saa7134-oss.c
@@ -1002,7 +1002,8 @@ static void saa7134_oss_exit(void)
 	return;
 }
 
-module_init(saa7134_oss_init);
+/* We initialize this late, to make sure the sound system is up and running */
+late_initcall(saa7134_oss_init);
 module_exit(saa7134_oss_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
