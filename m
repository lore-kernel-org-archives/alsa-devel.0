From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001161]: Midi in still does not work for Hoontech/STAudio DSP2000 C-Port
Date: Fri, 17 Jun 2005 11:13:53 +0200
Message-ID: <bc56a1b3ec40ce59bc276f5d6d6b1760@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DB8AC15A
	for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2005 11:13:53 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1161> 
======================================================================
Reported By:                vandongen2
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1161
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               linux from scratch
Kernel Version:             2.6.12-rc4-RT-V0.7.47-03
======================================================================
Date Submitted:             06-06-2005 15:29 CEST
Last Modified:              06-17-2005 11:13 CEST
======================================================================
Summary:                    Midi in still does not work for Hoontech/STAudio
DSP2000 C-Port
Description: 
As reported before in bug 000055 that is now marked resolved.
It has not been resolved.
The problem seems to be related to hardware specific registers on the card
that need to be set.

I will be happy to spend a couple of days trying different flags/bits with
the initialisation code, if somebody gives me an idea of where to start.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000055 Midi in does not work for Hoontech/STAu...
======================================================================

----------------------------------------------------------------------
 perex - 06-16-05 14:54 
----------------------------------------------------------------------
Could you try this patch?

Index: hoontech.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/hoontech.c,v
retrieving revision 1.8
diff -u -r1.8 hoontech.c
--- hoontech.c  27 Sep 2004 14:44:14 -0000      1.8
+++ hoontech.c  16 Jun 2005 12:53:44 -0000
@@ -188,7 +188,7 @@
        ICE1712_STDSP24_3_INSEL(ice->spec.hoontech.boxbits, 0);
 
        /* let's go - activate only functions in first box */
-       ice->spec.hoontech.config = 0;
+       ice->spec.hoontech.config = ICE1712_STDSP24_INSEL;
                            /* ICE1712_STDSP24_MUTE |
                               ICE1712_STDSP24_INSEL |
                               ICE1712_STDSP24_DAREAR; */

----------------------------------------------------------------------
 vandongen2 - 06-17-05 11:13 
----------------------------------------------------------------------
The patch doesn't change anything as far as I can tell.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-05 15:29 vandongen2     New Issue                                    
06-06-05 15:29 vandongen2     Distribution              => linux from scratch
06-06-05 15:29 vandongen2     Kernel Version            =>
2.6.12-rc4-RT-V0.7.47-03
06-07-05 08:24 perex          Relationship added       related to 0000055  
06-16-05 14:54 perex          Note Added: 0005055                          
06-17-05 11:13 vandongen2     Note Added: 0005066                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
