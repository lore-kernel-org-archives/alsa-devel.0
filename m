From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000408]: Volume control is chaotic
Date: Wed, 18 Aug 2004 15:41:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818134132.0338C1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4B770273
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 15:41:32 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
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
Last Modified:              08-18-2004 15:41 CEST
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

----------------------------------------------------------------------
 tiwai - 08-18-2004 13:47 CEST 
----------------------------------------------------------------------
Could you try the attached patch?

----------------------------------------------------------------------
 skamp - 08-18-2004 15:20 CEST 
----------------------------------------------------------------------
patching file pci/ice1712/aureon.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 FAILED at 273.
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 FAILED at 305.
2 out of 2 hunks FAILED -- saving rejects to file
pci/ice1712/aureon.c.rej

I installed version 1.0.6 when it got out.

----------------------------------------------------------------------
 tiwai - 08-18-2004 15:32 CEST 
----------------------------------------------------------------------
It's a patch to alsa-kernel tree (in alsa-driver).  You'll likely
need to pass an appropriate -p option.

----------------------------------------------------------------------
 skamp - 08-18-2004 15:36 CEST 
----------------------------------------------------------------------
Oops, I issued patch -Np1 instead of patch -Np0. My bad.
The patch solves the issue, but Master still has to be set to 100%, so the
overall volume is way too low for that value. If I set Front to the
maximum as well, the volume is still quite bearable, and the sound to
noise ratio is very *low*. I know this card could blow my ears away, and
I'm far from being deaf ;-)

edited on: 08-18-04 15:36

----------------------------------------------------------------------
 tiwai - 08-18-2004 15:41 CEST 
----------------------------------------------------------------------
The problem of sensitivty is that the volume is defined in a wide
range.  In the second patch I changed the master volume to -64dB
from -128dB, but it's still fairly big.  If you choose 50%, it means
-32dB.  (Moreover, surround volumes are up to -101dB.)

This problem will be solved when we introduce the dB control.
For kernel OSS emulation, the problem will remain, though...

Anyway, I'll apply the patch then.  Thanks for testing.

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
08-18-04 13:47 tiwai          Bugnote Added: 0001578                       
08-18-04 13:48 tiwai          File Added: aureon-volfix3.dif                    
08-18-04 15:20 skamp          Bugnote Added: 0001579                       
08-18-04 15:32 tiwai          Bugnote Added: 0001580                       
08-18-04 15:34 skamp          Bugnote Added: 0001581                       
08-18-04 15:36 skamp          Bugnote Edited: 0001581                      
08-18-04 15:41 tiwai          Bugnote Added: 0001583                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
