From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Sun, 25 Sep 2005 01:03:10 +0200
Message-ID: <717850f638f8d29fe97e5d61292c5279@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DC67169
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2005 01:03:10 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001441.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              09-25-2005 01:03 CEST
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001441 snd-powermac: Burgundy: controls for he...
======================================================================

----------------------------------------------------------------------
 tiwai - 05-28-04 21:18 
----------------------------------------------------------------------
to be sure: the mixer value cannot be changed via amixer program?

----------------------------------------------------------------------
 Quietti - 05-28-04 21:37 
----------------------------------------------------------------------
Yes, that fails too.  For example:

root@omena:/home/q-funk# amixer set CD 80%
Simple mixer control 'CD',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 80 [80%]
  Front Right: Playback 80 [80%]
root@omena:/home/q-funk# amixer get CD
Simple mixer control 'CD',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 100
  Front Left: Playback 0 [0%]
  Front Right: Playback 0 [0%]
root@omena:/home/q-funk#

That has always failed on this hardware using ALSA.  

However, the old OSS driver dmasound_pmac produces sounds, so I know that
the hardware is not at fault. Then again, since OSS is being deprecated, I
cannot afford to continue using it for too long.

----------------------------------------------------------------------
 Quietti - 07-25-04 20:16 
----------------------------------------------------------------------
I would just like to point out that this is still broken in kernel 2.6.7.

----------------------------------------------------------------------
 Quietti - 09-08-04 06:32 
----------------------------------------------------------------------
Still broken in kernel 2.6.8.1 also.

----------------------------------------------------------------------
 Quietti - 10-20-04 00:38 
----------------------------------------------------------------------
Still broken in kernel 2.6.9 as well.

----------------------------------------------------------------------
 Quietti - 01-06-05 18:14 
----------------------------------------------------------------------
Still broken in kernel 2.6.10 as well.

----------------------------------------------------------------------
 rlrevell - 01-06-05 18:27 
----------------------------------------------------------------------
Just to be sure, is it still broken with ALSA CVS?

----------------------------------------------------------------------
 Quietti - 01-06-05 19:43 
----------------------------------------------------------------------
I never try CVS, so I cannot say.  I only test stable Linux 2.6 release
kernels.

----------------------------------------------------------------------
 Quietti - 01-07-05 00:00 
----------------------------------------------------------------------
The content of CVS and kernel 2.6.10 completely match for the PPC drivers
(CVS cruft shows up as the only difference):

diff -ruN linux-2.6.10/sound/ppc/CVS/Entries alsa-kernel/ppc/CVS/Entries
--- linux-2.6.10/sound/ppc/CVS/Entries  1970-01-01 02:00:00.000000000
+0200
+++ alsa-kernel/ppc/CVS/Entries 2005-01-06 21:10:26.000000000 +0200
@@ -0,0 +1,15 @@
+/Kconfig/1.5/Mon Sep 13 07:14:59 2004//
+/Makefile/1.6/Mon Aug  2 10:06:38 2004//
+/awacs.c/1.26/Wed Aug 18 09:50:49 2004//
+/awacs.h/1.3/Wed May 15 16:31:40 2002//
+/beep.c/1.1/Mon Aug  2 10:06:38 2004/-ko/
+/burgundy.c/1.13/Tue Jul 20 15:54:28 2004//
+/burgundy.h/1.2/Sun Dec 30 09:26:48 2001//
+/daca.c/1.14/Tue Nov 30 14:44:30 2004//
+/keywest.c/1.17/Fri Apr 23 14:18:25 2004//
+/pmac.c/1.43/Tue Dec 21 10:52:47 2004//
+/pmac.h/1.18/Tue Nov 30 14:44:30 2004//
+/powermac.c/1.20/Mon Aug  2 10:06:38 2004//
+/tumbler.c/1.35/Tue Nov 30 14:44:30 2004//
+/tumbler_volume.h/1.2/Tue Aug 27 13:46:15 2002/-ko/
+D
diff -ruN linux-2.6.10/sound/ppc/CVS/Repository
alsa-kernel/ppc/CVS/Repository
--- linux-2.6.10/sound/ppc/CVS/Repository       1970-01-01
02:00:00.000000000 +0200
+++ alsa-kernel/ppc/CVS/Repository      2005-01-06 21:10:26.000000000
+0200
@@ -0,0 +1 @@
+alsa-kernel/ppc
diff -ruN linux-2.6.10/sound/ppc/CVS/Root alsa-kernel/ppc/CVS/Root
--- linux-2.6.10/sound/ppc/CVS/Root     1970-01-01 02:00:00.000000000
+0200
+++ alsa-kernel/ppc/CVS/Root    2005-01-06 21:10:26.000000000 +0200
@@ -0,0 +1 @@
+:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa


...therefore, yes, even what's in CVS is broken.

----------------------------------------------------------------------
 Quietti - 01-07-05 00:19 
----------------------------------------------------------------------
You asked me a while ago to confirm whether certain tests worked. I pasted
them and got no response. Since you are still assigned to this issue, I
would like to know what is your situation. Thanks.

----------------------------------------------------------------------
 Quietti - 01-07-05 00:30 
----------------------------------------------------------------------
'hwinfo' mentions the following about the sound hardware of this vintage
iMac:

11: None 00.0: 0401 Multimedia audio controller
  [Created at prom.409]
  Unique ID: AT0p.4TqZ9X2iLH0
  Parent ID: LxCh.xWNNVcdS2SF
  Hardware Class: sound
  Model: "Apple Integrated Sound (burgundy)"
  Vendor: int 0x0401 "Apple"
  Device: int 0x0012 "Integrated Sound (burgundy)"
  PROM id: pci@80000000/mac-io@10/davbus@14000/sound
  IRQ: 17 (1 event)
  Driver Info #0:
    Driver Status: dmasound is not active
    Driver Activation Cmd: "modprobe dmasound"
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #7 (Unclassified device)

07: PCI 10.0: ff00 Unclassified device
  [Created at pci.244]
  Unique ID: LxCh.xWNNVcdS2SF
  SysFS ID: /devices/pci0000:00/0000:00:10.0
  SysFS BusID: 0000:00:10.0
  Hardware Class: unknown
  Model: "Apple Paddington Mac I/O"
  Vendor: pci 0x106b "Apple Computer Inc."
  Device: pci 0x0017 "Paddington Mac I/O"
  Driver: "macio"
  PROM id: pci@80000000/mac-io@10
  Memory Range: 0x80800000-0x8087ffff (rw,non-prefetchable)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

----------------------------------------------------------------------
 Quietti - 01-14-05 00:53 
----------------------------------------------------------------------
These CVS repositorie appear to contain Apple's own open source drivers:

http://cvs.opendarwin.org/index.cgi/src/AppleOnboardAudio/
http://cvs.opendarwin.org/index.cgi/src/IOAudioFamily/

Note that some files must be unhidden from the Attic to appear visible.

Comparing those to what you have should at least allow you to see what
might be wrong in the current ALSA code.

----------------------------------------------------------------------
 Quietti - 02-04-05 09:22 
----------------------------------------------------------------------
ALSA 1.0.8 (as found in kernel 2.6.11-rc3) is also broken).

----------------------------------------------------------------------
 tiwai - 02-04-05 13:04 
----------------------------------------------------------------------
Well sorry, I can't work on this driver.  I have no ppc hardware at all and
don't want to read through the whole darwin codes.

----------------------------------------------------------------------
 Quietti - 04-02-05 13:33 
----------------------------------------------------------------------
Mark Shuttleworth has placed a 500 USD bounty towards fixing all remaining
ALSA issues for PowerMac hardware. Contact Ubuntu's Matt Zimmerman for
details.

----------------------------------------------------------------------
 Quietti - 08-06-05 20:24 
----------------------------------------------------------------------
Just a reminder that the Open Darwin source is still available as a
reference for anyone willing to fix ALSA for all PowerMac variants and to
pocket the Ubuntu bounty for fixing it:

http://darwinsource.opendarwin.org/10.4.2/AppleOnboardAudio-250.2.17/

----------------------------------------------------------------------
 rlrevell - 08-06-05 20:53 
----------------------------------------------------------------------
Please specify exactly what is meant by "fix all remaining ALSA issues for
PowerMac hardware" by providing a list of ALSA bug IDs.

If you supply this info AND someone provides any necessary hardware to fix
the problem(s) then I can take on this bounty.

----------------------------------------------------------------------
 rlrevell - 08-06-05 21:17 
----------------------------------------------------------------------
Hmm, if the open source OSS driver works on the exact same machine, I might
be able to fix this with SSH access.  Please send me a private message if
this is possible.

----------------------------------------------------------------------
 rlrevell - 08-06-05 23:54 
----------------------------------------------------------------------
So, just to clarify, it seems that "snapper", "tumbler" etc are OK but
"burgundy" does not work for anyone?

----------------------------------------------------------------------
 pochini - 08-07-05 10:03 
----------------------------------------------------------------------
card 2: Snapper [PowerMac Snapper], device 0: PMac Snapper [PowerMac
Snapper]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Works fine here (dual G4 MDD). Did you remember to turn the "Master
Playback Switch" on ?
The Burgundy chip worked fine with OSS, but I don't remember if it worked
with ALSA. I don't have the b/w G3 anymore.

----------------------------------------------------------------------
 Quietti - 08-07-05 10:31 
----------------------------------------------------------------------
pochini:  I tried every slider in amixer; they all refuse to move.

rlrevell:  Absolutely every PowerMac chipset's ALSA support is broken in
one way or another; it's *not* just Burgundy. Some chipsets have
everything except the console bell working, others everything except sound
input, others have the separate volume for the built-in speakers (as
opposed to master volume) broken, etc. Someone had started sending info
about what works and what doesn't to the Debian PPC mailing list (see
http://lists.debian.org/debian-powerpc/ for the archive). Look for a
thread whose Subject was "list of PowerMac sound hardware TO-DO (help
welcome)" starting around 2005-03-22.

NOTE: I'm affraid that very few people will bother filing bug reports to
the ALSA BTS for as long as this first requires creating a user account!

----------------------------------------------------------------------
 rlrevell - 08-07-05 10:46 
----------------------------------------------------------------------
Every bug tracker in existence requires creating a user account first. 
It's just part of open source development these days, the volume is too
high to depend on mailing lists.  You should consider being able to report
bugs a privilege, try it with any other OS and see how far you get.

Anyway I'm not surprised that several of the drivers are broken.  I
believe tiwai wrote these based on the OSS driver without access to the
hardware.

----------------------------------------------------------------------
 Quietti - 08-07-05 11:36 
----------------------------------------------------------------------
Debian's BTS, for instance, works quite well without the hindrance of a
user account creation.

Anyhow, that's a moot point for me, since I have accounts pretty much
everywhere. 

This being said, I know for fact that most end-users won't bother with
creating an account  on someone's Bugzilla, for every damn piece of OSS
they use; they will switch OS instead. The proof of the pudding exists for
this ALSA PowerMac bug as well: several people immediately posted the
details of their ALSA problems to the debian-powerpc list, as soon as the
possibility was offered to them. Good luck finding anyone among them who
would have done the same, if it first required them to create an account
on some BTS.

Perhaps adopting the path of lowest resistance that Debian uses (including
bug reporting tools that mail the report and won't require the creation of
an account on every project's BTS) would make it easier for users to
report bugs, which would then result in immediate product quality
improvements. Think about that.

----------------------------------------------------------------------
 Quietti - 08-07-05 11:44 
----------------------------------------------------------------------
As for Tiwai's blindfold-coding based on an already broken OSS driver:
using the Open Darwin source code as a reference would definitely lead to
more solid results, since the starting point is the opensourced version of
Apple's own drivers.

----------------------------------------------------------------------
 rlrevell - 08-07-05 20:27 
----------------------------------------------------------------------
But you said the OSS driver worked.

----------------------------------------------------------------------
 Quietti - 08-08-05 14:53 
----------------------------------------------------------------------
Your comment about OSS is off-topic.

----------------------------------------------------------------------
 rlrevell - 08-08-05 19:42 
----------------------------------------------------------------------
Off topic?  WTF are you talking about?

If we can establish that the another open source driver for the same OS
works (the OSS driver) then we can look at that to fix the ALSA driver,
instead of having to wade through thousands of lines of a C++ driver
written for another OS in a bizarre and unfamiliar coding style.

You don't know much about writing driverrs, do you?

----------------------------------------------------------------------
 Johannes Berg - 08-11-05 13:09 
----------------------------------------------------------------------
Power management on the driver is also broken (well, doesn't exist at all)
and after hibernation the module has to be reloaded to get sound at all.

Note that this is with a chipset where I actually *do* get sound (the one
in a PowerBook5,6), not a chipset where sound doesn't work at all.

----------------------------------------------------------------------
 Quietti - 08-31-05 11:44 
----------------------------------------------------------------------
Kernel 2.6.13 shows some major improvements: 
Almost everything ALSA works on Burgundy as it should! :-) 
Whoever worked on this since 2.6.11 deserves a big hug!

master volume:    works as expected.
headphone volume: seems to control the internal stereo speakers instead.
Oops!
headphone detect: (what is this supposed to do?)
analog CD volume: works as expected.
line input:       (no analog signal to feed the input jack and test it)
microphone input: (feedbacks if I rise it high enough, so I'd assume it
works)
mono PC speaker:  seems to control the stereo headphones instead. Oops!
auto-mute:        (what is this supposed to do?)
console beep:     works as expected.

On a general note, I cannot seem to completely silence the internal stereo
speakers or the headphones, other than by muting the master volume.

Still, this is already a *major* improvement over previous ALSA releases:
I finally get some sound on this iMac CRT's Burgundy chip! Many thanks!
:-)

----------------------------------------------------------------------
 Quietti - 09-17-05 20:13 
----------------------------------------------------------------------
The Debian PPC community is compiling a list of current ALSA status for
each PowerMac chipset at http://wiki.debian.net/?PowerpcSoundcards

----------------------------------------------------------------------
 rlrevell - 09-17-05 20:21 
----------------------------------------------------------------------
OK keep in mind the version of ALSA in the kernel is not the current ALSA
version.  It lags by a month or two.  So make sure to test against the
latest ALSA development release or (better) ALSA CVS.

----------------------------------------------------------------------
 Quietti - 09-20-05 12:23 
----------------------------------------------------------------------
That lag is something the ALSA team will have to live with. 

Most people are not likely to even try grafting the current ALSA release
onto an existing kernel tree, let alone fetching from the CVS tree.
Pointless to think that end-users would do either one, when they don't
even build their own kernels. As much as this would speed development up
in a positive way, one simply cannot turn end-users into developers.

----------------------------------------------------------------------
 rlrevell - 09-21-05 03:59 
----------------------------------------------------------------------
My point was that it's a waste of time reporting bugs in the kernel ALSA
version that have already been fixed for a month in ALSA CVS, unless you
plan to push the fix into the -stable kernel.  Have fun with that... ;-)

----------------------------------------------------------------------
 rlrevell - 09-21-05 04:00 
----------------------------------------------------------------------
Is it OK to close this?

----------------------------------------------------------------------
 Quietti - 09-21-05 10:52 
----------------------------------------------------------------------
No, it's not OK.

See the table on the Debian wiki, at the URL I published a couple of days
ago. snd-powermac is far from being fixed for everyone.

----------------------------------------------------------------------
 Quietti - 09-21-05 13:02 
----------------------------------------------------------------------
rlrevell, this is the second time you suggest checking out CVS and, on both
occasions, there was no change in the PPC directory that concern any of
the defective drivers. The first time had no single change in the
directory at all, while this time only has the addition of the toonie
driver for the Mac Mini and even that is old news.

----------------------------------------------------------------------
 rlrevell - 09-21-05 19:34 
----------------------------------------------------------------------
You need to open separate bug reports for those issues.

Bug #306 is "no sound" which you reported on 8-31 was fixed in 2.6.13.

----------------------------------------------------------------------
 Quietti - 09-22-05 10:23 
----------------------------------------------------------------------
While I *do* get some sound out, the Burgundy driver still has broken
support for some of the chipset's features.

As for other chipsets within the snd-powermac realm, indeed, others can
file their own separate bug reports.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Issue                                    
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6
vanilla.
05-25-04 20:38 Quietti        Issue Monitored: Quietti                     
05-28-04 21:18 tiwai          Note Added: 0001274                          
05-28-04 21:37 Quietti        Note Added: 0001275                          
07-25-04 20:16 Quietti        Note Added: 0001473                          
09-08-04 06:32 Quietti        Note Added: 0001726                          
10-20-04 00:38 Quietti        Note Added: 0002209                          
01-06-05 18:14 Quietti        Note Added: 0003093                          
01-06-05 18:27 rlrevell       Note Added: 0003094                          
01-06-05 19:43 Quietti        Note Added: 0003095                          
01-07-05 00:00 Quietti        Note Added: 0003096                          
01-07-05 00:19 Quietti        Note Added: 0003097                          
01-07-05 00:30 Quietti        Note Added: 0003098                          
01-14-05 00:53 Quietti        Note Added: 0003206                          
02-04-05 09:22 Quietti        Note Added: 0003496                          
02-04-05 13:04 tiwai          Note Added: 0003499                          
04-02-05 13:33 Quietti        Note Added: 0004297                          
08-06-05 20:24 Quietti        Note Added: 0005682                          
08-06-05 20:31 rlrevell       Note Added: 0005683                          
08-06-05 20:32 rlrevell       Note Added: 0005684                          
08-06-05 20:53 rlrevell       Note Added: 0005685                          
08-06-05 21:17 rlrevell       Note Added: 0005686                          
08-06-05 23:54 rlrevell       Note Added: 0005687                          
08-06-05 23:55 rlrevell       Note Deleted: 0005683                        
08-06-05 23:55 rlrevell       Note Deleted: 0005684                        
08-07-05 10:03 pochini        Note Added: 0005689                          
08-07-05 10:31 Quietti        Note Added: 0005690                          
08-07-05 10:46 rlrevell       Note Added: 0005691                          
08-07-05 11:36 Quietti        Note Added: 0005692                          
08-07-05 11:44 Quietti        Note Added: 0005693                          
08-07-05 20:27 rlrevell       Note Added: 0005697                          
08-08-05 14:53 Quietti        Note Added: 0005708                          
08-08-05 19:42 rlrevell       Note Added: 0005711                          
08-11-05 13:09 Johannes Berg  Note Added: 0005755                          
08-11-05 13:09 Johannes Berg  Issue Monitored: Johannes Berg                    
08-31-05 11:44 Quietti        Note Added: 0005986                          
09-17-05 20:13 Quietti        Note Added: 0006259                          
09-17-05 20:21 rlrevell       Note Added: 0006260                          
09-20-05 12:23 Quietti        Note Added: 0006313                          
09-21-05 03:59 rlrevell       Note Added: 0006320                          
09-21-05 04:00 rlrevell       Note Added: 0006321                          
09-21-05 10:52 Quietti        Note Added: 0006322                          
09-21-05 13:02 Quietti        Note Added: 0006323                          
09-21-05 19:34 rlrevell       Note Added: 0006324                          
09-22-05 10:23 Quietti        Note Added: 0006335                          
09-25-05 01:03 rlrevell       Relationship added       related to 0001441  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
