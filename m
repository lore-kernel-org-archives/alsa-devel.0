From: Markus Schoder <markus_schoder@yahoo.de>
Subject: cmipci random noise + Makefile patch
Date: Sat, 25 May 2002 22:04:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205252204.16801.markus_schoder@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA23228
	for <alsa-devel@alsa-project.org>; Sat, 25 May 2002 22:05:08 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When playing .wav files with aplay sometimes random noise is appended to =
the=20
actual sample.  It does not happen with e.g. playwave which uses OSS=20
emulation.  I think this never worked correctly with the cmipci driver.

Another problem I see is that with the current CVS alsa drivers (2002-05-=
25) I=20
get the following message when doing a depmod -ae

depmod: *** Unresolved symbols in=20
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/sound/alsa/snd-seq-midi.o
depmod:         snd_midi_event_decode
depmod:         snd_midi_event_free
depmod:         snd_midi_event_new
depmod:         snd_midi_event_encode
depmod:         snd_midi_event_reset_decode

The following patch solved it for me


--- alsa/alsa-kernel/core/seq/Makefile.old=09Fri May 24 20:56:10 2002
+++ alsa/alsa-kernel/core/seq/Makefile=09Sat May 25 21:28:21 2002
@@ -34,7 +34,9 @@
 snd-seq-virmidi-objs :=3D seq_virmidi.o
=20
 obj-$(CONFIG_SND_SEQUENCER) +=3D snd-seq.o snd-seq-device.o
-obj-$(CONFIG_SND_SEQUENCER_OSS) +=3D snd-seq-midi-event.o
+ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
+obj-$(CONFIG_SND_SEQUENCER) +=3D snd-seq-midi-event.o
+endif
 obj-$(CONFIG_SND_SEQ_DUMMY) +=3D snd-seq-dummy.o
=20
 # Toplevel Module Dependency


--
Markus


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
