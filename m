From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000370]: CMedia 8768 Support
Date: Sat, 16 Oct 2004 07:32:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041016053244.BCCC311030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2447726C
	for <alsa-devel@alsa-project.org>; Sat, 16 Oct 2004 07:32:45 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000370
======================================================================
Reported By:                drbobguy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     370
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-07-2004 04:59 CEST
Last Modified:              10-16-2004 07:32 CEST
======================================================================
Summary:                    CMedia 8768 Support
Description: 
I've recently built a new computer with an on-board CMedia 8768 chip.  This
chip is not listed as one of the supported CMedia chips (8738, etc.),
although I suspect that is because it is so new.  Just wanted to let you
guys know it apparently doesn't work with the standard cmipci driver (at
least I think I'm doing everthing correctly -- I have a decent amount of
Linux experience but I'm no guru).  Here is what I see though:

The card is recognized in /proc/asound as a CMedia 8738M6.  However, if I
use a mixer like amixer or gnome-alsamixer none of the mixer settings I
change will take effect (and I am running these as root).

Any advice or comments would be appreciated.  I'd be happy to help if you
think there is a possible fix.
======================================================================

----------------------------------------------------------------------
 drbobguy - 07-07-2004 05:03 CEST 
----------------------------------------------------------------------
By the way I'm on an AMD 64 machine if that makes a difference.

----------------------------------------------------------------------
 robg - 07-27-2004 05:26 CEST 
----------------------------------------------------------------------
Is there any progress on a driver for this chip?
It is used on the Soltek EQ3801 amd64 computer and a lot of people in
forums on other websites are interested in sound support.

I have the same problems as listed by drbobguy. I tested it under 64bit
kernel 2.6.7 I believe he did as well. I can setup a 32bit kernel and
retest if you fell its useful.

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:56 CEST 
----------------------------------------------------------------------
Any datasheet available?

I don't know of...

----------------------------------------------------------------------
 drbobguy - 07-31-2004 02:46 CEST 
----------------------------------------------------------------------
I found this file off the CMedia website (I've attached it here):

http://www.cmedia.com.tw/doc/CMI8768%20Datasheet%20Rev%200.9.pdf

----------------------------------------------------------------------
 robg - 07-31-2004 06:10 CEST 
----------------------------------------------------------------------
The file from cmedia website does not contain any info for programming the
chip unfortunately.  I have sent an email to cmedia requesting full
information.  Will advise when I get a response.

Since the chip gives an ID of CMI8738-MC6 it may be very close to the
existing driver.

In the interim, is there any more information we can provide from /proc
that is useful?

----------------------------------------------------------------------
 robg - 10-08-2004 05:17 CEST 
----------------------------------------------------------------------
Finally get some feedback from Cmedia.  Following is copy of email
exchanges. I will attach documentation also received.

---------------------------------------------------------------
Date: Thu, 07 Oct 2004 15:41:28 +0800
From: "Liang, Jason - ???" <jason.liang@cmedia.com.tw>
Subject: RE: [Fwd: technical information for 8768]
To: Rob Gordon <snip>
Cc: "Tien,  C.L. - ???" <cltien@cmedia.com.tw>,
 "Yao, Alan - ???" <alanyao@cmedia.com.tw>,
 "Chang, Kinkon - ???" <kinkon.chang@cmedia.com.tw>

Dear Rob,
 
I'm sorry I missed your previous mail. I enclosed 8768 datasheet, register
spec and programming guide to you. 8768 is basically modified from 8738
and hence the 8738 programming guide is applicable. Hope them helpful.
Shall you have any specific question or further need, you can tell us
then.
 
BTW, our Linux driver developer is Chen-Li Tien (in CC list) and he is
also working on this. You can have a talk if you would like.  
 
Regards,
Jason
-----Original Message-----
From: Rob Gordon [snip]
Sent: Thursday, October 07, 2004 10:00 AM
To: Liang, Jason 
Subject: [Fwd: technical information for 8768]


Dear Mr. Liang,

I am still looking for information on programming the 8768 soundchip.
Can you provide a contact so I can can pursue this information.

Thank you for your time,
Rob


-------- Original Message --------
Subject: technical information for 8768
Date: Fri, 03 Sep 2004 01:19:11 -0600
From: Rob Gordon <snip>
To: jason.liang@cmedia.com.tw

Dear Mr Liang,

I am working with the ALSA linux sound media team to implement a driver
for the new 8768 soundchip.  This is currently used in the Soltek EQ3801
computer and there is a lot of interest in the Linux community to obtain
a working driver.

Since the technical details and an open source driver were available for
the 8738, I was hoping that the same level of information would be
published for the 8768 as well.

I am willing to work on the driver development if sufficient technical
documentation is provided, assuming a driver has not been prepared
already.

I have tried contacting the support group at Cmedia
(support@cmedia.com.tw ) several times but have not received any reply.

Can you assist in obtaining the information required or provide the name
of a contact person who could help?

Thank-you for your time.

Regards,
Rob Gordon

----------------------------------------------------------------------
 tiwai - 10-08-2004 12:49 CEST 
----------------------------------------------------------------------
A good news!  It will help for debugging.  Thanks.

----------------------------------------------------------------------
 tiwai - 10-08-2004 15:26 CEST 
----------------------------------------------------------------------
According to the datasheet, CM8768 seems almost backward compatible
with CM8738 (6ch).

What did you mean in the original post, "none of the mixer settings I
change will take effect"?  Isn't the mixer value changed at all, or
you get only the silent output, although the playback looks as if
working?

----------------------------------------------------------------------
 tiwai - 10-08-2004 15:36 CEST 
----------------------------------------------------------------------
Also, attach /etc/asound.state and /proc/asound/card0/cmipci for
debugging.

----------------------------------------------------------------------
 patrick - 10-09-2004 09:30 CEST 
----------------------------------------------------------------------
When I run a command like "amixer set Master 10" I get what looks like
proper output. The adjustments don't seem to stick though. Volume for
Master/PCM etc are always listed at 100% in alsamixer and even after
issuing the unmute command for PCM it is always listed as muted.

But if I try to use the ncurses program alsamixer none of the settings are
adjustable. Likewise if I try to use beep-media-player it says it "can't
open audio."

So yeah, I can't get any sound out of it and most audio programs either
give an error about not being able to access the device or just sit there
and do nothing (like aplay).

If you need any more information let me know, I'll try to help as best I
can. Thank you!

ps: Linux Kawaii64 2.6.9-rc3-nitro2 https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 Sat Oct 9 03:24:19 EDT 2004 x86_64
AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux

edited on: 10-09-04 09:30

----------------------------------------------------------------------
 robg - 10-10-2004 04:48 CEST 
----------------------------------------------------------------------
I get the same problems as patrick for amixer and alsamixer operation.  To
verify proper alsa setup, I disabled the 8768 in bios and installed a SB
es1371 and all controls and audio output works.
I use AMD 64-bit kernel 2.6.8-rc2.
I will attach /etc/asound.state and /proc/asound/card0/cmipci as
suggested.

----------------------------------------------------------------------
 robg - 10-10-2004 04:57 CEST 
----------------------------------------------------------------------
I checked and my /etc/asound.state and /proc/asound/card0/cmipci were
identical to those uploaded by patrick so I didn't upload them.

Using aplay I get the following error:

#aplay /usr/lib/mozilla/res/samples/test.wav
 Playing WAVE '/usr/lib/mozilla/res/samples/test.wav' : Unsigned 8 bit,
Rate
 22050 Hz, Mono
 aplay: pcm_write:1115: write error: Input/output error

----------------------------------------------------------------------
 tiwai - 10-13-2004 16:37 CEST 
----------------------------------------------------------------------
The register dump is all ff, that is, the driver is reading wrong I/O
ports.
Can you show the output of "lspci -xvv" ?

----------------------------------------------------------------------
 tiwai - 10-13-2004 16:37 CEST 
----------------------------------------------------------------------
Also, please use 1.0.7-rc2 for avoid unnecessary differences.

----------------------------------------------------------------------
 patrick - 10-14-2004 01:24 CEST 
----------------------------------------------------------------------
0000:02:08.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d300
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 05 00 10 02 10 00 01 04 00 20 00 00
10: 01 d3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f6 13 11 01
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0c 01 02 18


If you want the entire output let me know, this was the only listing
referring to the cmedia card.

----------------------------------------------------------------------
 tiwai - 10-14-2004 12:02 CEST 
----------------------------------------------------------------------
Please try the attached patch (just for testing).

----------------------------------------------------------------------
 patrick - 10-14-2004 16:05 CEST 
----------------------------------------------------------------------
I gave the patch a try just now and I can't seem to produce any different
results. I only had a moment to poke at it though since I am off to work
now.

Maybe some one else will have more luck with it?

Thank you for doing all of this by the way!

----------------------------------------------------------------------
 tiwai - 10-14-2004 16:19 CEST 
----------------------------------------------------------------------
Did you check /proc/asound/card0/cmipci?  Now it should address d400.

BTW, do you have a 32bit system on it?  It might be a problem of
64bit kernel.

----------------------------------------------------------------------
 patrick - 10-14-2004 23:57 CEST 
----------------------------------------------------------------------
Yeah, it seems to be:

C-Media PCI CMI8738-MC6 (model 39) at 0xd400, irq 12

00: ff ff ff ff
04: ff ff ff ff
08: ff ff ff ff
0c: ff ff ff ff
10: ff ff ff ff
14: ff ff ff ff
18: ff ff ff ff
1c: ff ff ff ff
20: ff ff ff ff
24: ff ff ff ff
28: ff ff ff ff
2c: ff ff ff ff
30: ff ff ff ff
34: ff ff ff ff
38: ff ff ff ff
3c: ff ff ff ff

Yes I am using a 64-bit kernel. The motherboard this chip is built on is
an nforce3 250 board so as far as I know they are all 64 bit systems.
Maybe some one else has a 32bit kernel they can test it on but I do not.

----------------------------------------------------------------------
 cltien - 10-16-2004 00:33 CEST 
----------------------------------------------------------------------
Why increase I/O port address by 0x100? Is the port range assigned by BIOS
not working? Is this case for AMD 64-bit (and nForce3) system only?

ChenLi Tien
C-Media Inc.

----------------------------------------------------------------------
 robg - 10-16-2004 07:32 CEST 
----------------------------------------------------------------------
I have been doing some additional testing and I think cltien is right.

I have rebuilt my system to run a 32 bit kernel (vanilla 2.6.7) on the
EQ3801 and I get the same problems.  So it is not a 64 bit kernel issue. 
I also installed an es1371 soundcard and it works properly so basic alsa
is ok.

I added a printk to snd_cmipci_proc_read:

printk(KERN_INFO "cmipci: proc read iobase=0x%lx\n", cm->iobase);

And dmesg shows:

cmipci: proc_read iobase=0xd200

And lspci -xvv shows I/O ports at 0xd200 so offset is not the problem.
But cat /proc/asound/card0/cmipci shows same as patrick posted with ff for
all register values.

There seems to be some success with 8768 PCI cards for current driver:
http://www.linuxquestions.org/questions/history/234279

So is it possible the Soltek EQ3801/nforce3 needs additional
initialization?
Anything else I can investigate?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-07-04 04:59 drbobguy       New Bug                                      
07-07-04 04:59 drbobguy       Distribution              => Gentoo          
07-07-04 04:59 drbobguy       Kernel Version            => 2.6.7           
07-07-04 05:03 drbobguy       Bugnote Added: 0001390                       
07-27-04 05:26 robg           Bugnote Added: 0001475                       
07-30-04 16:56 tiwai          Bugnote Added: 0001493                       
07-31-04 02:46 drbobguy       File Added: CMI8768.pdf                      
07-31-04 02:46 drbobguy       Bugnote Added: 0001508                       
07-31-04 06:10 robg           Bugnote Added: 0001509                       
08-22-04 22:13 masanetz       Bug Monitored: masanetz                      
09-06-04 18:02 patrick        Bug Monitored: patrick                       
10-08-04 05:17 robg           Bugnote Added: 0002043                       
10-08-04 05:18 robg           File Added: CMI8768 register spec v1.0.pdf                    
10-08-04 05:19 robg           File Added: Programming Guide to CMI8738 PCI Audio Chip_v16_0311.pdf                    
10-08-04 12:49 tiwai          Bugnote Added: 0002050                       
10-08-04 15:26 tiwai          Bugnote Added: 0002053                       
10-08-04 15:36 tiwai          Bugnote Added: 0002054                       
10-09-04 09:05 patrick        File Added: asound.state                     
10-09-04 09:08 patrick        File Added: cmipci                           
10-09-04 09:29 patrick        Bugnote Added: 0002061                       
10-09-04 09:30 patrick        Bugnote Edited: 0002061                      
10-10-04 04:48 robg           Bugnote Added: 0002064                       
10-10-04 04:57 robg           Bugnote Added: 0002065                       
10-13-04 16:37 tiwai          Bugnote Added: 0002126                       
10-13-04 16:37 tiwai          Bugnote Added: 0002127                       
10-14-04 01:24 patrick        Bugnote Added: 0002136                       
10-14-04 12:02 tiwai          Bugnote Added: 0002139                       
10-14-04 12:03 tiwai          File Added: cmipci-address.diff                    
10-14-04 16:05 patrick        Bugnote Added: 0002151                       
10-14-04 16:19 tiwai          Bugnote Added: 0002152                       
10-14-04 23:57 patrick        Bugnote Added: 0002161                       
10-16-04 00:33 cltien         Bugnote Added: 0002177                       
10-16-04 07:32 robg           Bugnote Added: 0002184                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
