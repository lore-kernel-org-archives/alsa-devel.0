From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002097]: ALC850 is 8-channel but intel8x0 only seems to support 6 channels
Date: Sun, 7 May 2006 01:41:09 +0200
Message-ID: <1bf224eea81273ebe1ee9eacaa7ea097@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4DEFD165
	for <alsa-devel@alsa-project.org>; Sun,  7 May 2006 01:41:09 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2097> 
======================================================================
Reported By:                ellismartinp
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2097
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 5
Kernel Version:             2.6.15 (2096)
======================================================================
Date Submitted:             05-05-2006 14:17 CEST
Last Modified:              05-07-2006 01:41 CEST
======================================================================
Summary:                    ALC850 is 8-channel but intel8x0 only seems to
support 6 channels
Description: 
I have on-board Nforce4 with AC97 CODEC.  This is feeding a Creative 7.1
amp & speakers via analogue.  In Windows XP I get all 8 channels and can
test them individually.

Under Linux I can get ALSA to play on 6 speakers (not the side ones) by
duplicating front to rear but I can't see any way of testing if all
individual channels work and I can't see any way of enabling the remaining
two speakers.

Help please?!

There must be millions of Nforce4 boards out there running 7.1 sound just
dying to go to Linux.
======================================================================

----------------------------------------------------------------------
 ellismartinp - 05-06-06 23:55 
----------------------------------------------------------------------
OK - so I got stuck in and now have a working 8-channel intel8x0 (together
with a small add-in to ac97_patch.c) - based on the 1.0.11 driver set.

speaker-test -c8 -Dsurround71
now gives me 8 channels of lovely pink noise, one by one, on the correct
speakers!

The patch for ac97 is based on a good look at the ALC850 datasheet.

The changes to intel8x0 are based on intelligent guesswork and I have no
idea what impact they might have on chipsets other than NFORCE4.  All I
can say is that they work on my Gigabyte K8N-Pro SLI (NFORCE4).

I'll put the modded files up here as soon as I've tidied them up and am
completely happy with them, together with some notes on how alsamixer
needs to be set up.

(... now, can't resist ... Woohoo!!!!! I still have the touch).

----------------------------------------------------------------------
 ellismartinp - 05-07-06 01:41 
----------------------------------------------------------------------
I've uploaded the modded files.  All seems to work fine on my rig so far.
Not sure if they'll be any use to anyone else - hope so!  All the changes
have Martin Ellis next to or around them.  Someone who really knows what
they're doing should take a look, 'cos I'm a noobie and have probably
broken something :!

Maybe someone from Alsa could take a look and see if they could be a basis
for a future enhancement?

**** Please don't try this without backing up EVERYTHING etc. first ****

Download Alsa drivers 1.0.11 and unzip

ac97_patch.c goes in alsa-driver-1.0.11/alsa-kernel/pci/ac97/
intel8x0.c goes in alsa-driver-1.0.11/alsa-kernel/pci/

Open a Terminal session
cd alsa-driver-1.0.11
./configure --with-cards=intelx80
make
su [enter password]
make install
reboot

To correctly run speaker-test you'll need to edit NFORCE.conf in
/etc/alsa/cards/
Add the following after the NFORCE.pcm.surround51.0 definition

<confdir:pcm/surround71.conf>

NFORCE.pcm.surround71.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type softvol
	slave.pcm {
		type route
		ttable.0.0 1
		ttable.1.1 1
		ttable.2.4 1
		ttable.3.5 1
		ttable.4.2 1
		ttable.5.3 1
		ttable.6.6 1
		ttable.7.7 1
		slave.pcm {
			type hooks
			slave.pcm {
				type hw
				card $CARD
				device 0
			}
			hooks.0 {
				type ctl_elems
				hook_args [
				{
					name "Channel Mode"
					preserve true
					value "8ch"
					lock true
					optional true
				}
				# for old drivers
				{
					name "Line-In As Surround"
					preserve true
					value true
					optional true
				}
				{
					name "Mic As Center/LFE"
					preserve true
					value true
					optional true
				}
				{
					name "Surround Down Mix"
					preserve true
					value off
					lock true
					optional true
				}
				{
					name "Center/LFE Down Mix"
					preserve true
					value off
					lock true
					optional true
				}
				]
			}
		}
		slave.channels 8
	}
	control {
		name "PCM Playback Volume"
		card $CARD
	}
}

Martin Ellis

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-05-06 14:17 ellismartinp   New Issue                                    
05-05-06 14:17 ellismartinp   Distribution              => Fedora Core 5   
05-05-06 14:17 ellismartinp   Kernel Version            => 2.6.15 (2096)   
05-06-06 00:52 ellismartinp   Note Added: 0009633                          
05-06-06 23:55 ellismartinp   Note Added: 0009638                          
05-07-06 01:26 ellismartinp   File Added: ac97_patch.c                     
05-07-06 01:26 ellismartinp   File Added: intel8x0.c                       
05-07-06 01:41 ellismartinp   Note Added: 0009639                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
