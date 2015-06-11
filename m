From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA & Realtek issues on ASUS G751JM
Date: Fri, 12 Jun 2015 01:11:39 +0800
Message-ID: <CAN8ccib4f0O5TW6Z=QzrSoRkp=EA-Km6z15TTh+HXb5me-=+NQ@mail.gmail.com>
References: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
 <s5hzj47n9d1.wl-tiwai@suse.de>
 <CAH=tA9FR7vb+dFS2Mzpd7RJGrbGNRAjj9pM3BCsdVxzG_i0YAA@mail.gmail.com>
 <s5h616ul6o5.wl-tiwai@suse.de>
 <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f196.google.com (mail-ob0-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D9826657D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 19:11:40 +0200 (CEST)
Received: by obcwm4 with SMTP id wm4so2625831obc.3
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 10:11:39 -0700 (PDT)
In-Reply-To: <CAH=tA9E_D7Nt0iS8j9GXp3duDYN=xDn5aDt2O_cZuf1gFRArJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolae Rosia <nicolae.rosia@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> The laptop has 3 jacks. 5.1/4.0 works fine in Windows 8.1 and I'm not
> talking about HDMI/SPDIF.
> If you look at the laptop specification, it says
> 1 x Microphone-in jack
> 2 x Headphone-out jack (SPDIF)
> But the microphone-in jack can also be an output.
> Also, the laptop has two microphones, a pair of speakers and a subwoofer
(?)
> I can also boot Windows and provide information, please let me know
> what you need.

/sys/class/sound/hwC1D0/init_pin_configs:
0x12 0x90a60150
0x14 0x90170110
0x15 0x04011020
0x16 0x4000c000
0x18 0x04a11060
0x19 0x411111f0
0x1a 0x90170130
0x1b 0x411111f0
0x1d 0x40c6852d
0x1e 0x90460140
0x1f 0x411111f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:

!!ALSA/HDA dmesg
!!--------------

[   35.145467] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
(N/A, 0 mBm), (N/A)
[   35.345395] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[   35.407107] uvcvideo: Found UVC 1.00 device USB2.0 HD UVC WebCam
(04f2:b414)
--
[   35.492214] iwlwifi 0000:3b:00.0: L1 Enabled - LTR Enabled
[   35.492771] input: HDA Intel HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input20
[   35.493539] input: HDA Intel HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input21
[   35.493624] input: HDA Intel HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input22
[   35.557069] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   35.564380] iwlwifi 0000:3b:00.0 wls1: renamed from wlan0
[   35.657431] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC668:
line_outs=1 (0x15/0x0/0x0/0x0/0x0) type:line
[   35.658257] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=2
(0x14/0x1a/0x0/0x0/0x0)
[   35.659068] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   35.659870] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   35.660664] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   35.661454] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   35.662241] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x18
[   35.663004] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12

Try hdajacksensetest -a to find out the two headphone jacks and mic jack by
plug and unplug

As not enough volume control for 5.1, internal speaker and subwoofer
