From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000443]: OSS emulation on 'snd-via82xx' & nonblocking write to /dev/dsp
Date: Sun, 15 Aug 2004 12:19:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040815101914.7A5821102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 34894228
	for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2004 12:19:15 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 8A66C18011
	for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2004 12:19:14 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000443
======================================================================
Reported By:                serge
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     443
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-15-2004 12:19 CEST
Last Modified:              08-15-2004 12:19 CEST
======================================================================
Summary:                    OSS emulation on 'snd-via82xx' & nonblocking write to /dev/dsp
Description: 
When you open '/dev/dsp' in nonblocking mode (O_NONBLOCK) and write too
much data to it, it seems that write operation always returns success and
pretends that all data was written. But calls to ioctl(oss_fd,
SNDCTL_DSP_GETOSPACE, &bufinfo) start returning weird information. Test
program that reproduces the bug is attached.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-15-04 12:19 serge          New Bug                                      
08-15-04 12:19 serge          File Added: oss-bug.cpp                      
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
