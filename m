From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000801]: Persistent "max-amp" level on hdspmixer inputs
Date: Sat, 15 Jan 2005 19:27:30 +0100
Message-ID: <cc2f2b1e823abea5e9fa98e0c0d2a0f7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 994B424E
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2005 19:27:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=801> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   801
Category:                   hdsp progs
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             01-10-2005 09:20 CET
Last Modified:              01-15-2005 19:27 CET
======================================================================
Summary:                    Persistent "max-amp" level on hdspmixer inputs
Description: 
HDSPmixer shows constant "max-amp" (actually -6db or so) levels at all
times in the first 8 channels.  And when sound is played internally the
middle row meters (playback) show the left channel with maxed-out levels
while the right channel shows nothing.  Peak meters (yellow), however,
appear to work normally.

A screenshot of the mixer while playing a stereo soundfile routed to AN1+2
and Analog (headphones) only with NOTHING connected to the inputs can be
cound here:

http://www.esm.rochester.edu/kevine/hdsp_screenshot.jpg

Note that the outputs (bottom row) show proper levels as do the yellow
peak meters in playback (Out 1+2).  

Signal quality is unaffected.
======================================================================

----------------------------------------------------------------------
 slick - 01-15-05 19:27 
----------------------------------------------------------------------
I used SuSE 9.1 with the current Kernel 2.6.5 and the build-in ALSA (I
think 1.03) and the hdspmixer worked fine for my Multiface with cardbus
adapter. 
Today I tried out the current 9.2 Kernel 2.6.8-24.10 and I had similar
problem as described in this thread (flickering peaks at the first 7 input
channels of my Multiface). 
After the installation of ALSA 1.08 there were no improvements at
2.6.8-24.10 (the same problem with the hdspmixer) but after the
installation of ALSA 1.08 at the current  SuSE 9.1 Kernel 2.6.5 the same
problem occured at this Kernel too. So I think it could be an ALSA bug.
I thought this problem was solved with release 1.08 but it doesn't seem
so.
If you need more information send an E-Mail to Slick@feierfreunde.com

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 09:20 kme            New Issue                                    
01-15-05 19:27 slick          Note Added: 0003212                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
