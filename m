From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001335]: No sound on first probe
Date: Fri, 6 Jan 2006 19:10:45 +0100
Message-ID: <49589fa36b5b80b80e42aca65016a88c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4A9A12C
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 19:10:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1335> 
======================================================================
Reported By:                cpx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1335
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             08-14-2005 08:31 CEST
Last Modified:              01-06-2006 19:10 CET
======================================================================
Summary:                    No sound on first probe
Description: 
The first probe of the snd-via82xx module results in no sound from the
speakers/headphone jack. Removing the module and reloading it fixes the
problem. Upon reloading (sometimes when removing) a small bit of feedback
is audible (i.e. suggesting the hardware's been "initialized").

The module seems to have to be removed for it to work though... just
rebooting and having it reload the module that way doesn't work.

After performing the above to make it work the system can then be warm
booted with the sound continuing to work until powering off.
======================================================================

----------------------------------------------------------------------
 cpx - 01-06-06 19:10 
----------------------------------------------------------------------
So... this is still happening with the latest kernel, only sometime around
2.6.14 the rmmod trick stop working. Now I have to boot to winders first
to get the hardware initialized.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 08:31 cpx            New Issue                                    
08-14-05 08:31 cpx            Distribution              => Slackware 10.0  
08-14-05 08:31 cpx            Kernel Version            => 2.6.13-rc6      
01-06-06 19:10 cpx            Note Added: 0007493                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
