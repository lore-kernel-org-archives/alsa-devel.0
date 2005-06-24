From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001212]: no sound via82xx kernel 2.6.12
Date: Fri, 24 Jun 2005 11:19:49 +0200
Message-ID: <6dbda6159fa48607c3d967ba58fb6676@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4530222A
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 11:19:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1212> 
======================================================================
Reported By:                bricem13
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1212
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               debian sarge
Kernel Version:             2.6.12
======================================================================
Date Submitted:             06-24-2005 10:06 CEST
Last Modified:              06-24-2005 11:19 CEST
======================================================================
Summary:                    no sound via82xx kernel 2.6.12
Description: 
I updated my kernel to 2.6.12 and since I don't have sound anymore.

The volume are unmuted and the right modules are present:

[brice@TuxBox:brice]$ lsmod|grep snd
snd_via82xx            26432  1
gameport               15624  1 snd_via82xx
snd_ac97_codec         70520  1 snd_via82xx
snd_pcm_oss            47008  0
snd_mixer_oss          17024  2 snd_pcm_oss
snd_pcm                83464  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              23684  1 snd_pcm
snd_page_alloc          9604  2 snd_via82xx,snd_pcm
snd_mpu401_uart         7424  1 snd_via82xx
snd_rawmidi            24352  1 snd_mpu401_uart
snd_seq_device          8332  1 snd_rawmidi
snd                    53380  9
snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10080  2 snd
[brice@TuxBox:brice]$

[brice@TuxBox:brice]$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7
[Apollo KT266/A/333 AGP]
0000:00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0e.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
0000:00:0e.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
0000:00:0e.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394
Controller (rev 02)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537
[AC97 Modem] (rev 80)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4
420 Go] (rev a3)
0000:06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8180L
802.11b MAC (rev 20)
[brice@TuxBox:brice]$

I do not know what's wrong! I tried alsaconf unsuccesfully.
I noticed also that I don't have a /etc/asound.state file but a
/var/lib/alsa/asound.state one


I am stuck without sound...


Best regards, Brice


======================================================================

----------------------------------------------------------------------
 pzad - 06-24-05 10:14 
----------------------------------------------------------------------
Do 
alsactl -f test.state store
and attach test.state file

----------------------------------------------------------------------
 tiwai - 06-24-05 11:19 
----------------------------------------------------------------------
If it worked with 2.6.11.x, try this old (working) kernel and get the
contents of /proc/asound/card0/codec97#0/* files to compare with the
contents of them on 2.6.12.
(Also, compile with CONFIG_SND_DEBUG=y).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-24-05 10:06 bricem13       New Issue                                    
06-24-05 10:06 bricem13       Distribution              => debian sarge    
06-24-05 10:06 bricem13       Kernel Version            => 2.6.12          
06-24-05 10:14 pzad           Note Added: 0005207                          
06-24-05 10:34 bricem13       File Added: test.state                       
06-24-05 11:19 tiwai          Note Added: 0005213                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
