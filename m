From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [patch] fix typo and snd_pcm_lib_malloc_pages comment
Date: Wed, 12 Jan 2005 18:34:33 +0300
Message-ID: <200501121834.33376.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JOU5B2fvUsT8tpC"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.mns.spb.ru (mns.spb.ru [195.131.16.6])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CE8AC305
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 16:34:44 +0100 (MET)
Received: from [192.168.0.127] (helo=tugrik.volcano)
	by mail.mns.spb.ru with esmtp id 1CokWD-0004tx-0d
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 18:34:45 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_JOU5B2fvUsT8tpC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_JOU5B2fvUsT8tpC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x.patch"

Index: alsa-kernel/core/pcm_memory.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_memory.c,v
retrieving revision 1.33
diff -u -r1.33 pcm_memory.c
--- alsa-kernel/core/pcm_memory.c	25 Nov 2004 11:42:15 -0000	1.33
+++ alsa-kernel/core/pcm_memory.c	12 Jan 2005 15:04:59 -0000
@@ -291,7 +291,7 @@
  * @substream: the substream to allocate the DMA buffer to
  * @size: the requested buffer size in bytes
  *
- * Allocates the DMA buffer on the BUS type given by
+ * Allocates the DMA buffer on the BUS type given earlier to
  * snd_pcm_lib_preallocate_xxx_pages().
  *
  * Returns 1 if the buffer is changed, 0 if not changed, or a negative
Index: alsa-lib/src/pcm/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
retrieving revision 1.294
diff -u -r1.294 pcm.c
--- alsa-lib/src/pcm/pcm.c	27 Dec 2004 14:40:19 -0000	1.294
+++ alsa-lib/src/pcm/pcm.c	12 Jan 2005 15:05:15 -0000
@@ -410,7 +410,7 @@
 if successfully finishes, otherwise the state #SND_PCM_STATE_OPEN
 is entered.
 When it is brought to SETUP state, this function automatically
-calls #snd_pcm_prepar() function to bring to the PREPARE state
+calls #snd_pcm_prepare() function to bring to the PREPARE state
 as below.
 
 \par snd_pcm_prepare

--Boundary-00=_JOU5B2fvUsT8tpC--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
