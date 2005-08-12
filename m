From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001326]: ISA cards (opl3sa2 in particular) are not detected properly on 2.6 kernels
Date: Fri, 12 Aug 2005 15:56:51 +0200
Message-ID: <3b0bc0e2f78085d3f8c07bee63a3fa20@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B5E5C188
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 15:56:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1326> 
======================================================================
Reported By:                ahaning
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Issue ID:                   1326
Category:                   alsaconf
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             08-10-2005 03:39 CEST
Last Modified:              08-12-2005 15:56 CEST
======================================================================
Summary:                    ISA cards (opl3sa2 in particular) are not detected
properly on 2.6 kernels
Description: 
When brute-force detecting my OPL3SA2 card, the IRQ and DMA1/DMA2 settings
are incorrectly detected by alsaconf from alsa-utils. For example, the
default BIOS settings are IRQ=11, DMA1=0, DMA2=1, but alsaconf detects
IRQ=5, DMA1=1, DMA2=0. No matter the BIOS settings, alsaconf always
detects those settings (IRQ=5, DMA1=1, DMA2=0). If I set the BIOS settings
to that, then the card will make sound (after touching the mixer while
playing audio).

According to perex (author of the opl3sa2 driver):

"The alsaconf tries to gather free resources (irq/dma/ports) from the
/proc filesystem. It might be extended to gather this information also
from /sys filesystem."
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000879 (snd_)opl3sa2 (isa) doesn't work (fails...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-12-05 15:45 
----------------------------------------------------------------------
.. and do NOT define any module parameters in /etc/modprobe.conf or
whatever.  And do just "modprobe snd-opl3sa2".

----------------------------------------------------------------------
 perex - 08-12-05 15:56 
----------------------------------------------------------------------
takashi: See the previous bug (related to). The BIOS disables ISA PnP
feature of the opl3sa2 card. It is not visible with the ISA PnP subsystem
or pnpdump from the isapnptools package. So, it behaves like a legacy ISA
card.

ahaning: You have a driver provided by vendor for Windows, right? Then it
might do some magic which we don't know. Or you may try, if the driver
resources in windows follows the BIOS settings. Perhaps, you'll have
similar problems with non-default values.

The datasheet for your chip says that the ISA PnP subsystem should detect
the card even if it is configured in manual mode.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-10-05 03:39 ahaning        New Issue                                    
08-10-05 03:39 ahaning        Distribution              => Slackware 9.1 (but
it's not distribution-specific)
08-10-05 03:39 ahaning        Kernel Version            => 2.6.12.2        
08-10-05 13:26 perex          Status                   new => assigned     
08-10-05 13:26 perex          Assigned To               => perex           
08-10-05 13:26 perex          File Added: alsaconf                         
08-10-05 13:28 perex          Note Added: 0005747                          
08-10-05 13:29 perex          Project                  ALSA - driver => ALSA -
utils
08-10-05 13:30 perex          Relationship added       related to 0000879  
08-10-05 13:31 perex          Category                 1_OTHERS => alsaconf
08-10-05 14:55 ahaning        Note Added: 0005748                          
08-11-05 00:24 ahaning        Note Added: 0005752                          
08-11-05 23:59 ahaning        Note Added: 0005763                          
08-12-05 00:00 ahaning        Note Edited: 0005763                         
08-12-05 03:09 ahaning        Note Added: 0005764                          
08-12-05 09:29 perex          Note Added: 0005766                          
08-12-05 12:54 ahaning        Note Added: 0005767                          
08-12-05 15:11 perex          Summary                  ISAPNP cards (opl3sa2 in
particular) are not detected properly on 2.6 kernels => ISA cards (opl3sa2 in
particular) are not detected properly on 2.6 kernels
08-12-05 15:14 perex          Note Added: 0005768                          
08-12-05 15:35 tiwai          Note Added: 0005769                          
08-12-05 15:36 ahaning        Note Added: 0005770                          
08-12-05 15:44 tiwai          Note Added: 0005771                          
08-12-05 15:45 tiwai          Note Added: 0005772                          
08-12-05 15:56 perex          Note Added: 0005777                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
