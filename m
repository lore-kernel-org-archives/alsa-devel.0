From: "Paul Hanly \(Hotmail\)" <paulhanly@hotmail.com>
Subject: Re: [ANN] ALSA 1.0.0pre1 is released
Date: Thu, 20 Nov 2003 09:39:30 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-DAV45fk0nL0f5E000054e3@hotmail.com>
References: <s5hn0as1hvn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Was the patching described by Eric Hathaway's post done for the new version,
or was it decided it wasn't really necessary? See: [Alsa-devel] aureal
driver compile problem and patch The patch is copied below for your
convenience.

I would also like to suggest that the INSTALL file and read me files have
specific references to the pages at:
http://alsa.opensrc.org/index.php?page=AlsaDrivers
In my case the ones for Aureal
(http://alsa.opensrc.org/index.php?page=au88x0 and links from there) were
invaluable.
I would also like to sugget the addition of a NewToLinuxReadThis file with a
quick overview that will get newbies who have just installed a distro and
can't get their soundcard to work up and running in the easiest possible
way. Maybe including the reference to the
http://alsa.opensrc.org/index.php?page=AlsaDrivers will do.

Some other mods that would be good for Newbies is if alsamixergui is package
independent and had an obvious Save Settings button that initiated a script
that did away with the need to directly use alsactl and to modify the
modules.conf file. It could also pop up a reference to the
http://alsa.opensrc.org/index.php?page=AlsaDrivers page on starting.

I would also like to suggest a gui for the install process with scripting
that did the detection of card, whether kernel-source is installed, whether
sound is loaded, whether oss is needed, whether tools are needed (based on
soundcard), doing ./snddevices, checking for/getting, installing and setting
unmuting/volumes for alsamixergui - the whole process should be able to be
made a lot easier for people who just got a distro off the front cover of a
computer mag. For these people ease of installation and use of sound and
surfing (the winmodem problem) are likely to be a big deal right at the
start.
cheers
Paul
--------------- BEGIN PATCH -----------------------
diff -ur alsa-driver-0.9.8/acore/Makefile
alsa-driver-0.9.8-patched/acore/Makefile
--- alsa-driver-0.9.8/acore/Makefile Tue Sep 16 06:14:03 2003
+++ alsa-driver-0.9.8-patched/acore/Makefile Tue Oct 21 22:21:12 2003
@@ -10,6 +10,9 @@
obj-$(CONFIG_SND_SERIALMIDI) += snd-rawmidi.o snd.o
obj-$(CONFIG_SND_MSND_PINNACLE) += snd-pcm.o snd-timer.o snd-page-alloc.o
snd.o snd-rawmidi.o
obj-$(CONFIG_SND_USB_US428) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
snd-rawmidi.o snd-hwdep.o
+obj-$(CONFIG_SND_AU8810) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
snd-rawmidi.o
+obj-$(CONFIG_SND_AU8820) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
snd-rawmidi.o
+obj-$(CONFIG_SND_AU8830) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
snd-rawmidi.o

export-objs := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o memalloc.o

diff -ur alsa-driver-0.9.8/acore/seq/Makefile
alsa-driver-0.9.8-patched/acore/seq/Makefile
--- alsa-driver-0.9.8/acore/seq/Makefile Mon Jun 2 09:03:38 2003
+++ alsa-driver-0.9.8-patched/acore/seq/Makefile Tue Oct 21 22:21:20
2003@@ -7,6 +7,9 @@

obj-$(CONFIG_SND_SERIALMIDI) += snd-seq-midi.o snd-seq.o snd-seq-device.o
snd-seq-midi-event.o
obj-$(CONFIG_SND_MSND_PINNACLE) += snd-seq-midi.o snd-seq.o snd-seq-device.o
snd-seq-midi-event.o
+obj-$(CONFIG_SND_AU8810) += snd-seq-midi.o snd-seq.o snd-seq-device.o
snd-seq-midi-event.o snd-seq-instr.o
+obj-$(CONFIG_SND_AU8820) += snd-seq-midi.o snd-seq.o snd-seq-device.o
snd-seq-midi-event.o snd-seq-instr.o
+obj-$(CONFIG_SND_AU8830) += snd-seq-midi.o snd-seq.o snd-seq-device.o
snd-seq-midi-event.o snd-seq-instr.o

export-objs := seq_device.o seq.o seq_instr.o seq_midi_emul.o \
seq_midi_event.o seq_virmidi.o
diff -ur alsa-driver-0.9.8/drivers/mpu401/Makefile
alsa-driver-0.9.8-patched/drivers/mpu401/Makefile
--- alsa-driver-0.9.8/drivers/mpu401/Makefile Mon Jun 2 09:03:39 2003
+++ alsa-driver-0.9.8-patched/drivers/mpu401/Makefile Tue Oct 21 22:21:36
2003@@ -3,6 +3,10 @@
include $(TOPDIR)/toplevel.config
include $(TOPDIR)/Makefile.conf


+obj-$(CONFIG_SND_AU8810) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_AU8820) += snd-mpu401-uart.o
+obj-$(CONFIG_SND_AU8830) += snd-mpu401-uart.o
+
export-objs  := mpu401_uart.o

TOPDIR = $(MAINSRCDIR)
diff -ur alsa-driver-0.9.8/pci/ac97/Makefile
alsa-driver-0.9.8-patched/pci/ac97/Makefile
--- alsa-driver-0.9.8/pci/ac97/Makefile Sun Feb 9 13:35:57 2003
+++ alsa-driver-0.9.8-patched/pci/ac97/Makefile Tue Oct 21 22:21:49 2003
@@ -3,6 +3,10 @@
include $(TOPDIR)/toplevel.config
include $(TOPDIR)/Makefile.conf


+obj-$(CONFIG_SND_AU8810) += snd-ac97-codec.o
+obj-$(CONFIG_SND_AU8820) += snd-ac97-codec.o
+obj-$(CONFIG_SND_AU8830) += snd-ac97-codec.o
+
export-objs  := ac97_codec.o ak4531_codec.o


TOPDIR = $(MAINSRCDIR)
--------------- END PATCH -----------------------

----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de>
To: <alsa-devel@lists.sourceforge.net>
Cc: <alsa-user@lists.sourceforge.net>
Sent: Thursday, November 20, 2003 2:46 AM
Subject: [Alsa-devel] [ANN] ALSA 1.0.0pre1 is released


> Hi all,
>
> as you might have already seen on the web news page, we released
> 1.0.0pre1 tarball.  This is intended for the wide tests before the
> official 1.0.0 release.  We planned to release 1.0.0 (hopefully) in
> this month, so please everyone test this version and give bug reports
> now.
>
> Especially, if you have a card or a mobo with ICH (or compatible)
> chip and *multiple* AC97 codecs, testing this version is appreciated.
> Please give (also positive) feedback whether it works.  The handling
> of multiple codecs was changed recently, but not tested well because
> of lack of hardware.
>
>
> Important changes / fixes since 0.9.8
>
> - joystick is configured now (again) by module options instead of
>   control API.  see alsa-kernel/Documentation/Joystick.txt.
>
> - the default value of cards_limit option of sound module is 1.
>   note that this doesn't mean that the max. number of cards is limited
>   to 1, but it restricts the number of auto-loaded cards.  if you load
>   a module manually, it's added safely.
>
> - PCM OSS emulation was fixed, e.g. mplayer delay problem should be
>   fixed now.  Hopefully this doesn't introduce another bug...
>
> - AC97 handler is rewritten.  please test!
>
> - some serious ISA PnP bugs are fixed (e.g. cs4236 freeze).
>
> - some bugs in OSS-emulation library are fixed.  please test!
>
> - dmix problems with xmms ALSA plugin is solved.
>
> - alsa-driver tree can be built with 2.6 kernel.
>
> - alsaconf is now moved to alsa-utils tarball.
>
>
> Known problems
>
> - pdplus driver seems broken.  more testers?
>
> - korg1212 driver seems broken (somehow).
>
> - PCM OSS emulation might cause oops when you compile the kernel
>   without frame pointer (depending on the compiler).
>
> - opti92x still might not work (although some bugs were fixed).
>
>
> --
> Takashi Iwai <tiwai@suse.de> ALSA Developer - www.alsa-project.org
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
