From: noreply@alsa-project.org
Subject: [ALSA - lib 0000117]: aplay segfaults when attemptingto use "dmix" plugin
Date: Fri, 16 Jul 2004 12:44:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104406.7ED3526008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BF372255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:44:06 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000117
======================================================================
Reported By:                dandruczyk
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     117
Category:                   general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-04-2004 19:21 CET
Last Modified:              07-16-2004 12:44 CEST
======================================================================
Summary:                    aplay segfaults when attemptingto use "dmix" plugin
Description: 
aplay segfautls when using dmix plugin. (Was following tutorial at
http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php3?company=Generic&card=Generic&chip=Generic&module=Generic
======================================================================

----------------------------------------------------------------------
 Stephan Wurm - 03-06-2004 22:27 CET 
----------------------------------------------------------------------
I can confirm that problem!

Everything worked fine until I upgraded to version 1.0.3 (alsa-lib,
alsa-oss, alsa-utils). I tried 1.0.3a (alsa-lib, alsa-oss), too, but it
didn't change anything!

I use kernel 2.6.4-rc2 with alsa-patch 2004-03-01.

EDIT: I've added a file with the strace-output

bearbeitet am: 03-06-04 22:27

----------------------------------------------------------------------
 Stephan Wurm - 03-07-2004 15:38 CET 
----------------------------------------------------------------------
I downgraded ALSA to 1.0.2 now. The dmix-plugin works fine again. 

Is that problem related to the snd-intel8x0 driver? Can anybody else
confirm that segfault with another chipset/driver?

----------------------------------------------------------------------
 Meeuw - 03-10-2004 21:40 CET 
----------------------------------------------------------------------
Same problem here (same driver, same (SMP, hyperthreading?) kernel)

The testcase can be simplified to:
$ aplay -D plug:dmix arrive.wav

I've traced it down doing:
$ gdb aplay
(gdb) set args -D plug:dmix arrive.wav
(gdb) run
...
Starting program: /usr/bin/aplay -D plug:dmix arrive.wav
Detaching after fork from child process 10134.
Playing WAVE 'arrive.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Mono

Program received signal SIGSEGV, Segmentation fault.

(gdb) disassemble
Dump of assembler code for function mix_areas1_smp_mmx:
0x40099acb <mix_areas1_smp_mmx+0>:      sub    $0x8,%esp
0x40099ace <mix_areas1_smp_mmx+3>:      mov    %esi,(%esp,1)
0x40099ad1 <mix_areas1_smp_mmx+6>:      mov    %edi,0x4(%esp,1)
0x40099ad5 <mix_areas1_smp_mmx+10>:     push   %ebx
0x40099ad6 <mix_areas1_smp_mmx+11>:     mov    0x10(%esp,1),%edi
0x40099ada <mix_areas1_smp_mmx+15>:     mov    0x14(%esp,1),%esi
0x40099ade <mix_areas1_smp_mmx+19>:     mov    0x18(%esp,1),%ebx
0x40099ae2 <mix_areas1_smp_mmx+23>:     jmp    0x40099afc
<mix_areas1_smp_mmx+49
>
0x40099ae4 <mix_areas1_smp_mmx+25>:     lea    0x0(%esi),%esi
0x40099aea <mix_areas1_smp_mmx+31>:     lea    0x0(%edi),%edi
0x40099af0 <mix_areas1_smp_mmx+37>:     add    0x1c(%esp,1),%edi
0x40099af4 <mix_areas1_smp_mmx+41>:     add    0x20(%esp,1),%esi
0x40099af8 <mix_areas1_smp_mmx+45>:     add    0x24(%esp,1),%ebx
0x40099afc <mix_areas1_smp_mmx+49>:     xor    %ax,%ax
0x40099aff <mix_areas1_smp_mmx+52>:     mov    %ax,%cx
0x40099b02 <mix_areas1_smp_mmx+55>:     inc    %cx
0x40099b04 <mix_areas1_smp_mmx+57>:     mov    (%ebx),%edx
0x40099b06 <mix_areas1_smp_mmx+59>:     lock cmpxchg %cx,(%edi)
0x40099b0b <mix_areas1_smp_mmx+64>:     movswl (%esi),%ecx
0x40099b0e <mix_areas1_smp_mmx+67>:     jne    0x40099b12
<mix_areas1_smp_mmx+71

edited on: 03-10-04 21:40

----------------------------------------------------------------------
 Meeuw - 03-10-2004 21:55 CET 
----------------------------------------------------------------------
Reminder sent to perex

Hi Perex, if've done some additional debugging... I hope it's useful!

----------------------------------------------------------------------
 perex - 03-11-2004 12:07 CET 
----------------------------------------------------------------------
Please, try replace file alsa-lib/src/pcm/pcm_dmix_i386.h with the attached
one
and retry again (with recompiled alsa-lib).

----------------------------------------------------------------------
 Meeuw - 03-11-2004 14:47 CET 
----------------------------------------------------------------------
Great, it works for me!

I did a simple patch on the gentoo ebuild:
27a28
>       cp /tmp/pcm_dmix_i386.h src/pcm/

and the segfault is replaced by a smooth wave sound ;)

great work

edited on: 03-11-04 14:47

----------------------------------------------------------------------
 perex - 03-11-2004 15:05 CET 
----------------------------------------------------------------------
Unfortunately, it's not a proper fix (it was old code).
I'm trying to figure what's wrong now.

----------------------------------------------------------------------
 perex - 03-12-2004 13:48 CET 
----------------------------------------------------------------------
Can you try apply the attached dmix_asm_diff file to alsa-lib 1.0.3a?
It's the first attempt to make an official fix.

----------------------------------------------------------------------
 Stephan Wurm - 03-12-2004 16:41 CET 
----------------------------------------------------------------------
I've tried your diff, but sadly it didn't change anything.

I have attached another tarball with the ouput of two strace's.

btw: the bug is discussed in gentoo's bugzilla, too.
http://bugs.gentoo.org/show_bug.cgi?id=44055

bearbeitet am: 03-12-04 16:41

----------------------------------------------------------------------
 Meeuw - 03-12-2004 18:43 CET 
----------------------------------------------------------------------
Starting program: /usr/bin/aplay -D plug:dmix arrive.wav
Detaching after fork from child process 31316.
Playing WAVE 'arrive.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
Mono

Program received signal SIGSEGV, Segmentation fault.
0x40099b26 in mix_areas1_smp_mmx () from /usr/lib/libasound.so.2

Dump of assembler code for function mix_areas1_smp_mmx:
0x40099aeb <mix_areas1_smp_mmx+0>:      sub    $0x8,%esp
0x40099aee <mix_areas1_smp_mmx+3>:      mov    %esi,(%esp,1)
0x40099af1 <mix_areas1_smp_mmx+6>:      mov    %edi,0x4(%esp,1)
0x40099af5 <mix_areas1_smp_mmx+10>:     push   %ebx
0x40099af6 <mix_areas1_smp_mmx+11>:     mov    0x10(%esp,1),%edi
0x40099afa <mix_areas1_smp_mmx+15>:     mov    0x14(%esp,1),%esi
0x40099afe <mix_areas1_smp_mmx+19>:     mov    0x18(%esp,1),%ebx
0x40099b02 <mix_areas1_smp_mmx+23>:     cmpl   $0x0,0xc(%esp,1)
0x40099b07 <mix_areas1_smp_mmx+28>:     jne    0x40099b1c
<mix_areas1_smp_mmx+49>
0x40099b09 <mix_areas1_smp_mmx+30>:     jmp    0x40099b4f
<mix_areas1_smp_mmx+100>
0x40099b0b <mix_areas1_smp_mmx+32>:     nop
0x40099b0c <mix_areas1_smp_mmx+33>:     lea    0x0(%esi,1),%esi
0x40099b10 <mix_areas1_smp_mmx+37>:     add    0x1c(%esp,1),%edi
0x40099b14 <mix_areas1_smp_mmx+41>:     add    0x20(%esp,1),%esi
0x40099b18 <mix_areas1_smp_mmx+45>:     add    0x24(%esp,1),%ebx
0x40099b1c <mix_areas1_smp_mmx+49>:     mov    $0x0,%ax
0x40099b20 <mix_areas1_smp_mmx+53>:     mov    $0x1,%cx
0x40099b24 <mix_areas1_smp_mmx+57>:     mov    (%ebx),%edx
0x40099b26 <mix_areas1_smp_mmx+59>:     lock cmpxchg %cx,(%edi)
0x40099b2b <mix_areas1_smp_mmx+64>:     movswl (%esi),%ecx

It didn't seem to work :-(

ebuild patch:
27a28
>       patch -d src/pcm < ${FILESDIR}/dmix_asm.diff

----------------------------------------------------------------------
 perex - 03-12-2004 20:39 CET 
----------------------------------------------------------------------
Please, try dmix_asm-2.diff . It seems that it might be GCC version related
problem, because I cannot reproduce this bug here with GCC 3.3.1.

----------------------------------------------------------------------
 Meeuw - 03-12-2004 21:04 CET 
----------------------------------------------------------------------
Program exited normally.

it seems to work!

gentoo ebuild patch:
--- /usr/portage/media-libs/alsa-lib/alsa-lib-1.0.3.ebuild      2004-03-01
09:28:05.000000000 +0100
+++ media-libs/alsa-lib/alsa-lib-1.0.3.ebuild   2004-03-12
21:00:14.413993432 +0100
@@ -25,6 +25,7 @@
 S=${WORKDIR}/${MY_P}

 src_compile() {
+       patch -d src/pcm < ${FILESDIR}/dmix_asm-2.diff
        elibtoolize
        econf || die "./configure failed"
        emake || die "make failed"

----------------------------------------------------------------------
 Stephan Wurm - 03-13-2004 02:31 CET 
----------------------------------------------------------------------
Okay, everything's fine over here again :-)

----------------------------------------------------------------------
 perex - 03-13-2004 16:02 CET 
----------------------------------------------------------------------
Fine. 1.0.3b alsa-lib package is out with this fix.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-04-04 19:21 dandruczyk     New Bug                                      
03-06-04 21:52 Stephan Wurm   Bug Monitored: Stephan Wurm                    
03-06-04 21:56 Stephan Wurm   Bugnote Added: 0000521                       
03-06-04 22:26 Stephan Wurm   File Added: dmix-error                       
03-06-04 22:27 Stephan Wurm   Bugnote Edited: 0000521                      
03-07-04 15:38 Stephan Wurm   Bugnote Added: 0000523                       
03-09-04 18:42 perex          Assigned To               => perex           
03-09-04 18:42 perex          Status                   new => assigned     
03-10-04 20:31 Meeuw          Bugnote Added: 0000566                       
03-10-04 21:29 Meeuw          Bug Monitored: Meeuw                         
03-10-04 21:40 Meeuw          Bugnote Edited: 0000566                      
03-10-04 21:55 Meeuw          Bugnote Added: 0000567                       
03-11-04 12:06 perex          File Added: pcm_dmix_i386.h                    
03-11-04 12:07 perex          Bugnote Added: 0000569                       
03-11-04 14:47 Meeuw          Bugnote Added: 0000570                       
03-11-04 14:47 Meeuw          Bugnote Edited: 0000570                      
03-11-04 15:05 perex          Bugnote Added: 0000571                       
03-12-04 13:47 perex          File Added: dmix_asm.diff                    
03-12-04 13:48 perex          Bugnote Added: 0000577                       
03-12-04 16:14 Stephan Wurm   Bugnote Added: 0000578                       
03-12-04 16:21 Stephan Wurm   Bugnote Edited: 0000578                      
03-12-04 16:39 Stephan Wurm   File Added: traces.tar.bz2                    
03-12-04 16:40 Stephan Wurm   Bugnote Edited: 0000578                      
03-12-04 16:41 Stephan Wurm   Bugnote Edited: 0000578                      
03-12-04 18:43 Meeuw          Bugnote Added: 0000579                       
03-12-04 20:37 perex          File Added: dmix_asm-2.diff                    
03-12-04 20:39 perex          Bugnote Added: 0000583                       
03-12-04 21:04 Meeuw          Bugnote Added: 0000585                       
03-13-04 02:31 Stephan Wurm   Bugnote Added: 0000589                       
03-13-04 16:02 perex          Bugnote Added: 0000592                       
03-13-04 16:02 perex          Resolution               open => fixed       
03-13-04 16:02 perex          Status                   assigned => resolved
03-13-04 18:09 Stephan Wurm   Bug End Monitor: Stephan Wurm                    
03-13-04 22:37 eradicator     Bug Monitored: eradicator                    
07-16-04 12:44 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
