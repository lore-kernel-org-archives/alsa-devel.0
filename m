From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001059]: dsx_support and APIC interaction
Date: Mon, 2 Jan 2006 20:27:58 +0100
Message-ID: <b187733a104941c4960eab2e11745df0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04D4B162
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 20:27:58 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1059> 
======================================================================
Reported By:                systemloc
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1059
Category:                   PCI - via82xx
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Slackware 10.0
Kernel Version:             2.6.11.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-17-2005 20:41 CEST
Last Modified:              01-02-2006 20:27 CET
======================================================================
Summary:                    dsx_support and APIC interaction
Description: 
I was using the 2.6.7 kernel without APIC or ACPI support, and the via82xx

driver worked perfectly, compiled as a module, without any options. I
built a 
new 2.6.7 kernel on the same hardware with APIC and ACPI support in the 
kernel, as the board supports it, and the driver did not work correctly.
When 
sound was played, a short, 1 second long bit of the sound to be played was

looped. Possibly this is the clicking noise described by some people? The

driver works fine with this new kernel after adding the option 
"dxs_support=1". I hope this interaction with ACPI and APIC sheds some
light 
on some of the troubles with this driver. I can provide more information
if 
anyone wants it. Please CC me, I'm not on the list.

TJ


======================================================================

----------------------------------------------------------------------
 vsu - 04-22-05 19:49 
----------------------------------------------------------------------
The "irq XX: nobody cared!" message means that some device in your system
signaled that IRQ, but the loaded drivers did not handle it. (Actually,
this triggers after 99900 out of 100000 interrupts were unhandled, but
because PCI interrupts are level-triggered, this happens instantly
whenever some IRQ cannot be reset by existing interrupt handlers). Linux
2.6.x turns off the IRQ in this case - the devices using that IRQ stop
working, but at least the complete system lockup is avoided.

Common causes of "IRQ disabled" messages:

- The interrupt is shared with another device, the driver for which is not
loaded, and for some reason that device generates an interrupt. In many
cases loading the module for that device (even if it is not really used)
fixes this.

- Some BIOS tables are broken, and Linux gets wrong IRQ numbers. Upgrading
BIOS  helps sometimes (it could also make (other) things worse, however).

BTW, if you really get messages about IRQ 12, probably the IO-APIC support
was not activated (PCI IRQ numbers with IO-APIC are usually 16 or higher).
The configuration definitely does not correspond to the lspci output
posted earlier.

This part looks like an ACPI problem, which should be reported at
bugme.osdl.org (Category=ACPI, Component=Config-Interrupts); only the
"best dxs_support value for your board" part seems to be relevant for the
ALSA bugtracker.

----------------------------------------------------------------------
 systemloc - 05-01-05 19:57 
----------------------------------------------------------------------
Ah, it is as you said. There was a device sharing the IRQ which did not
have a loaded driver. After removing the device, sound worked just fine
without any dsx_support settings at all. 

Please close this issue :)

Thanks!
TJ Harrell

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-05 20:41 systemloc      New Issue                                    
04-17-05 20:41 systemloc      Distribution              => Slackware 10.0  
04-17-05 20:41 systemloc      Kernel Version            => 2.6.7           
04-17-05 20:42 systemloc      Note Added: 0004510                          
04-17-05 21:44 systemloc      Note Added: 0004511                          
04-19-05 17:45 tiwai          Status                   new => resolved     
04-19-05 17:45 tiwai          Resolution               open => fixed       
04-19-05 17:45 tiwai          Assigned To               => tiwai           
04-20-05 06:22 systemloc      Kernel Version           2.6.7 => 2.6.11.7   
04-20-05 06:22 systemloc      Status                   resolved => feedback
04-20-05 06:22 systemloc      Resolution               fixed => reopened   
04-20-05 06:22 systemloc      Note Added: 0004540                          
04-20-05 06:23 systemloc      Note Edited: 0004540                         
04-22-05 19:49 vsu            Note Added: 0004556                          
05-01-05 19:57 systemloc      Note Added: 0004582                          
01-02-06 20:27 rlrevell       Status                   feedback => resolved
01-02-06 20:27 rlrevell       Resolution               reopened => fixed   
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
