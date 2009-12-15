From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] sound/oss/pss: Fix test of unsigned in pss_reset_dsp() and
 pss_download_boot()
Date: Tue, 15 Dec 2009 23:06:18 +0100
Message-ID: <4B28085A.6020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933898AbZLOWEb@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

limit and jiffies are unsigned so the test does not work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found using coccinelle: http://coccinelle.lip6.fr/

diff --git a/sound/oss/pss.c b/sound/oss/pss.c
index 83f5ee2..9325f4d 100644
--- a/sound/oss/pss.c
+++ b/sound/oss/pss.c
@@ -269,7 +269,7 @@ static int pss_reset_dsp(pss_confdata * devc)
 	unsigned long   i, limit = jiffies + HZ/10;
 
 	outw(0x2000, REG(PSS_CONTROL));
-	for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)
+	for (i = 0; i < 32768 && (limit >= jiffies); i++)
 		inw(REG(PSS_CONTROL));
 	outw(0x0000, REG(PSS_CONTROL));
 	return 1;
@@ -369,11 +369,11 @@ static int pss_download_boot(pss_confdata * devc, unsigned char *block, int size
 		outw(0, REG(PSS_DATA));
 
 		limit = jiffies + HZ/10;
-		for (i = 0; i < 32768 && (limit - jiffies >= 0); i++)
+		for (i = 0; i < 32768 && (limit >= jiffies); i++)
 			val = inw(REG(PSS_STATUS));
 
 		limit = jiffies + HZ/10;
-		for (i = 0; i < 32768 && (limit-jiffies >= 0); i++)
+		for (i = 0; i < 32768 && (limit >= jiffies); i++)
 		{
 			val = inw(REG(PSS_STATUS));
 			if (val & 0x4000)
