From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] midi_voices
Date: Fri, 28 Feb 2003 12:57:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302281234530.8163-100000@studcom.urz.uni-halle.de>
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


Isn't it really nice that there are ioctls and library functions to get/
set the midi_voices property of sequencer ports?

Well, it would be, if ports actually had this property.  :o)


Index: alsa-kernel/core/seq/seq_ports.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_ports.h,v
retrieving revision 1.2
diff -u -r1.2 seq_ports.h
--- alsa-kernel/core/seq/seq_ports.h	30 Dec 2001 09:26:45 -0000	1.2
+++ alsa-kernel/core/seq/seq_ports.h	28 Feb 2003 10:35:06 -0000
@@ -81,6 +81,7 @@

 	/* supported channels */
 	int midi_channels;
+	int midi_voices;
 	int synth_voices;

 } client_port_t;
Index: alsa-kernel/core/seq/seq_ports.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/seq_ports.c,v
retrieving revision 1.12
diff -u -r1.12 seq_ports.c
--- alsa-kernel/core/seq/seq_ports.c	5 Feb 2003 11:07:51 -0000	1.12
+++ alsa-kernel/core/seq/seq_ports.c	28 Feb 2003 10:35:06 -0000
@@ -351,6 +351,7 @@

 	/* information about supported channels/voices */
 	port->midi_channels = info->midi_channels;
+	port->midi_voices = info->midi_voices;
 	port->synth_voices = info->synth_voices;

 	return 0;
@@ -372,6 +373,7 @@

 	/* information about supported channels/voices */
 	info->midi_channels = port->midi_channels;
+	info->midi_voices = port->midi_voices;
 	info->synth_voices = port->synth_voices;

 	/* get subscriber counts */
@@ -611,7 +613,7 @@
 int snd_seq_event_port_attach(int client,
 			      snd_seq_port_callback_t *pcbp,
 			      int cap, int type, int midi_channels,
-			      char *portname)
+			      int midi_voices, char *portname)
 {
 	snd_seq_port_info_t portinfo;
 	int  ret;
@@ -628,6 +630,7 @@
 	portinfo.type = type;
 	portinfo.kernel = pcbp;
 	portinfo.midi_channels = midi_channels;
+	portinfo.midi_voices = midi_voices;

 	/* Create it */
 	ret = snd_seq_kernel_client_ctl(client,
Index: alsa-kernel/include/seq_kernel.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/seq_kernel.h,v
retrieving revision 1.6
diff -u -r1.6 seq_kernel.h
--- alsa-kernel/include/seq_kernel.h	5 Feb 2003 11:07:52 -0000	1.6
+++ alsa-kernel/include/seq_kernel.h	28 Feb 2003 10:35:06 -0000
@@ -174,7 +174,7 @@

 /* port attach/detach */
 int snd_seq_event_port_attach(int client, snd_seq_port_callback_t *pcbp,
-			      int cap, int type, int midi_channels, char *portname);
+			      int cap, int type, int midi_channels, int midi_voices, char *portname);
 int snd_seq_event_port_detach(int client, int port);

 #endif /* __SOUND_SEQ_KERNEL_H */
Index: alsa-kernel/drivers/opl3/opl3_oss.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl3/opl3_oss.c,v
retrieving revision 1.9
diff -u -r1.9 opl3_oss.c
--- alsa-kernel/drivers/opl3/opl3_oss.c	5 Feb 2003 11:07:52 -0000	1.9
+++ alsa-kernel/drivers/opl3/opl3_oss.c	28 Feb 2003 10:35:06 -0000
@@ -101,7 +101,7 @@
 							  SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
 							  SNDRV_SEQ_PORT_TYPE_MIDI_GM |
 							  SNDRV_SEQ_PORT_TYPE_SYNTH,
-							  voices,
+							  voices, voices,
 							  name);
 	if (opl3->oss_chset->port < 0) {
 		snd_midi_channel_free_set(opl3->oss_chset);
Index: alsa-kernel/drivers/opl3/opl3_seq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl3/opl3_seq.c,v
retrieving revision 1.10
diff -u -r1.10 opl3_seq.c
--- alsa-kernel/drivers/opl3/opl3_seq.c	5 Feb 2003 11:07:52 -0000	1.10
+++ alsa-kernel/drivers/opl3/opl3_seq.c	28 Feb 2003 10:35:06 -0000
@@ -179,8 +179,10 @@
 {
 	snd_seq_port_callback_t callbacks;
 	char name[32];
-	int opl_ver;
+	int voices, opl_ver;

+	voices = (opl3->hardware < OPL3_HW_OPL3) ?
+		MAX_OPL2_VOICES : MAX_OPL3_VOICES;
 	opl3->chset = snd_midi_channel_alloc_set(16);
 	if (opl3->chset == NULL)
 		return -ENOMEM;
@@ -204,7 +206,7 @@
 						      SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
 						      SNDRV_SEQ_PORT_TYPE_MIDI_GM |
 						      SNDRV_SEQ_PORT_TYPE_SYNTH,
-						      16,
+						      16, voices,
 						      name);
 	if (opl3->chset->port < 0) {
 		snd_midi_channel_free_set(opl3->chset);
Index: alsa-kernel/isa/gus/gus_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_synth.c,v
retrieving revision 1.9
diff -u -r1.9 gus_synth.c
--- alsa-kernel/isa/gus/gus_synth.c	5 Feb 2003 11:07:52 -0000	1.9
+++ alsa-kernel/isa/gus/gus_synth.c	28 Feb 2003 10:35:06 -0000
@@ -197,7 +197,7 @@
 						   SNDRV_SEQ_PORT_TYPE_MIDI_GS |
 						   SNDRV_SEQ_PORT_TYPE_DIRECT_SAMPLE |
 						   SNDRV_SEQ_PORT_TYPE_SYNTH,
-						   16,
+						   16, 0,
 						   name);
 	if (p->chset->port < 0) {
 		result = p->chset->port;
Index: alsa-kernel/pci/trident/trident_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/trident/trident_synth.c,v
retrieving revision 1.9
diff -u -r1.9 trident_synth.c
--- alsa-kernel/pci/trident/trident_synth.c	25 Feb 2003 20:36:40 -0000	1.9
+++ alsa-kernel/pci/trident/trident_synth.c	28 Feb 2003 10:35:06 -0000
@@ -909,7 +909,7 @@
 						   SNDRV_SEQ_PORT_TYPE_MIDI_GS |
 						   SNDRV_SEQ_PORT_TYPE_DIRECT_SAMPLE |
 						   SNDRV_SEQ_PORT_TYPE_SYNTH,
-						   16,
+						   16, 0,
 						   name);
 	if (p->chset->port < 0) {
 		result = p->chset->port;
Index: alsa-kernel/synth/emux/emux_seq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/synth/emux/emux_seq.c,v
retrieving revision 1.8
diff -u -r1.8 emux_seq.c
--- alsa-kernel/synth/emux/emux_seq.c	5 Feb 2003 11:07:53 -0000	1.8
+++ alsa-kernel/synth/emux/emux_seq.c	28 Feb 2003 10:35:06 -0000
@@ -176,7 +176,8 @@
 	}

 	p->chset.port = snd_seq_event_port_attach(emu->client, callback,
-						  cap, type, max_channels, name);
+						  cap, type, max_channels,
+						  emu->max_voices, name);

 	return p;
 }




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
