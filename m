From: noreply@alsa-project.org
Subject: [ALSA - driver 0000352]: cracks and blibs when playing Quake 1
Date: Fri, 16 Jul 2004 12:50:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105057.284C926005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6AE72255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:50:57 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000352
======================================================================
Reported By:                maps4711
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     352
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.7
======================================================================
Date Submitted:             06-30-2004 13:34 CEST
Last Modified:              07-16-2004 12:50 CEST
======================================================================
Summary:                    cracks and blibs when playing Quake 1
Description: 
Playing Quake1 (quakeforge-flavor with ALSA-driver) I hear cracks and
blibs. Other apps (xine, mpg321) are fine. The OSS driver in 2.6.7
produces no cracks (but reverses stereo BTW).
======================================================================

----------------------------------------------------------------------
 maps4711 - 07-03-2004 15:32 CEST 
----------------------------------------------------------------------
I fixed it, i.e. it works for me.

*No swapping of stereo channels
*no cracks

See the patch for details.

----------------------------------------------------------------------
 perex - 07-04-2004 13:07 CEST 
----------------------------------------------------------------------
Applied to CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 13:34 maps4711       New Bug                                      
06-30-04 13:34 maps4711       Distribution              => Debian          
06-30-04 13:34 maps4711       Kernel Version            => 2.6.7           
07-03-04 15:32 maps4711       File Added: alsa-driver-2.6.7-es1938.diff                    
07-03-04 15:32 maps4711       Bugnote Added: 0001378                       
07-04-04 13:07 perex          Bugnote Added: 0001379                       
07-04-04 13:07 perex          Assigned To               => perex           
07-04-04 13:07 perex          Resolution               open => fixed       
07-04-04 13:07 perex          Status                   new => resolved     
07-16-04 12:50 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
