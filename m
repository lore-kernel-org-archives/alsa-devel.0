From: noreply@alsa-project.org
Subject: [ALSA - driver 0000207]: Mixer controls wrong with Intel Corp. 82801DB AC'97 Audio (rev 01)
Date: Fri, 16 Jul 2004 12:51:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105116.225E026008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 856D3255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:51:16 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000207
======================================================================
Reported By:                biny
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     207
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Red Hat Linux 9
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-13-2004 11:20 CEST
Last Modified:              07-16-2004 12:51 CEST
======================================================================
Summary:                    Mixer controls wrong with Intel Corp. 82801DB AC'97 Audio (rev 01)
Description: 
Master and PCM mixer controls do affect to the volume correctly, but the
balance does not affect to the balance.

Some flash animation got the sound in some way wrong when I was using the
OSS driver and then I changed to alsa to see whether it would work better.
It doesn't. If I mute either left or right (not both), I think I get more
bass, but it still doesn't sound correctly.

======================================================================

----------------------------------------------------------------------
 biny - 05-10-2004 14:45 CEST 
----------------------------------------------------------------------
Sorry, this bug is can be closed as invalid. (A plug was loosely
connected.)

----------------------------------------------------------------------
 tiwai - 05-10-2004 15:40 CEST 
----------------------------------------------------------------------
ok, closed as you wished :)

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-13-04 11:20 biny           New Bug                                      
04-13-04 11:20 biny           Distribution              => Red Hat Linux 9 
04-13-04 11:20 biny           Kernel Version            => 2.4.25          
05-10-04 14:45 biny           Bugnote Added: 0001077                       
05-10-04 15:40 tiwai          Bugnote Added: 0001078                       
05-10-04 15:40 tiwai          Assigned To               => tiwai           
05-10-04 15:40 tiwai          Resolution               open => not a bug   
05-10-04 15:40 tiwai          Status                   new => resolved     
07-16-04 12:51 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
