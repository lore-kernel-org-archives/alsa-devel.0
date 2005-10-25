From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] Use 31 bit DMA mask for Audigy
Date: Tue, 25 Oct 2005 00:08:16 -0400
Message-ID: <1130213297.28314.36.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

I think this should go in 1.0.10 final.  It seems to "fix" ALSA bug
#1276.

It appears that either the Audigy DMA engine or the Linux kernel cannot
handle 32 bit DMA with this device.  Problem manifests as noise when
using more than 2GB of RAM, possibly only on 64 bit machines.

The OSS driver actually uses a 29 bit DMA mask for both devices, this
seems like overkill for now.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- include/sound/emu10k1.h-orig	2005-10-11 12:31:42.000000000 -0400
+++ include/sound/emu10k1.h	2005-10-25 00:00:51.000000000 -0400
@@ -48,7 +48,8 @@
 
 /* FIXME? - according to the OSS driver the EMU10K1 needs a 29 bit DMA mask */
 #define EMU10K1_DMA_MASK	0x7fffffffUL	/* 31bit */
-#define AUDIGY_DMA_MASK		0xffffffffUL	/* 32bit */
+#define AUDIGY_DMA_MASK		0x7fffffffUL	/* 31bit FIXME - 32 should work? */
+						/* See ALSA bug #1276 - rlrevell */
 
 #define TMEMSIZE        256*1024
 #define TMEMSIZEREG     4




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
