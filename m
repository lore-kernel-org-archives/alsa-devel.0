From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000800]: Sound is Corrupted or terribe quality.
Date: Tue, 24 May 2005 14:12:24 +0200
Message-ID: <4beeea443470e4529f395a728d73679b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 166E01E3
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 14:12:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=800> 
======================================================================
Reported By:                abonilla
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   800
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             01-10-2005 03:20 CET
Last Modified:              05-24-2005 14:12 CEST
======================================================================
Summary:                    Sound is Corrupted or terribe quality.
Description: 
Sound goes out just like if the jack was not propperly plugged. bad Sound
Quality.
======================================================================

----------------------------------------------------------------------
 jdthood - 05-24-05 13:37 
----------------------------------------------------------------------
The submitter of Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=299459 installed
1.0.9rc2-1 modules but
the "rustling" persists.  The submitter provides a recording of the
rustling in an mp3 file.



----------------------------------------------------------------------
 tiwai - 05-24-05 14:12 
----------------------------------------------------------------------
1.0.9rc4 has a module option "position_fix".  Set 1 or 2 to this option if
the default doesn't work properly.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 03:20 abonilla       New Issue                                    
01-10-05 03:20 abonilla       Distribution              => Debian          
01-10-05 03:20 abonilla       Kernel Version            => 2.6.9           
01-10-05 14:56 tiwai          Note Added: 0003134                          
03-16-05 13:27 jdthood        Note Added: 0003956                          
03-18-05 18:23 tiwai          Note Added: 0004003                          
03-18-05 23:35 allefant       Issue Monitored: allefant                    
03-18-05 23:36 allefant       Issue End Monitor: allefant                    
03-19-05 12:42 jdthood        Note Added: 0004036                          
05-24-05 13:37 jdthood        Note Added: 0004725                          
05-24-05 13:37 jdthood        Note Edited: 0004725                         
05-24-05 14:12 tiwai          Note Added: 0004728                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
