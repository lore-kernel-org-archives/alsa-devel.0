From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000628]: Can't record audio
Date: Tue, 9 Nov 2004 15:28:53 +0100
Message-ID: <109a784cc4bb9ba94f035ea071cc6c84@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C7D69241
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 15:28:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=628> 
======================================================================
Reported By:                pawlik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   628
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-03-2004 18:46 CET
Last Modified:              11-09-2004 15:28 CET
======================================================================
Summary:                    Can't record audio
Description: 
I'm not able to record any audio. Reading from /dev/dsp results in an
"Input/Output Error".
The hardware I'm using is Soltek 75DRV5 with built-in soundcard.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 15:28 
----------------------------------------------------------------------
Make sure that you choose 'Line1' for the "Input Source Select".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-03-04 18:46 pawlik         New Issue                                    
11-03-04 18:46 pawlik         Distribution              => Debian          
11-03-04 18:46 pawlik         Kernel Version            => 2.6.8.1         
11-09-04 15:28 tiwai          Note Added: 0002323                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
