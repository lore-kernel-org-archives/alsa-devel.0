From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000496]: nearest-neighbor downsampling causes noise
Date: Tue, 9 Nov 2004 16:33:08 +0100
Message-ID: <d897926170e0e7a44513cd79449c2cd3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7C3F92B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:33:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=496> 
======================================================================
Reported By:                grabner
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   496
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-10-2004 22:06 CEST
Last Modified:              11-09-2004 16:33 CET
======================================================================
Summary:                    nearest-neighbor downsampling causes noise
Description: 
The rate-conversion plugin in ALSA-1.0.7rc1 uses the nearest-neighbor
method for downsampling (function snd_pcm_rate_shrink in
src/pcm/pcm_rate.c), which causes considerable noise.
======================================================================

----------------------------------------------------------------------
 grabner - 09-16-04 11:24 
----------------------------------------------------------------------
Ok, here is the required information:

-----
Summary: Fix the downsampling noise problem
 
Description: The patch replaces the nearest neighbor downsampling method
in the sample rate conversion plugin by linear interpolation of the
closest two samples, thus significantly reducing the resampling noise.
 
Signed-off-by: Markus Grabner <grabner@icg.tu-graz.ac.at>
-----

Regards,
Markus

edited on: 09-16-04 11:24

----------------------------------------------------------------------
 tiwai - 09-16-04 12:02 
----------------------------------------------------------------------
Thanks, applied to CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-10-04 22:06 grabner        New Issue                                    
09-10-04 22:06 grabner        File Added: downsample_interpolate.patch          
         
09-10-04 22:08 grabner        Issue Monitored: grabner                     
09-15-04 18:18 tiwai          Note Added: 0001763                          
09-16-04 11:24 grabner        Note Added: 0001768                          
09-16-04 11:24 grabner        Note Edited: 0001768                         
09-16-04 12:02 tiwai          Status                   new => resolved     
09-16-04 12:02 tiwai          Resolution               open => fixed       
09-16-04 12:02 tiwai          Assigned To               => tiwai           
09-16-04 12:02 tiwai          Note Added: 0001771                          
11-09-04 16:33 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
