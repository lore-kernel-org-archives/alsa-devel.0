From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001036]: Replacement SB Live card not detected
Date: Fri, 30 Dec 2005 04:22:21 +0100
Message-ID: <da3234e9d2b2ba71b73da44df3eb2487@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6C50E1A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:22:21 +0100 (MET)
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
Last Modified:              12-30-2005 04:22 CET
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
 pzad - 04-05-05 10:20 
----------------------------------------------------------------------
This can by sb live (c) 2003 with STAC9758. Some older alsa versions had
bug for this card - card was sillent. And proper support was added in alsa
1.0.5.

kernel 2.6.3 contains old alsa. Try to upgrade to never alsa.

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:22 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-05 02:10 grolschie      New Issue                                    
04-05-05 02:10 grolschie      Distribution              => Debian          
04-05-05 02:10 grolschie      Kernel Version            => 2.6.3           
04-05-05 02:12 grolschie      Note Added: 0004333                          
04-05-05 08:30 pzad           Note Added: 0004334                          
04-05-05 08:55 grolschie      Note Added: 0004335                          
04-05-05 10:20 pzad           Note Added: 0004336                          
12-30-05 04:22 rlrevell       Note Added: 0007205                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
