From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000433]: Clicking noise on some sample rates with Chaintech AV-710 (ICE1724)
Date: Wed, 25 Aug 2004 05:56:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040825035629.6EE3D1102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BF465301
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2004 05:56:29 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000433
======================================================================
Reported By:                cabbagerat
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     433
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-09-2004 11:36 CEST
Last Modified:              08-25-2004 05:56 CEST
======================================================================
Summary:                    Clicking noise on some sample rates with Chaintech AV-710 (ICE1724)
Description: 
Playing sound at any sample rate other than 48000Hz produces a loud
clicking sound along with the expected sound. This started with the ALSA
included with kernel 2.6.7 (worked perfectly in 2.6.6).
Clicking sound is loudest at 44.1kHz, not present at 48Khz and soft but
noticeable at 96kHz.
I have tried playing with alsaplayer, aplay, mpg123 and a variety of
gstreamer based apps - all display this behavior. Both native alsa and OSS
emulation display the same problem.
======================================================================

----------------------------------------------------------------------
 av710user - 08-21-2004 02:40 CEST 
----------------------------------------------------------------------
I hear clicking noises with my AV710 at every sample rate I've tried. 
dmesg says "invalid EEPROM version 1" after loading the drivers.  If it's
any help, the VIA ICEnsemble chip on the AV710 isn't a 1724 but a 1721.  A
site I found using Google speculates that the Envy24HT-S (VT1721) is
similar to the Envy24PT (VT1720).  I'm using the ALSA 1.0.6a drivers, GCC
3.3.3 and Linux 2.4.26.

----------------------------------------------------------------------
 cabbagerat - 08-22-2004 10:04 CEST 
----------------------------------------------------------------------
Upgrading to kernel version 2.6.8.1-mm3 (CONFIG_PREEMPT disabled) stopped
the clicking noises in all sample rates. Brief testing of 2.6.8.1 without
preempt enabled also seemed to suggest that the clicking had gone. This
leads me to believe that the clicking sound is related in some way to
preempt.

----------------------------------------------------------------------
 av710user - 08-25-2004 03:00 CEST 
----------------------------------------------------------------------
I tried vanilla 2.6.8.1's ALSA drivers, and they show the same behavior as
1.0.6a and Linux 2.4.26 with my sound card.  The buzzing is less noisy at
48000, but still there.  Switching between kernels with and without
preemption hasn't had an effect for me.  Now to try the mm4 patch...

----------------------------------------------------------------------
 av710user - 08-25-2004 05:56 CEST 
----------------------------------------------------------------------
No luck with mm3 or mm4.  Another oddball from VIA.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-09-04 11:36 cabbagerat     New Bug                                      
08-09-04 11:36 cabbagerat     Distribution              => Debian Unstable 
08-09-04 11:36 cabbagerat     Kernel Version            => 2.6.7           
08-09-04 11:37 cabbagerat     Bug Monitored: cabbagerat                    
08-21-04 02:40 av710user      Bugnote Added: 0001603                       
08-22-04 10:04 cabbagerat     Bugnote Added: 0001608                       
08-25-04 03:00 av710user      Bugnote Added: 0001616                       
08-25-04 05:56 av710user      Bugnote Added: 0001618                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
