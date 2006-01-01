From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001100]: Driver loaded, no sound card detected
Date: Sun, 1 Jan 2006 19:04:27 +0100
Message-ID: <d6e9cadcf06c3792050d6a138437d943@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07895154
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2006 19:04:27 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1100> 
======================================================================
Reported By:                dwatters
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1100
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.8-14.24
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-11-2005 15:51 CEST
Last Modified:              01-01-2006 19:04 CET
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
 rlrevell - 12-31-05 00:09 
----------------------------------------------------------------------
Any improvement in later releases?

----------------------------------------------------------------------
 kaasgaard - 01-01-06 11:24 
----------------------------------------------------------------------
indeed there is, i have a working system now, with the following:

alsa: 1.0.10
kernel: kernel-2.6.14-1.1800_FC5
distro: fedora core 4.90 (pre 5)
mb: shuttle FN25

<pre>
# cat /proc/asound/cards
0 [SN25P          ]: ICE1724 - Shuttle SN25P
                     Shuttle SN25P at 0xa000, irq 50


# lspci -d 1412:1724 -nvx
05:06.0 0401: 1412:1724 (rev 01)
        Subsystem: 1297:5036
        Flags: bus master, medium devsel, latency 32, IRQ 50
        I/O ports at a000 [size=32]
        I/O ports at a400 [size=128]
        Capabilities: [80] Power Management version 1
00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
10: 01 a0 00 00 01 a4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 97 12 36 50
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 01 00 00

</pre>

whoever fixed this thanks a bundle

// Kaasgaard

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-05 15:51 dwatters       New Issue                                    
05-11-05 15:51 dwatters       Distribution              => SuSE Linux 9.2  
05-11-05 15:51 dwatters       Kernel Version            => 2.6.8-14.24     
05-11-05 15:53 dwatters       Note Added: 0004637                          
06-15-05 20:35 kaasgaard      Note Added: 0005043                          
06-15-05 20:36 kaasgaard      Note Added: 0005044                          
12-31-05 00:09 rlrevell       Note Added: 0007309                          
01-01-06 11:24 kaasgaard      Note Added: 0007364                          
01-01-06 19:04 rlrevell       Status                   new => resolved     
01-01-06 19:04 rlrevell       Resolution               open => fixed       
01-01-06 19:04 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
