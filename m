From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_driver_0002117]:_No_5.1-support_f=FCr_VIA8237x/161?=
 =?iso-8859-1?Q?7_based_soundsystems_(i.e._VIA_EPIA_SP8000-Board)?=
Date: Fri, 26 May 2006 02:45:29 +0200
Message-ID: <c79199f24a0666ea086d000f2d61e1c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D24315A
	for <alsa-devel@alsa-project.org>; Fri, 26 May 2006 02:45:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2117> 
======================================================================
Reported By:                Flipsen1977
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2117
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-12-2006 09:42 CEST
Last Modified:              05-26-2006 02:45 CEST
======================================================================
Summary:                    No 5.1-support für VIA8237x/1617 based soundsystems
(i.e. VIA EPIA SP8000-Board)
Description: 
I've installed the latest via82xx-module, 2-channel works fine, but
6-channel isn't available at all.

alsamixer shows all the channels, they are unmuted und up at 90-100%, but
center/lfe und rear speakers don't work. I've been missing an opportunity
to switch the line-in and mic-in to output. As I read in some articles
there isn't yet support for this chipset.

Is there already something done?
======================================================================

----------------------------------------------------------------------
 Flipsen1977 - 05-15-06 22:17 
----------------------------------------------------------------------
Well, I tried speaker-test, but just heard sound from front-left and
front-right, no center, no lfe, no surround, although all switches where
set to 90%.

I'm missing the switches to tell the line-jack and the mic-jack to be an
output and no input-channel. For 8233/35-southbridges with
1612/1616-chipsets there should be these switches as I read in some
articles, but not for 8237/1617A as used on my VIA EPIA SP8000-board.



----------------------------------------------------------------------
 doobedoobedo - 05-26-06 02:45 
----------------------------------------------------------------------
I have a VIA EPIA SP1300 (same board different processor) and have exactly
the same problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-12-06 09:42 Flipsen1977    New Issue                                    
05-12-06 09:42 Flipsen1977    Distribution              => Debian          
05-12-06 09:42 Flipsen1977    Kernel Version            => 2.6.15          
05-12-06 16:03 tiwai          Note Added: 0009775                          
05-15-06 14:27 Flipsen1977    Note Added: 0009823                          
05-15-06 22:17 Flipsen1977    Note Edited: 0009823                         
05-26-06 02:45 doobedoobedo   Note Added: 0009970                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
