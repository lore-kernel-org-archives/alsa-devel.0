From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001489]: Sound blocking.
Date: Sat, 28 Jan 2006 03:07:22 +0100
Message-ID: <6484445ceac6ef59cdbf6f872ef96eb0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFC851B1
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 03:07:22 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1489> 
======================================================================
Reported By:                nono31
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1489
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.11-2.6.14
======================================================================
Date Submitted:             10-21-2005 14:56 CEST
Last Modified:              01-28-2006 03:07 CET
======================================================================
Summary:                    Sound blocking.
Description: 
Onboard card is:

 VIA Technologies Inc. VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio
Controller (rev 01)

I can't have multi-channel working (not big deal for me, I'm not using).
I can't have 2 softwares accessing sound device...
This is very annoying, apps just block and need to be stop... sometimes
need to stop my desktop manager.
As skype have fame of having bad sound support, it is beeing worse when I
come to use it.
Another example: I'm playing music with xmms and at the same time I start
vmware... vmware will start without sound support... If I have vmware
running, and then play music with xmms, it will block sound device. So
vmware will complain each time it want to use sound...

Every information I got from internet shows that every user with my
configuration have this problem...

I don't know if it is a driver problem (i guess it is not configuration
problem as I did not have this problem with my SBLive and that everybody
seems to be in the same case as I am).

I have this problem on 2.6.11, 2.6.12, 2.6.13.2, 2.6.14-rc4


More information is just asking!

Thanks

Mathieu


======================================================================

----------------------------------------------------------------------
 nono31 - 01-28-06 03:07 
----------------------------------------------------------------------
This bug is fixed in 1.0.11rc2. thanks.
I'll still open a new bug about aoss skype blocking.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 14:56 nono31         New Issue                                    
10-21-05 14:56 nono31         Distribution              => Debian          
10-21-05 14:56 nono31         Kernel Version            => 2.6.11-2.6.14   
01-28-06 03:06 nono31         Issue Monitored: nono31                      
01-28-06 03:07 nono31         Note Added: 0007819                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
