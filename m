From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001036]: Replacement SB Live card not detected
Date: Tue, 5 Apr 2005 08:30:42 +0200
Message-ID: <de8630f4da4d36517eb96c2d46697b92@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E4301E2
	for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2005 08:30:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1036> 
======================================================================
Reported By:                grolschie
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1036
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.3
======================================================================
Date Submitted:             04-05-2005 02:10 CEST
Last Modified:              04-05-2005 08:30 CEST
======================================================================
Summary:                    Replacement SB Live card not detected
Description: 
Hi there.

I have been using my SB Live Value PCI for over a year with ALSA with no
problems. I recently swapped the card for a newer SB Live 5.1 DE PCI card.
Even though these cards are pretty much the same, alsaconf cannot detect
any supported sound cards. lspci shows that the new card is indeed
detected.

Regards,
grolschie
======================================================================

----------------------------------------------------------------------
 grolschie - 04-05-05 02:12 
----------------------------------------------------------------------
I dual boot Linux with a certain W32 OS ;) and the card is indeed working
on that OS, just not with ALSA.

----------------------------------------------------------------------
 pzad - 04-05-05 08:30 
----------------------------------------------------------------------
What is output from 
lspci -n

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-05 02:10 grolschie      New Issue                                    
04-05-05 02:10 grolschie      Distribution              => Debian          
04-05-05 02:10 grolschie      Kernel Version            => 2.6.3           
04-05-05 02:12 grolschie      Note Added: 0004333                          
04-05-05 08:30 pzad           Note Added: 0004334                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
