From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: Re: HDMI LPCM (7.1) with AMD/FGLRX
Date: Mon, 8 Aug 2011 11:32:43 +0200
Message-ID: <CAD=fgeLDRisd8V88NL7L8Vfty95kCqaWUDM6onxSPNbd2udwRw@mail.gmail.com>
References: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
	<s5haabk9xud.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EEC6103803
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 11:32:44 +0200 (CEST)
Received: by vxh2 with SMTP id 2so3044737vxh.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 02:32:43 -0700 (PDT)
In-Reply-To: <s5haabk9xud.wl%tiwai@suse.de>
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

>>
/proc/asound/Generic/codec#0

Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100200
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Device: name=3D"HDMI 0", type=3D"HDMI", device=3D3
  Converter: stream=3D1, channel=3D0
  Digital: Enabled
  Digital category: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D03, enabled=3D1
  Connection: 1
     0x02
<<

Since it's R6xx, it should be processed by patch_generic_hdmi().

>>
patch_hdmi.c
..

id =3D 0x1002aa01, .name =3D "R6xx HDMI",	.patch =3D patch_generic_hdmi
<<

Although this might not be proof enough, how best would I debug and
check if it's using patch_generic_hdmi?
I also checked the ELD, while outputting video to HDMI (to make sure
it's enabled) to the screen.

(Generic is symlink to card2)
>>
/proc/asound/Generic/eld#0.0

monitor_present		0
eld_valid		1
monitor_name		=

connection_type		HDMI
eld_version		[0x0] reserved
edid_version		[0x0] no CEA EDID Timing Extension block present
manufacture_id		0x0
product_id		0x0
port_id			0x0
support_hdcp		0
support_ai		0
audio_sync_delay	0
speakers		[0x0]
sad_count		0
<<

It seems to think that it's valid at least, but I doesn't seem to
output any information about it (speaker count etc).

On 8 August 2011 09:16, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 7 Aug 2011 21:17:46 +0200,
> Andr=E9e 'Glaucous' wrote:
> >
> > Hello.
> >
> > I'm wondering if there's any ongoing development on multichannel sound
> > support for HDMI - LPCM/5.1/7.1, not bitstreamed audio such as DTS/AC3
> > (which works).
> > I've tried both a AMD HD 4870 and AMD HD 6870, on both 2 channel and
> > bitstreamed audio works with ALSA, but not LPCM. LPCM works perfectly
> (5.1,
> > 7.1) on Windows.
> >
> > According to the mailing list there seem to have been some activity in
> this
> > area (January or so), but no success. I'd gladly try out patches.
>
> Check whether your HDMI codec chip is processed via
> patch_generic_hdmi() in patch_hdmi.c.  Some ATI codecs are via
> patch_atihdmi() and it doesn't support multi-channel LPCM.
>
> If it's through patch_generic_hdmi(), basically it should work as is,
> since the very same function is used by Intel and Nvidia HDMI, too, and
> LPCM works on them.  Of course, some unknown ATI-specific things might
> be missing.  But first check whether ELD validity is set, i.e. whether
> the video driver passes the right ELD to HDMI auido side.
>
>
> Takashi
>
