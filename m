From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] sequencer port type flags
Date: Fri, 16 May 2003 08:33:30 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305160829010.4782-100000@studcom.urz.uni-halle.de>
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


- the OPL4 driver cannot download instrument data
- the Gus and Trident drivers don't understand MIDI


Index: alsa-driver/drivers/opl4/opl4_seq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/drivers/opl4/opl4_seq.c,v
retrieving revision 1.2
diff -u -r1.2 opl4_seq.c
--- alsa-driver/drivers/opl4/opl4_seq.c	7 Apr 2003 08:04:54 -0000	1.2
+++ alsa-driver/drivers/opl4/opl4_seq.c	16 May 2003 06:24:12 -0000
@@ -183,8 +183,7 @@
 						      SNDRV_SEQ_PORT_CAP_WRITE |
 						      SNDRV_SEQ_PORT_CAP_SUBS_WRITE,
 						      SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
-						      SNDRV_SEQ_PORT_TYPE_MIDI_GM |
-						      SNDRV_SEQ_PORT_TYPE_SYNTH,
+						      SNDRV_SEQ_PORT_TYPE_MIDI_GM,
 						      16, 24,
 						      "OPL4 Wavetable Port");
 	if (opl4->chset->port < 0) {
Index: alsa-driver/drivers/opl4/opl4_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/drivers/opl4/opl4_synth.c,v
retrieving revision 1.2
diff -u -r1.2 opl4_synth.c
--- alsa-driver/drivers/opl4/opl4_synth.c	7 Apr 2003 08:04:54 -0000	1.2
+++ alsa-driver/drivers/opl4/opl4_synth.c	16 May 2003 06:24:12 -0000
@@ -465,7 +465,7 @@
 	return list_entry(opl4->on_voices.next, opl4_voice_t, list);
 }

-void snd_opl4_wait_for_wave_headers(opl4_t *opl4)
+static void snd_opl4_wait_for_wave_headers(opl4_t *opl4)
 {
 	int timeout = 200;

Index: alsa-kernel/isa/gus/gus_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_synth.c,v
retrieving revision 1.10
diff -u -r1.10 gus_synth.c
--- alsa-kernel/isa/gus/gus_synth.c	28 Feb 2003 15:08:24 -0000	1.10
+++ alsa-kernel/isa/gus/gus_synth.c	16 May 2003 06:24:32 -0000
@@ -192,9 +192,6 @@
 	p->chset->port = snd_seq_event_port_attach(gus->gf1.seq_client,
 						   &callbacks,
 						   SNDRV_SEQ_PORT_CAP_WRITE | SNDRV_SEQ_PORT_CAP_SUBS_WRITE,
-						   SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
-						   SNDRV_SEQ_PORT_TYPE_MIDI_GM |
-						   SNDRV_SEQ_PORT_TYPE_MIDI_GS |
 						   SNDRV_SEQ_PORT_TYPE_DIRECT_SAMPLE |
 						   SNDRV_SEQ_PORT_TYPE_SYNTH,
 						   16, 0,
Index: alsa-kernel/pci/trident/trident_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/trident/trident_synth.c,v
retrieving revision 1.10
diff -u -r1.10 trident_synth.c
--- alsa-kernel/pci/trident/trident_synth.c	28 Feb 2003 15:08:25 -0000	1.10
+++ alsa-kernel/pci/trident/trident_synth.c	16 May 2003 06:24:44 -0000
@@ -904,9 +904,6 @@
 	p->chset->port = snd_seq_event_port_attach(trident->synth.seq_client,
 						   &callbacks,
 						   SNDRV_SEQ_PORT_CAP_WRITE | SNDRV_SEQ_PORT_CAP_SUBS_WRITE,
-						   SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
-						   SNDRV_SEQ_PORT_TYPE_MIDI_GM |
-						   SNDRV_SEQ_PORT_TYPE_MIDI_GS |
 						   SNDRV_SEQ_PORT_TYPE_DIRECT_SAMPLE |
 						   SNDRV_SEQ_PORT_TYPE_SYNTH,
 						   16, 0,




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
