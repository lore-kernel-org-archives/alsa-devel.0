From: noreply@alsa-project.org
Subject: [ALSA - driver 0000297]: codec read timeout / irq problem, atiixp driver crashes
Date: Fri, 16 Jul 2004 12:55:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105558.9DBF326008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 05933244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:55:59 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000297
======================================================================
Reported By:                Dezi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     297
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             Kernel 2.6.x
======================================================================
Date Submitted:             05-22-2004 20:41 CEST
Last Modified:              07-16-2004 12:55 CEST
======================================================================
Summary:                    codec read timeout / irq problem, atiixp driver crashes
Description: 
Maybe this is a duplicate of 0000232.

ALSA build into kernel:
When the alsa driver is compiled into the kernel, I can find a lot of
"codec read timeout" messages in dmesg but finally the atiixp chip seems
to be recognized. I can use alsamixer for example. When I use an audio
player (e.g. aplay) the system crashes (see atached "alsa_error.jpg" for
detail).

ALSA build as module:
I get a lot of "coded read timeout" messages, the chip doesn't seem to be
recognized and the system crashes (same output as above, see attached
"alsa_error.jpg" for details)
======================================================================

----------------------------------------------------------------------
 tiwai - 05-24-2004 15:09 CEST 
----------------------------------------------------------------------
as long as i see the kernel messages, it's a problem of irq routing.
i don't think that there would be many things i can do from ALSA
side...

----------------------------------------------------------------------
 Dezi - 05-24-2004 20:13 CEST 
----------------------------------------------------------------------
Hi Tiwai,

thanks for your information. So what would you suggest? Forward this
problem to the kernel guys or to the manufacturer of this board (it's a
Shuttle ST62K Barebone)?

Thanks,

Frank.

----------------------------------------------------------------------
 pkashou - 05-24-2004 20:27 CEST 
----------------------------------------------------------------------
Try taking pci=noacpi out of your kernel options on boot. I have a ST62K
also and it does not run without ACPI PCI. Also make sure that only ACPI
(not APM) is enabled in the kernel.

A very helpful site for ST62K owners:
http://www.bluelightning.org/linux/st62k/

----------------------------------------------------------------------
 Dezi - 05-26-2004 12:40 CEST 
----------------------------------------------------------------------
Hi pkashou,

thanks for this information, ALSA works very well now!!

But beceause of the missing APM in the kernel I cannot poweroff the
ST62K.

Do you also have a tip for this?

Thanks in advance

Frank.

----------------------------------------------------------------------
 pkashou - 05-26-2004 13:19 CEST 
----------------------------------------------------------------------
Unfortunately I do not. I have heard of some other people being able to use
'shutdown -h now' with their ST62K so I assume it is possible. My hunch is
that it is a BIOS setting - I have duplicated a "working" kernel config
and still cannot shutdown. It is not a large priority for me because that
machine is an always-on MythTV box. 

Sorry I couldn't help any further.

----------------------------------------------------------------------
 tiwai - 05-26-2004 14:31 CEST 
----------------------------------------------------------------------
ok then now close this bug.

(please report shutdown problem on linux kernel bugzilla :)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-22-04 20:41 Dezi           New Bug                                      
05-22-04 20:41 Dezi           Distribution              => Debian          
05-22-04 20:41 Dezi           Kernel Version            => Kernel 2.6.x    
05-22-04 20:59 Dezi           File Added: alsa_error.jpg                    
05-22-04 21:05 Dezi           File Added: alsa_error_2.jpg                    
05-22-04 21:06 Dezi           File Added: dmesg                            
05-22-04 21:07 Dezi           Bug Monitored: Dezi                          
05-24-04 15:09 tiwai          Bugnote Added: 0001187                       
05-24-04 20:13 Dezi           Bugnote Added: 0001191                       
05-24-04 20:27 pkashou        Bugnote Added: 0001193                       
05-26-04 12:40 Dezi           Bugnote Added: 0001247                       
05-26-04 13:19 pkashou        Bugnote Added: 0001249                       
05-26-04 14:31 tiwai          Bugnote Added: 0001255                       
05-26-04 14:31 tiwai          Resolution               open => fixed       
05-26-04 14:31 tiwai          Status                   assigned => resolved
07-16-04 12:55 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
