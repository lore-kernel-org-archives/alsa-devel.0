From: noreply@alsa-project.org
Subject: [ALSA - driver 0000280]: no PC SPEAKER recognized
Date: Fri, 16 Jul 2004 12:49:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104925.5F1DD26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 24328255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:49:26 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000280
======================================================================
Reported By:                trapperhoney
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     280
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.6 (self built)
======================================================================
Date Submitted:             05-17-2004 03:50 CEST
Last Modified:              07-16-2004 12:49 CEST
======================================================================
Summary:                    no PC SPEAKER recognized
Description: 
When upgrading from linux kernel 2.4.25 to 2.6.6, my laptop lost the
ability to generate a terminal bell beep.  With the 2.4.25 kernel, I was
compiling the intel8x0 v1.0.3 module from source.  I'm now using version
1.0.4, which is distributed with the 2.6.6 version of the linux kernel,
compiled directly into the kernel.  It turns out, that PC SPEAKER mixer
option was not present with either version.  But for some reason, my
computer could still process pc speaker tones with the old version.  

I have another computer with, supposedly, the same sound card chipset and
I am not having this problem with that computer for either version
(following the same upgrade process).  That machine does have a PC SPEAKER
control available.  The problematic hardware is in an IBM Thinkpad T40
laptop.  

Both machines claim to have the following hardware when queried with
lspci
Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)

cat /proc/asound/cards shows the following being recognized:
0 [I82801DBICH4   ]: ICH - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 at 0xef001000, irq 17

Please let me know if you have any ideas or need further information.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-17-2004 15:04 CEST 
----------------------------------------------------------------------
did you enable CONFIG_INPUT_PCSPKR in kernel config?

----------------------------------------------------------------------
 trapperhoney - 05-21-2004 05:56 CEST 
----------------------------------------------------------------------
Adding CONFIG_INPUT_PCSPKR fixed the problem.  Incidentally,
CONFIG_INPUT_MISC must also be enabled to use the PCSPKR feature.

Thanks for the help!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-17-04 03:50 trapperhoney   New Bug                                      
05-17-04 03:50 trapperhoney   Distribution              => Debian          
05-17-04 03:50 trapperhoney   Kernel Version            => 2.6.6 (self built)
05-17-04 15:04 tiwai          Bugnote Added: 0001130                       
05-21-04 05:56 trapperhoney   Bugnote Added: 0001159                       
05-21-04 11:53 tiwai          Assigned To               => tiwai           
05-21-04 11:53 tiwai          Resolution               open => not a bug   
05-21-04 11:53 tiwai          Status                   new => resolved     
07-16-04 12:49 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
