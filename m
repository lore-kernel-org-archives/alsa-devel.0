From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001011]: ALSA doesnt sense connected headphones
Date: Thu, 12 Jan 2006 04:21:52 +0100
Message-ID: <5435a55fd39fdac36a92ea0773efac9f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 59953156
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2006 04:21:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1011> 
======================================================================
Reported By:                rmrfchik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1011
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.10-1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-24-2005 17:13 CET
Last Modified:              01-12-2006 04:21 CET
======================================================================
Summary:                    ALSA doesnt sense connected headphones
Description: 
I have: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
with Realek ALC850 chipset (motherboard gigabyte 8ig1000G Pro).
When connecting headphones to line out (or other any output), I hear line
output (not apmlified).
I think, output to headphone must be amplified.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-24-05 19:43 
----------------------------------------------------------------------
Attach the content of /proc/asound/card0/codec97#0/* files.

Check the register 0x7a in /proc/asound/card0/codec97#0/ac97#0-0+regs.
How are the bits 6 and 7?  According to the datasheet, bit 7 corresponds
to the Front-out amplifier control.

When the driver is compiled with CONFIG_SND_DEBUG=y, you can edit the
register value via this proc file, like

    # echo 7a 2092 > /proc/asound/card0/codec97#0/ac97#0-0+regs

----------------------------------------------------------------------
 rlrevell - 01-12-06 04:21 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 17:13 rmrfchik       New Issue                                    
03-24-05 17:13 rmrfchik       Distribution              => Debian          
03-24-05 17:13 rmrfchik       Kernel Version            => 2.6.10-1        
03-24-05 19:43 tiwai          Note Added: 0004195                          
01-12-06 04:21 rlrevell       Status                   new => closed       
01-12-06 04:21 rlrevell       Note Added: 0007580                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
