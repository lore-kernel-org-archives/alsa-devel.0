From: noreply@alsa-project.org
Subject: [ALSA - driver 0000351]: Too large I/O port region requested for gameport
Date: Fri, 16 Jul 2004 12:50:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105012.B103D26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28B2E255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:50:13 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000351
======================================================================
Reported By:                wiget
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     351
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               PLD Linux
Kernel Version:             2.6.6-0.28
======================================================================
Date Submitted:             06-30-2004 12:02 CEST
Last Modified:              07-16-2004 12:50 CEST
======================================================================
Summary:                    Too large I/O port region requested for gameport
Description: 
In me system gameport is available on 0x201, but on 0x208-0x20f I have "pnp
00:0b". In cmipci.c for gameport is reserved 8 ioports (0x200-0x208 or
0x201-0x209), but only first ioport is used by analog joystick driver
(gameport_read() from include/linux/gameport.h use inb() if gameport
driver doesn't define gameport->read()).
Attached patch change request_region() calls for gameport to reserve only
one ioport.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-30-2004 15:42 CEST 
----------------------------------------------------------------------
already applied to cvs.

thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 12:02 wiget          New Bug                                      
06-30-04 12:02 wiget          File Added: cmipci-joystick.patch                    
06-30-04 12:02 wiget          Distribution              => PLD Linux       
06-30-04 12:02 wiget          Kernel Version            => 2.6.6-0.28      
06-30-04 15:42 tiwai          Bugnote Added: 0001350                       
06-30-04 15:42 tiwai          Resolution               open => fixed       
06-30-04 15:42 tiwai          Status                   assigned => resolved
07-16-04 12:50 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
