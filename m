From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] change snd-seq-midi client names
Date: Mon, 23 Feb 2004 10:05:47 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231004240.20713-100000@studcom.urz.uni-halle.de>
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


This patch reverses the order of the "Rawmidi x" and rawmidi name
parts of client names to enable selecting clients by a unique prefix
(as snd_seq_parse_address does).


Index: alsa-kernel/core/seq/seq_midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_midi.c,v
retrieving revision 1.15
diff -u -r1.15 seq_midi.c
--- alsa-kernel/core/seq/seq_midi.c	7 Jan 2004 14:34:22 -0000	1.15
+++ alsa-kernel/core/seq/seq_midi.c	23 Feb 2004 08:27:41 -0000
@@ -285,7 +285,7 @@
 	cinfo.client = client->seq_client;
 	cinfo.type = KERNEL_CLIENT;
 	name = rmidi->name[0] ? (const char *)rmidi->name : "External MIDI";
-	snprintf(cinfo.name, sizeof(cinfo.name), "Rawmidi %d - %s", card->number, name);
+	snprintf(cinfo.name, sizeof(cinfo.name), "%s - Rawmidi %d", name, card->number);
 	return snd_seq_kernel_client_ctl(client->seq_client, SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, &cinfo);
 }





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
