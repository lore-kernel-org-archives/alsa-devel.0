From: noreply@alsa-project.org
Subject: [ALSA - driver 0000202]: atiixp works under 2.4.25, fails under 2.6.5
Date: Fri, 16 Jul 2004 13:03:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110355.4516A2600A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8FC79255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:03:55 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000202
======================================================================
Reported By:                Mark Knecht
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     202
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-12-2004 18:02 CEST
Last Modified:              07-16-2004 13:03 CEST
======================================================================
Summary:                    atiixp works under 2.4.25, fails under 2.6.5
Description: 
I've been messign with this problem off and on for a couple of weeks now.
Probably time to report it.

Under 2.4.25 Alsa starts up and works fine. There are a few messages in
dmesg: (similar to another Alsa bug)

devfs_mk_dir(snd): using old entry in dir: dff6f700 ""
PCI: Guessed IRQ 10 for device 00:14.5
PCI: Sharing IRQ 10 with 00:14.6
PCI: Sharing IRQ 10 with 02:04.0
ALSA atiixp.c:453: atiixp: codec read timeout
ALSA atiixp.c:453: atiixp: codec read timeout
ALSA atiixp.c:453: atiixp: codec read timeout
ALSA atiixp.c:453: atiixp: codec read timeout
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
mark@flash mark $ 

Under 2.6.5 I get far more of these messages in dmesg. The driver appears
to load, but I get no sound:

mark@flash mark $ uname -a
Linux flash 2.6.5 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000003 Mon Apr 12 08:52:55 PDT 2004 i686 Mobile Intel(R)
Pentium(R) 4     CPU 3.06GHz GenuineIntel GNU/Linux
mark@flash mark $ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.4rc2 (Tue Mar 30
08:19:30 2004 UTC).
Compiled on Apr 12 2004 for kernel 2.6.5.
mark@flash mark $ 

Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
Adding 1004020k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout


<SNIP>

atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
atiixp: codec read timeout
AC'97 2 does not respond - RESET
atiixp: codec read timeout
atiixp: codec read timeout
AC'97 2 access is not valid [0xffffffff], removing mixer.
ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error -5
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1

I have tried this with 1.0.3, 1.0.4 and the Alsa driver that's included in
the development-sources kernel. Always the same under 2.6.5
======================================================================

----------------------------------------------------------------------
 Mark Knecht - 04-12-2004 18:03 CEST 
----------------------------------------------------------------------
Sorry - I should have included lsmod to show the driver is loaded:

flash root # lsmod
Module                  Size  Used by
fglrx                 199556  7 
snd_atiixp             15012  0 
snd_ac97_codec         60548  1 snd_atiixp
snd_seq_oss            32256  0 
snd_seq_midi_event      6272  1 snd_seq_oss
snd_seq                52368  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          6920  2 snd_seq_oss,snd_seq
snd_pcm_oss            49060  0 
snd_pcm                84900  2 snd_atiixp,snd_pcm_oss
snd_page_alloc          9092  2 snd_atiixp,snd_pcm
snd_timer              22148  2 snd_seq,snd_pcm
snd_mixer_oss          17920  1 snd_pcm_oss
snd                    47972  10
snd_atiixp,snd_ac97_codec,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
soundcore               7648  1 snd
flash root # 


and that alsamixer returns an error:

flash root # alsamixer

alsamixer: function snd_ctl_open failed for default: No such device
flash root # 


flash root # cat /proc/asound/cards 
--- no soundcards ---
flash root #

----------------------------------------------------------------------
 tiwai - 04-13-2004 19:14 CEST 
----------------------------------------------------------------------
most likely an ACPI problem.
try turn on/off ACPI support.

----------------------------------------------------------------------
 Mark Knecht - 04-14-2004 02:35 CEST 
----------------------------------------------------------------------
No luck so far. I tried editing the kernel line in grub.conf file two ways.
I added pci=noacpi & I also tried adding acpi=off. Neither changed all the
messages in dmesg.

Did I do what you wanted me to do? I'm not sure where to find instructions
on the proper way to turn ACPI on or OFF.

----------------------------------------------------------------------
 tiwai - 04-14-2004 15:13 CEST 
----------------------------------------------------------------------
hmm, the fact that 2.4.x kernel works implies that it's not in
the ALSA side.  you'd better to ask this on lkml, especially
ACPI developers.

----------------------------------------------------------------------
 Mark Knecht - 04-14-2004 18:10 CEST 
----------------------------------------------------------------------
I'm not going anywhere near the kernel developers. I'm not a developer. I
don't program. I wouldn't know what to ask, and most likely I wouldn't
know what to do even if they told me. Much better that you do it, or I'll
push it up through the Gentoo folks. I'm helpless. 

Why do we think this is an ACPI problem?

Can you explain why the driver is loaded but I have no sound cards? I
don't understand that at all. If I have no sound cards then the driver
shouldn't load, correct?

Thanks.

----------------------------------------------------------------------
 tiwai - 04-14-2004 18:22 CEST 
----------------------------------------------------------------------
2.6 kernel keeps the pci modules even if they fail to load.
it's for PCI hotplug.

ACPI is suspicious because it handles the PCI routing and certain
initialization.  it's just from my experiences.  this is one of
the most different parts (from the lowlevel driver perspective)
between different kernel versions.

the bug report should be done by the hardware owner in such a case.
otherwise it would be quite hard to debug for developers.

----------------------------------------------------------------------
 Mark Knecht - 04-14-2004 18:38 CEST 
----------------------------------------------------------------------
OK, I can see why the module would still be there then.

Still, I wouldn't know what to report or how to report it. I cannot join
lkml and watch this like a developer. I don't have the time or bandwidth.


Do they have some official bug reporting system like this one? I'd be
happy to file something there, but I'm not going to join a high volume
mailing list.

Thanks

edited on: 04-14-04 18:38

----------------------------------------------------------------------
 ryan - 04-14-2004 23:39 CEST 
----------------------------------------------------------------------
I get this same exact problem, here is some additional info though:

Kernel 2.4.26rc1 Alsa-1.0.3: works(skippy sound, only one app can use
sound at a time)
Kernel 2.4.26rc1 Alsa-1.0.4: Doesnt work(same errors that i get with
2.6.5(which are the same errors as mark gets))
Kernel 2.6.5 Alsa-1.0.3: Doesnt compile(will note at the bottom)
Kernel 2.6.5 Alsa-1.0.4: Same problem as Mark has.

Now i had kernel 2.6.something with alsa-1.0.3 working at one point by
ndiswrapper wouldnt function.... im sorry but i dont have any details
except that it did in fact work(if it would -really- help that much i can
try and make it work again to get more info). 


---[Build error when building alsa-driver 1.0.3 on kernel 2.6.5]---
root@HPimp alsa-driver-1.0.3 # make
make -C /lib/modules/2.6.5/build SUBDIRS=/usr/src/alsa-driver-1.0.3/kbuild
modules
make[1]: Entering directory `/usr/src/linux-2.6.5'
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  /usr/src/alsa-driver-1.0.3/kbuild/../acore/memalloc.o
/usr/src/alsa-driver-1.0.3/acore/memalloc.c: In function
`snd_pci_hack_alloc_consistent':
/usr/src/alsa-driver-1.0.3/acore/memalloc.c:109: error: structure has no
member named `consistent_dma_mask'
/usr/src/alsa-driver-1.0.3/acore/memalloc.c:117: error: structure has no
member named `consistent_dma_mask'
/usr/src/alsa-driver-1.0.3/acore/memalloc.c:122: error: structure has no
member named `consistent_dma_mask'
make[3]: *** [/usr/src/alsa-driver-1.0.3/kbuild/../acore/memalloc.o] Error
1
make[2]: *** [/usr/src/alsa-driver-1.0.3/kbuild/../acore] Error 2
make[1]: *** [/usr/src/alsa-driver-1.0.3/kbuild] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.5'
make: *** [compile] Error 2
----------------------------------------------------

let me also add this: This is a laptop that only supports ACPI, im using
ACPI, and cpufreq. 

one more thing thats interesting: when i try and load the alsadrivers and
the ac97 codec fails (such as with kernel 2.6.5 alsa 1.0.4) my wireless
lan drops and i have to unload + reload ndiswrapper, and eth0 drops as
well.

edited on: 04-14-04 23:39

----------------------------------------------------------------------
 Mark Knecht - 04-15-2004 04:41 CEST 
----------------------------------------------------------------------
Ryan,
   Hi. Thanks for posting here. What laptop model are you using? Not sure
I said, but mine is a Compaq Presario R3070.

   I also looked in BIOS for ways to try disabling ACPI but there are no
relavant BIOS options on my machine so nothing I could do there. 

   Interestign about your wireless stuff. I haven't tried wireless on mine
so no way for me to verify similar issues.

Thanks,
Mark

----------------------------------------------------------------------
 ryan - 04-15-2004 05:06 CEST 
----------------------------------------------------------------------
My laptop is the HP zv5030us

Ok i just compiled 2.6.5bk2 --WITH-- ACPI

same result as usual

then i appended 'pci=noacpi' to my kernel before booting, now works the
same way as in 2.4.26rc1. as in it works but only one audio stream at a
time. so if im listening to music and i get an instant message i dont hear
the little gaim 'ding' until i stop playing music. to my suprise
pci=noacpi doesnt actually disable acpi, i can still use speedstep, check
my battery, see the tempature etc.

so now i guess how do i get the mixer working proper?

----------------------------------------------------------------------
 ryan - 04-15-2004 05:12 CEST 
----------------------------------------------------------------------
mmmm one more update here: my dmesg

PCI: IRQ 5 for device 0000:00:14.5 doesn't match PIRQ mask - try
pci=usepirqmask
ALSA sound/pci/atiixp.c:455: atiixp: codec read timeout
ALSA sound/pci/atiixp.c:455: atiixp: codec read timeout
ALSA sound/pci/atiixp.c:455: atiixp: codec read timeout
ALSA sound/pci/atiixp.c:455: atiixp: codec read timeout

and what device is 00:14.5? suprise(or not)! its the soundcard 
00:14.5 Multimedia audio controller: ATI Technologies Inc SoundMAX
Integrated Digital Audio
        Subsystem: Hewlett-Packard Company: Unknown device 006b
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 5
        Memory at d0003000 (32-bit, non-prefetchable) [size=256]

im going to try appending pci=usepirqmask and see what happens, but i
think that the problem involving only being able to hear one thing at a
time is config related. here is my lsmod in case it helps any

Module                  Size  Used by
ndiswrapper            67072  0
snd_pcm_oss            53540  0
snd_mixer_oss          20480  2 snd_pcm_oss
snd_atiixp             18340  5
snd_ac97_codec         63876  1 snd_atiixp
snd_pcm                96036  3 snd_pcm_oss,snd_atiixp
snd_timer              25732  1 snd_pcm
snd                    55908  13
snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer
soundcore              10464  2 snd
snd_page_alloc         11652  2 snd_atiixp,snd_pcm

----------------------------------------------------------------------
 ryan - 04-15-2004 05:38 CEST 
----------------------------------------------------------------------
ok appending pci=noacpi,usepirqmask doesnt work. same result as just using
acpi. 

any ideas on why only one prog at a time can use sound?

----------------------------------------------------------------------
 Mark Knecht - 04-15-2004 16:34 CEST 
----------------------------------------------------------------------
For me, using Gentoo's current 2.6.5, booting with acpi=off doesn't work
for me., nor does booting with pci=noacpi. In both cases I get a timeout
on the codec and alsamixer doesn't see any sound card.

I'll try backing up to 2.6.3, but I may lose DMA on my hard drive doing
that, so that's not a good solution for me. However, if it helps convince
Takashi to help us then I'm happy to try it.

Don't know why you should get only a single app using sound unless the
first app you use is blocking. Maybe use lsof and see what's using sound
or snd resources. That's helped me before.

----------------------------------------------------------------------
 pzad - 04-15-2004 16:47 CEST 
----------------------------------------------------------------------
To ryan:

Your hardware doesn't support hardware mixing - use dmix plugin.

----------------------------------------------------------------------
 ryan - 04-15-2004 18:04 CEST 
----------------------------------------------------------------------
i just uploaded a copy of my kernel config for 2.6.5-bk2

this works nicely on my laptop ... minus the mixer thing... ill give that
dmix a shot. thanks pzad

----------------------------------------------------------------------
 Mark Knecht - 04-15-2004 18:34 CEST 
----------------------------------------------------------------------
Ryan,
   Thanks for the kernel config. I'll check it out. I cannot find a Gentoo
version of 2.6.5-bk2. but they have a new 2.6.6_rc1 out today so I'll give
that a quick shot and see what happens.

Cheers,
Mark

----------------------------------------------------------------------
 ryan - 04-15-2004 19:21 CEST 
----------------------------------------------------------------------
you wont find the gentoo version of that kernel. just goto kernel.org
download the vanilla kernel 2.6.5, download patch 2.6.5-bk2 then extract +
patch the kernel

copy my .config into the kernel source dir and build it. you dont need a
'gentoo' kernel really. i rarely use gentoos patched kernels.

----------------------------------------------------------------------
 Mark Knecht - 04-16-2004 00:30 CEST 
----------------------------------------------------------------------
Good news! I tried a new 2.6.6 kernel out today and at least for me it
appears to be fixed under Gentoo.

I'll leave it to Takashi to close this bug if he feels that's
appropriate.

Thanks,
Mark

----------------------------------------------------------------------
 ryan - 04-16-2004 01:50 CEST 
----------------------------------------------------------------------
2.6.6rc1 -- thatd be the kernel thats the latest snapshot, are you saying
you run that but dont need to append pci=noacpi to the kernel when
booting?

----------------------------------------------------------------------
 Mark Knecht - 04-16-2004 03:16 CEST 
----------------------------------------------------------------------
Right. I just run 2.6.6 with no configuration options at all and it seems
to work fine. I'm getting good DMA rates on my hard drive. I'm actually
playing 'As Good As It Gets' full screen using xine as I write this. Video
is not jerky at all. Sound is fine for a laptop. 

I have ACPI built into the kernel using the default settings that came
with the kernel. I have not disabled APCI or anything else at the command
line.

BTW - I do still get a few codec timeout messages in dmesg. More like
2.4.25 was, but a few more. Maybe 7 or 8.

edited on: 04-16-04 03:16

----------------------------------------------------------------------
 tiwai - 04-16-2004 10:29 CEST 
----------------------------------------------------------------------
good to hear that your machine finally working!

i've already fixed (first a few) codec timeout messages in ALSA cvs.
please give a try.

also, feel free to close this bug by yourself :)

----------------------------------------------------------------------
 Mark Knecht - 04-16-2004 23:45 CEST 
----------------------------------------------------------------------
I'd be happy to try CVS out, but I don't know how to it on Gentoo. 2.6
kernels are difficult anyway. Assume I download CVS for alsa-driver. (Is
it only alsa-driver that you're asking me to test?) Is there a document
that tells me where to move everything in the kernel tree? If so I'll give
it a try.

Also, I'm looking on this page but I'm not finding a button to use to
close this bug report. Maybe you should just do it, or leave it open for a
few days with instructions on doing the CVS thing under Gentoo.

Thanks!

----------------------------------------------------------------------
 ryan - 04-17-2004 04:25 CEST 
----------------------------------------------------------------------
Leave it open for now, i plan to give the driver in CVS a shot this
weekend. (hint: you cannot use emerge to grab cvs alsa ;) )

----------------------------------------------------------------------
 ryan - 04-23-2004 02:51 CEST 
----------------------------------------------------------------------
ok i tried the cvs.... it seems broken right now:

  CC [M]  /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_pcm.o
copying file
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/kbuild/../pci/ac97/ac97_proc.c
`/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/kbuild/../pci/ac97/ac97_proc.c'
-> `/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.c'
patching file
/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.c
  CC [M]  /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.s
as   -o /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.o
/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.s
  CC [M]  /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_patch.o
In file included from
/home/ryan/alsa-cvs/alsa-driver/pci/ac97/ac97_patch.c:2:
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c: In
function `patch_sigmatel_stac9758':
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:475:
error: dereferencing pointer to incomplete type
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:476:
error: dereferencing pointer to incomplete type
make[4]: ***
[/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_patch.o] Error 1
rm /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.c
make[3]: *** [/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97] Error 2
make[2]: *** [/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci] Error 2
make[1]: *** [/home/ryan/alsa-cvs/alsa-driver/kbuild] Error 2
make[1]: Leaving directory `/usr/src/2.6.6rc2/linux-2.6.5'
make: *** [compile] Error 2
---
i presume this means CVS is broke, but let me know if im just messing up
somehow. 

i retrieved the build around 6:30pm apr 22

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:09 CEST 
----------------------------------------------------------------------
fixed on CVS.

i also updated the atiixp driver.  this update might fix the problem
of codec probing.

----------------------------------------------------------------------
 ryan - 04-23-2004 17:20 CEST 
----------------------------------------------------------------------
still errors out for me :

  CC [M]  /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_patch.o
In file included from
/home/ryan/alsa-cvs/alsa-driver/pci/ac97/ac97_patch.c:2:
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c: In
function `patch_sigmatel_stac9758':
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:475:
error: dereferencing pointer to incomplete type
/home/ryan/alsa-cvs/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:476:
error: dereferencing pointer to incomplete type
make[4]: ***
[/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_patch.o] Error 1
rm /home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97/ac97_proc.c
make[3]: *** [/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci/ac97] Error 2
make[2]: *** [/home/ryan/alsa-cvs/alsa-driver/kbuild/../pci] Error 2
make[1]: *** [/home/ryan/alsa-cvs/alsa-driver/kbuild] Error 2
make[1]: Leaving directory `/usr/src/2.6.6rc2/linux-2.6.5'
make: *** [compile] Error 2

i grabbed this from cvs fri apr 23 around 11:10 am EST

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:25 CEST 
----------------------------------------------------------------------
it takes time (at most 24 hours) that anonymous CVS tree on SF is
sync'ed with the developer's CVS tree.  will be fine on tomorrow.

----------------------------------------------------------------------
 ryan - 04-24-2004 21:10 CEST 
----------------------------------------------------------------------
Just as a confirmation: the driver in CVS (apr 24 3:00 pm EST) works fine
(no codec timeouts in dmesg.

just for the record: uname -a 
Linux HPimp 2.6.6-rc2 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 Tue Apr 20 22:57:25 EDT 2004 i686 Intel(R)
Pentium(R) 4 CPU 2.66GHz GenuineIntel GNU/Linux

Thanks for the help everyone! (also dmix is a pain :-/)

----------------------------------------------------------------------
 Mark Knecht - 04-24-2004 21:37 CEST 
----------------------------------------------------------------------
Yes, thanks Takashi! We appreciate your help very much.

----------------------------------------------------------------------
 tiwai - 04-24-2004 21:41 CEST 
----------------------------------------------------------------------
thanks for confirmation!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-12-04 18:02 Mark Knecht    New Bug                                      
04-12-04 18:02 Mark Knecht    Distribution              => Gentoo          
04-12-04 18:02 Mark Knecht    Kernel Version            => 2.6.5           
04-12-04 18:03 Mark Knecht    Bugnote Added: 0000784                       
04-13-04 19:14 tiwai          Bugnote Added: 0000788                       
04-13-04 19:14 tiwai          Assigned To               => tiwai           
04-13-04 19:14 tiwai          Status                   new => assigned     
04-14-04 02:35 Mark Knecht    Bugnote Added: 0000802                       
04-14-04 15:13 tiwai          Bugnote Added: 0000804                       
04-14-04 18:10 Mark Knecht    Bugnote Added: 0000806                       
04-14-04 18:22 tiwai          Bugnote Added: 0000807                       
04-14-04 18:38 Mark Knecht    Bugnote Added: 0000808                       
04-14-04 18:38 Mark Knecht    Bugnote Edited: 0000808                      
04-14-04 23:36 ryan           Bugnote Added: 0000810                       
04-14-04 23:39 ryan           Bugnote Edited: 0000810                      
04-15-04 04:41 Mark Knecht    Bugnote Added: 0000812                       
04-15-04 05:06 ryan           Bugnote Added: 0000813                       
04-15-04 05:12 ryan           Bugnote Added: 0000814                       
04-15-04 05:38 ryan           Bugnote Added: 0000815                       
04-15-04 16:34 Mark Knecht    Bugnote Added: 0000816                       
04-15-04 16:47 pzad           Bugnote Added: 0000817                       
04-15-04 18:02 ryan           File Added: .config                          
04-15-04 18:04 ryan           Bugnote Added: 0000818                       
04-15-04 18:34 Mark Knecht    Bugnote Added: 0000819                       
04-15-04 19:21 ryan           Bugnote Added: 0000820                       
04-16-04 00:30 Mark Knecht    Bugnote Added: 0000823                       
04-16-04 01:50 ryan           Bugnote Added: 0000824                       
04-16-04 03:15 Mark Knecht    Bugnote Added: 0000825                       
04-16-04 03:16 Mark Knecht    Bugnote Edited: 0000825                      
04-16-04 10:29 tiwai          Bugnote Added: 0000827                       
04-16-04 23:45 Mark Knecht    Bugnote Added: 0000846                       
04-17-04 04:25 ryan           Bugnote Added: 0000847                       
04-23-04 02:51 ryan           Bugnote Added: 0000897                       
04-23-04 17:09 tiwai          Bugnote Added: 0000898                       
04-23-04 17:20 ryan           Bugnote Added: 0000902                       
04-23-04 17:25 tiwai          Bugnote Added: 0000905                       
04-24-04 21:10 ryan           Bugnote Added: 0000926                       
04-24-04 21:37 Mark Knecht    Bugnote Added: 0000927                       
04-24-04 21:41 tiwai          Bugnote Added: 0000928                       
04-24-04 21:41 tiwai          Resolution               open => fixed       
04-24-04 21:41 tiwai          Status                   assigned => resolved
07-16-04 13:03 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
