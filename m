From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001326]: ISAPNP cards (opl3sa2 in particular) are not detected properly on 2.6 kernels
Date: Fri, 12 Aug 2005 09:29:04 +0200
Message-ID: <39f34af17da56fa2e8b2acac9519a0ec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0969B168
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2005 09:29:04 +0200 (MEST)
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
Last Modified:              08-12-2005 09:29 CEST
======================================================================
Summary:                    ISAPNP cards (opl3sa2 in particular) are not
detected properly on 2.6 kernels
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
 ahaning - 08-12-05 03:09 
----------------------------------------------------------------------
Well, I've fiddled with this a bit more. After fixing the dma1 and dma2
entries, I can set the IRQ to 5, 7, or 11 in /etc/modprobe.conf and the
OPL3SA2 driver is loaded.

Currently, I have the BIOS settings set to the default IRQ=11, DMA1=0,
DMA2=1 like before. I've fixed dma1= and dma2= in /etc/modprobe.conf and
if irq= is set to 5, 7, or 11, sound works (I just have to touch the PCM
mixer while playing...).

Here's my /proc/dma entry as alsaconf detects it and after I fix it so
sound sort of works. Maybe it's helpful?

Detected by alsaconf:
# cat /proc/dma
 0: CS4231 - 2
 1: CS4231 - 1
 4: cascade
#

Fixed by me so things kinda work:
# cat /proc/dma
 0: CS4231 - 1
 1: CS4231 - 2
 4: cascade
#

Here is /sys/module/snd_opl3sa2/parameters/dma1 and
/sys/module/snd_opl3sa2/parameters/dma2 before and after:

dma1 before:
# cat /sys/module/snd_opl3sa2/parameters/dma1
1,65535,65535,65535,65535,65535,65535,65535

dma2 before:
# cat /sys/module/snd_opl3sa2/parameters/dma2
0,65535,65535,65535,65535,65535,65535,65535

dma1 after:
# cat /sys/module/snd_opl3sa2/parameters/dma1
0,65535,65535,65535,65535,65535,65535,65535

dma2 after:
# cat /sys/module/snd_opl3sa2/parameters/dma2
1,65535,65535,65535,65535,65535,65535,65535

Anyway. FWIW.

Thanks.

----------------------------------------------------------------------
 perex - 08-12-05 09:29 
----------------------------------------------------------------------
The NMX devices are probably not related. Yamaha has YMF prefix.

So, the IRQ can be selected without any problem, but the DMA configuration
must be forced to one combination otherwise it does not work?

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
