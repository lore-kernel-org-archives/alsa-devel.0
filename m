From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001760]: bad digital output
Date: Fri, 27 Jan 2006 19:22:01 +0100
Message-ID: <3c42bba6d254eebd4917751aba57c2c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 182CC1B5
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 19:22:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1760> 
======================================================================
Reported By:                koloom
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1760
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.14
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-17-2006 21:46 CET
Last Modified:              01-27-2006 19:22 CET
======================================================================
Summary:                    bad digital output
Description: 
Notebook and receiver is connected using digital optical cable. Then I
start aplay --device spdif some_stereo.wav. The receiver correctly detects
stereo PCM. The left channel works well, but only noise comes from the
right channel. I tried iec958 and hw:0.1 devices with the same result.
Playing AC3 does not work at all - the receiver is unable to detect the
data format (dolby etc).


======================================================================

----------------------------------------------------------------------
 koloom - 01-27-06 10:59 
----------------------------------------------------------------------
The problems disappeared when I stopped alsa and removed /etc/asound.state.
I guess that the file contained some wrong values set by some older
driver. Everything works fine now, including AC3 passtrough. I am sorry
for the troubles and please close this bug.



----------------------------------------------------------------------
 rlrevell - 01-27-06 19:22 
----------------------------------------------------------------------
Mixer settings

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-17-06 21:46 koloom         New Issue                                    
01-17-06 21:46 koloom         Distribution              => gentoo          
01-17-06 21:46 koloom         Kernel Version            => 2.6.14          
01-27-06 10:58 koloom         Note Added: 0007798                          
01-27-06 10:59 koloom         Note Edited: 0007798                         
01-27-06 19:22 rlrevell       Status                   assigned => closed  
01-27-06 19:22 rlrevell       Note Added: 0007805                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
