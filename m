From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000461]: Distcc breaks alsa-driver upon compile
Date: Wed, 25 Aug 2004 17:01:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040825150103.B726D1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0D686283
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2004 17:01:03 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000461
======================================================================
Reported By:                endtransmission
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     461
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.7
Resolution:                 fixed
======================================================================
Date Submitted:             08-22-2004 02:11 CEST
Last Modified:              08-25-2004 17:01 CEST
======================================================================
Summary:                    Distcc breaks alsa-driver upon compile
Description: 
Running Gentoo Linux, with NO optimizations or flags set, trying to emerge
(compile) Alsa-driver repeatedly gave me a Parallel Make Failed error.

Thought that this either could be addressed or simply annotated in the
documentation somewhere.  There are many builds out there that
intentionally disable the ability to distribute compiling efforts -
Xfree86 being the most prominent example that comes to mind at present. 
Editing the documentation should be but an intermediate step to either
following the example of Xfree86 in disabling distcc functionality all
together so to avoid getting compilation errors ahead of time, or applying
a fix so it will actually work.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-25-2004 17:01 CEST 
----------------------------------------------------------------------
fixed on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-22-04 02:11 endtransmissionNew Bug                                      
08-22-04 02:11 endtransmissionDistribution              => Gentoo          
08-22-04 02:11 endtransmissionKernel Version            => 2.6.7           
08-25-04 17:01 tiwai          Bugnote Added: 0001622                       
08-25-04 17:01 tiwai          Resolution               open => fixed       
08-25-04 17:01 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
