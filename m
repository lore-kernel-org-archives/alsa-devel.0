From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000464]: Right Channel always +6dB Louder than Left Channel while recording in Stereo
Date: Sun, 31 Oct 2004 04:06:24 +0100
Message-ID: <89b31b2767673c40c572c926504c9367@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 65DD72C8
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2004 04:06:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=464> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   464
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mandrake Linux
Kernel Version:             2.4.19-16mdk
======================================================================
Date Submitted:             08-26-2004 07:48 CEST
Last Modified:              10-31-2004 04:06 CET
======================================================================
Summary:                    Right Channel always +6dB Louder than Left Channel
while recording in Stereo
Description: 
The sound card is Turtle Beach Santa Cruz (CS4630). When trying to record
from any stereo source (Line In, Aux, CDROM, Mix) the right channel is
always +6dB louder than left channel. This happens with arecord, mencoder,
audacity, or any program that can record audio. Recording in mono works
perfectly.


======================================================================

----------------------------------------------------------------------
 Electro - 10-31-04 04:06 
----------------------------------------------------------------------
I fixed it. The ADC mixer have to be 100% for both channels. Then change
the capture mixer to set the volume of the capture. Anything below 100%
for both channels of the ADC mixer will have the problem that I mentioned.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 07:48 Electro        New Issue                                    
08-26-04 07:48 Electro        Distribution              => Mandrake Linux  
08-26-04 07:48 Electro        Kernel Version            => 2.4.19-16mdk    
10-31-04 04:06 Electro        Note Added: 0002291                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
