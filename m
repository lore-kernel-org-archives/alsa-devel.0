From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] rme32 segfault fix
Date: Sun, 19 Sep 2004 22:10:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040919201017.GA512@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 472022CA
	for <alsa-devel@alsa-project.org>; Sun, 19 Sep 2004 22:07:58 +0200 (MEST)
Content-Disposition: inline
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


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

looks like rme32 in halfduplex mode is broken for playback (since v1.0.6).
You will get a segfault without this patch :(

Changes:
- disables buffer prefill in halfduplex mode, which fixes segmentation fault
  of rme32 for playback in halfduplex mode

Signed-Off by Martin Langer <martin-langer@gmx.de>


martin



--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rme32-halfduplex-fix.patch"

--- alsa-kernel/pci/rme32.c.ORIGINAL	Sun Sep 19 21:39:28 2004
+++ alsa-kernel/pci/rme32.c	Sun Sep 19 21:40:04 2004
@@ -1123,7 +1123,7 @@
 	}
 	
 	/* prefill playback buffer */
-	if (cmd == SNDRV_PCM_TRIGGER_START) {
+	if ((cmd == SNDRV_PCM_TRIGGER_START) && (rme32->fullduplex_mode)) {
 		snd_pcm_group_for_each(pos, substream) {
 			s = snd_pcm_group_substream_entry(pos);
 			if (s == rme32->playback_substream) {

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
