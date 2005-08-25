From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001359]: cs46xx DTS pass through works, but AC3/Dolby Digital does not
Date: Thu, 25 Aug 2005 11:56:16 +0200
Message-ID: <92de22350ee245b2f30fc32b7aaa00bd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 50F321F4
	for <alsa-devel@alsa-project.org>; Thu, 25 Aug 2005 11:56:17 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1359> 
======================================================================
Reported By:                rjh
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1359
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             Linux 2.6.12-1.1398_FC4 (a standard FC4 kernel)
Resolution:                 duplicate
Duplicate:                  562
Fixed in Version:           
======================================================================
Date Submitted:             08-22-2005 20:57 CEST
Last Modified:              08-25-2005 11:56 CEST
======================================================================
Summary:                    cs46xx DTS pass through works, but AC3/Dolby Digital
does not
Description: 
Dear Alsa developers.

I have an interesting situation with my Terratec XFire 1024 and Sony
STR-DB930 external amplifier.

I have a dual boot system. When I use Windows and Windows DVD players,
digital pass-through sound works perfectly. When I switch to Linux FC4 +
Alsa + Xine, only DTS pass-though sound works. In particular, when playing
a typical DVD that uses Dolby Digital sound by default, the amplifier
recognizes that it is receiving Dolby Digital signal (Sony STD DB-930
front panel shows text "Dolby Digital [3/2]", and all the apropriate
status lights are turned on, too), but no sound comes out. Likewise, no
DVD intro sounds that play before and during DVD menus can be heard (but
Sony STD DB-930 front panel shows for example text "Dolby Digital [2/0]").
There is no humming, rattling, popping, or some other artifact sounds
either, just silence.

If I on the other hand select a DTS sound track using Xine DVD menu
functions, the aplifier recognizes that it is now receiving DTS signal
(font panel shows "DTS [3/2]"), and sound plays as it should!

If I configure Xine to do the decoding and output normal stereo sound,
that works too, but without the benefits of surround sound, of course.

It would therefore seem that current ALSA cs46xx driver can almost but not
quite output Dolby Digital sound in a format that the Sony STR-DB930
amplifier recognizes. One the other hand, DTS signal comes through ok. I
hope that these observations will propably limit the number of locations
where the problem may be.

I would also point out that the amplifier status display reacts correctly
to changes in signal type. This propably proves that at least something
does indeed come though correctly. Finally, the fact that everything works
perfectly with Windows drivers shows that the card and amplifier can work
together.

I have also tried to randomly change the control values in Xine iec958
control string (the audio.device.alsa_passthrough_device parameter that
has the default value of "iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2) but
without any effect.

I have also tried various control values with 'iecset' utility, but again
without any effect.

I have no custom .asoundrc settings in place.

I have to admit that I have not tried other recent players than Xine
0.99.4-1.2.fc4 yet, mainly because latest mplayer current crashes and I
have had some trouble compiling it, too. However, I have observed the same
problem earlier with older Xine and mplayer version is some older Linux
distribution (and exactly the same hardware).

I would be very thankfull for any advice. I would also be happy to run any
additional tests you might consider usefull.

  Rami
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000542 custom kernel with latest alsa-source f...
duplicate of        0000562 No AC3 sound playable through S/PDIF wi...
======================================================================

----------------------------------------------------------------------
 rjh - 08-24-05 23:53 
----------------------------------------------------------------------
After some browsing, I actually found issue number 0000562 which seems to
be a much better match with this issue that 0000542. So maybe the correct
duplicate ID would be 0000562, not 0000542 (the difference is only one
digit, so the original entry was most propably a typo).

Maybe some administrator could fix the duplicate relationship link?

The real question is however, who could fix the actual problem, already
cited by 'tiwai' as being "a long standing bug about AC3 on cs46xx" (a
direct quote from issue 0000562, dated '10-06-04', over a year ago)!

Is there anything I can do to help? I'm not AC3/cs46xx expert, but I can
program, compile, and run test software. Most importantly, I can provide a
test environment where the problem can be easily reproducted. So please
instruct me what to do so that we may together kill this bug.

----------------------------------------------------------------------
 tiwai - 08-25-05 11:56 
----------------------------------------------------------------------
Yep, sorry it was a typo.  The correct id is #562.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 20:57 rjh            New Issue                                    
08-22-05 20:57 rjh            Distribution              => Fedora Core 4   
08-22-05 20:57 rjh            Kernel Version            => Linux
2.6.12-1.1398_FC4 (a standard FC4 kernel)
08-22-05 21:00 rjh            Issue Monitored: rjh                         
08-23-05 16:35 tiwai          Relationship added       duplicate of 0000542
08-23-05 16:35 tiwai          Duplicate ID             0 => 542            
08-23-05 16:35 tiwai          Status                   new => resolved     
08-23-05 16:35 tiwai          Resolution               open => duplicate   
08-23-05 16:35 tiwai          Assigned To               => tiwai           
08-24-05 21:57 rjh            Status                   resolved => feedback
08-24-05 21:57 rjh            Resolution               duplicate => reopened
08-24-05 21:57 rjh            Note Added: 0005934                          
08-24-05 23:53 rjh            Note Added: 0005935                          
08-25-05 11:56 tiwai          Relationship added       duplicate of 0000562
08-25-05 11:56 tiwai          Duplicate ID             542 => 562          
08-25-05 11:56 tiwai          Status                   feedback => resolved
08-25-05 11:56 tiwai          Resolution               reopened => duplicate
08-25-05 11:56 tiwai          Note Added: 0005937                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
