From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001011]: ALSA doesnt sense connected headphones
Date: Thu, 24 Mar 2005 19:43:16 +0100
Message-ID: <57673b1b1928be93814758b33118cae1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5528264
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 19:43:16 +0100 (MET)
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
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.10-1
======================================================================
Date Submitted:             03-24-2005 17:13 CET
Last Modified:              03-24-2005 19:43 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 17:13 rmrfchik       New Issue                                    
03-24-05 17:13 rmrfchik       Distribution              => Debian          
03-24-05 17:13 rmrfchik       Kernel Version            => 2.6.10-1        
03-24-05 19:43 tiwai          Note Added: 0004195                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
