From: Chris Clayton <chris2553@googlemail.com>
Subject: No CD audio with kernel 2.6.32.3
Date: Mon, 11 Jan 2010 20:51:57 +0000
Message-ID: <c6b1100b1001111251pb33f11atf5131228de6dc90d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E490244FD
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 21:51:58 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so1896643fgg.2
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:51:57 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please cc me on any reply - I'm not subscribed.

Except for CD audio, sound is working fine on my new HP G61 laptop
with kernel 2.6.32.3. I can play CD audio fine in Windows.

IIRC, on my (very) old Dell laptop, alsamixer showed a CD audio
device, but that's not the case on the G61. I have asla built as
modules.

Diagnostics:

[chris:~]$ lsmod | grep snd
snd_hda_codec_intelhdmi    10250  1
snd_hda_codec_idt      40146  1
snd_hda_intel          17040  1
snd_hda_codec          46119  3
snd_hda_codec_intelhdmi,snd_hda_codec_idt,snd_hda_intel
snd_pcm                51424  2 snd_hda_intel,snd_hda_codec
snd_timer              15133  1 snd_pcm
snd                    37459  8
snd_hda_codec_intelhdmi,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          5657  2 snd_hda_intel,snd_pcm

[chris:~]$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: INTEL HDMI [INTEL HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

[chris:~]$ amixer controls
numid=10,iface=MIXER,name='Master Playback Switch'
numid=9,iface=MIXER,name='Master Playback Volume'
numid=5,iface=MIXER,name='Headphone Playback Switch'
numid=4,iface=MIXER,name='Headphone Playback Volume'
numid=15,iface=MIXER,name='PCM Playback Volume'
numid=3,iface=MIXER,name='Mic Jack Mode'
numid=7,iface=MIXER,name='Capture Switch'
numid=6,iface=MIXER,name='Capture Volume'
numid=11,iface=MIXER,name='IEC958 Playback Con Mask'
numid=12,iface=MIXER,name='IEC958 Playback Pro Mask'
numid=13,iface=MIXER,name='IEC958 Playback Default'
numid=14,iface=MIXER,name='IEC958 Playback Switch'
numid=8,iface=MIXER,name='Mux Capture Volume'
numid=2,iface=MIXER,name='Speaker Playback Switch'
numid=1,iface=MIXER,name='Speaker Playback Volume'

[chris:~]$ amixer scontrols
Simple mixer control 'Master',0
Simple mixer control 'Headphone',0
Simple mixer control 'Speaker',0
Simple mixer control 'PCM',0
Simple mixer control 'Mic Jack Mode',0
Simple mixer control 'IEC958',0
Simple mixer control 'Capture',0
Simple mixer control 'Mux',0

Extract from dmesg:
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64

Let me know if there is any other information I can provide.

Thanks

Chris

-- 
No, Sir; there is nothing which has yet been contrived by man, by which
so much happiness is produced as by a good tavern or inn - Doctor Samuel
Johnson
