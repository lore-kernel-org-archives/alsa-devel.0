From: noreply@alsa-project.org
Subject: [ALSA - driver 0000175]: atiixp: codec timeout
Date: Fri, 16 Jul 2004 14:39:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123941.06E402C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6B07A244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:39:41 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000175
======================================================================
Reported By:                frhart
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     175
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.4, 2.6.5-rc3
======================================================================
Date Submitted:             04-01-2004 04:41 CEST
Last Modified:              07-16-2004 14:39 CEST
======================================================================
Summary:                    atiixp: codec timeout
Description: 
The atiixp driver gives the following error 4 times on startup:
atiixp: codec read timeout

The driver does load however. This is when compiling alsa without OSS
support (OSS Mixer API, OSS PCM API). When OSS is configured the same
error occurs but now 400+ times and the driver doesn't load.

I used the 1.03b alsa drivers and tried it with kernel 2.6.5-rc3.
======================================================================

----------------------------------------------------------------------
 Mark Knecht - 04-03-2004 16:07 CEST 
----------------------------------------------------------------------
I am experiencing the same problem using Gentoo. Soudn worked fine
yesterday using a 2.4.25 type kernel. I updated to 2.6.5_rc3 to get DMA
support for the same ATI chipset and sound is broken totally. From dmesg:

<SNIP>
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
Adding 1004020k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout

<SNIP>

atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
AC'97 2 does not respond - RESET
atiixp: codec read timeout
atiixp: codec read timeout
AC'97 2 access is not valid [0xffffffff], removing mixer.
ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -5
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1

Attempting to run alsamixer fails:

flash root # alsamixer

alsamixer: function snd_ctl_open failed for default: No such device
flash root # 


flash root # cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.3 (Mon Mar 01
10:12:14 2004 UTC).
Compiled on Apr  3 2004 for kernel 2.6.5-rc3.
flash root # 


flash root # cat /proc/asound/cards   
--- no soundcards ---
flash root # 


### modules-update: start processing /etc/modules.d/alsa
alias char-major-116 snd
alias char-major-14 soundcore

alias snd-card-0 snd-atiixp
alias sound-slot-0 snd-card-0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

options snd cards_limit=1

### modules-update: end processing /etc/modules.d/alsa

----------------------------------------------------------------------
 Mark Knecht - 04-03-2004 18:02 CEST 
----------------------------------------------------------------------
Just verification that under 2.4.25 the atiixp driver works fine. From
dmesg:

PCI: Sharing IRQ 10 with 02:04.1
PCI: Sharing IRQ 10 with 02:07.0
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8208000-e82087ff]  Max
Packet=         
[2048]
sbp2: $Rev: 1074 $ Ben Collins <bcollins@debian.org>
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[413f0200b723013d]
PCI: Guessed IRQ 10 for device 00:14.5
PCI: Sharing IRQ 10 with 00:14.6
PCI: Sharing IRQ 10 with 02:04.0
ALSA atiixp.c:453: atiixp: codec read timeout
ALSA atiixp.c:453: atiixp: codec read timeout
ALSA atiixp.c:453: atiixp: codec read timeout
ALSA atiixp.c:453: atiixp: codec read timeout
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
mark@flash mark $ 


At this point xine and alsaplayer both work fine. xine is jerky since I
don't get dma for the ATI chipset with this kernel.

----------------------------------------------------------------------
 frhart - 04-04-2004 19:04 CEST 
----------------------------------------------------------------------
It seems OSS emulations works with 2.6.5. atiixp still gives the codec read
timeout 4 times, but the driver does load, also when OSS emulations
compiled in. I used the 2.6.5 kernel source and the kernel alsa drivers
(1.0.4rc2).

----------------------------------------------------------------------
 Mark Knecht - 04-04-2004 19:54 CEST 
----------------------------------------------------------------------
Sorry, I'm not following. Are you saying with OSS-emulation compiled into
the kernel, instead of modular, you are able to get OSS apps to produce
sound?

I'm not able to run alsamixer at all, so how do I raise volume to hear an
OSS application's audio?

Can you run alsamixer?

----------------------------------------------------------------------
 frhart - 04-04-2004 20:35 CEST 
----------------------------------------------------------------------
Sorry, that was confusing. I meant to say that I didn't use the alsa
drivers seperately but use the alsa drivers from the kernel. I don't think
you can compile the drivers into the kernel anyway. I think they changed
something from version 1.03 to 1.04rc2 but haven't found it in the
changelog.

Yes, I can run alsamixer. How did you compile the kernel?

----------------------------------------------------------------------
 Mark Knecht - 04-04-2004 22:17 CEST 
----------------------------------------------------------------------
OK, we're doing it a bit differently, so I'll try the way you are doing it.
On Gentoo I download (emerge) the 2.6.5_rc3 kernel, but during
configuration I was only choosing sound and I was disabling all Alsa
options in the kernel. I was then building (through emerge again)
alsa-driver + everything else outside the kernel. Doing it this way I am
unable to run alsamixer and I get no sound at all.

I'll remove the alsa-driver package and then re-emerge the 2.6.5 kernel,
rebuild Alsa using what's included in the kernel and see how that goes. I
really need 2.6.5 since without it my ATI chipset has no DMA.

Thanks

edited on: 04-04-04 22:17

----------------------------------------------------------------------
 frhart - 04-04-2004 21:43 CEST 
----------------------------------------------------------------------
Well, the seperate alsa driver is only a few days newer than the ones in
the kernel so that shouldn't make much difference. But the way you do it
should work too. I've tried it with a different 2.6 kernel and it works
the same. Seems to me your sound devices aren't available. Maybe you
haven't created those?

Anyway, compiling the alsa drivers from the kernel works fine so I bet
you'll succeed this time. Good luck.

----------------------------------------------------------------------
 Mark Knecht - 04-04-2004 22:12 CEST 
----------------------------------------------------------------------
Unfortunately it's still failing...

What do you mean by "my sound devices aren't available. Maybe I haven't
created them." What sound devices? Normally this is all done by Gentoo
during emerge and I don't have to do anything else by hand, but maybe
that's my problem under 2.6? (This could be a Gentoo'ish issue and not an
Alsa issue for all I know.)

----------------------------------------------------------------------
 frhart - 04-04-2004 22:27 CEST 
----------------------------------------------------------------------
The MAKEDEV.snd is used to create the sound device files, such as /dev/dsp,
/dev/mixer, etc. Try running that script. It's in
/usr/src/linux-2.6.5/scripts/.

If this doesn't work I think it's beter to ask the list or search the
archives (http://www.mail-archive.com/alsa-user@lists.sourceforge.net/)
cause this has not much to do with the bug anymore.

You can mail me directly if you wish: hart@warp.homelinux.com

----------------------------------------------------------------------
 Mark Knecht - 04-04-2004 22:43 CEST 
----------------------------------------------------------------------
It still doesn't work. That script seem to (correctly as per its name)
create devices in /dev/snd, but it doesn't create devices in /dev/sound.

I'll look elsewhere (gentoo-user and alsa-user I guess) for a solution.
Thanks for your help.

----------------------------------------------------------------------
 tiwai - 04-13-2004 19:27 CEST 
----------------------------------------------------------------------
a new category was added.

the 4 times "codec timeout" should have been fixed now.
the other general timeout should be because of ACPI.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-01-04 04:41 frhart         New Bug                                      
04-01-04 04:41 frhart         Distribution              => Debian          
04-01-04 04:41 frhart         Kernel Version            => 2.6.4, 2.6.5-rc3
04-02-04 04:05 frhart         Bug Monitored: frhart                        
04-03-04 16:07 Mark Knecht    Bugnote Added: 0000737                       
04-03-04 18:02 Mark Knecht    Bugnote Added: 0000738                       
04-03-04 18:02 Mark Knecht    Bug Monitored: Mark Knecht                    
04-04-04 19:04 frhart         Bugnote Added: 0000741                       
04-04-04 19:54 Mark Knecht    Bugnote Added: 0000742                       
04-04-04 20:35 frhart         Bugnote Added: 0000743                       
04-04-04 21:00 Mark Knecht    Bugnote Added: 0000744                       
04-04-04 21:43 frhart         Bugnote Added: 0000746                       
04-04-04 22:12 Mark Knecht    Bugnote Added: 0000747                       
04-04-04 22:17 Mark Knecht    Bugnote Edited: 0000744                      
04-04-04 22:27 frhart         Bugnote Added: 0000748                       
04-04-04 22:43 Mark Knecht    Bugnote Added: 0000749                       
04-13-04 19:27 tiwai          Bugnote Added: 0000790                       
04-13-04 19:31 tiwai          duplicate_id             0 => 202            
04-13-04 19:31 tiwai          Assigned To               => tiwai           
04-13-04 19:31 tiwai          Resolution               open => duplicate   
04-13-04 19:31 tiwai          Status                   new => resolved     
07-16-04 14:39 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
