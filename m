From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: HDSP -- how to configure modules.conf?
Date: Wed, 15 May 2002 17:38:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000201c1fc58$d4c73070$ac1f830a@ico>
References: <20020515172558.KHLI981.mta02.fuse.net@newmx1.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020515172558.KHLI981.mta02.fuse.net@newmx1.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> How did you compile? I mean right from the very beginning ... I've
> obviously been building from CVS all along, and I assume that Jaroslav
> did a rebuild after he committed the changes.
> 
> --p

Thank you for your continuous help!

Here's what I tried so far:

Did a clean cvs checkout on several occasions (last being today
afternoon):

1) used "build" script in the root dir of the cvs:
./build prep
./build config
./build all

2) used simple "make" in the root dir

3) did "cvscompile in the alsa-driver/ dir

The following 2 I did after the above one (once I got all the configure
files made with the above process and saw that it did not compile
properly)

4) did "./config --use-sequencer=yes" in the alsa-driver/ dir

5) did "./config --with-cards=hdsp"

All of them gave me the same error (the one I sent you) except the last
one which reported that there is no such card.

In between I did clean CVS-checkouts and/or updates just to make sure it
worked. Finally, I messed with the code since the error always reported
error in the hammerfall_mem.c file on the line 58. I commented that line
out and suddenly it compiled miraculously. I can even modprobe
hammerfall_mem.o without any problem and the built-in soundcard (Dell
Inspiron 8000) maestro3.o starts up just fine, but neither in the
/lib/modules/... nor in the <CVS>/alsa-driver/modules/ there is no sign
of snd-hdsp.o. These are the files I do have there:

CVS/                  snd-es1688.o@          snd-pdplus.o@
snd-ac97-codec.o@     snd-es18xx.o@          snd-rawmidi.o@
snd-ad1816a-lib.o@    snd-es1938.o@          snd-rme32.o@
snd-ad1816a.o@        snd-es1968.o@          snd-rme9652.o@
snd-ad1848-lib.o@     snd-es968.o@           snd-rme96.o@
snd-ad1848.o@         snd-fm801.o@           snd-sb16-csp.o@
snd-ainstr-fm.o@      snd-gusclassic.o@      snd-sb16-dsp.o@
snd-ainstr-gf1.o@     snd-gusextreme.o@      snd-sb16.o@
snd-ainstr-iw.o@      snd-gus-lib.o@         snd-sb8-dsp.o@
snd-ainstr-simple.o@  snd-gusmax.o@          snd-sb8.o@
snd-ak4531-codec.o@   snd-gus-synth.o@       snd-sbawe.o@
snd-ali5451.o@        snd-hammerfall-mem.o@  snd-sb-common.o@
snd-als100.o@         snd-hwdep.o@           snd-seq-device.o@
snd-als4000.o@        snd-i2c.o@             snd-seq-instr.o@
snd-azt2320.o@        snd-ice1712.o@         snd-seq-midi-emul.o@
snd-cmi8330.o@        snd-intel8x0.o@        snd-seq-midi-event.o@
snd-cmipci.o@         snd-interwave.o@       snd-seq-midi.o@
snd-cs4231-lib.o@     snd-interwave-stb.o@   snd-seq.o@
snd-cs4231.o@         snd-korg1212.o@        snd-seq-oss.o@
snd-cs4232.o@         snd-maestro3.o@        snd-seq-virmidi.o@
snd-cs4236-lib.o@     snd-mixer-oss.o@       snd-serialmidi.o@
snd-cs4236.o@         snd-mpu401.o@          snd-serial-u16550.o@
snd-cs4281.o@         snd-mpu401-uart.o@     snd-sgalaxy.o@
snd-cs46xx.o@         snd-mtpav.o@           snd-sonicvibes.o@
snd-cs8427.o@         snd-nm256.o@           snd-tea6330t.o@
snd-dt0197h.o@        snd.o@                 snd-timer.o@
snd-dummy.o@          snd-opl3-lib.o@        snd-trident.o@
snd-emu10k1.o@        snd-opl3sa2.o@         snd-trident-synth.o@
snd-emu10k1-synth.o@  snd-opl3-synth.o@      snd-util-mem.o@
snd-emu8000-synth.o@  snd-opti92x-ad1848.o@  snd-via686.o@
snd-emux-synth.o@     snd-opti92x-cs4231.o@  snd-via8233.o@
snd-ens1370.o@        snd-opti93x.o@         snd-virmidi.o@
snd-ens1371.o@        snd-pcm.o@             snd-wavefront.o@
snd-es1688-lib.o@     snd-pcm-oss.o@         snd-ymfpci.o@

(all of these are sym-links to different folders where these files
reside i.e. ../driver/ etc.)


ALSA-CVS/alsa-driver/pci/rme9652 folder has the following entries, and
as you can see all the files have the .o counterparts except for the
hdsp.c:

CVS/              hdsp.c     rme9652.o
hammerfall_mem.c  Makefile   snd-hammerfall-mem.o
hammerfall_mem.o  rme9652.c  snd-rme9652.o

So, I have no clue as to what is going on. I will check the makefile in
the rme9652 folder to see if it even mentions building hdsp.c file.

Finally, my system is MDK 8.1 (slightly modified) Kernel 2.4.8 (I know,
I've been lazy with my updating of the kernel).

Thank you for your help! Sincerely,

Ico




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
