From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000322]: oops while removing au8810
Date: Wed, 16 Nov 2005 06:42:58 +0100
Message-ID: <260b8f17ae87b89461edbbff694b023c@85.132.177.35>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from 85.132.177.35 (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9BA581AF
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2005 06:42:58 +0100 (MET)
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
<https://85.132.177.35/alsa-bug/view.php?id=322> 
======================================================================
Reported By:                aris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   322
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               conectiva linux 10 snapshot with custom kernel
Kernel Version:             2.6.7-rc2
======================================================================
Date Submitted:             06-02-2004 13:24 CEST
Last Modified:              11-16-2005 06:42 CET
======================================================================
Summary:                    oops while removing au8810
Description: 
after getting an error on activating IRQ (not sure if this board is
working)
and trying to remove module I get an oops. I tryed to dig in but couldn't
find where exactly it is happening.
the IRQ error message:
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:01.1
Vortex: init.... <6>done.
vortex: IRQ reg error

======================================================================

----------------------------------------------------------------------
 Raymond - 09-07-05 14:08 
----------------------------------------------------------------------
cat /proc/asound/au8810/codec97#0/ac97#0-0+regs

Which one are your card ?

SQ1500

http://www.watch.impress.co.jp/akiba/hotline/991106/newitem.html#19

Vortex Advantage

http://www.watch.impress.co.jp/akiba/hotline/990724/newitem.html#28



----------------------------------------------------------------------
 Raymond - 11-16-05 06:42 
----------------------------------------------------------------------
> 0000:00:0b.0 0401: 12eb:0003 (rev 02)
>     Subsystem: 12eb:0003

Your card is Aureal Vortex Advantage which do not has digital out (coaxial
out).

   /* Enable codec channels 0 and 1. */
    hwwrite(vortex->mmio, VORTEX_CODEC_EN,
        hwread(vortex->mmio, VORTEX_CODEC_EN) | 0x00000300);


Only SQ1500 (au8810) has digital out and SDAC.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 13:24 aris           New Issue                                    
06-02-04 13:24 aris           Distribution              => conectiva linux 10
snapshot with custom kernel
06-02-04 13:24 aris           Kernel Version            => 2.6.7-rc2       
06-03-04 17:51 mjander        Note Added: 0001289                          
06-03-04 17:51 mjander        Note Added: 0001290                          
06-03-04 17:52 mjander        File Added: aureal-quadfix.patch                  
 
04-12-05 20:45 alien999999999 Issue Monitored: alien999999999                   

08-30-05 12:22 jdthood        Note Added: 0005973                          
09-06-05 11:03 Raymond        Note Added: 0006043                          
09-06-05 14:12 aris           Note Added: 0006044                          
09-06-05 14:32 Raymond        Note Added: 0006045                          
09-06-05 14:34 Raymond        Note Edited: 0006045                         
09-06-05 14:58 Raymond        Note Added: 0006046                          
09-06-05 15:02 Raymond        Note Edited: 0006046                         
09-07-05 02:22 aris           Note Added: 0006051                          
09-07-05 03:14 Raymond        Note Added: 0006052                          
09-07-05 14:08 Raymond        Note Edited: 0006052                         
11-16-05 06:42 Raymond        Note Added: 0006737                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
