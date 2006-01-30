From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001797]: Aureon 7.1 Universe: mixer flakyness (irrecoverable muting, intermittent muting of single channel)
Date: Mon, 30 Jan 2006 23:46:53 +0100
Message-ID: <bd91a30dd969636a3b27b741f677a077@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 449F21D1
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2006 23:46:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1797> 
======================================================================
Reported By:                ikari_01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1797
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             01-30-2006 23:46 CET
Last Modified:              01-30-2006 23:46 CET
======================================================================
Summary:                    Aureon 7.1 Universe: mixer flakyness (irrecoverable
muting, intermittent muting of single channel)
Description: 
1. Setting (or muting/unmuting) of any of the Master, Center, LFE, or Side
mixers eventually results in irrecoverably completely muted sound.
Sometimes, at first only one channel is muted.
Sometimes, at first the volume decreases before muting occurs.

This does not occur when touching the "Front" mixer.
The only way to recover sound is to unload and reload at least the
snd_ice1724 module.

2. When muting and unmuting "PCM" repeatedly, sound is not always muted or
unmuted accordingly, but only about 50% of the time. (meaning you have to
toggle a couple of times to get the desired setting)

3. When muting or unmuting Master, sometimes only one of the channels is
muted or unmuted.

note: None of the problems occurred when testing on a 32-bit distribution
(Knoppix 4.0 / 2.6.12 / ALSA 1.0.9; different version, but I had the same
problem with 1.0.9 on x86_64 anyway.)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-06 23:46 ikari_01       New Issue                                    
01-30-06 23:46 ikari_01       Distribution              => Debian unstable 
01-30-06 23:46 ikari_01       Kernel Version            => 2.6.14.3        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
