From: noreply@alsa-project.org
Subject: [ALSA - driver 0000245]: Intel 82801DB (ICH4) AC'97 broken in Linux kernel 2.6.5 and above.
Date: Fri, 16 Jul 2004 12:51:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105128.2D03D26005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2992255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:51:28 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000245
======================================================================
Reported By:                mooky
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     245
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.6
======================================================================
Date Submitted:             04-28-2004 22:03 CEST
Last Modified:              07-16-2004 12:51 CEST
======================================================================
Summary:                    Intel 82801DB (ICH4) AC'97 broken in Linux kernel 2.6.5 and above.
Description: 
I had AlSA working in kernel 2.6.3 and 2.6.4, but sometime after 2.6.4 it
broke.   Even the most recent 2.6.6rc3, sound is broken.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-30-2004 10:37 CEST 
----------------------------------------------------------------------
make sure that intel8x0m (modem) module is not loaded via hotplug.
hotplug tends to load it automatically, and it breaks the preferred
order of modules.

you can avoid hotplugging of intel8x0m by adding snd-intel8x0m
and snd_intel8x0m to /etc/hotplug/blacklist.  the file may be dependent
on the distribution.

----------------------------------------------------------------------
 mooky - 05-01-2004 10:03 CEST 
----------------------------------------------------------------------
Fixed.  The exclusion name is actually:     snd-intel8x0m

Is this a bug known kernel bug?  I hope they get that fixed sometime, oh
well, it's unbroken now. Cheers.

edited on: 05-01-04 10:03

----------------------------------------------------------------------
 tiwai - 05-01-2004 10:30 CEST 
----------------------------------------------------------------------
sorry, i added mistakenly a wrong reply (deleted now).

this the problem of hotplug, not of the kernel nor the ALSA.
the hotplug must be fixed.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-28-04 22:03 mooky          New Bug                                      
04-28-04 22:03 mooky          Distribution              => Slackware       
04-28-04 22:03 mooky          Kernel Version            => 2.6             
04-30-04 10:37 tiwai          Bugnote Added: 0000971                       
05-01-04 10:02 mooky          Bugnote Added: 0000990                       
05-01-04 10:03 mooky          Bugnote Edited: 0000990                      
05-01-04 10:28 tiwai          Bugnote Added: 0000991                       
05-01-04 10:29 tiwai          Bugnote Deleted: 0000991                     
05-01-04 10:30 tiwai          Bugnote Added: 0000992                       
05-01-04 10:30 tiwai          Assigned To               => tiwai           
05-01-04 10:30 tiwai          Resolution               open => fixed       
05-01-04 10:30 tiwai          Status                   new => resolved     
07-16-04 12:51 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
