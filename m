From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000772]: Analog/Digital output not working.
Date: Fri, 31 Dec 2004 23:02:02 +0100
Message-ID: <5c08b2d77dea42118352d0ae7269f4d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 54DCD336
	for <alsa-devel@alsa-project.org>; Fri, 31 Dec 2004 23:02:02 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              12-31-2004 23:02 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 23:02 ianw1234       New Issue                                    
12-31-04 23:02 ianw1234       Kernel Version            => 2.6.9-1.681_FC3 
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
