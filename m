From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000924]: crash in oss emulation's rate conversion
Date: Sat, 19 Feb 2005 12:02:16 +0100
Message-ID: <e96e8bdef665366362019c93ce360500@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0061D1C9
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 12:02:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=924> 
======================================================================
Reported By:                Benjamin Otte
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   924
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.6.9
======================================================================
Date Submitted:             02-19-2005 12:02 CET
Last Modified:              02-19-2005 12:02 CET
======================================================================
Summary:                    crash in oss emulation's rate conversion
Description: 
When running the attached code on my ibook, it crashes inside the kernel.
After that, /dev/dsp is reported as in use until I restart.
This is using OSS emulations with the snd-powermac driver.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-05 12:02 Benjamin Otte  New Issue                                    
02-19-05 12:02 Benjamin Otte  File Added: bug.c                            
02-19-05 12:02 Benjamin Otte  Distribution              => Debian unstable 
02-19-05 12:02 Benjamin Otte  Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
