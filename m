From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000711]: Sound still bad with alsa on sb audigyls / ca0106
Date: Wed, 8 Dec 2004 01:26:25 +0100
Message-ID: <9eea30423053616737edc0c3f0a07ec2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8B2D43B9
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2004 01:26:25 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=711> 
======================================================================
Reported By:                scorpion77
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   711
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.9-1.6_FC2custom
======================================================================
Date Submitted:             12-07-2004 18:12 CET
Last Modified:              12-08-2004 01:26 CET
======================================================================
Summary:                    Sound still bad with alsa on sb audigyls / ca0106
Description: 
Sound is choppy and at wrong speed with both the snd-audigyls from alsa
1.0.7 and snd-ca0106 from alsa CVS. CVS seems worse, which bugs me since
last bug report was closed woth a "Use snd-ca0106 from CVS remark"!
Workaround seems to select (Threaded)OSS as artsd backend instead of Alsa.
Esd as artsd backend only works / fixes things in 1.0.7, it crashes when
the CVS version is used.
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-08-04 01:23 
----------------------------------------------------------------------
The sound card hardware is able to do:
1) Capture at 8, 11.025, 22.05, 44,1, 48, 96, at 16 or 24 bit
2) Analog playback at 48, 96 at 16 or 24bit.
3) Digital playback at 44.1, 48, 96.
4) Only one stream at a time.

All the other rates and options are all done in software in windows.

You are correct that the sound card driver is new, and will probably not
be updated for some time as I will be doing work on other alsa drivers
before I come back to the Audigy LS. For example, add support for 96khz,
24bit to the Audigy 2 class of sound cards.

I can only suggest that you try to configure arts to talk to the sound
card in a better fashion. e.g. Use buffers of 8 periods if you can get
arts to do that, otherwise use 4 periods. I expect that the problems you
are having is that the sound app is setting 2 periods, and as the sound
card hardware has a fairly small limit on max size of a period, your PC
cannot handle the interrupts quickly enough, and thus get the bad sound.
More periods is better with this sound card, up to a max of 8 periods.
Also, try forcing arts to output at 48khz.

I do not use arts or esd, so I am not the best person to ask regarding
them.

----------------------------------------------------------------------
 scorpion77 - 12-08-04 01:26 
----------------------------------------------------------------------
I'm sorry read the box to fast, it said spdif out upto 24bit 44.1, 48 or
96kbit samplerate

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:12 scorpion77     New Issue                                    
12-07-04 18:12 scorpion77     Distribution              => Fedora Core 2   
12-07-04 18:12 scorpion77     Kernel Version            => 2.6.9-1.6_FC2custom
12-07-04 20:24 rlrevell       Note Added: 0002764                          
12-07-04 21:40 scorpion77     Note Added: 0002765                          
12-07-04 21:53 jcdutton       Note Added: 0002766                          
12-08-04 00:21 scorpion77     Note Added: 0002769                          
12-08-04 00:22 scorpion77     Note Edited: 0002769                         
12-08-04 01:23 jcdutton       Note Added: 0002770                          
12-08-04 01:26 scorpion77     Note Added: 0002771                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
