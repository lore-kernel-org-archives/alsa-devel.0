From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000237]: Kernel Oops/panic initializing driver on TP380Z
Date: Tue, 10 Aug 2004 11:56:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810095646.E9E391102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5B22E207
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2004 11:56:47 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000237
======================================================================
Reported By:                alfmel
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     237
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Linux from scratch, gcc 3.3.3, module-init-tools 3.0
Kernel Version:             2.6.5
Resolution:                 fixed
======================================================================
Date Submitted:             04-27-2004 00:43 CEST
Last Modified:              08-10-2004 11:56 CEST
======================================================================
Summary:                    Kernel Oops/panic initializing driver on TP380Z
Description: 
When trying to load the cs4236 module (or during kernel boot if compiled
in) the kernel oopses and panics as follows (it was copied by hand; may
contain errors):

Unable to handle kernel NULL pointer dereference at virtual address
00000060 printing eip:
c02328fb
*pde = 00000000
Ooops: 0000 [https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000001]
PREMEPT
CPU:    0
EIP:    0060:[<C02328FB>]    Not tainted
EFLAGS: 00010082   (2.6.5)
EIP is at snd_pcm_period_elapsed+0xb/0x320
eax: 00000000   ebx:000000ff   ecx: ebff36f9   edx:00000000
esi: c5f0f280   edi: 00000000   ebp: c5f9fe94   esp:c5f9fdf8
ds: 007b    es: 007b    ss: 0068
Process swapper (pid: 1, threadinfo=c5f9e000 task=c5f996c0)
stack: c5fc7a44 000000d0 c5e96058 c5fc7a50 00000018 c01b9b12 000055f0
       c025c32d 000000ff c5f0f280 00000000 c5f9fe94 c025d95d 00000000
00000018
       000000d0 c5e99900 ffe96e60 c5eac32 20000001 c0108989 00000005
c5f0f280
Call Trace:
 [<c01b9b12>] __delay+0x12/0x20
 [<c025c32d>] snd_cs4231_int+0x5d/0x70
 [<c025d95d>] snd_cs4231_interrupt+0xfd/0x120
 [<c0108989>] handle_IRQ_event+0x49/0x80
 [<c0108cff>] do_IRQ+0x8f/0x130
 [<c0107138>] common_interrupt+0x18/0x20
 [<c01092ef>] setup_irq+0x7f/0xf0
 [<c025d860>] snd_cs4231_interrupt+0x0/0x120
 [<c0108e51>] request_irq+0x81/0xd0
 [<c025d860>] snd_cs4231_interrupt+0x0/0x120
 [<c025e93f>] snd_cs4231_create+0x77/0x330
 [<c025d860>] snd_cs4231_interrupt+0x0/0x120
 [<c025aee7>] snd_cs4236_create+0x77/0x3e0
 [<c025a65b>] snd_card_cs423x_probe+0x11b/0x3f0
 [<c036c26f>] alsa_card_cs423x_init+0x6f/0x80
 [<c035a7ab>] do_initcalls+0x2b/0xc0
 [<c012941f>] init_workqueues+0xf/0x30
 [<c01030cc>] init+0x2c/0x120
 [<c01030a0>] init+0x0/0x120
 [<c0104f0d>] kernel_trhead_helper+0x5/0x18

Code: 8b 40 60 89 44 24 18 8b 90 0c 02 00 00 85 d2 0f 85 e0 02 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

(I hope I got it all right)
======================================================================

----------------------------------------------------------------------
 tiwai - 04-30-2004 10:54 CEST 
----------------------------------------------------------------------
enable CONFIG_SND_DEBUG if it's off.
i guess this will give the debug message instead of panic.
(yes, it's a bug, and should be fixed :)

----------------------------------------------------------------------
 tiwai - 05-01-2004 10:47 CEST 
----------------------------------------------------------------------
try the attached patch.  i guess this fixes the bug...
(BTW it's to CVS version.  1.0.2 is anyway too old!)

----------------------------------------------------------------------
 alfmel - 05-02-2004 04:10 CEST 
----------------------------------------------------------------------
I applied to the patch to kernel 2.6.5 but it now fails to build.  See the
file for details.

edited on: 05-02-04 04:10

----------------------------------------------------------------------
 tiwai - 05-02-2004 11:55 CEST 
----------------------------------------------------------------------
it's to *CVS version*.  not to the codes in 2.6 kernel tree.

----------------------------------------------------------------------
 tiwai - 05-02-2004 11:55 CEST 
----------------------------------------------------------------------
the latest CVS already includes the patch.

----------------------------------------------------------------------
 alfmel - 05-02-2004 16:05 CEST 
----------------------------------------------------------------------
Oops!  Sorry.  I'll download the latest CVS.

----------------------------------------------------------------------
 alfmel - 05-03-2004 06:04 CEST 
----------------------------------------------------------------------
OK, still no luck.  Here is the run down.

This morning I downloaded the latest CVS snapshot from the FTP server. 
(CVS kept timing out this morning, so I used the snapshot).

I built the driver installed it, and the kernel still panicked.  I checked
the source and I saw that the patch was not included.  I patched it with
the diff file you posted and at build time, it gave me the same error as
with the kernel build.  The configure line I used was:

./configure --with-oss --with-cards=cs4236 --with-debug=full

Sorry to be such a pain. :-)

----------------------------------------------------------------------
 tiwai - 05-03-2004 18:00 CEST 
----------------------------------------------------------------------
oops, sorry, it's a missing brace!

the additional patch is uploaded.

----------------------------------------------------------------------
 alfmel - 05-04-2004 08:11 CEST 
----------------------------------------------------------------------
Well, I feel stupid.  I should have been able to fix the missing brace. 
Guess I wasn't looking close enough.

The module compiles now and "loads" without problems.

However, now it cannot find the card.  I'm using the same settings I used
before under 2.4.2x and alsa 0.98.  I've tried several other combos and
still nothing.  The card is not PNP.  Any suggestions?

I'll keep playing with it and see if I can get it to load.

Thanks for your help, tiwai.

----------------------------------------------------------------------
 tiwai - 05-05-2004 11:46 CEST 
----------------------------------------------------------------------
did you get any kernel error messages regarding this?

it would be really helpful if you find out which point returns the error
in probe callback of cs4236.c, e.g. by putting printk's in the code.

----------------------------------------------------------------------
 alfmel - 05-06-2004 23:28 CEST 
----------------------------------------------------------------------
I haven't had much time to play with it.  I'll be spending some time on it
in the next few days.  I'll let you know how it goes.

----------------------------------------------------------------------
 alfmel - 05-14-2004 04:06 CEST 
----------------------------------------------------------------------
OK.  I finally had some time to play around with this.  Here are my
findings.

I stuck a whole bunch of printk()'s in the code to figure out where the
problem was.  I followed the code all the way back to snd_cs4231_lib.c and
where I got stuck (where I couldn't figure out what the code was actually
doing) was in function snd_cs4231_probe().  This is the place where the
"device not found" error originates (on line 1066, where id = 0x00 and not
0x0a as expected).

Going backwards on the function, line 1051 contains a for loop designed to
run 50 times.  On line 1053 there is an if statement.  This if statement
returned true all 50 times, taking the udelay(2000) route and never
updating id.  I increased the loop to 500 just for the heck of it and the
result was the same.  I also modified id manually and set it to 0x0a.  The
code then exited with error when rev was set to 0xe7 and deemed as an
unknown chip revision (line 1089).  I then manually set rev to 0x83 and
the loading failed with a segfault.

According to articles I found, the TP 380Z has a CS4237B chipset.  I
didn't see any ID checks for this chip on the lines of code I mentioned
above.  Is the code forking in a weird spot and looking for the wrong
chip?

Anyway, when trying to load the cs4236 module after a restart, I get a bit
more messages on klog about the problem.  Here are the messages:

May 13 19:20:17 (none) ALSA
/usr/src/alsa-cvs/alsa-driver/alsa-kernel/isa/cs423x/cs4231_lib.c:242: in:
auto calibration time out - reg = 0x18
May 13 19:20:17 (none) ALSA
/usr/src/alsa-cvs/alsa-driver/alsa-kernel/isa/cs423x/cs4231_lib.c:183:
outm: auto calibration time out - reg = 0x18, value = 0x0
May 13 19:20:18 (none) Error: -19 [DEBUG]
May 13 19:20:18 (none) CS4236+ soundcard not found or device busy

Any tips would be appreciated.  I'll keep playing with it and report any
new findings.

----------------------------------------------------------------------
 alfmel - 05-15-2004 03:52 CEST 
----------------------------------------------------------------------
I continued to play around some more, this time taking a different
approach.  I tried the OSS driver for the CS4232.  The module was unable
to find the card.  So this problem may not be ALSA related.  Perhaps there
is something deeper into the kernel that is interfearing.

Or, I could just be off my rocker.  Again, the card works in Windows, and
it used to work in Linux with a 2.4 kernel and alsa 0.9x.

----------------------------------------------------------------------
 alfmel - 08-06-2004 20:51 CEST 
----------------------------------------------------------------------
OK.  I had some time to play around with this again.  I wrote some scripts
to iterate through all possible settings and that didn't work.  I tried
debugging the driver and the problem was that the card was returning
something unexpected.  Sound in Windows was still working fine so I
decided to check settings in the BIOS.

There was not much I could find there but the diagnostics would report an
error on the System Board.  I read more on that and reset some of the BIOS
settings to force a rewrite of the BIOS memory.  I ran the diags again and
the error disappeared.  I went back to Linux, tried loading the module
again, and it worked!  Sound is working perfectly!

My guess is that the kernel oops tripped something bad in the machine
(hence the oops).  With the BIOS resets it cleared it and everything went
back to normal.

Thanks for you help.  You can now consider this bug closed.

----------------------------------------------------------------------
 perex - 08-10-2004 11:56 CEST 
----------------------------------------------------------------------
It seems like BIOS setup issue.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-27-04 00:43 alfmel         New Bug                                      
04-27-04 00:43 alfmel         Distribution              => Linux from scratch, gcc 3.3.3, module-init-tools 3.0
04-27-04 00:43 alfmel         Kernel Version            => 2.6.5           
04-27-04 00:45 alfmel         Bug Monitored: alfmel                        
04-30-04 10:54 tiwai          Bugnote Added: 0000973                       
05-01-04 10:47 tiwai          Bugnote Added: 0000998                       
05-01-04 10:47 tiwai          File Added: cs423x-fix.dif                    
05-01-04 17:02 alfmel         Bugnote Added: 0001000                       
05-01-04 17:03 alfmel         File Added: kernel_build_error                    
05-02-04 04:10 alfmel         Bugnote Edited: 0001000                      
05-02-04 11:55 tiwai          Bugnote Added: 0001004                       
05-02-04 11:55 tiwai          Bugnote Added: 0001005                       
05-02-04 16:05 alfmel         Bugnote Added: 0001009                       
05-03-04 06:04 alfmel         Bugnote Added: 0001020                       
05-03-04 18:00 tiwai          Bugnote Added: 0001023                       
05-03-04 18:00 tiwai          File Added: cs4231-fix2.dif                    
05-04-04 08:11 alfmel         Bugnote Added: 0001037                       
05-05-04 11:46 tiwai          Bugnote Added: 0001054                       
05-06-04 23:28 alfmel         Bugnote Added: 0001065                       
05-14-04 04:06 alfmel         Bugnote Added: 0001107                       
05-15-04 03:52 alfmel         Bugnote Added: 0001119                       
08-06-04 20:51 alfmel         Bugnote Added: 0001543                       
08-10-04 11:56 perex          Bugnote Added: 0001548                       
08-10-04 11:56 perex          Assigned To               => perex           
08-10-04 11:56 perex          Resolution               open => fixed       
08-10-04 11:56 perex          Status                   new => resolved     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
