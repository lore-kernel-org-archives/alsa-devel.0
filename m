From: Paul Davis <paul@linuxaudiosystems.com>
Subject: [forward] patch for 0.9.0rc6
Date: Mon, 06 Jan 2003 11:38:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301061629.h06GTw2a016313@spider.tela.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from spider.tela.com (spider.tela.com [206.98.7.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA02802
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 17:30:08 +0100
Received: from dhin.linuxaudiosystems.com (maxtnt01-sdf-281.fast.net [209.92.61.27])
	by spider.tela.com (8.12.6/8.12.6) with ESMTP id h06GTw2a016313
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 10:29:59 -0600 (CST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


------- Forwarded Message

Date:    Sun, 05 Jan 2003 16:31:00 +0100
From:    Jan Lindemann <jan@jannet.de>
To:      pbd@op.net
Subject: patch: module dependencies for Hammerfall DSP


- --------------Boundary-00=_O3Z8X6R9W6E459ZQIQUK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Paul,

my Hammerfall DSP card together with the plain alsa-driver-0.9.0rc6 distr=
o was=20
lacking support for the /dev/snd/seq device, since some modules had not b=
een=20
built. The attached one line patch worked for me.

Regards and thanks for the driver

Jan
- --=20
Jan Lindemann
mailto:j a n - a t - j a n n e t . d e  http://www.jannet.de

- --------------Boundary-00=_O3Z8X6R9W6E459ZQIQUK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="moddep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="moddep.patch"

diff -Naur alsa-driver-0.9.0rc6/alsa-kernel/core/seq/Makefile alsa-driver-0.9.0
rc6-jl-07/alsa-kernel/core/seq/Makefile
- --- alsa-driver-0.9.0rc6/alsa-kernel/core/seq/Makefile	Mon Nov  4 11:05:18 200
2
+++ alsa-driver-0.9.0rc6-jl-07/alsa-kernel/core/seq/Makefile	Sun Jan  5 13:3
7:51 2003
@@ -75,6 +75,7 @@
 obj-$(CONFIG_SND_TRIDENT) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq
- -midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_YMFPCI) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-
midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_USB_AUDIO) += snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+obj-$(CONFIG_SND_HDSP) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-mi
di-event.o
 
 obj-m := $(sort $(obj-m))
 

- --------------Boundary-00=_O3Z8X6R9W6E459ZQIQUK--



------- End of Forwarded Message



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
