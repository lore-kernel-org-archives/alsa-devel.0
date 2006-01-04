From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001703]: NVidia CK804 - Realtek ALC850 rev 0 - passthrough not working
Date: Wed, 4 Jan 2006 17:42:26 +0100
Message-ID: <edfc0c9b6998ee862214b42d1c049abd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B807184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:42:26 +0100 (MET)
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
Last Modified:              01-04-2006 17:42 CET
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
 alsarealist - 01-04-06 17:33 
----------------------------------------------------------------------
This case is against 1.0.11rc2!

----------------------------------------------------------------------
 alsarealist - 01-04-06 17:42 
----------------------------------------------------------------------
I added /etc/asound.state and /proc/asound/card0/codec97#0/*
during playing a 5.1 DVD with xine configured as pass through.

Maybe you wanna see iecset?

idefix:/usr/src # iecset
Mode: consumer
Data: non-audio
Rate: 48000 Hz
Copyright: permitted
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
