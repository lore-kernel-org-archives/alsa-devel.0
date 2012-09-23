From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Dynamic HDMI PCM creation
Date: Sun, 23 Sep 2012 10:47:56 +0800
Message-ID: <CAN8ccia3vn9r0FP7NekZt7gBHWnt_W2eyz+n9yrarsU6HD7swA@mail.gmail.com>
References: <s5htxv6rq0e.wl%tiwai@suse.de> <5056F83B.7080602@canonical.com>
 <s5h7grtx78l.wl%tiwai@suse.de> <5057039C.50906@perex.cz>
 <s5hwqzsx476.wl%tiwai@suse.de> <50571596.8000207@perex.cz>
 <50572594.3090900@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id F1DB22602AD
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2012 04:47:57 +0200 (CEST)
Received: by qcsb14 with SMTP id b14so1547942qcs.38
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 19:47:56 -0700 (PDT)
In-Reply-To: <50572594.3090900@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

>
> Another question PA needs to deal with is, when this new HDMI PCM device
is plugged in, what other streams can coexist with this new HDMI stream?
What if we have an analog + HDMI combined card, but the controller only
supports one stream to either of them? In that case, we can not even probe
the HDMI device without disturbing the stream potentially being played back
through analog.

Refer to ICH8 datasheet

Independent Bus Master logic for eight general purpose streams: four input
and four output
Support four external Codecs

does it mean that for those hda codecs which support two independent spdif
, the driver can be configured to support two spdif device instead of
slaves ?

e.g. alc1200

Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x99430140: [Fixed] SPDIF Out at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x10

Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01456130: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Orange
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=6a05ac4afa90ac9c38fedd3f6940fe8da5d1fcf6

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commit;h=0852d7a654f75d22a3c09fd7da4a3551bbb37740

The other case is audio codec and hdmi codec with NVidia controller

can the hda controller support more than two streams?

**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
