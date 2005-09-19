From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000660]: No sound output  despite unmuting and maximizing all volume settings
Date: Mon, 19 Sep 2005 10:12:53 +0200
Message-ID: <64a32f0bb9397dd97f52574873c4339a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5F2EF13A
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 10:12:54 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=660> 
======================================================================
Reported By:                bji
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   660
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               Fedora Core 3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-21-2004 02:53 CET
Last Modified:              09-19-2005 10:12 CEST
======================================================================
Summary:                    No sound output  despite unmuting and maximizing all
volume settings
Description: 
I get no sound output from any program I have tried (xmms, play, aplay, cat
> /dev/audio) with no error messages or any other indication that there is
a problem which would cause sound to not occur.

I have already run alsamixer many times and tried every combination of
muted and unmuted settings with all volumes maximized.  With no volume
settings muted, and all volume settings at maximum level, I still get no
sound.

Everything *looks* like it's working - output in the kernel log, xmms's
display, everything.  But I get no sound out of the built-in speaker or
the headphone jack.

I have tried the following:

* Default install of Fedora Core 3; it recognized the sound card and
installed module settings in /etc/modprobe.conf to load snd-intel8x0.  But
I never got any sound out of this default install no matter what I tried.

* Custom compiled the 2.6.9 kernel with no patches except the software
suspend 2 patch.  This built the version of the ALSA drivers that come
with 2.6.9.  Still no sound.

* Downloaded and compiled version 1.0.7 of the ALSA drivers and installed
them.  Still no sound.

======================================================================

----------------------------------------------------------------------
 bji - 11-21-04 02:55 
----------------------------------------------------------------------
Oh, I should mention that previously I had been using Debian unstable and
the sound worked perfectly.  I believe that the kernel version was 2.6.8
or 2.6.9 (unfortunately I have blown away that installation and can't get
any information from it).

----------------------------------------------------------------------
 bji - 11-21-04 03:16 
----------------------------------------------------------------------
Here's my /etc/modprobe.conf if it helps:

# Ethernet
alias eth0 8139too

# USB
alias usb-controller ehci-hcd
alias usb-controller1 uhci-hcd

# ALSA
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=0
install snd-intel8x0 /sbin/modprobe --ignore-install snd-intel8x0 &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
remove snd-intel8x0 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-intel8x0

# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-slot 1 snd-card-1

# Intel Sound
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

----------------------------------------------------------------------
 bji - 11-21-04 03:19 
----------------------------------------------------------------------
Here are the modules that are installed after my system boots:

Module                  Size  Used by
snd_pcm_oss            55208  0 
snd_mixer_oss          19712  1 snd_pcm_oss
snd_intel8x0           36924  1 
snd_ac97_codec         76896  1 snd_intel8x0
snd_pcm               111240  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              34948  1 snd_pcm
snd                    61156  8
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore              11360  1 snd
snd_page_alloc         10504  2 snd_intel8x0,snd_pcm
uhci_hcd               34960  0 
ehci_hcd               37380  0 
ipw2100               146372  0 
ieee80211              35908  1 ipw2100
i915                   86788  3 
md5                     4608  1 
ipv6                  272320  8 
ds                     19204  2 
ipt_REJECT              7296  1 
ipt_state               2176  1 
ip_conntrack           45876  1 ipt_state
iptable_filter          3200  1 
ip_tables              18048  3 ipt_REJECT,ipt_state,iptable_filter
dm_mod                 62740  0 
button                  6928  0 
battery                 9220  0 
ac                      5124  0 
yenta_socket           20864  0 
pcmcia_core            67396  2 ds,yenta_socket
arc4                    2176  1 
ieee80211_crypt_wep     5376  1 
ieee80211_crypt         7684  2 ieee80211,ieee80211_crypt_wep
8139too                30336  0 
mii                     5504  1 8139too
ext3                  121576  1 
jbd                    90392  1 ext3

----------------------------------------------------------------------
 tiwai - 11-23-04 16:20 
----------------------------------------------------------------------
It's likely a mixer issue.  Could you attach /etc/asound.state?

----------------------------------------------------------------------
 bji - 11-24-04 12:33 
----------------------------------------------------------------------
OK, I attached /etc/asound.state.  Thank you very much for looking into
this problem.

----------------------------------------------------------------------
 tiwai - 11-24-04 12:40 
----------------------------------------------------------------------
Please, don't mix up bugs on different systems.  Rather create a new bug
report for a different board.  We can mark them as duplicated once after
we find they are really identical.

(Both of you have different AC97 codec chips, so the culprit could be also
different in a high probability...)

----------------------------------------------------------------------
 IceRAM - 11-24-04 13:26 
----------------------------------------------------------------------
Sorry, didn't know that. 

I was too happy (sort of) because somebody else had the same problem,
under the same conditions. That's why I reported here. (I tried cleaning
up a bit the Bug report page, but I couldn't remove my attachments).

New bug @ https://bugtrack.alsa-project.org/alsa-bug/view.php?id=674

----------------------------------------------------------------------
 tiwai - 11-24-04 14:57 
----------------------------------------------------------------------
Thanks.

The problem in this bug seems that some missing codec setup for STAC9752. 
Needs a more deeper look at the datasheet.

----------------------------------------------------------------------
 bji - 11-25-04 07:07 
----------------------------------------------------------------------
Is there something I can do to help?  Thanks!

----------------------------------------------------------------------
 bji - 11-28-04 04:24 
----------------------------------------------------------------------
Hi there, is there anything that I can to do help diagnose and fix this
problem?  Let me know if there is.  I think I'll start by trying older
ALSA versions; like I said in my original report, my Debain Sarge install
had ALSA working with this laptop and maybe it was using an older version
of ALSA.  Thank you!

----------------------------------------------------------------------
 bji - 11-28-04 06:04 
----------------------------------------------------------------------
I could not get older versions of ALSA drivers to compile with kernel
2.6.9.  The oldest that I successfully got to compile was 1.0.4.  It did
not fix the problem, nor did 1.0.5.

Please let me know if there is something else I should try to diagnose
this problem.  Thanks!

----------------------------------------------------------------------
 tiwai - 11-29-04 17:19 
----------------------------------------------------------------------
Could you try the patch stac9752.diff and change values in "Headphone Pin"
and "Line-Out Pin" controls?

----------------------------------------------------------------------
 bji - 11-30-04 08:56 
----------------------------------------------------------------------
Unfortunately, the patch did not fix the problem.  I applied the patch by
running the following commands:

cd ~/alsa-driver-1.0.7/alsa-kernel
patch -p1 < ~/stac9752a.diff
cd ~/alsa-driver-1.0.7
make
make install

This patched, built and installed new snd-ac97-codec.ko and
snd-ak4531-codec.ko modiles.  However, when I modprobe -r the old versions
and modprobe the new versions, I still received no sound from the built-in
speaker or the headphone jack.

I also ran alsamixer and played with the settings there, especially the
headphone and the line out settings.  No changes to these values had any
effect.

Is there something else I can try :(

Thank you for taking the time to try to solve this problem, I really do
appreciate it!

----------------------------------------------------------------------
 tiwai - 11-30-04 21:02 
----------------------------------------------------------------------
One thing you can check is to set the capture source as 'Mix', and record
the sound during playback PCM at the same time.  In this way, at least you
can see whether the PCM is processed correctly in the AC97 codec (e.g. you
can see waves in a sound editor).

If the signal is processed properly in the chip, it's a problem of some
missing configuration for the HP or Line-Out jacks.

----------------------------------------------------------------------
 bji - 12-02-04 06:37 
----------------------------------------------------------------------
I apologize, but I am not very familiar with recording sound under Linux. 
I am running Fedora Core 3 without Gnome or KDE, and I don't know of any
sound recorder that I can use.  Can you please give some hints about what
I need to do to record sound from the PCM during playback at the same
time?  Can I do this using a command line tool?

I tried using arecord while playing a song using xmms but the resulting
file did not show any waves in the graphical xmms display when I played
it.

I also tried using arecord while playing a .wav file repeatedly using
aplay, but the resulting file also did not show any waves in the graphical
xmms display when I played it.

----------------------------------------------------------------------
 tiwai - 12-02-04 19:20 
----------------------------------------------------------------------
Don't forget to choose 'Mix' as the capture source, and raise 'Capture
Volume', turn on 'Capture Switch', too.

----------------------------------------------------------------------
 jnm11 - 12-06-04 19:47 
----------------------------------------------------------------------
I have the same intel system and run Fedora core.
It seems you must set the "external amplifier" to mute in in the mixer
control and then it works.

----------------------------------------------------------------------
 bji - 12-09-04 07:06 
----------------------------------------------------------------------
Thank you for the suggestion, unfortunately muting "external amplifier" via
alsamixer does not fix the problem.

I apologize but I still don't know how to run the record test that you
(tiwai) are suggesting.  I don't know what program to run to do the audio
recording.  Can you please suggest a program.  Thank you!

----------------------------------------------------------------------
 bji - 03-07-05 02:22 
----------------------------------------------------------------------
OK, here's another data point.

I recently got a Panasonic Y2 in addition to the Panasonic T2 that I was
using when reporting this bug.  As far as I know, the hardware related to
sound in these two laptops is essentially the same.

I discovered that I could get sound to work with the Panasonic Y2 if I did
the following:

* Booted to Windows XP
* Turned the Windows XP volume control to its highest setting
* Muted sound in Windows XP (which is how I usually keep sound in Windows
XP)

Now if I boot Linux with ALSA 1.0.6 (the stock alsa with Fedora Core 3), I
can adjust the sound volumes using alsamixer, and everything works.  I can
play musing using xmms with either the ALSA or OSS plugins, and this also
works (although the volume slider in xmms does not work, not sure why, I
have to use alsamixer or aumix to adjust sound volume).  Also, the
speakers work.

Thus I am convinced that the problem is that the ALSA driver for this
hardware is for some reason not able to adjust the volume beyond some
maximum value which was set by the BIOS, as remembered by the most recent
Windows XP setting.

Does this help at all?

Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-04 02:53 bji            New Issue                                    
11-21-04 02:53 bji            Distribution              => Fedora Core 3   
11-21-04 02:53 bji            Kernel Version            => 2.6.9           
11-21-04 02:55 bji            Note Added: 0002481                          
11-21-04 02:56 bji            File Added: proc_asound.txt                    
11-21-04 03:16 bji            Note Added: 0002483                          
11-21-04 03:19 bji            Note Added: 0002484                          
11-23-04 16:20 tiwai          Note Added: 0002522                          
11-23-04 23:23 IceRAM         Note Added: 0002537                          
11-23-04 23:24 IceRAM         File Added: asound.state                     
11-23-04 23:25 IceRAM         File Added: modprobe.conf                    
11-23-04 23:26 IceRAM         File Added: iceram_lsmod.txt                    
11-23-04 23:27 IceRAM         Note Added: 0002538                          
11-23-04 23:28 IceRAM         Note Edited: 0002537                         
11-23-04 23:29 IceRAM         Note Edited: 0002537                         
11-23-04 23:29 IceRAM         Issue Monitored: IceRAM                      
11-23-04 23:45 IceRAM         Note Added: 0002539                          
11-23-04 23:45 IceRAM         File Added: .asoundrc                        
11-23-04 23:46 IceRAM         Note Edited: 0002538                         
11-24-04 12:32 bji            File Added: asound.state                     
11-24-04 12:33 bji            Note Added: 0002550                          
11-24-04 12:40 tiwai          Note Added: 0002552                          
11-24-04 13:15 IceRAM         Note Deleted: 0002537                        
11-24-04 13:16 IceRAM         Note Deleted: 0002539                        
11-24-04 13:19 IceRAM         Note Deleted: 0002538                        
11-24-04 13:26 IceRAM         Note Added: 0002561                          
11-24-04 14:57 tiwai          Note Added: 0002565                          
11-25-04 07:07 bji            Note Added: 0002587                          
11-28-04 04:24 bji            Note Added: 0002619                          
11-28-04 06:04 bji            Note Added: 0002620                          
11-29-04 17:19 tiwai          Note Added: 0002654                          
11-29-04 17:19 tiwai          File Added: stac9752a.diff                    
11-30-04 08:56 bji            Note Added: 0002661                          
11-30-04 21:02 tiwai          Note Added: 0002662                          
12-02-04 06:37 bji            Note Added: 0002674                          
12-02-04 19:20 tiwai          Note Added: 0002689                          
12-06-04 19:47 jnm11          Note Added: 0002730                          
12-06-04 19:47 jnm11          Issue Monitored: jnm11                       
12-09-04 07:06 bji            Note Added: 0002797                          
03-07-05 02:22 bji            Note Added: 0003806                          
09-19-05 10:12 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
