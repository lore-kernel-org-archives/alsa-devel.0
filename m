From: noreply@alsa-project.org
Subject: [ALSA - lib 0000277]: Periodic ticks when playing sounds true dmix  (with fix)
Date: Fri, 16 Jul 2004 12:48:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104826.9877B26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CC415255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:48:26 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000277
======================================================================
Reported By:                ceno
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     277
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             05-15-2004 11:10 CEST
Last Modified:              07-16-2004 12:48 CEST
======================================================================
Summary:                    Periodic ticks when playing sounds true dmix  (with fix)
Description: 
Since 1.0.3b the problem exist. (1.0.3a was good)

The patch below will fix the problem.


diff -r alsa-lib-1.0.4/src/pcm/pcm_dmix_i386.h
../alsa-lib-1.0.4/src/pcm/pcm_dmix_i386.h
242a243,244
> 
> 
251,252d252
<       unsigned int old_ebx;
< 
264c264
<               "\tmovl %%ebx, %7\n"    /* ebx is GOT pointer (-fPIC) */
---
>               "\tpush %%ebx\n"        /* ebx is GOT pointer (-fPIC) */
271,273d270
<               "\tcmpl $0, %0\n"
<               "\tjnz 2f\n"
<               "\tjmp 6f\n"
346c343
<               "\tmovl %7, %%ebx\n"    /* ebx is GOT pointer (-fPIC) */
---
>               "\tpop %%ebx\n"         /* ebx is GOT pointer (-fPIC) */
349,351c346
<               : "m" (size), "m" (dst), "m" (src),
<                 "m" (sum), "m" (dst_step), "m" (src_step),
<                 "m" (sum_step), "m" (old_ebx)
---
>               : "m" (size), "m" (dst), "m" (src), "m" (sum), "m"
(dst_step), "m" (src_step), "m" (sum_step)

======================================================================

----------------------------------------------------------------------
 ceno - 05-15-2004 11:13 CEST 
----------------------------------------------------------------------
Same bug as 0000150

----------------------------------------------------------------------
 username - 05-15-2004 11:27 CEST 
----------------------------------------------------------------------
Could you please attach the patch to the bug (as a file)? (Please also use
'diff -u'). I'm having trouble applying it by using cut/paste.

----------------------------------------------------------------------
 ceno - 05-15-2004 11:44 CEST 
----------------------------------------------------------------------
The patch is uploaded (using the -u option). patch -p1 < fix.patch should
'fix' the 1.0.4 tree. btw, this is a 'quick' fix. Not a very nice one, but
it works for me.

edited on: 05-15-04 11:44

----------------------------------------------------------------------
 username - 05-15-2004 12:54 CEST 
----------------------------------------------------------------------
Thanks! Works great for me, FWIW. (Just for the record: I'm using a
Terratec Aureon Sky)

----------------------------------------------------------------------
 perex - 05-24-2004 19:48 CEST 
----------------------------------------------------------------------
The code should do same thing. Please, tell me your GCC version.

Can you attach output from the command bellow - for both versions -
non-working and yours - working:

perex@pnote:~/alsa/alsa-lib/src/pcm> objdump --disassemble --source
.libs/pcm_dmix.o > out.txt

----------------------------------------------------------------------
 ceno - 05-24-2004 20:23 CEST 
----------------------------------------------------------------------
$gcc --version
gcc (GCC) 3.3.3 (Debian 20040422)

the objdump's included

----------------------------------------------------------------------
 perex - 05-24-2004 20:41 CEST 
----------------------------------------------------------------------
Could you try attached pcm_dmix_i386.h.patch ?

----------------------------------------------------------------------
 ceno - 05-24-2004 20:59 CEST 
----------------------------------------------------------------------
Yes it works, With the pcm_dmix_i386.h.patch the periodic tick is gone.
thanks,

----------------------------------------------------------------------
 perex - 05-24-2004 21:06 CEST 
----------------------------------------------------------------------
The fixed code is in 1.0.5rc1 alsa-lib tarbal.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-15-04 11:10 ceno           New Bug                                      
05-15-04 11:11 ceno           Bug Monitored: ceno                          
05-15-04 11:12 ceno           Bug End Monitor: ceno                        
05-15-04 11:12 ceno           Bug Monitored: ceno                          
05-15-04 11:13 ceno           Bugnote Added: 0001121                       
05-15-04 11:23 username       Bug Monitored: username                      
05-15-04 11:27 username       Bugnote Added: 0001123                       
05-15-04 11:38 ceno           Bugnote Added: 0001124                       
05-15-04 11:40 ceno           File Added: fix-24bit-pcm-mixing-using-1.0.3a-pcm-mixing-code.diff                    
05-15-04 11:41 ceno           Bugnote Edited: 0001124                      
05-15-04 11:44 ceno           Bugnote Edited: 0001124                      
05-15-04 12:54 username       Bugnote Added: 0001125                       
05-24-04 19:48 perex          Bugnote Added: 0001190                       
05-24-04 19:48 perex          Assigned To               => perex           
05-24-04 19:48 perex          Status                   new => assigned     
05-24-04 20:23 ceno           Bugnote Added: 0001192                       
05-24-04 20:25 ceno           File Added: alsa-lib-1.0.4.objdump.gz                    
05-24-04 20:26 ceno           File Added: alsa-lib-1.0.4-with-fix.objdump.gz                    
05-24-04 20:41 perex          File Added: pcm_dmix_i386.h.patch                    
05-24-04 20:41 perex          Bugnote Added: 0001194                       
05-24-04 20:59 ceno           Bugnote Added: 0001195                       
05-24-04 21:06 perex          Bugnote Added: 0001196                       
05-24-04 21:06 perex          Resolution               open => fixed       
05-24-04 21:06 perex          Status                   assigned => resolved
07-16-04 12:48 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
