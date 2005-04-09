From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001040]: ice1724: Invalid EEPROM (size = 255)
Date: Sat, 9 Apr 2005 19:09:10 +0200
Message-ID: <4f0c6c6abd133922f9cb5257c68e262c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A268825F
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 19:09:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1040> 
======================================================================
Reported By:                lorenb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1040
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-08-2005 14:10 CEST
Last Modified:              04-09-2005 19:09 CEST
======================================================================
Summary:                    ice1724: Invalid EEPROM (size = 255)
Description: 
Have a Shuttle SN25P based system:
http://global.shuttle.com/Product/Barebone/SN25P.asp

It comes with VIA Envy24PT audio controller:
http://www.via.com.tw/en/products/audio/controllers/envy24pt/

Every time I tried and load the ice1724 driver I get an error about
invalid EEPROM size.

I saw this old bug:
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000142

Which indicated this issue was resolved in 1.0.5a.  I'm using v1.0.9rc2.

======================================================================

----------------------------------------------------------------------
 ungod - 04-09-05 19:09 
----------------------------------------------------------------------
I don't see how bug 0000142 should indicate that your bug was fixed in
ealier version of ALSA.
ALSA simply doesn't know your card (No matching model found for ID
0x97123650), and unlike AC97 cards, ICE1724 cards does not nessesarily
work the same way. The ICE1724 chip only does digital audio and PCI stuff.
Analogue I/O and often SPDIF stuff is done by external chips through I/O
pins on the chip and either the AC97 or I2S interface, but since there is
no bulletproof way to detect what chips are located where, there must be
written specific driver code for each ICE1724 sound card on the market.

So, in your case, the solution (if any) will be to identify all relevant
chips on the card, and figure out how they are interconnected, and then
hopefully it will be possible to make the nessesary adjustments to the
ICE1724 driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-08-05 14:10 lorenb         New Issue                                    
04-08-05 14:10 lorenb         Distribution              => Gentoo          
04-08-05 14:10 lorenb         Kernel Version            => 2.6.11          
04-09-05 19:09 ungod          Note Added: 0004427                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
