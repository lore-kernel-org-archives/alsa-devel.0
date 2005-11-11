From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001331]: MSI K8N's SB Live 24 bit, no sound from line-in
Date: Fri, 11 Nov 2005 19:33:37 +0100
Message-ID: <2acd8c2f490817b697cadcae3d5ac109@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1B36818F
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2005 19:33:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1331> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1331
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398-x86_64
======================================================================
Date Submitted:             08-13-2005 01:27 CEST
Last Modified:              11-11-2005 19:33 CET
======================================================================
Summary:                    MSI K8N's SB Live 24 bit, no sound from line-in
Description: 
I have a MSI K8N Platinum motherboard that has a SBLive! 24 bit
integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack like the pci version of the sb live 24
bit.

With this card I cannot hear any sound that come from line-in.
For Example I have a tv card, its output audio go into line-in: result is
I cannot hear nothing from the tv, I can only see channels without audio.

The "Capture feedback into playback" in the mixer change the mic's
volume.
There is nothing that change line-in's volume.
======================================================================

----------------------------------------------------------------------
 Cimmo - 11-07-05 11:07 
----------------------------------------------------------------------
So I've to switch to development version 1.0.10rc2?

----------------------------------------------------------------------
 Cimmo - 11-11-05 19:33 
----------------------------------------------------------------------
Ok I've compiled and installed succesfully alsa-driver and alsa-lib
1.0.10rc3

I've retested everything:
putting TV audio output to mic it works great, I can listen to TV!
With this configuration I'm be able to record and play with these 2
commands:
arecord -fdat -Dhw:0,1 | aplay
arecord -fdat -Dhw:0,2 | aplay

with line-in there is no chance: audio doesn't work, and none of the four
0,x works.

I've to stress Creative for documentation?

Tell me something

Thanx
Marco

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 01:27 Cimmo          New Issue                                    
08-13-05 01:27 Cimmo          Distribution              => Fedora Core 4   
08-13-05 01:27 Cimmo          Kernel Version            => 2.6.12-1.1398-x86_64
08-13-05 01:41 jcdutton       Note Added: 0005798                          
08-13-05 01:42 jcdutton       Status                   assigned => feedback
08-13-05 18:30 Cimmo          Note Added: 0005807                          
08-31-05 15:14 Cimmo          Note Added: 0005989                          
08-31-05 18:59 rlrevell       Note Added: 0005991                          
09-10-05 10:31 jcdutton       Note Added: 0006107                          
10-19-05 19:13 Cimmo          Note Added: 0006496                          
11-07-05 00:02 jcdutton       Note Added: 0006610                          
11-07-05 11:07 Cimmo          Note Added: 0006612                          
11-11-05 19:33 Cimmo          Note Added: 0006678                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
