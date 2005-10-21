From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001489]: Sound blocking.
Date: Fri, 21 Oct 2005 14:56:25 +0200
Message-ID: <283d06746442d9af26dfb911da277838@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89EC4157
	for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2005 14:56:25 +0200 (MEST)
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
Last Modified:              10-21-2005 14:56 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 14:56 nono31         New Issue                                    
10-21-05 14:56 nono31         Distribution              => Debian          
10-21-05 14:56 nono31         Kernel Version            => 2.6.11-2.6.14   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
