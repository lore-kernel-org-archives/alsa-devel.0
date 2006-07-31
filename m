From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002107]: audigy 2 ZS SB0350 gives no
	sound
Date: Mon, 31 Jul 2006 20:48:05 +0200
Message-ID: <aeb16cae940cf74a07e9df32b3fa3a11@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1E5F197
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 20:48:05 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2107> 
======================================================================
Reported By:                peter_scott
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2107
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111
======================================================================
Date Submitted:             05-08-2006 23:36 CEST
Last Modified:              07-31-2006 20:48 CEST
======================================================================
Summary:                    audigy 2 ZS SB0350 gives no sound
Description: 
I have an Audigy 2 ZS Model SB0350 card with a chip marked CA0102-ICT,
installed in a PC running Fedora Core 5 with a 2.6.16-1.2111 kernel.

The already-existing-in-the-kernel emu10k1 sound module provides no sound
for me (should it?), so I tried downloading and building emu10k1 in the
alsa-driver and installing it according to the instructions in the
"INSTALL" file in the source directory.

But (of course?) it did not work.  Well, after all, the emu10k1 is already
in the FC5 kernel.  Is there any way to get this sound card to work?

I try "system-config-soundcard" (alsaconf is not included in alsa-utils
for FC5) to test the card.

I was led to believe that Audigy 2 ZS cards generally will work on linux
systems, but I've also since read others write that not all Audigy 2 ZS
cards run the same hardware.  It's a PCI card.  I am a little suspicious
of the "CA0102-ICT" text on the chip.

Any thoughts or predictions would be most welcome.  Maybe it should have a
"ca0102" driver?
======================================================================

----------------------------------------------------------------------
 peter_scott - 07-31-06 20:39 
----------------------------------------------------------------------
Dear jcdutton,

Alas, I gave away my Audigy 2 ZS sound card to a friend with a windows
machine since I had (mistakenly, I presume) believed it would not work for
me.  Instead I did manage to get my on board (in my ASUS A8N-SLI mobo)
nVidia sound (using the snd-intel8x0 module) to work, and that seems OK
for my use.  However I am
sure I could retrieve that Audigy sound card if there is some thought that
it might produce better sound in my system.  Any thoughts on this point? 
My current kernel is 2.6.17-1.2139_FC5 #1 SMP, with an AMD Athlon 64 x2
3800+ CPU.

Thanks so much for posting your kind response, and for any additional
thoughts you might have.

-- Peter Scott

----------------------------------------------------------------------
 jcdutton - 07-31-06 20:48 
----------------------------------------------------------------------
The Audigy 2 ZS is considerably better than the nvidia sound.
This is particularly the case for Games and Voice over IP. Voice over IP
benefits from better mic quality, and Games benefit from the out card
being a hardware mixing device. The Audigy 2 ZS is, the nvidia sound is
not.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 23:36 peter_scott    New Issue                                    
05-08-06 23:36 peter_scott    Distribution              => Fedora Core 5   
05-08-06 23:36 peter_scott    Kernel Version            => 2.6.16-1.2111   
07-06-06 07:33 L0cKd0wN       Note Added: 0010854                          
07-06-06 07:34 L0cKd0wN       Issue Monitored: L0cKd0wN                    
07-06-06 07:35 L0cKd0wN       Note Edited: 0010854                         
07-18-06 14:23 jcdutton       Status                   new => assigned     
07-18-06 14:23 jcdutton       Assigned To               => jcdutton        
07-30-06 18:26 jcdutton       Note Added: 0011325                          
07-30-06 18:26 jcdutton       Status                   assigned => feedback
07-31-06 20:39 peter_scott    Note Added: 0011347                          
07-31-06 20:48 jcdutton       Note Added: 0011348                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
