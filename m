From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000408]: Volume control is chaotic
Date: Wed, 18 Aug 2004 13:47:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818114730.A98471102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0661D235
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 13:47:30 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000408
======================================================================
Reported By:                skamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     408
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-27-2004 18:40 CEST
Last Modified:              08-18-2004 13:47 CEST
======================================================================
Summary:                    Volume control is chaotic
Description: 
Volume control doesn't work properly, with alsa-mixer as well as with
gnome-volume-control. As I figured out that line-out volume was controled
with DAC and DAC1 (how intuitive), I noticed that while sliding the
controls up and down increased and decreased the volume as expected,
modifying the master volume control afterwards made the volume jump to a
much lower level than expected: increasing or decreasing the master volume
even just a little bit makes the overall volume drop, even though it is
not mirrored by the controls.

Thus, setting DAC and DAC1 to 100% while Master was set to 82% resulted in
a quite high volume, but modifying the master volume to 84% or 80%
resulted in the drop. Setting master volume to 60% made the sound very
low, and setting it to 40% made it almost inaudible, until I changed DAC
and DAC1 by 2%.
======================================================================

----------------------------------------------------------------------
 skamp - 08-17-2004 04:33 CEST 
----------------------------------------------------------------------
Fixed with alsa-* 1.0.6, although the Master control is weird: you only get
full sound when you set Master to 0. Increasing Master decreases overall
volume very fast. This control is basically unusable.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 18:40 skamp          New Bug                                      
07-27-04 18:40 skamp          File Added: aadebug                          
07-27-04 18:40 skamp          Distribution              => LFS 5.1.1, BLFS 5.1
07-27-04 18:40 skamp          Kernel Version            => 2.4.26          
07-27-04 18:52 skamp          Bug Monitored: skamp                         
08-17-04 04:33 skamp          Bugnote Added: 0001571                       
08-18-04 13:47 tiwai          Assigned To               => tiwai           
08-18-04 13:47 tiwai          Status                   new => assigned     
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
