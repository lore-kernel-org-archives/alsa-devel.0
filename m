From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_driver_0002117]:_No_5.1-support_f=FCr_VIA8237x/161?=
 =?iso-8859-1?Q?7_based_soundsystems_(i.e._VIA_EPIA_SP8000-Board)?=
Date: Mon, 15 May 2006 14:27:28 +0200
Message-ID: <56d71fb223b5d43704d86436bd450d80@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B6067228
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 14:27:28 +0200 (MEST)
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
Last Modified:              05-15-2006 14:27 CEST
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
 tiwai - 05-12-06 16:03 
----------------------------------------------------------------------
Did you test with speaker-test?

----------------------------------------------------------------------
 Flipsen1977 - 05-15-06 14:27 
----------------------------------------------------------------------
No, I couldn't, where can I get it? 

I just tried mplayer in 5.1-file with -channels 6 option resulting in a
sound without voices.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-12-06 09:42 Flipsen1977    New Issue                                    
05-12-06 09:42 Flipsen1977    Distribution              => Debian          
05-12-06 09:42 Flipsen1977    Kernel Version            => 2.6.15          
05-12-06 16:03 tiwai          Note Added: 0009775                          
05-15-06 14:27 Flipsen1977    Note Added: 0009823                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
