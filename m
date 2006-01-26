From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001784]: line input not recording right channel
Date: Thu, 26 Jan 2006 07:33:09 +0100
Message-ID: <fd88a6d60d32b3ef42f9d17a3bf1d6f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3BE2197
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 07:33:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1784> 
======================================================================
Reported By:                Eil
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1784
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14
======================================================================
Date Submitted:             01-26-2006 07:33 CET
Last Modified:              01-26-2006 07:33 CET
======================================================================
Summary:                    line input not recording right channel
Description: 
I'm trying to set up my computer to record audio from the line-in jack
(blue) on a SoundBlaster Live! Value card (CT4832). No matter what
adjustments I make to the mixer (using alsamixer or kmix), I cannot get it
to record sound from the right channel. Additionally, sound on the left
sounds quieter than it should, but this may be a perception issue since
stereo is missing. I've tried the drivers that ship with the 2.6.14 kernel
and the 1.0.10-r2 Gentoo alsa-driver package, both do the same thing. On a
whim, I booted an old MEPIS live CD with 1.0.5 (or maybe 1.0.6) drivers
and those worked just fine. It's almost as if the right Capture slider in
alsamixer isn't working and the left one won't go high enough.
Additionally, the Line slider doesn't do anything, like I would expect it
to, muted or not. However, the Line slider does have to have capture set
on it to hear anything from the line-in jack.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-26-06 07:33 Eil            New Issue                                    
01-26-06 07:33 Eil            Distribution              => Gentoo          
01-26-06 07:33 Eil            Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
