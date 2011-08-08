From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: Re: HDMI LPCM (7.1) with AMD/FGLRX
Date: Mon, 8 Aug 2011 16:43:31 +0200
Message-ID: <CAD=fge+x+wPPROTsnOSkwUM+PXKLajYxLczZFhmRqksd25oKJA@mail.gmail.com>
References: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
	<s5haabk9xud.wl%tiwai@suse.de>
	<CAD=fgeLDRisd8V88NL7L8Vfty95kCqaWUDM6onxSPNbd2udwRw@mail.gmail.com>
	<s5hk4aogrhu.wl%tiwai@suse.de>
	<CAD=fgeJrbWs9faGKf_wah7qOLV3juDHSDNtTnhy3XQ2u2WzM4w@mail.gmail.com>
	<s5hmxfkf505.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 903CD244FD
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 16:43:32 +0200 (CEST)
Received: by vxh2 with SMTP id 2so3246755vxh.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 07:43:31 -0700 (PDT)
In-Reply-To: <s5hmxfkf505.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks.

# hda-verb /dev/snd/hwC2D0 0x03 GET_PIN_SENSE 0
nid =3D 0x3, verb =3D 0xf09, param =3D 0x0
value =3D 0xffffffff

With monitor connected and outputting.

On 8 August 2011 14:43, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 8 Aug 2011 12:22:26 +0200,
> Andr=E9e 'Glaucous' wrote:
> >
> > Turns out hda-verb is somewhat "out of my league".
> > This is what I came up with, but I'm not sure what PARAMETER I should u=
se
> in
> > order to get something useful, I'm actually not sure
> > if it's the correct nid either. If you could point me (even more) in the
> > correct direction that'd be good, so that I can confirm it.
> >
> > # hda-verb /dev/snd/hwC2D0 0x0 GET_PIN_SENSE VENDOR_ID
>
> It should be like:
>
>  # hda-verb /dev/snd/hwC2D0 0x03 GET_PIN_SENSE 0
>
> The pin NID is 0x03.
>
>
> Takashi
>
> >
> > On 8 August 2011 11:52, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Mon, 8 Aug 2011 11:32:43 +0200,
> > > Andr=E9e 'Glaucous' wrote:
> > > >
> > > > >>
> > > > /proc/asound/Generic/codec#0
> > > >
> > > > Codec: ATI R6xx HDMI
> > > > Address: 0
> > > > AFG Function Id: 0x1 (unsol 0)
> > > > Vendor Id: 0x1002aa01
> > > > Subsystem Id: 0x00aa0100
> > > > Revision Id: 0x100200
> > > > No Modem Function Group found
> > > > Default PCM:
> > > >     rates [0x70]: 32000 44100 48000
> > > >     bits [0x2]: 16
> > > >     formats [0x5]: PCM AC3
> > > > Default Amp-In caps: N/A
> > > > Default Amp-Out caps: N/A
> > > > GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> > > > Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
> > > >   Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
> > > >   Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
> > > >   Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
> > > >   Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
> > > >   Device: name=3D"HDMI 0", type=3D"HDMI", device=3D3
> > > >   Converter: stream=3D1, channel=3D0
> > > >   Digital: Enabled
> > > >   Digital category: 0x0
> > > > Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
> > > >   Pincap 0x00000094: OUT Detect HDMI
> > > >   Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
> > > >     Conn =3D Digital, Color =3D Unknown
> > > >     DefAssociation =3D 0x1, Sequence =3D 0x0
> > > >   Pin-ctls: 0x40: OUT
> > > >   Unsolicited: tag=3D03, enabled=3D1
> > > >   Connection: 1
> > > >      0x02
> > > > <<
> > > >
> > > > Since it's R6xx, it should be processed by patch_generic_hdmi().
> > > >
> > > > >>
> > > > patch_hdmi.c
> > > > ..
> > > >
> > > > id =3D 0x1002aa01, .name =3D "R6xx HDMI", .patch =3D patch_generic_=
hdmi
> > > > <<
> > > >
> > > > Although this might not be proof enough, how best would I debug and
> > > > check if it's using patch_generic_hdmi?
> > >
> > > Don't worry, if it has ELD file, it alone means it's generic-HDMI
> > > parser.
> > >
> > >
> > > > I also checked the ELD, while outputting video to HDMI (to make sure
> > > > it's enabled) to the screen.
> > > >
> > > > (Generic is symlink to card2)
> > > > >>
> > > > /proc/asound/Generic/eld#0.0
> > > >
> > > > monitor_present               0
> > > > eld_valid             1
> > > > monitor_name
> > > > connection_type               HDMI
> > > > eld_version           [0x0] reserved
> > > > edid_version          [0x0] no CEA EDID Timing Extension block
> present
> > > > manufacture_id                0x0
> > > > product_id            0x0
> > > > port_id                       0x0
> > > > support_hdcp          0
> > > > support_ai            0
> > > > audio_sync_delay      0
> > > > speakers              [0x0]
> > > > sad_count             0
> > > > <<
> > > >
> > > > It seems to think that it's valid at least, but I doesn't seem to
> > > > output any information about it (speaker count etc).
> > >
> > > The monitor isn't present, so it seems that it didn't get ELD info.
> > > The information is taken from the pin-sense verb, so you can even get
> > > it externally via hda-verb for confirming whether the information is
> > > correct or not.
> > >
> > >
> > > Takashi
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
