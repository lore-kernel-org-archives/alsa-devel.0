From: noreply@alsa-project.org
Subject: [ALSA - driver 0000208]: 1.0.4 snd-mpu401 fails
Date: Fri, 16 Jul 2004 12:51:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105159.3488426008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68182255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:51:59 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000208
======================================================================
Reported By:                hawklord
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     208
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.4.20
======================================================================
Date Submitted:             04-14-2004 02:57 CEST
Last Modified:              07-16-2004 12:51 CEST
======================================================================
Summary:                    1.0.4 snd-mpu401 fails
Description: 
Hi,
I use snd-mpu401 with snd-via82xx
in 1.0.4 snd-mpu401 fails to load - irq error
in 1.0.3 snd-mpu401 loads fine
builds / configuration identical
======================================================================

----------------------------------------------------------------------
 tiwai - 04-16-2004 11:57 CEST 
----------------------------------------------------------------------
snd-mpu401 on 1.0.4 includes the ACPI support.
try to remove module parameters of snd-mpu401 (except for index).

----------------------------------------------------------------------
 hawklord - 04-16-2004 20:16 CEST 
----------------------------------------------------------------------
Makes no difference if I try to load without giving options.
Not being certain if I need snd-pnp or not I tried with snd-pnp loaded and
that also don't work.

----------------------------------------------------------------------
 perex - 04-19-2004 16:49 CEST 
----------------------------------------------------------------------
Could you try to add 'acpipnp=0' module option to snd-mpu401 module?

Also send us the full error message including contents of /proc/interrupts
file.
Thanks.

----------------------------------------------------------------------
 hawklord - 04-19-2004 21:48 CEST 
----------------------------------------------------------------------
Many thanx everything is now working and all at the same time:-)

insmod snd-mpu401 acpipnp=0 port=0x330 irq=7

worked.  I tried just acpipnp=0 but that also failed.
I guess you don't need the files but if you do tell me.

Thanx much.  

Chris

----------------------------------------------------------------------
 tiwai - 04-20-2004 12:29 CEST 
----------------------------------------------------------------------
ok closing now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-14-04 02:57 hawklord       New Bug                                      
04-14-04 02:57 hawklord       Kernel Version            => 2.4.20          
04-16-04 11:57 tiwai          Bugnote Added: 0000833                       
04-16-04 20:16 hawklord       Bugnote Added: 0000842                       
04-19-04 16:49 perex          Bugnote Added: 0000860                       
04-19-04 21:48 hawklord       Bugnote Added: 0000865                       
04-20-04 12:29 tiwai          Bugnote Added: 0000872                       
04-20-04 12:29 tiwai          Assigned To               => tiwai           
04-20-04 12:29 tiwai          Resolution               open => fixed       
04-20-04 12:29 tiwai          Status                   new => resolved     
07-16-04 12:51 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
