From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000463]: snd_powermac: Unknown symbol num_controls
Date: Wed, 25 Aug 2004 16:55:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040825145547.5814D1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A8ABD283
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2004 16:55:47 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000463
======================================================================
Reported By:                ncrfgs
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     463
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian; Crux PPC (http://cruxppc.sunsite.dk/)
Kernel Version:             2.6.8.1
Resolution:                 fixed
======================================================================
Date Submitted:             08-23-2004 19:15 CEST
Last Modified:              08-25-2004 16:55 CEST
======================================================================
Summary:                    snd_powermac: Unknown symbol num_controls
Description: 
Elimar (riesebie at lxtec dot de) and I tried the alsa-drivers 1.0.6 with
2.6.8.1 and got the following               
error while loading snd-powermac:                                         
     
                                                                          
     
snd_powermac: Unknown symbol num_controls


Elimar patched kernel sources with                                      
ftp://ftp.iasi.roedu.net/pub/mirrors/ftp.alsa-project.org/\               
     
kernel-patches/alsa-bk-2004-08-15.patch.gz. Loading this kernel           
     
gives him "snd_powermac: Unknown symbol num_controls".                    
      
                                                                          
     
So he patched the "patched kernel" withe the attached patch and 1.0.6     
      
runs perfect ;-)
======================================================================

----------------------------------------------------------------------
 tiwai - 08-25-2004 16:55 CEST 
----------------------------------------------------------------------
already fixed on CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-23-04 19:15 ncrfgs         New Bug                                      
08-23-04 19:15 ncrfgs         File Added: awacs2.patch                     
08-23-04 19:15 ncrfgs         Distribution              => Debian; Crux PPC (http://cruxppc.sunsite.dk/)
08-23-04 19:15 ncrfgs         Kernel Version            => 2.6.8.1         
08-25-04 16:55 tiwai          Resolution               open => fixed       
08-25-04 16:55 tiwai          Status                   assigned => resolved
08-25-04 16:55 tiwai          Bugnote Added: 0001621                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
