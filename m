From: Amerigo Wang <amwang@redhat.com>
Subject: [Patch] sound: silent echo'ed messages in Makefile
Date: Fri, 28 Jan 2011 16:52:00 +0800
Message-ID: <1296204727-19160-1-git-send-email-amwang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: WANG Cong <amwang@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Paul Mundt <lethal@linux-sh.org>, John Kacur <jkacur@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Silent these echo's, please.

Signed-off-by: WANG Cong <amwang@redhat.com>

---
diff --git a/sound/oss/Makefile b/sound/oss/Makefile
index 96f14dc..90ffb99 100644
--- a/sound/oss/Makefile
+++ b/sound/oss/Makefile
@@ -87,7 +87,7 @@ ifeq ($(CONFIG_PSS_HAVE_BOOT),y)
 	$(obj)/bin2hex pss_synth < $< > $@
 else
     $(obj)/pss_boot.h:
-	(							\
+	$(Q)(							\
 	    echo 'static unsigned char * pss_synth = NULL;';	\
 	    echo 'static int pss_synthLen = 0;';		\
 	) > $@
@@ -102,7 +102,7 @@ ifeq ($(CONFIG_TRIX_HAVE_BOOT),y)
 	$(obj)/hex2hex -i trix_boot < $< > $@
 else
     $(obj)/trix_boot.h:
-	(							\
+	$(Q)(							\
 	    echo 'static unsigned char * trix_boot = NULL;';	\
 	    echo 'static int trix_boot_len = 0;';		\
 	) > $@
