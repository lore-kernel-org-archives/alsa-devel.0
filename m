From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000468]: stuttering audio output with SDL_audio applications
Date: Fri, 27 Aug 2004 03:48:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827014821.09E772500E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4A8F51F4
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 03:48:21 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 1ADE71AAF5
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 03:48:21 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000468
======================================================================
Reported By:                int-e
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     468
Category:                   PCI - via82xx
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             08-27-2004 03:48 CEST
Last Modified:              08-27-2004 03:48 CEST
======================================================================
Summary:                    stuttering audio output with SDL_audio applications

Description: 
I traced this down to the check that's now called check_invalid_pos() in
calc_linear_pos() in the driver being triggered with lastpos==bufsize and
res==bufsize/2.

I think lastpos should be 0 at that point.

Moving the assignment viadev->lastpos = res; at the end of that function
after the wrap handling if() solved the problem for me.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-27-04 03:48 int-e          New Bug                                      
08-27-04 03:48 int-e          File Added: via82xx.diff                     
08-27-04 03:48 int-e          Distribution              => Gentoo          
08-27-04 03:48 int-e          Kernel Version            => 2.6.8.1         
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
