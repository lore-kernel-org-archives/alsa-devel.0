From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001326]: ISA cards (opl3sa2 in particular) are not detected properly on 2.6 kernels
Date: Sat, 13 Aug 2005 19:06:09 +0200
Message-ID: <0a0eba4ec1dacec766d04e5612482737@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AE64C17E
	for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2005 19:06:09 +0200 (MEST)
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
Last Modified:              08-13-2005 19:06 CEST
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
 perex - 08-13-05 15:11 
----------------------------------------------------------------------
Could you also test the latest alsaconf (attached to this bug)? It should
detect your card as PnP, too.

----------------------------------------------------------------------
 ahaning - 08-13-05 19:06 
----------------------------------------------------------------------
When I got back to my machine and tried playing some audio, no sound was
being made. I tried turning the mixers up, mute/unmute while playing, and
still nothing.

I just tried a cold start and after loading the patched snd_opl3sa2
module, I get the following in dmesg:

pnp: the driver 'opl3sa2' has been registered
pnp: match found with the PnP device '00:05' and the driver 'opl3sa2'
ALSA /usr/src/alsa-1.0.9/alsa-driver-1.0.9b/alsa-kernel/isa/opl3sa2.c:609:
PnP manual resources are invalid, using auto config
pnp: the driver 'opl3sa2' has been registered
kobject_register failed for opl3sa2 (-17)
 [<c020bdf4>] kobject_register+0x44/0x70
 [<c0290417>] bus_add_driver+0x57/0xd0
 [<c025728f>] pnp_register_driver+0x3f/0x80
 [<c0256e14>] pnp_register_card_driver+0x64/0xb0
 [<c025728f>] pnp_register_driver+0x3f/0x80
 [<cc860816>] alsa_card_opl3sa2_init+0x46/0xb0 [snd_opl3sa2]
 [<c0135ac7>] sys_init_module+0x1f7/0x220
 [<c0103205>] syscall_call+0x7/0xb

But! I also get sound if I touch the PCM mixer (mute/unmute) while
playing!

If I try to remove the module with 'alsasound stop', I get an Oops!. I
also get an Oops! when I run the above alsaconf :-/.

The Oops'es don't lock up the machine, though, thankfully (my other
machine doesn't have serial) so I should be able to capture them
eventually. If/When I do, I'll edit them into this comment.

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
08-12-05 16:08 perex          Note Added: 0005778                          
08-12-05 16:44 ahaning        Note Added: 0005782                          
08-12-05 18:00 perex          File Added: opl3sa2.c.patch                    
08-12-05 18:03 perex          Note Added: 0005783                          
08-12-05 18:52 ahaning        Note Added: 0005787                          
08-13-05 15:10 perex          File Deleted: alsaconf                       
08-13-05 15:10 perex          File Added: alsaconf                         
08-13-05 15:11 perex          Note Added: 0005806                          
08-13-05 19:06 ahaning        Note Added: 0005808                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
