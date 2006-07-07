From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002198]: No sound out of the built in
	speakers, but from headphones on a Apple MacBook Pro
Date: Fri, 7 Jul 2006 05:21:01 +0200
Message-ID: <c7b2d693c59f1485f5ddc2e5a4aecb89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8D85259
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 05:21:01 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2198> 
======================================================================
Reported By:                enlighter
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2198
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.16.16
======================================================================
Date Submitted:             06-09-2006 12:09 CEST
Last Modified:              07-07-2006 05:21 CEST
======================================================================
Summary:                    No sound out of the built in speakers, but from
headphones on a Apple MacBook Pro
Description: 
Hi,

this error occours on all macbook pros! (see www.mactel-linux.org). Sound
comes only out of the headphones or out of line-out, but the internal
speakers keep mute. I cannot unmute them using the mixer (alsamixer,
kmix). I also tried a rc version of linux-2.6.17 with the same result.

I also tried to load the snd-hda-intel module with "model=laptop" and
"model=laptop-eapd".
======================================================================

----------------------------------------------------------------------
 tiwai - 07-06-06 18:20 
----------------------------------------------------------------------
Make a diff of the state with HP (if any changes are found).

When you compile with --with-debug=detect option
(CONFIG_SND_DEBUG_DETECT=y kconfig), the driver will show the detected pin
configurations in kernel message.  Please show it, too.

----------------------------------------------------------------------
 Gendo - 07-07-06 05:21 
----------------------------------------------------------------------
Tiwai, 
The diff with the headphones plugged in showed no differences.

Below is hopefully the kernel output you requested.

[17179598.288000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:663:
codec_mask = 0x1
[17179598.556000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:1737: hda_codec:
PCI 8384:7680, codec config 3 is selected
[17179598.644000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:2133: autoconfig:
line_outs=1 (0xa/0x0/0x0/0x0/0x0)
[17179598.644000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:2137:   
speaker_outs=1 (0xc/0x0/0x0/0x0/0x0)
[17179598.644000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:2139:    hp=0x0,
dig_out=0x10, din_in=0x11
[17179598.644000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:2147:    inputs:
mic=0xb, fmic=0x0, line=0xf, fline=0x0, cd=0x0, aux=0x0
[17179617.552000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1124:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[17179617.568000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x8, stream=0x5, channel=0, format=0x11
[17179617.576000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[17179617.584000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[17179617.592000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
[17179618.048000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
[17179618.056000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
[17179618.064000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
[17179618.072000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x8, stream=0x0, channel=0, format=0x0
[17180186.872000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1124:
azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
[17180186.888000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x8, stream=0x5, channel=0, format=0x11
[17180186.896000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
[17180186.904000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
[17180186.912000] ALSA
/usr/src/alsa/alsa-driver-1.0.12rc1/pci/hda/hda_codec.c:636:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-09-06 12:09 enlighter      New Issue                                    
06-09-06 12:09 enlighter      Distribution              => Gentoo Linux    
06-09-06 12:09 enlighter      Kernel Version            => 2.6.16.16       
06-14-06 09:47 enlighter      Issue Monitored: enlighter                    
06-18-06 09:27 enlighter      Note Added: 0010297                          
06-18-06 09:29 enlighter      Note Added: 0010298                          
06-25-06 20:17 enlighter      Note Added: 0010518                          
06-26-06 16:08 tiwai          Note Added: 0010541                          
06-26-06 16:20 enlighter      Note Added: 0010546                          
06-26-06 16:34 tiwai          Note Added: 0010547                          
06-29-06 17:48 tiwai          Note Added: 0010676                          
07-05-06 04:18 Gendo          Note Added: 0010830                          
07-05-06 15:21 tiwai          Note Added: 0010838                          
07-06-06 03:13 Gendo          Note Added: 0010848                          
07-06-06 15:46 tiwai          Note Added: 0010861                          
07-06-06 18:14 Gendo          Note Added: 0010869                          
07-06-06 18:20 tiwai          Note Added: 0010870                          
07-07-06 05:21 Gendo          Note Added: 0010893                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
