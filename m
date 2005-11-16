From: Nicolas Boullis <nboullis@debian.org>
Subject: Bug in the generation of IEC958 subframes
Date: Wed, 16 Nov 2005 01:45:01 +0100
Message-ID: <20051116004500.GA5622@home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

While working on an ALSA driver for the audio part of em8300-based MPEG 
decoder boards (Sigma Designs' Hollywood+ boards and Creative Labs' DXR3 
boards), I think I discovered a bug in the code that generates IEC958 
subframes from linear samples (iec958 plugin): M and W preambles are 
swapped, and B preambles should only be used on even subframes. The 
attached patch fixes this issue.

Moreover, (using debian's 1.0.9-3 package, I haven't checked with 
1.0.10rc3), I get segfaults whenever I try to specify the preambles in 
my ~/.asoundrc file.

(https://bugtrack.alsa-project.org/alsa-bug/ times out, that's why I'm 
sending this report here.)


Cheers,

Nicolas

PS: please CC replies to me, as I don't read the alsa-devel ML.

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-lib.patch"

diff -ruN alsa-lib-1.0.10rc3.orig/src/pcm/pcm_iec958.c alsa-lib-1.0.10rc3/src/pcm/pcm_iec958.c
--- alsa-lib-1.0.10rc3.orig/src/pcm/pcm_iec958.c	2005-05-24 16:14:35.000000000 +0200
+++ alsa-lib-1.0.10rc3/src/pcm/pcm_iec958.c	2005-11-16 01:35:46.000000000 +0100
@@ -116,10 +116,10 @@
 		data |= 0x80000000;
 
 	/* Preamble */
-	if (! iec->counter)
-		data |= iec->preamble[PREAMBLE_Z];	/* Block start, 'Z' */
-	else if (! channel)
+	if (channel)
 		data |= iec->preamble[PREAMBLE_Y];	/* odd sub frame, 'Y' */
+	else if (! iec->counter)
+		data |= iec->preamble[PREAMBLE_Z];	/* Block start, 'Z' */
 	else
 		data |= iec->preamble[PREAMBLE_X];	/* even sub frame, 'X' */
 

--jRHKVT23PllUwdXP--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
