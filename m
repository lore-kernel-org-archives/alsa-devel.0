From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000443]: OSS emulation and nonblocking write to /dev/dsp
Date: Sun, 29 Aug 2004 12:26:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040829102655.8F72D39006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EC9EA24D
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 12:26:55 +0200 (MEST)
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


The following bug has been ASSIGNED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000443
======================================================================
Reported By:                serge
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     443
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-15-2004 12:19 CEST
Last Modified:              08-29-2004 12:26 CEST
======================================================================
Summary:                    OSS emulation and nonblocking write to /dev/dsp
Description: 
When you open '/dev/dsp' in nonblocking mode (O_NONBLOCK) and write too
much data to it, it seems that write operation always returns success and
pretends that all data was written. But calls to ioctl(oss_fd,
SNDCTL_DSP_GETOSPACE, &bufinfo) start returning weird information. Test
program that reproduces the bug is attached.
======================================================================

----------------------------------------------------------------------
 serge - 08-26-2004 19:54 CEST 
----------------------------------------------------------------------
Just tested and reproduced the same problem on 'snd-intel8x0' (nforce2
chipset), so this is not 'snd-via82xx' specific (KT133A chipset). Please
anybody replace the summary of this bug with 'OSS emulation & nonblocking
write to /dev/dsp'.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 12:19 serge          New Bug                                      
08-15-04 12:19 serge          File Added: oss-bug.cpp                      
08-15-04 12:26 serge          Bug Monitored: serge                         
08-26-04 19:54 serge          Bugnote Added: 0001635                       
08-27-04 14:01 Clemens Ladischsummary                  OSS emulation on 'snd-via82xx' & nonblocking write to /dev/dsp => OSS emulation and nonblocking write to /dev/dsp
08-29-04 12:26 perex          Assigned To               => perex           
08-29-04 12:26 perex          Status                   new => assigned     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
