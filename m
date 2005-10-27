From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] AMD Au1x00 driver: buggy spinlocks
Date: Thu, 27 Oct 2005 15:26:00 +0400
Message-ID: <4360B948.2060202@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050004000303010301040707"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050004000303010301040707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

          AMD Au1x00 ALSA driver fails compilation with the alternate spinlock
implementation because it doesn't do locking/unlocking correctly in some
places (passes spinlock by value).

WBR, Sergei





--------------050004000303010301040707
Content-Type: text/plain;
 name="Au1x00-ALSA-spinlocks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1x00-ALSA-spinlocks.patch"

Signed-off-by: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: sound/mips/au1x00.c
===================================================================
--- sound/mips/au1x00.c	23 Sep 2005 20:03:28 -0000	1.3
+++ sound/mips/au1x00.c	26 Oct 2005 19:00:40 -0000
@@ -474,7 +474,7 @@ snd_au1000_ac97_read(ac97_t *ac97, unsig
 	u32 volatile cmd;
 	u16 volatile data;
 	int             i;
-	spin_lock(au1000->ac97_lock);
+	spin_lock(&au1000->ac97_lock);
 /* would rather use the interupt than this polling but it works and I can't
 get the interupt driven case to work efficiently */
 	for (i = 0; i < 0x5000; i++)
@@ -497,7 +497,7 @@ get the interupt driven case to work eff
 	}
 
 	data = au1000->ac97_ioport->cmd & 0xffff;
-	spin_unlock(au1000->ac97_lock);
+	spin_unlock(&au1000->ac97_lock);
 
 	return data;
 
@@ -509,7 +509,7 @@ snd_au1000_ac97_write(ac97_t *ac97, unsi
 {
 	u32 cmd;
 	int i;
-	spin_lock(au1000->ac97_lock);
+	spin_lock(&au1000->ac97_lock);
 /* would rather use the interupt than this polling but it works and I can't
 get the interupt driven case to work efficiently */
 	for (i = 0; i < 0x5000; i++)
@@ -522,7 +522,7 @@ get the interupt driven case to work eff
 	cmd &= ~AC97C_READ;
 	cmd |= ((u32) val << AC97C_WD_BIT);
 	au1000->ac97_ioport->cmd = cmd;
-	spin_unlock(au1000->ac97_lock);
+	spin_unlock(&au1000->ac97_lock);
 }
 static void
 snd_au1000_ac97_free(ac97_t *ac97)



--------------050004000303010301040707--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
