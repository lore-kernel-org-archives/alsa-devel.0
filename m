From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001025]: kernel panic when trying to load module snd-au8830
Date: Mon, 4 Apr 2005 11:00:19 +0200
Message-ID: <2407912799486cb54fbd13ab25aa8c3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CA1D322B
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 11:00:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025> 
======================================================================
Reported By:                Osiris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1025
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             03-30-2005 22:50 CEST
Last Modified:              04-04-2005 11:00 CEST
======================================================================
Summary:                    kernel panic when trying to load module snd-au8830
Description: 
kernel panic occurs on boot when system tries to load kernel module for
Aureal Vortex 2. The same thing happens when driver is compiled into
kernel, not module

======================================================================

----------------------------------------------------------------------
 Osiris - 04-03-05 21:16 
----------------------------------------------------------------------
My computer's hardware configuration is:
AMD Athlon64 2800+ (runs in 64-bit mode)
512 Mb RAM
MB: Asus K8V (chipset - Via KT800)
Video: GeForceFX 5600 (Sparcle)
HDD: Maxtor Diamond Max 9 SATA

built-in soundcard is turned off in bios

Vortex2 driver is built into kernel (not as a module)

Here are kernel messages during boot:
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18(level, low)->IRQ177
Vortex: init....<1> Unable to handle kernel paging request at
ffffc20000754018
RIP:<ffffffff802a0dda>{vortex_core_init+42}
PGD 1ff12067  PUD 1ff11067  PMD 1fc8f067  PTE 0
Oops:0002 [1]
CPU 0
Modules linked in:
Pid:1, comm: swapper Not tainted 2.6.11.6
RIP:0010:[<ffffffff802a0dda>] <ffffffff802a0dda> {vortex_core_init+42}
RSP:0000:ffff8100018c3d98  EFLAGS:00010296
RAX:ffffc20000700000  RBX:ffff81001fda8000  RCX:00000000000927bf
RDX:ffffffff80429310  RSI:0000000000000000  RDI:0000000000000005
RBP:0000000000000000  R08:0000000000000008  R09:ffff8100018da120
R10:00000000ffffffff  R11:0000000000000000  R12:00000000ffffffff
R13:ffff81001fd5fc00  R14:ffff8100018c3df0  R15:ffffffff8045bfb0
FS:0000000000000000(0000)  GS:ffffffff804540c0(0000)
knlGS:0000000000000008
CS:0010  DS:0018  ES:0018  CR0:000000008005003b
CR2:ffffc20000754018  CR3:0000000000101000  CR4:00000000000006e0
Process swapper (pid:1, threadinfo ffff8100018c2000, task
ffff8100018c14d0)
Stack:ffff81001fd5fc00 ffff8100019e9000 ffff81001fda8000 ffffffff802a51d3
      ffffffff803d8ce0 ffff81001fd5fc00 ffff8100019e9000 0000000000000000
      0000ffffffff8010 ffffffff802a5328
Call trace: <ffffffff802a51d3> {snd_vortex_create+323}
            <ffffffff802a5328> {snd_vortex_probe+120}
            <ffffffff801ed1bd> {pci_device_probe_static+61}
            <ffffffff801ed219> {__pci_device_probe+41}
            <ffffffff801ed270> {pci_device_probe+48}
            <ffffffff80245f5d> {driver_probe_device+77}
            <ffffffff80246076> {driver_attach+70}
            <ffffffff80246570> {bus_add_driver+144}
            <ffffffff80246a92> {driver_register+50}
            <ffffffff801ed516> {pci_register_driver+118}
            <ffffffff8045c85a> {do_initcalls+106}
            <ffffffff8010c07d> {init+45}
            <ffffffff8010ebdb> {child_rip+8}
            <ffffffff8010c050> {init+0}
            <ffffffff8010ebd3> {child_rip+0}
Code  44 89 a0 18 40 05 00 e8 6a 89 e9 ff 48 8b 93 e8 40 00 00 b8
RIP <ffffffff802a0dda> {vortex_core_init+42} RSP <ffff8100018c3d98>
CR2: ffffc20000754018
 <0> kernel panic - not syncing: Attempt to kill init!

the soundcard worked fine with kernel 2.6.10 (32bit) on the same machine

----------------------------------------------------------------------
 alien999999999 - 04-04-05 11:00 
----------------------------------------------------------------------
I had similar issues on 64bit, there are a few changes i did in the above
files that make it work, but it's not yet cleaned up and some things just
have been commented out...

in a certain macro, some things are strictly for 32bit usage ( <<2 ), if
you change a few files like this, it'll work.

i can't make a patch yet, since i don't have alsa CVS, and further testing
is very uneasy, since i have only 1 64bit machine and it is this
server...

attached file

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 22:50 Osiris         New Issue                                    
03-30-05 22:50 Osiris         Distribution              => Debian          
03-30-05 22:50 Osiris         Kernel Version            => 2.6.11.6        
03-31-05 11:34 mjander        Note Added: 0004278                          
04-03-05 21:16 Osiris         Note Added: 0004320                          
04-04-05 10:19 alien999999999 Issue Monitored: alien999999999                   

04-04-05 11:00 alien999999999 File Added: alsa-changes.tar.bz2                  
 
04-04-05 11:00 alien999999999 Note Added: 0004325                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
