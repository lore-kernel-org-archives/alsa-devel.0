From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix typo in port flags
Date: Mon, 23 Feb 2004 10:08:29 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231006481.20713-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


- fix typo in port flags
- add GM2 capability bit


Index: alsa-kernel/include/asequencer.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/asequencer.h,v
retrieving revision 1.11
diff -u -r1.11 asequencer.h
--- alsa-kernel/include/asequencer.h	7 Jan 2004 14:34:23 -0000	1.11
+++ alsa-kernel/include/asequencer.h	23 Feb 2004 08:27:42 -0000
@@ -594,6 +594,7 @@
 #define SNDRV_SEQ_PORT_TYPE_MIDI_GS	(1<<3)	/* GS compatible device */
 #define SNDRV_SEQ_PORT_TYPE_MIDI_XG	(1<<4)	/* XG compatible device */
 #define SNDRV_SEQ_PORT_TYPE_MIDI_MT32	(1<<5)	/* MT-32 compatible device */
+#define SNDRV_SEQ_PORT_TYPE_MIDI_GM2	(1<<6)	/* General MIDI 2 compatible device */

 /* other standards...*/
 #define SNDRV_SEQ_PORT_TYPE_SYNTH	(1<<10)	/* Synth device (no MIDI compatible - direct wavetable) */
@@ -605,7 +606,7 @@
 /* misc. conditioning flags */
 #define SNDRV_SEQ_PORT_FLG_GIVEN_PORT	(1<<0)
 #define SNDRV_SEQ_PORT_FLG_TIMESTAMP	(1<<1)
-#define SNDRV_SEQ_PORT_FLG_TIME_REAL	(1<<1)
+#define SNDRV_SEQ_PORT_FLG_TIME_REAL	(1<<2)

 struct sndrv_seq_port_info {
 	struct sndrv_seq_addr addr;	/* client/port numbers */
Index: alsa-lib/include/sound/asequencer.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/sound/asequencer.h,v
retrieving revision 1.3
diff -u -r1.3 asequencer.h
--- alsa-lib/include/sound/asequencer.h	7 Jan 2004 14:36:40 -0000	1.3
+++ alsa-lib/include/sound/asequencer.h	23 Feb 2004 08:27:42 -0000
@@ -594,6 +594,7 @@
 #define SNDRV_SEQ_PORT_TYPE_MIDI_GS	(1<<3)	/* GS compatible device */
 #define SNDRV_SEQ_PORT_TYPE_MIDI_XG	(1<<4)	/* XG compatible device */
 #define SNDRV_SEQ_PORT_TYPE_MIDI_MT32	(1<<5)	/* MT-32 compatible device */
+#define SNDRV_SEQ_PORT_TYPE_MIDI_GM2	(1<<6)	/* General MIDI 2 compatible device */

 /* other standards...*/
 #define SNDRV_SEQ_PORT_TYPE_SYNTH	(1<<10)	/* Synth device (no MIDI compatible - direct wavetable) */
@@ -605,7 +606,7 @@
 /* misc. conditioning flags */
 #define SNDRV_SEQ_PORT_FLG_GIVEN_PORT	(1<<0)
 #define SNDRV_SEQ_PORT_FLG_TIMESTAMP	(1<<1)
-#define SNDRV_SEQ_PORT_FLG_TIME_REAL	(1<<1)
+#define SNDRV_SEQ_PORT_FLG_TIME_REAL	(1<<2)

 struct sndrv_seq_port_info {
 	struct sndrv_seq_addr addr;	/* client/port numbers */




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
