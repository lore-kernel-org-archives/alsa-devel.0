From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001757]: compilation breaks on hwdep.c
Date: Mon, 16 Jan 2006 23:27:31 +0100
Message-ID: <4ca4e03c52b36aad409b55dc44d4d35d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EDD92152
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2006 23:27:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1757> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1757
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.15-git8
======================================================================
Date Submitted:             01-16-2006 23:27 CET
Last Modified:              01-16-2006 23:27 CET
======================================================================
Summary:                    compilation breaks on hwdep.c
Description: 

CC [M]  /home/henne/alsa/test/alsa-driver-1.0.11rc2/acore/hwdep.o
In file included from
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/adriver.h:776,
                 from
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/sound/driver.h:47,
                 from
/home/henne/alsa/test/alsa-driver-1.0.11rc2/acore/hwdep.c:22:
include/linux/pci.h:461: error: syntax error before numeric constant
In file included from
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/sound/driver.h:47,
                 from
/home/henne/alsa/test/alsa-driver-1.0.11rc2/acore/hwdep.c:22:
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/adriver.h: In function
&#8216;snd_pci_orig_save_state&#8217;:
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/adriver.h:1017: error:
too many arguments to function &#8216;pci_save_state&#8217;
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/adriver.h: In function
&#8216;snd_pci_orig_restore_state&#8217;:
/home/henne/alsa/test/alsa-driver-1.0.11rc2/include/adriver.h:1021: error:
too many arguments to function &#8216;pci_restore_state&#8217;

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-16-06 23:27 Henne          New Issue                                    
01-16-06 23:27 Henne          Distribution              => Suse 10.0 x86_64
01-16-06 23:27 Henne          Kernel Version            => 2.6.15-git8     
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
