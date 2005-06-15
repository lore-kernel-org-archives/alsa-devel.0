From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001100]: Driver loaded, no sound card detected
Date: Wed, 15 Jun 2005 20:36:35 +0200
Message-ID: <8c1999ebb646ce2698717704814f8727@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 809031FA
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 20:36:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1100> 
======================================================================
Reported By:                dwatters
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1100
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.8-14.24
======================================================================
Date Submitted:             05-11-2005 15:51 CEST
Last Modified:              06-15-2005 20:36 CEST
======================================================================
Summary:                    Driver loaded, no sound card detected
Description: 
In /var/log/message gives:
May 11 10:30:43 miro kernel: ACPI: PCI interrupt 0000:05:06.0[A] -> GSI 5
(level, low) -> IRQ 5
May 11 10:30:43 miro kernel: ice1724: No matching model found for ID
0x97123650
May 11 10:30:43 miro kernel: ice1724: Invalid EEPROM (size = 255)
May 11 10:30:43 miro kernel: ICE1724: probe of 0000:05:06.0 failed with
error -5


======================================================================

----------------------------------------------------------------------
 kaasgaard - 06-15-05 20:35 
----------------------------------------------------------------------
I get the exact same error:
Jun 14 16:50:42 home kernel: ice1724: No matching model found for ID
0x97123650
Jun 14 16:50:42 home kernel: ice1724: Invalid EEPROM (size = 255)
Jun 14 16:50:42 home kernel: ICE1724: probe of 0000:05:06.0 failed with
error -5

alsa: 1.0.9
kernel: 2.6.11-1.1369_FC
distro: fedora core 4
mb: shuttle FN25
reproducibility: always

# cat /proc/asound/cards
--- no soundcards ---

Hope someone can figure it out

thx

// Kaasgaard

----------------------------------------------------------------------
 kaasgaard - 06-15-05 20:36 
----------------------------------------------------------------------
forgot to mention:

lspci -d 1412:1724 -nvx:

05:06.0 Class 0401: 1412:1724 (rev 01)
        Subsystem: 1297:5036
        Flags: medium devsel, IRQ 50
        I/O ports at a000 [size=32]
        I/O ports at a400 [size=128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 01 00 10 02 01 00 01 04 00 20 00 00
10: 01 a0 00 00 01 a4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 97 12 36 50
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 01 00 00

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 15:51 dwatters       New Issue                                    
05-11-05 15:51 dwatters       Distribution              => SuSE Linux 9.2  
05-11-05 15:51 dwatters       Kernel Version            => 2.6.8-14.24     
05-11-05 15:53 dwatters       Note Added: 0004637                          
06-15-05 20:35 kaasgaard      Note Added: 0005043                          
06-15-05 20:36 kaasgaard      Note Added: 0005044                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
