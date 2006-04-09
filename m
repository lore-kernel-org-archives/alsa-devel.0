From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001703]: NVidia CK804 - Realtek ALC850 rev 0 - passthrough not working
Date: Sun, 9 Apr 2006 16:22:01 +0200
Message-ID: <8f4a37cd1f07f68384aa22bd5a36715f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9F1C6B3
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 16:22:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1703> 
======================================================================
Reported By:                alsarealist
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1703
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               self burned
Kernel Version:             
======================================================================
Date Submitted:             01-03-2006 18:42 CET
Last Modified:              04-09-2006 16:22 CEST
======================================================================
Summary:                    NVidia CK804 - Realtek ALC850 rev 0 - passthrough
not working
Description: 
Pass-through with xine is not working.
PCM Stereo downmix works fine


00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio
Controller (rev a2)

gcc (GCC) 4.0.2
alsa version 1.0.11rc2
Linux 2.6.15

======================================================================

----------------------------------------------------------------------
 alsarealist - 04-09-06 14:31 
----------------------------------------------------------------------
Giving up frustrated - DTS, Dolby 5.1 seems not to be possible. Stay an
stereo.

Closing case.

----------------------------------------------------------------------
 rlrevell - 04-09-06 16:22 
----------------------------------------------------------------------
You have to use a stereo .wav file for this, a 6 channel one won't work. 
SPDIF only supports 2 channels unless the signal is AC3 encoded.

% aplay -Dplug:spdif somefile.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 18:42 alsarealist    New Issue                                    
01-03-06 18:42 alsarealist    Distribution              => self burned     
01-03-06 19:05 rlrevell       Note Added: 0007403                          
01-04-06 01:45 alsarealist    Note Added: 0007409                          
01-04-06 17:11 tiwai          Note Added: 0007436                          
01-04-06 17:32 alsarealist    File Added: asound.state                     
01-04-06 17:33 alsarealist    Note Added: 0007443                          
01-04-06 17:38 alsarealist    File Added: proc-asound                      
01-04-06 17:42 alsarealist    Note Added: 0007447                          
01-04-06 23:11 alsarealist    Note Added: 0007459                          
01-05-06 20:00 tiwai          Note Added: 0007477                          
01-06-06 01:03 alsarealist    Note Added: 0007486                          
04-09-06 14:31 alsarealist    Note Added: 0009179                          
04-09-06 16:22 rlrevell       Note Added: 0009180                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
