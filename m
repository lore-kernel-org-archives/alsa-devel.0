From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000959]: After S3 resume: ali_stimer_read: stimer is not ready
Date: Wed, 14 Dec 2005 17:38:43 +0100
Message-ID: <8c2210130746676418160136b9bd8ff7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C3A7E191
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 17:38:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=959> 
======================================================================
Reported By:                avuton
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   959
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-03-2005 18:41 CET
Last Modified:              12-14-2005 17:38 CET
======================================================================
Summary:                    After S3 resume: ali_stimer_read: stimer is not
ready
Description: 
After S3 resume, 'ali_stimer_read: stimer is not ready.' repeats until I
reset/power down the computer.

Workaround is to stop all audio activity and unload the driver, which
works fine.

This happens on my Libretto L5.
======================================================================

----------------------------------------------------------------------
 avuton - 07-08-05 22:48 
----------------------------------------------------------------------
I'm very sorry, but this machine cannot use APM due to it not being
equipped for it (it has no bios). And acpi=off would work but then I
wouldn't be able to suspend any longer thus defeating the purpose of this
bug :).

Thanks, anything else I can do please let me know.

----------------------------------------------------------------------
 sluskyb - 12-14-05 17:38 
----------------------------------------------------------------------
Looks like the "stimer is not ready" messages repeat for only about two and
a half minutes, and then I get my laptop back. (Tested on my Libretto L5
w/2.6.15-rc5.) Sound doesn't work after that until I unload and reload the
module.

The hangcheck timer throws out a few backtraces -- see dmesg output in
attached ali5451-S3.txt.

Using a CVS tree from November 18th, the "stimer is not ready" messages
come faster, and the total delay is only a few seconds, but still sound
doesn't work as described above. I'll try 1.0.11-rc1 tonight...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-05 18:41 avuton         New Issue                                    
03-03-05 18:41 avuton         Distribution              => Gentoo          
03-03-05 18:41 avuton         Kernel Version            => 2.6.11          
05-02-05 02:22 avuton         Note Added: 0004583                          
06-27-05 03:52 avuton         Note Added: 0005270                          
07-08-05 14:59 tiwai          Note Added: 0005431                          
07-08-05 22:48 avuton         Note Added: 0005436                          
12-14-05 17:28 sluskyb        File Added: ali5451-S3.txt                    
12-14-05 17:38 sluskyb        Note Added: 0007038                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
