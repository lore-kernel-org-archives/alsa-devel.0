From: noreply@alsa-project.org
Subject: [ALSA - driver 0000213]: Loading snd-intel8x0 crashes system, ACPI related?
Date: Fri, 16 Jul 2004 12:53:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105345.009AB26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4DFBD1B0
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:53:45 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000213
======================================================================
Reported By:                vii
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     213
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-15-2004 21:02 CEST
Last Modified:              07-16-2004 12:53 CEST
======================================================================
Summary:                    Loading snd-intel8x0 crashes system, ACPI related?
Description: 
I have a Gigabyte GA-7S748L motherboard with a Silicon Integrated Systems
[SiS] Sound Controller (rev 160). Usually when I load the snd-intel8x0
module the computer locks up. If I boot with acpi=off then it either
hardlocks or turns the power off(!). With acpi on it prints lots of
messages about disabling GPE event 00000000 because no handler was found.
Annoyingly, very occasionally it works.
======================================================================

----------------------------------------------------------------------
 vii - 04-25-2004 20:03 CEST 
----------------------------------------------------------------------
Loading the module does not seem to crash on a kernel built without local
APIC support

----------------------------------------------------------------------
 perex - 05-04-2004 12:08 CEST 
----------------------------------------------------------------------
It's something for the Linux kernel mailing list, because it appears that
you have a wrong interrupt routing. We cannot help you. It's not driver
but kernel fault.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-15-04 21:02 vii            New Bug                                      
04-15-04 21:02 vii            Distribution              => Debian          
04-15-04 21:02 vii            Kernel Version            => 2.6.5           
04-25-04 20:03 vii            Bugnote Added: 0000943                       
05-04-04 12:08 perex          Bugnote Added: 0001041                       
05-04-04 12:15 perex          Resolution               open => not a bug   
05-04-04 12:16 perex          Status                   new => resolved     
07-16-04 12:53 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
