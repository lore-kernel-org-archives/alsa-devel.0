From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001705]: Unknown souncard ES1988 sound card. I similar as Allegro/Maestro03
Date: Wed, 4 Jan 2006 17:21:08 +0100
Message-ID: <4090fddfbd0d45afb90b2ee12f7fc93d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8081154
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:21:08 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1705> 
======================================================================
Reported By:                naith
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1705
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-03-2006 21:49 CET
Last Modified:              01-04-2006 17:21 CET
======================================================================
Summary:                    Unknown souncard ES1988 sound card. I similar as
Allegro/Maestro03
Description: 
checking for which soundcards to compile driver for... configure: error:
Unknown soundcard ES1988

!!! Please attach the config.log to your bug report:
!!!
/var/tmp/portage/alsa-driver-1.0.10_rc3/work/alsa-driver-1.0.10rc3/config.log

!!! ERROR: media-sound/alsa-driver-1.0.10_rc3 failed.
!!! Function econf, Line 485, Exitcode 0
!!! econf failed
!!! If you need support, post the topmost build error, NOT this status
message
======================================================================

----------------------------------------------------------------------
 tiwai - 01-04-06 17:21 
----------------------------------------------------------------------
You passed a wrong configure option.  Should be "--with-cards=maestro3".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-06 21:49 naith          New Issue                                    
01-03-06 21:49 naith          File Added: config.log                       
01-04-06 17:21 tiwai          Status                   assigned => resolved
01-04-06 17:21 tiwai          Resolution               open => not an issue
01-04-06 17:21 tiwai          Note Added: 0007437                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
