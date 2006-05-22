From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002140]: No sound from mic on Fujitsu Siemens Amilo M3438G
Date: Mon, 22 May 2006 10:17:13 +0200
Message-ID: <93456ca926d1ba441f3c726fc95df523@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D72B188
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2006 10:17:13 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2140> 
======================================================================
Reported By:                jacobs
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2140
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               OpenSuSE 10.1
Kernel Version:             2.6.16.13
======================================================================
Date Submitted:             05-22-2006 10:17 CEST
Last Modified:              05-22-2006 10:17 CEST
======================================================================
Summary:                    No sound from mic on Fujitsu Siemens Amilo M3438G
Description: 
I own a Fujitsu Siemens Amilo M3438G notebook with an onboard Azalia 7.1
SPDIF chipset/codec (see spec sheet at
http://www.fujitsu-siemens.de/ps/db/notebook/ds_amilo_m3438g_m4438g_d.pdf).
OpenSuSE 10.1 (Kernel 2.6.16.13) is installed; the module snd-hda-intel is
 loaded. Sound playback through the internal speakers and headphone does
work but I am unable to get sound from the internal and external
microphone. The alsamixer has three capture controls which all are set to
capture and maximum volume. Each capture controls source is set to mic.
The playback channel for mic is unmuted and also set to maximum volume but
I just don't get a signal.

I've tried to apply different model options to the snd-hda-intel module
relating to the file ALSA-Configuration.txt without luck.

This didn't work with OpenSuSE 10.0 (Kernel 2.6.13) either.

If you need any technical information please let me know.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 10:17 jacobs         New Issue                                    
05-22-06 10:17 jacobs         Distribution              => OpenSuSE 10.1   
05-22-06 10:17 jacobs         Kernel Version            => 2.6.16.13       
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
