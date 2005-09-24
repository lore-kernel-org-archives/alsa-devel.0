From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000772]: Analog/Digital output not working.
Date: Sat, 24 Sep 2005 17:47:56 +0200
Message-ID: <20136d3d0c9ef6af75529a217df7b3f4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53519165
	for <alsa-devel@alsa-project.org>; Sat, 24 Sep 2005 17:47:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=772> 
======================================================================
Reported By:                ianw1234
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   772
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.9-1.681_FC3
======================================================================
Date Submitted:             12-31-2004 23:02 CET
Last Modified:              09-24-2005 17:47 CEST
======================================================================
Summary:                    Analog/Digital output not working.
Description: 
I've been unable to get my SB Live! to send analog pcm out through the
Analog/Digital port. It's connected through this port to my receiver, and
while AC3 over the digital port works fine, I can't get anything else to
go over the line. I have a 48kHz wave file I've been testing, and I've
tried playing it with aplay over hw0,0 (no good), hw0,1 (doesn't exist),
and hw0,2 (no effect). 

I have the master, IEC Coaxial, AC97, External amplifier, and SB Live
Analog/Digital Output Jack all either unmuted or set to max volume. I've
tried loading the snd_pcm_oss module with various snd_dsp_map settings
without success.

I've tried this on 1.0.7 and 1.0.8rc1. I dimly remember this working in
the past, so I don't know if this was broken in the upgrade to 1.0.7
(which I had to do because AC3 passthrough didn't work in the version that
came with the 2.6.9 kernel) or whether I have some strange
misconfiguration. Help is appreciated! Thanks!
======================================================================

----------------------------------------------------------------------
 jdthood - 04-18-05 23:16 
----------------------------------------------------------------------
Submitter: Any improvement in more recent ALSA releases?

----------------------------------------------------------------------
 razer1 - 09-24-05 17:47 
----------------------------------------------------------------------
I've a similar bug too : geexbox distrib (multimedia usage :
www.geexbox.org), based on kernel 2.6.12, mplayer 1.0-pre7 & alsa 1.0.9. 
I try to use this SB Live 5.1 in 6 channels analog mode.
2 channels mode works, the rear output duplicates the front, but no output
via LFE/Center Jack Output (used for spdif too).
In Surround5.1 mode, the card give an uggly noise instead of movie sound
or music
All different amixer config give same result
Note : the card was working fine in this mode with an 2.6.7 on gentoo

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 23:02 ianw1234       New Issue                                    
12-31-04 23:02 ianw1234       Kernel Version            => 2.6.9-1.681_FC3 
01-01-05 00:33 ianw1234       Note Added: 0003028                          
01-01-05 02:28 rlrevell       Note Added: 0003030                          
01-01-05 10:01 pzad           Note Added: 0003031                          
01-01-05 22:48 ianw1234       Note Added: 0003039                          
01-01-05 23:03 pzad           Note Added: 0003041                          
01-02-05 19:15 jukkat         Note Added: 0003046                          
01-02-05 19:20 jukkat         Note Edited: 0003046                         
01-04-05 21:57 visit0r        Issue Monitored: visit0r                     
04-18-05 23:16 jdthood        Note Added: 0004516                          
09-24-05 17:47 razer1         Note Added: 0006373                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
