From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000507]: Soundcard cannot play more than one thing at a time (but Stereo!)
Date: Tue, 9 Nov 2004 16:33:45 +0100
Message-ID: <91dcbdfc9bde75b4fe78a91e9126bc1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5D64F2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:33:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=507> 
======================================================================
Reported By:                DashX
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   507
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.8-1.521
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-19-2004 17:34 CEST
Last Modified:              11-09-2004 16:33 CET
======================================================================
Summary:                    Soundcard cannot play more than one thing at a time
(but Stereo!)
Description: 
Sound Card:   SoundMAX Integrated Digital Audio
HWBrowser says 82801DB (ICH4) AC'97 Audio Controller

2x xmms with esound = works
2x xmms with alsa = doesent work because of audio device in use.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-20-04 17:38 
----------------------------------------------------------------------
This hardware doesn't support multiple PCM streams (h/w mixing).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 17:34 DashX          New Issue                                    
09-19-04 17:34 DashX          Distribution              => Fedora Core 2   
09-19-04 17:34 DashX          Kernel Version            => 2.6.8-1.521     
09-19-04 17:36 DashX          Issue Monitored: DashX                       
09-20-04 17:38 tiwai          Status                   assigned => resolved
09-20-04 17:38 tiwai          Resolution               open => not an issue
09-20-04 17:38 tiwai          Note Added: 0001788                          
11-09-04 16:33 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
