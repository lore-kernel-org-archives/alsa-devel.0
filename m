From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001803]: hda-intel on my amilo fujitsu laptop dont produces any sound
Date: Thu, 2 Feb 2006 10:11:16 +0100
Message-ID: <850c8ff84e0fb984adc567fde9cec26d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10C211BB
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2006 10:11:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1803> 
======================================================================
Reported By:                DjCoke
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1803
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r1
======================================================================
Date Submitted:             01-31-2006 23:30 CET
Last Modified:              02-02-2006 10:11 CET
======================================================================
Summary:                    hda-intel on my amilo fujitsu laptop dont produces
any sound
Description: 
driver don't procuce any sound at all.


I have a amilo fujitsu laptop.
======================================================================

----------------------------------------------------------------------
 DjCoke - 02-01-06 19:13 
----------------------------------------------------------------------
Fixed ;)

I've tried several things now and it just worked...

with option=6stack position_fix=3
But i dont have other sound ports then the micplug and earplug so i dont
understand why it works now but it works and very loud ;) forgotten to
lower the volume hehe

Btw i can get it only work when im root, so thats permission issue i
suppose

----------------------------------------------------------------------
 ash - 02-02-06 10:11 
----------------------------------------------------------------------
Yup, the permissions thing is nothing to do with ALSA.
Create a user group and called it 'audio' for example. Assign all the
users to that group who are to have audio access. Then chgrp your device
files to group 'audio'.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 23:30 DjCoke         New Issue                                    
01-31-06 23:30 DjCoke         Distribution              => Gentoo          
01-31-06 23:30 DjCoke         Kernel Version            => 2.6.15-gentoo-r1
01-31-06 23:32 DjCoke         Issue Monitored: DjCoke                      
01-31-06 23:34 DjCoke         Note Added: 0007856                          
02-01-06 18:27 DjCoke         Note Added: 0007862                          
02-01-06 19:13 DjCoke         Note Added: 0007863                          
02-02-06 10:11 ash            Note Added: 0007873                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
