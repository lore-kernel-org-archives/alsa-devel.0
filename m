From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000443]: OSS emulation and nonblocking write to /dev/dsp
Date: Tue, 9 Nov 2004 16:17:11 +0100
Message-ID: <05cd272efe480428accacbe536f21b71@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 57A1D244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:17:11 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=443> 
======================================================================
Reported By:                serge
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   443
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-15-2004 12:19 CEST
Last Modified:              11-09-2004 16:17 CET
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
 serge - 08-26-04 19:54 
----------------------------------------------------------------------
Just tested and reproduced the same problem on 'snd-intel8x0' (nforce2
chipset), so this is not 'snd-via82xx' specific (KT133A chipset). Please
anybody replace the summary of this bug with 'OSS emulation & nonblocking
write to /dev/dsp'.

----------------------------------------------------------------------
 perex - 09-07-04 16:38 
----------------------------------------------------------------------
Confirmed. Fixed in current ALSA CVS tree.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 12:19 serge          New Issue                                    
08-15-04 12:19 serge          File Added: oss-bug.cpp                      
08-15-04 12:26 serge          Issue Monitored: serge                       
08-26-04 19:54 serge          Note Added: 0001635                          
08-27-04 14:01 Clemens LadischSummary                  OSS emulation on
'snd-via82xx' & nonblocking write to /dev/dsp => OSS emulation and nonblocking
write to /dev/dsp
08-29-04 12:26 perex          Status                   new => assigned     
08-29-04 12:26 perex          Assigned To               => perex           
09-07-04 16:38 perex          Status                   assigned => resolved
09-07-04 16:38 perex          Resolution               open => fixed       
09-07-04 16:38 perex          Note Added: 0001713                          
11-09-04 16:17 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
