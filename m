From: William <walsac3c@orthoset.com>
Subject: Patch for typos in alsa-kernel cvs code for MIDI sostenuto
Date: Wed, 16 Mar 2005 12:20:13 GMT
Message-ID: <200503161220.MAA15993@orthoset.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Received: from orthoset.com (dsl-80-46-82-33.access.as9105.com [80.46.82.33])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 877A1215
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 13:18:23 +0100 (MET)
Received: (from root@localhost) by orthoset.com  id MAA15993 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 12:20:13 GMT
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix typos in alsa-kernel code for MIDI sostenuto.

Signed-off-by: William <walsac3c AT orthoset.com>

References:

 [1] MIDI 1.0 Specification
     http://www.midi.org/about-midi/specinfo.shtml

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=alsa-kernel-sostenuto.patch


--- a/alsa-kernel/include/seq_midi_emul.h	2004-11-30 20:03:18.000000000 +0000
+++ b/alsa-kernel/include/seq_midi_emul.h	2005-03-16 11:59:19.000000000 +0000
@@ -136,7 +136,7 @@
 #define gm_sustain	 	control[MIDI_CTL_SUSTAIN]
 #define gm_hold			gm_sustain
 #define gm_portamento		control[MIDI_CTL_PORTAMENTO]
-#define gm_sustenuto		control[MIDI_CTL_SUSTENUTO]
+#define gm_sostenuto		control[MIDI_CTL_SOSTENUTO]
 
 /*
  * These macros give the complete value of the controls that consist
@@ -166,7 +166,7 @@
 #define SNDRV_MIDI_NOTE_OFF		0x00
 #define SNDRV_MIDI_NOTE_ON		0x01
 #define SNDRV_MIDI_NOTE_RELEASED		0x02
-#define SNDRV_MIDI_NOTE_SUSTENUTO		0x04
+#define SNDRV_MIDI_NOTE_SOSTENUTO		0x04
  
 #define SNDRV_MIDI_PARAM_TYPE_REGISTERED		0
 #define SNDRV_MIDI_PARAM_TYPE_NONREGISTERED	1
--- a/alsa-kernel/include/asoundef.h	2002-03-11 18:54:30.000000000 +0000
+++ b/alsa-kernel/include/asoundef.h	2005-03-16 11:58:19.000000000 +0000
@@ -185,7 +185,7 @@
 #define MIDI_CTL_LSB_GENERAL_PURPOSE4 	0x33
 #define MIDI_CTL_SUSTAIN              	0x40
 #define MIDI_CTL_PORTAMENTO           	0x41
-#define MIDI_CTL_SUSTENUTO            	0x42
+#define MIDI_CTL_SOSTENUTO            	0x42
 #define MIDI_CTL_SOFT_PEDAL           	0x43
 #define MIDI_CTL_LEGATO_FOOTSWITCH	0x44
 #define MIDI_CTL_HOLD2                	0x45
--- a/alsa-kernel/core/seq/seq_midi_emul.c	2004-11-30 20:03:17.000000000 +0000
+++ b/alsa-kernel/core/seq/seq_midi_emul.c	2005-03-16 11:57:57.000000000 +0000
@@ -244,8 +244,8 @@
 	if (chan->gm_hold) {
 		/* Hold this note until pedal is turned off */
 		chan->note[note] |= SNDRV_MIDI_NOTE_RELEASED;
-	} else if (chan->note[note] & SNDRV_MIDI_NOTE_SUSTENUTO) {
-		/* Mark this note as release; it will be turned off when sustenuto
+	} else if (chan->note[note] & SNDRV_MIDI_NOTE_SOSTENUTO) {
+		/* Mark this note as release; it will be turned off when sostenuto
 		 * is turned off */
 		chan->note[note] |= SNDRV_MIDI_NOTE_RELEASED;
 	} else {
@@ -287,18 +287,18 @@
 		break;
 	case MIDI_CTL_PORTAMENTO:
 		break;
-	case MIDI_CTL_SUSTENUTO:
+	case MIDI_CTL_SOSTENUTO:
 		if (value) {
 			/* Mark each note that is currently held down */
 			for (i = 0; i < 128; i++) {
 				if (chan->note[i] & SNDRV_MIDI_NOTE_ON)
-					chan->note[i] |= SNDRV_MIDI_NOTE_SUSTENUTO;
+					chan->note[i] |= SNDRV_MIDI_NOTE_SOSTENUTO;
 			}
 		} else {
 			/* release all notes that were held */
 			for (i = 0; i < 128; i++) {
-				if (chan->note[i] & SNDRV_MIDI_NOTE_SUSTENUTO) {
-					chan->note[i] &= ~SNDRV_MIDI_NOTE_SUSTENUTO;
+				if (chan->note[i] & SNDRV_MIDI_NOTE_SOSTENUTO) {
+					chan->note[i] &= ~SNDRV_MIDI_NOTE_SOSTENUTO;
 					if (chan->note[i] & SNDRV_MIDI_NOTE_RELEASED) {
 						chan->note[i] = SNDRV_MIDI_NOTE_OFF;
 						if (ops->note_off)

--Nq2Wo0NMKNjxTN9z--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
