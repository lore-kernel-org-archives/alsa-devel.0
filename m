From: Jonathan McDowell <noodles@earth.li>
Subject: Audio crackles with 4.1-rc1
Date: Tue, 28 Apr 2015 12:21:57 +0100
Message-ID: <20150428112156.GQ10148@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Having upgraded to 4.1-rc1 from 4.0 I'm now hearing audio crackles at
regular intervals. I'm fairly sure this is due to the HDA power save as
once audio is playing things are fine, it's just when starting to play
audio that I hear the crackle.

System is a Dell Latitude E7240. I haven't tried a bisect yet but will
attempt to find some time to do so in the next few days. It looks like
there have been some changes in sound/hda/ between 4.0 + 4.1-rc1 so I'll
concentrate on those first.

Hopefully relevant dmesg output for the device:

[   23.551075] snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)
[   23.551279] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops 0xffffffff81891a00)
[   23.575852] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3226: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
[   23.575855] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   23.575857] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   23.575858] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   23.575859] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   23.575861] snd_hda_codec_realtek hdaudioC1D0:      Dock Mic=0x19
[   23.575863] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x1a
[   23.575870] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[   23.582324] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
[   23.582397] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
[   23.582747] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[   23.593267] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   23.594102] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input15
[   23.594268] input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input16
[   23.594346] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input17

I have:

CONFIG_SND_HDA_POWER_SAVE_DEFAULT=600

set in my kernel config. There's no dmesg output around the times when
the crackling is occurring.

J.

-- 
Friends are God's apology for relations.
