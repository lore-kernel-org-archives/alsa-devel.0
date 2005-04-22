From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001059]: dsx_support and APIC interaction
Date: Fri, 22 Apr 2005 19:49:54 +0200
Message-ID: <e870c64d42cfc5f7ca45f1115b574a5e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4B22F1D8
	for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2005 19:49:54 +0200 (MEST)
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
Status:                     feedback
Distribution:               Slackware 10.0
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-17-2005 20:41 CEST
Last Modified:              04-22-2005 19:49 CEST
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
 systemloc - 04-20-05 06:23 
----------------------------------------------------------------------
I upgraded to kernel version 2.6.11.7, and tried both dxs_support=4 and 1.
In both cases, the result was the same. The sound worked for an amount of
time, but after sitting idle for a day or so, the audio would not work,
freezing, and playing a short, 1 second loop. Additionally, I got a
message in syslog that may be related to the failure of audio. I'm not
clear on the workings of the kernel here, but this looks like an IRQ
sharing problem or something. I'm using IO-APIC, so should IRQs still be
used? I checked dmesg, and it looks to me like IO-APIC is working
properly. 

Apr 17 13:02:06 systemloc kernel: irq 12: nobody cared!                   
     Apr 17 13:02:06 systemloc kernel:  [<c012c12a>]
__report_bad_irq+0x2a/0x90
Apr 17 13:02:06 systemloc kernel:  [<c012bbe0>] handle_IRQ_event+0x30/0x70
     Apr 17 13:02:06 systemloc kernel:  [<c012c21c>]
note_interrupt+0x6c/0xd0
Apr 17 13:02:06 systemloc kernel:  [<c012bcfb>] __do_IRQ+0xdb/0xe0        
     Apr 17 13:02:06 systemloc kernel:  [<c0104659>] do_IRQ+0x19/0x30
Apr 17 13:02:06 systemloc kernel:  [<c0102d1e>] common_interrupt+0x1a/0x20
     Apr 17 13:02:06 systemloc kernel:  [<c0118170>]
__do_softirq+0x30/0x90
Apr 17 13:02:06 systemloc kernel:  [<c01181f6>] do_softirq+0x26/0x30      
     Apr 17 13:02:06 systemloc kernel:  [<c010465e>] do_IRQ+0x1e/0x30
Apr 17 13:02:06 systemloc kernel:  [<c0102d1e>] common_interrupt+0x1a/0x20
     Apr 17 13:02:06 systemloc kernel:  [<c0100413>]
default_idle+0x23/0x30
Apr 17 13:02:06 systemloc kernel:  [<c0100498>] cpu_idle+0x48/0x60        
     Apr 17 13:02:06 systemloc kernel:  [<c035078c>]
start_kernel+0x13c/0x160
Apr 17 13:02:06 systemloc kernel:  [<c0350380>]
unknown_bootoption+0x0/0x1b0    Apr 17 13:02:06 systemloc kernel:
handlers:
Apr 17 13:02:06 systemloc kernel: [<e08ea430>]
(snd_via82xx_interrupt+0x0/0x90 [snd_via82xx])
Apr 17 13:02:06 systemloc kernel: Disabling IRQ
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12



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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
