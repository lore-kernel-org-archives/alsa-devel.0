From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001401]: No Brooktree Bt878 in /proc/asound/cards
Date: Wed, 7 Sep 2005 21:04:30 +0200
Message-ID: <fcf52671b5f401a92465e3de037da415@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DE29197
	for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2005 21:04:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1401> 
======================================================================
Reported By:                ojec
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1401
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gnetoo
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-07-2005 21:04 CEST
Last Modified:              09-07-2005 21:04 CEST
======================================================================
Summary:                    No Brooktree Bt878 in /proc/asound/cards
Description: 
In alsa version 1.0.6 (included in kernel 2.6.10) a have record in
/proc/asound/cards that says:

2 [Bt878          ]: Bt87x - Brooktree Bt878
                     Brooktree Bt878 at 0xe3002000, irq 11

In alsa 1.0.9b (kernel 2.6.13) there is no record about bt87x.

# lspci

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0a.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
0000:00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 07)
0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 07)
0000:00:0d.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61)
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
0000:00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4
MX 4000 AGP 8x] (rev c1)

# lsmod

snd_seq_midi            8672  0
snd_emu10k1_synth       7872  0
snd_emux_synth         38336  1 snd_emu10k1_synth
snd_seq_virmidi         7552  1 snd_emux_synth
snd_seq_midi_emul       7872  1 snd_emux_synth
raid1                  17664  1
nvidia               3467228  32
parport_pc             28164  1
lp                     10920  0
parport                37128  2 parport_pc,lp
tun                     8896  2
usb_storage            32192  0
8250                   23524  0
serial_core            23168  1 8250
tuner                  22052  0
msp3400                27112  0
bttv                  154128  2
video_buf              22148  1 bttv
firmware_class         10304  1 bttv
i2c_algo_bit            9928  1 bttv
v4l2_common             5760  1 bttv
btcx_risc               4808  1 bttv
i2c_core               22736  4 tuner,msp3400,bttv,i2c_algo_bit
videodev                9664  3 bttv
snd_rtctimer            3152  0
rtc                    12552  1 snd_rtctimer
snd_bt87x              13444  1
snd_via82xx            27456  0
snd_mpu401_uart         7872  1 snd_via82xx
snd_emu10k1            99396  4 snd_emu10k1_synth
snd_rawmidi            25120  4
snd_seq_midi,snd_seq_virmidi,snd_mpu401_uart,snd_emu10k1
snd_ac97_codec         75936  2 snd_via82xx,snd_emu10k1
snd_util_mem            4480  2 snd_emux_synth,snd_emu10k1
snd_hwdep               9540  2 snd_emux_synth,snd_emu10k1
usbhid                 32384  0
ehci_hcd               30916  0
uhci_hcd               33552  0

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-07-05 21:04 ojec           New Issue                                    
09-07-05 21:04 ojec           Distribution              => Gnetoo          
09-07-05 21:04 ojec           Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
