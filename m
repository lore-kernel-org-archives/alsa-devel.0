From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation for ati-ixp chipset.
Date: Tue, 23 May 2006 16:46:16 +0200
Message-ID: <4d2d6fd7cd07769e0f7cfe5f67bf9af2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D1213175
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 16:46:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2147> 
======================================================================
Reported By:                Gene Heskett
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2147
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               FC5, uptodate
Kernel Version:             2.6.16-1.2111_FC5
======================================================================
Date Submitted:             05-23-2006 03:52 CEST
Last Modified:              05-23-2006 16:46 CEST
======================================================================
Summary:                    lack of full duplex operation for ati-ixp chipset.
Description: 
skype, ekiga, audacity, and generally any program that needs to both
transmit and receive, using isolated paths, fails in playback when
recording.  In skype, I sound great at the far end, but reception may or
may not work, with emphasis on the not.  What I hear in the phones, or in
the speakers, sounds like what you would get if you took a sentence of
spoken words, break it up into say 5ms pieces, and play them at maybe 10
of these little snippets per second, so that the resultant sound is broken
up to the point of no comprehension, and stretched in time by a
considerable amount.

In audacity, simultanious playback, or play one track while recording
another, likewise fails in that only very short snippets of the played
track are output to the phones or speakers.

Likewise, ekiga suffers from this same effect, I'm told I sound great on
teh other end, but I can't hear more than half a word occasionally.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-06 15:01 
----------------------------------------------------------------------
The driver works as full-duplex.  Try a simple test with arecord and aplay.

----------------------------------------------------------------------
 Gene Heskett - 05-23-06 16:46 
----------------------------------------------------------------------
Thats not so simple, I have only ogg files from one cd available, which
aplay apparently doesn't know how to play.  I've not ripped any aditional
music because grip cannot play a cd in the drive.  Attempts result in grip
(or most any other cd player, like kscd, go thru the motions of playing
the cd, but only silence comes out), it can rip it, and a not very high
quality rip (sounds like amplifier saturation to this broadcast engineer
and audacity says the levels are running 0 db and above) was made.  So I'm
not at all familiar with either aplay or arecord.

Can you supply a command line that would generate a file for test, and
then a command line that will play that file while recording another, with
no crosstalk between them?  Something you *know* works so we aren't trying
compare apple to oranges?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:52 Gene Heskett   New Issue                                    
05-23-06 03:52 Gene Heskett   Distribution              => FC5, uptodate   
05-23-06 03:52 Gene Heskett   Kernel Version            => 2.6.16-1.2111_FC5
05-23-06 15:01 tiwai          Note Added: 0009934                          
05-23-06 16:46 Gene Heskett   Note Added: 0009938                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
