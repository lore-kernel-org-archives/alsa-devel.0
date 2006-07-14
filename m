From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002281]: No sound with Realtek ALC880
Date: Fri, 14 Jul 2006 18:17:08 +0200
Message-ID: <12399a7fb00e3ff435c50468a5208d1e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DEFA6100
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 18:17:08 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2281> 
======================================================================
Reported By:                andy_w
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2281
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               no special distribution - Linux From Scratch (but
also tested with Mandrake)
Kernel Version:             2.6.16.20
======================================================================
Date Submitted:             07-14-2006 18:17 CEST
Last Modified:              07-14-2006 18:17 CEST
======================================================================
Summary:                    No sound with Realtek ALC880
Description: 
Got a notebook with Intel 945GM + ICH7-M and Realtek HDA. The driver
snd-hda-intel from alsa-driver-1.0.12rc1 can be loaded without errors.
Everything look's good but there is no sound output. Mixer and various
sound-apps work ok they can access /dev/dsp, ... volumes are set to 100%
but there is no hearable sound.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-14-06 18:17 andy_w         New Issue                                    
07-14-06 18:17 andy_w         Distribution              => no special
distribution - Linux From Scratch (but also tested with Mandrake)
07-14-06 18:17 andy_w         Kernel Version            => 2.6.16.20       
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
