From: noreply@alsa-project.org
Subject: [ALSA - driver 0000284]: dxs autodetection broken on my ASUS A7V8X motherboard
Date: Fri, 16 Jul 2004 12:56:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105641.7481A26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ABED1244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:56:41 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000284
======================================================================
Reported By:                noaq
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     284
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.5-1.358 (should be pretty close to vanilla 2.6.5)
======================================================================
Date Submitted:             05-20-2004 09:13 CEST
Last Modified:              07-16-2004 12:56 CEST
======================================================================
Summary:                    dxs autodetection broken on my ASUS A7V8X motherboard
Description: 
I get sizzling sounds when playing 44.1khz audio with my integrated VIA
8235 chip on a ASUS A7V8X motherboard. 48khz audio sounds good. Setting
the dxs_support parameter to snd-via82xx to either 2, 3 or 4 when loading
the module solves the problem.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-21-2004 13:14 CEST 
----------------------------------------------------------------------
ok, now it's set to NO_VRA (4) on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-20-04 09:13 noaq           New Bug                                      
05-20-04 09:13 noaq           Distribution              => Fedora Core 2   
05-20-04 09:13 noaq           Kernel Version            => 2.6.5-1.358 (should be pretty close to vanilla 2.6.5)
05-21-04 13:14 tiwai          Bugnote Added: 0001163                       
05-21-04 13:14 tiwai          Assigned To               => tiwai           
05-21-04 13:14 tiwai          Resolution               open => fixed       
05-21-04 13:14 tiwai          Status                   new => resolved     
07-16-04 12:56 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
