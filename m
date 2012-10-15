From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] Fix for conflict of HDMI and SPDIF IEC958
	controls
Date: Mon, 15 Oct 2012 21:10:44 +0800
Message-ID: <CAN8cciakmCAfwh_z8uRRmx=QyJDyWQw6upwDG_tJGu-5zkn6wg@mail.gmail.com>
References: <s5hpq4nk9b1.wl%tiwai@suse.de>
 <CAN8cciZ=7c7z5g5qSS30RnRf5TjoG8HjwBwYBtoUCMdNQ4Rxag@mail.gmail.com>
 <s5h1uh0uqhb.wl%tiwai@suse.de>
 <CAN8cciZgj6AZn1YsPgZEfvkhB54Xc+VD50nv5ELS++GcETLExQ@mail.gmail.com>
 <s5hvcect9nl.wl%tiwai@suse.de>
 <CAN8ccibBdGqPnkb06SV3EW1RukmBAKdbiLV1hsaLNTVMbU5EKw@mail.gmail.com>
 <s5hpq4kt8qk.wl%tiwai@suse.de>
 <CAN8ccib4Z9VpHcdGxP3q5kofikU6zt6risGDAbOBiRKyKVcsxA@mail.gmail.com>
 <CAN8cciY0TfZ+50EuoYbFdz1AzgNuDKZAaDE-o0v-YD_MpXnO1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 614FF2616DB
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 15:10:45 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so1411763qao.17
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 06:10:44 -0700 (PDT)
In-Reply-To: <CAN8cciY0TfZ+50EuoYbFdz1AzgNuDKZAaDE-o0v-YD_MpXnO1g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 881826@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

> > > > > >
> > > > > > how about those hdmi jack and iec958 on ad1989b?
> > > > >
> > > > > On AD codecs, all digital outputs are exposed as a single cloned
> > > > > device with HDA_PCM_TYPE_SPDIF.
> > > >
> > > > how about ad1988b with nvidia codec ?
> > >
> > > Nvidia codec provides devices only with HDA_PCM_TYPE_HDMI, of course.
> > >
> > > > from user point of view , how can they differenitate hdmi jack is
> > digital
> > > > ouput and hdmi output ?
> > >
> > > The device 1 is from AD and the device 3 is from Nvidia codec, as you
> > > can see below.  And this is exactly the case the conflict happens as I
> > > mentioned in the original mail.
> >
> > will your fix change the spdif of  those motherboard with ad1988b which
> > have iec958 but no hdmi jack ?
>
> It won't change anything unless both SPDIF and HDMI *devices* are
> actually created.
>
>
>
> > > Which is connected to what output, you can't know exactly unless you
> > > compare the obtained ELD.  The HD-audio spec isn't good enough to
> > > identify the actual output.
> >
> > it seem that there is no presence detect on this codec
>
> ELD has nothing to do with the presence detect bit.
>

ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html#_examples

6.1.2. Chipset with 8-channel support, single stream

This configuration is used in MCP77, MCP78, MCP79, MCP7A, and ION.

In the case where multiple HDMI display connectors are present, the audio
stream is broadcast to all HDMI connectors at once. A single ALSA device is
exposed.

ELD and PD information is not available on these chipsets.

In these chipsets, the multiple 2-channel converters are aggregated by the
ALSA driver and exposed as a single 8-channel device. Some chipsets support
2, or 8 channels (MCP77). Other chipsets support 2, 6, or 8 channels
(MCP79).

id = 0x10de0002, .name = "MCP77/78 HDMI",    .patch = patch_nvhdmi_8ch_7x },

does it mean that this hdmi codec support 8 channels but no ELD info ?

>
> > Codec: Nvidia MCP77/78 HDMI
> > Address: 3
> > AFG Function Id: 0x1 (unsol 0)
> > Vendor Id: 0x10de0002
> > Subsystem Id: 0x10de0101
> > Revision Id: 0x100000
> > No Modem Function Group found
> > Default PCM:
> >     rates [0x0]:
> >     bits [0x0]:
> >     formats [0x0]:
> > Default Amp-In caps: N/A
> > Default Amp-Out caps: N/A
> > GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
> > Node 0x04 [Audio Output] wcaps 0x211: Stereo Digital
> >   Control: name="IEC958 Playback Con Mask", index=1, device=0
> >   Control: name="IEC958 Playback Pro Mask", index=1, device=0
> >   Control: name="IEC958 Playback Default", index=1, device=0
> >   Control: name="IEC958 Playback Switch", index=1, device=0
> >   Device: name="HDMI 0", type="HDMI", device=3
> >   Converter: stream=0, channel=0
> >   Digital:
> >   Digital category: 0x0
> >   PCM:
> >     rates [0xc0]: 48000 88200
> >     bits [0xf]: 8 16 20 24
> >     formats [0x1]: PCM
> > Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
> >   Pincap 0x00000014: OUT Detect
> >   Pin Default 0x18560110: [Jack] Digital Out at Int HDMI
> >     Conn = Digital, Color = Unknown
> >     DefAssociation = 0x1, Sequence = 0x0
> >     Misc = NO_PRESENCE
> >   Pin-ctls: 0x40: OUT
> >   Unsolicited: tag=00, enabled=0
> >   Connection: 1
> >      0x04
> >
> > >
> > >
> > > > https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/881826
> > > >
