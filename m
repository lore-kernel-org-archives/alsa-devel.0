From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000498]: audigyls plays sound 1.5 times fast
Date: Mon, 6 Dec 2004 23:28:23 +0100
Message-ID: <afc05e7cb8022b5b5e0c7d8605d29e53@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5C5B43A0
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2004 23:28:24 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=498> 
======================================================================
Reported By:                andii
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   498
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo 2004.2
Kernel Version:             linux-2.6.7-gentoo-r11
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-12-2004 06:23 CEST
Last Modified:              12-06-2004 23:28 CET
======================================================================
Summary:                    audigyls plays sound 1.5 times fast
Description: 
audigyls plays sound 1.5 times faster then it should.

Example:
andy@gordon andy $ time plaympeg 01-radio_moscow.mp3
01-radio_moscow.mp3: MPEG audio stream
        Audio MPEG-1 Layer 3 128kbit/s 44100Hz stereo
        Size: 404165
        Total time: 25.260312

real    0m17.163s
user    0m0.374s
sys     0m0.015s

1st thought it might just be mp3s but also wav files and games,
everything!

Note: I downloaded and installed alsa-lib, alsa-drivers and alsa-utils by
hand, I did not use gentoo's emerge.
======================================================================

----------------------------------------------------------------------
 jcdutton - 09-15-04 16:18 
----------------------------------------------------------------------
This seems rather strange, because I set the AudigyLS to only do 48khz or
96khz in hardware, so for 44.1khz, alsa-lib should be doing sample rate
conversions.
The AudigyLS can do 44.1khz in hardware, but when I tried it, it sounded
horrible, so I disabled the hardware 44.1khz mode.
We don't seem to have received any other reports of sample rate conversion
problems for other cards that can only do 48khz.

----------------------------------------------------------------------
 jcdutton - 12-06-04 23:28 
----------------------------------------------------------------------
I am closing this bug. The reason for this is that the audigyls driver has
changed a lot recently, and I would prefer it if you tried again with the
latest alsa-driver cvs, and try the "snd-ca0106" driver. The snd-audigyls
does not exist any more.
If the bug is still present, please re-raise the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-12-04 06:23 andii          New Issue                                    
09-12-04 06:23 andii          Distribution              => Gentoo 2004.2   
09-12-04 06:23 andii          Kernel Version            =>
linux-2.6.7-gentoo-r11
09-13-04 15:40 tiwai          Note Added: 0001746                          
09-15-04 14:31 andii          Note Added: 0001761                          
09-15-04 16:18 jcdutton       Note Added: 0001762                          
12-06-04 23:28 jcdutton       Status                   assigned => closed  
12-06-04 23:28 jcdutton       Note Added: 0002740                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
