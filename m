From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000448]: System hangs up
Date: Mon,  6 Sep 2004 18:25:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040906162524.1314B28006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AEEA8279
	for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2004 18:25:32 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000448
======================================================================
Reported By:                zadnica
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     448
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-17-2004 13:02 CEST
Last Modified:              09-06-2004 18:25 CEST
======================================================================
Summary:                    System hangs up
Description: 
Systems hangs up, when modules snd-via82xx is loaded. When I using OSS
module via82cxxx_audio everything works fine.
======================================================================

----------------------------------------------------------------------
 sventura - 08-22-2004 09:51 CEST 
----------------------------------------------------------------------
same crash on vaio pcg-fxa78 VT/82C686 AC97
havent tried propoused "via82cxxx_audio" preload workaround
verified in ver: from 0.9.2 to 1.0.5a
native 2.4 kernel oss support works ok, so I compared initialization
sequences
and made this (attached) quick patch-module workaround. It's not a final
solution but provides a close idea as of what is missing in current code
initialization sequence.

----------------------------------------------------------------------
 tiwai - 08-23-2004 14:59 CEST 
----------------------------------------------------------------------
Does the attached patch fix?

----------------------------------------------------------------------
 sventura - 09-06-2004 18:25 CEST 
----------------------------------------------------------------------
propuosed patch doesnt work for me for the following reason:

(Notice: only SB is required to be disabled)

SB is disabled at snd_via8233_init_misc, but it still crashes at
snd_via82xx_create when requesting IRQ. So SB disable must happend before
that.

Additionally, chip->old_legacy must be SB masked ( chip->old_legacy ~=
VIA_FUNC_ENABLE_SB; ) as well, otherwise, it still crashes at
snd_via686_init_misc (in my case, sin I have 686 type card) when putting
back old legacy port settings saved in chip->old_legacy.

so, what works for me is add:
 chip->old_legacy &= ~VIA_FUNC_ENABLE_SB; //fixes bug id=448
 pci_write_config_byte(pci, VIA_FUNC_ENABLE, chip->old_legacy);
at snd_via82xx_create before (this is important) request_irq call.

Im still confused about the following:

If I enter bios before booting, it seems to initize everything and crash
doesnt happen. Yet VIA_FUNC_ENABLE port reads the same either way, so I
think BIOS initializes something else and disabling SB is just a quick fix
but REAL problem may be deeper inside.

Any specs around?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-17-04 13:02 zadnica        New Bug                                      
08-22-04 09:51 sventura       Bugnote Added: 0001607                       
08-22-04 09:52 sventura       File Added: myvia82xx.tar.gz                    
08-23-04 14:59 tiwai          Bugnote Added: 0001611                       
08-23-04 14:59 tiwai          File Added: via-crash-fix.dif                    
09-06-04 18:25 sventura       Bugnote Added: 0001700                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
