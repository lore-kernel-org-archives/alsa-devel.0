From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Use rawmidi device name for sequencer client name
Date: Thu, 28 Nov 2002 13:38:01 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211281330500.9032-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The snd_seq_midisynth_register_port() function already knows the name of
the rawmidi device, so there is no reason to invent another name for the
sequencer client.


Index: alsa-kernel/core/seq/seq_midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_midi.c,v
retrieving revision 1.9
diff -u -r1.9 seq_midi.c
--- alsa-kernel/core/seq/seq_midi.c	6 Aug 2002 07:28:26 -0000	1.9
+++ alsa-kernel/core/seq/seq_midi.c	12 Nov 2002 14:59:46 -0000
@@ -328,7 +328,7 @@
 		memset(&inf,0,sizeof(snd_seq_client_info_t));
 		inf.client = client->seq_client;
 		inf.type = KERNEL_CLIENT;
-		sprintf(inf.name, "External MIDI %i", card->number);
+		strncpy(inf.name, info.name, sizeof(inf.name) - 1);
 		snd_seq_kernel_client_ctl(client->seq_client, SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, &inf);
 	}




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
