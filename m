From: noreply@alsa-project.org
Subject: [ALSA - driver 0000278]: Gameport/joystick on Soundblaster AWE64 VE
Date: Fri, 16 Jul 2004 12:48:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104847.4D0BE26005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 853BB255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:48:47 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000278
======================================================================
Reported By:                Diskdoc
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     278
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             gentoo-sources-2.4.25-r2
======================================================================
Date Submitted:             05-15-2004 17:30 CEST
Last Modified:              07-16-2004 12:48 CEST
======================================================================
Summary:                    Gameport/joystick on Soundblaster AWE64 VE
Description: 
Apparently there is no joystick option for the snd-sbawe driver. As I have
a gameport on the card, it would be nice if it worked..
======================================================================

----------------------------------------------------------------------
 tiwai - 05-15-2004 17:34 CEST 
----------------------------------------------------------------------
joystick support of ISA board is independent from the sound driver.
see alsa-kernel/Documentation/Joystick.txt.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-15-04 17:30 Diskdoc        New Bug                                      
05-15-04 17:30 Diskdoc        Distribution              => Gentoo Linux    
05-15-04 17:30 Diskdoc        Kernel Version            => gentoo-sources-2.4.25-r2
05-15-04 17:34 tiwai          Bugnote Added: 0001126                       
05-15-04 17:34 tiwai          Assigned To               => tiwai           
05-15-04 17:34 tiwai          Resolution               open => not a bug   
05-15-04 17:34 tiwai          Status                   new => resolved     
07-16-04 12:48 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
