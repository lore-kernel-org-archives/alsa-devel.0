From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000457]: No AC3 via SPDIF possible
Date: Fri, 20 Aug 2004 18:13:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040820161318.073111102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 439F827C
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2004 18:13:18 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000457
======================================================================
Reported By:                nospam2000
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     457
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian SID
Kernel Version:             2.6.6
======================================================================
Date Submitted:             08-20-2004 17:42 CEST
Last Modified:              08-20-2004 18:13 CEST
======================================================================
Summary:                    No AC3 via SPDIF possible
Description: 
I have a onboard ES1371 soundcard with SPDIF output. It works fine with the
ALSA driver for analog and PCM output, even over SPDIF, but it is
impossible to play AC3 sound over the SPDIF output. Only a clicking noise
comes out of my speakers when I try this.

The problem is, that the raw data is modified by the sound chip and not
passed 1:1 to the SPDIF output. To get correct AC3 playback, the mixer and
the sample rate converter have to be bypassed. This means that
additionally to the bit ES_1373_SPDIF_THRU the bits ES_1373_RECEN_B and
ES_1373_BYPASS_P1/ES_1373_BYPASS_P2 have to be set to make AC3 playback
work.

======================================================================

----------------------------------------------------------------------
 tiwai - 08-20-2004 18:13 CEST 
----------------------------------------------------------------------
It's better to check the non-audio bit in the IEC958 status controls.
Does the attached patch work?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-20-04 17:42 nospam2000     New Bug                                      
08-20-04 17:42 nospam2000     File Added: alsa_ens1371_ac3_003.diff                    
08-20-04 17:42 nospam2000     Distribution              => Debian SID      
08-20-04 17:42 nospam2000     Kernel Version            => 2.6.6           
08-20-04 17:51 nospam2000     Bug Monitored: nospam2000                    
08-20-04 18:13 tiwai          Bugnote Added: 0001601                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
