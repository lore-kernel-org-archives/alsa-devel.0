From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000639]: Poor Audio Output
Date: Wed, 10 Nov 2004 05:02:28 +0100
Message-ID: <69f22cb92ecc18a1c93e490be4dc5920@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8EF82CB
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 05:02:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=639> 
======================================================================
Reported By:                gnif
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   639
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             Debian Kernel Image 2.6.7-1-686
======================================================================
Date Submitted:             11-10-2004 05:02 CET
Last Modified:              11-10-2004 05:02 CET
======================================================================
Summary:                    Poor Audio Output
Description: 
Card: ESS ES1978 (Maestro 2E)
Chip: SigmaTel STAC9721/23

During playback from any PCM source there is very poor audio output, I had
assumed that this was just intefearence from the HDD and other devices in
the laptop until I came across this: 

http://h20000.www2.hp.com/bizsupport/TechSupport/Document.jsp?locale=en_US&taskId=110&prodSeriesId=96235&prodTypeId=321957&objectID=PSD_PH020226_CW02

This makes me beleave that it is a problem with the driver as Compaq had
the same issue, I have tested this under windows and I have had no
crackling in the audio, so I am certain that it is the driver.

PS: I have used alsaconf to configure the sound, this worked out of the
box.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-04 05:02 gnif           New Issue                                    
11-10-04 05:02 gnif           Kernel Version            => Debian Kernel Image
2.6.7-1-686
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
