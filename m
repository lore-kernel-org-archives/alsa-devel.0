From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hammerfall DSP driver installation problem
Date: Wed, 23 Oct 2002 15:21:21 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210231513150.23561-100000@studcom.urz.uni-halle.de>
References: <s5hsmyx1j2d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hsmyx1j2d.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> the dependency to rawmidi was missing in the entry for hdsp driver.
> now fixed on cvs.

> Log message:
>   fixed dependency of hdsp and usb-audio drivers.

Oops. And I forgot the dependency in alsa-kernel/core/seq/, too.


Index: alsa-kernel/core/seq/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/Makefile,v
retrieving revision 1.21
diff -u -r1.21 Makefile
--- alsa-kernel/core/seq/Makefile	5 Sep 2002 13:38:47 -0000	1.21
+++ alsa-kernel/core/seq/Makefile	23 Oct 2002 13:10:38 -0000
@@ -73,7 +73,7 @@
 obj-$(CONFIG_SND_EMU10K1) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-virmidi.o
 obj-$(CONFIG_SND_TRIDENT) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 obj-$(CONFIG_SND_YMFPCI) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
-obj-$(CONFIG_SND_USB_AUDIO) += snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-virmidi.o
+obj-$(CONFIG_SND_USB_AUDIO) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o

 obj-m := $(sort $(obj-m))




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
