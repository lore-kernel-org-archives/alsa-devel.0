From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000972]: No sound after install...
Date: Tue, 15 Mar 2005 01:21:09 +0100
Message-ID: <08098f7cf22108941182a7e6ad5a589e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1D9A71BA
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2005 01:21:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=972> 
======================================================================
Reported By:                rbechard1
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   972
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-08-2005 02:00 CET
Last Modified:              03-15-2005 01:21 CET
======================================================================
Summary:                    No sound after install...
Description: 
After following all of the install instructions included with the
documentation there is no sound from the sound card. The settings in
DiskDrake indicate that the sound card is using the correct driver and
alsaconf reconfigured it several times to no effect. I also check the
mixer outputs and nothing is muted.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-14-05 22:50 
----------------------------------------------------------------------
"I 'strongly" suggest that your webmaster should put the RPM packages on
your website for the various distributions, it would save your support
people alot of time!!!!!!!!!!!!!!!!!"

Incorrect.  Do you have any idea how much work it would be to make binary
packages for every distro?  There would be no time left for actual
development.

It is your distro's responsibility to provide reasonably up to date and
easily accessible ALSA binary packages.  If they are not doing it, you
need to get a better distro.

----------------------------------------------------------------------
 fmoraes - 03-15-05 01:21 
----------------------------------------------------------------------
User installed binary packages from Distro instead of compiling and the
problem was solved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 02:00 rbechard1      New Issue                                    
03-08-05 02:01 rbechard1      Issue Monitored: rbechard1                    
03-08-05 09:54 rbechard1      Note Added: 0003813                          
03-09-05 02:11 fmoraes        Note Added: 0003820                          
03-09-05 03:14 rbechard1      Note Added: 0003824                          
03-14-05 21:45 rbechard1      Note Added: 0003908                          
03-14-05 21:46 rbechard1      Issue End Monitor: rbechard1                    
03-14-05 22:50 rlrevell       Note Added: 0003909                          
03-15-05 01:21 fmoraes        Status                   assigned => closed  
03-15-05 01:21 fmoraes        Note Added: 0003911                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
