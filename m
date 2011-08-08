From: =?ISO-8859-1?Q?Andr=E9e_=27Glaucous=27?= <glakke1@gmail.com>
Subject: Re: HDMI LPCM (7.1) with AMD/FGLRX
Date: Tue, 9 Aug 2011 00:13:24 +0200
Message-ID: <CAD=fgeKsQAFTD3m41p7o6AAm9H53On=O4ZOkioCk+CJJQ99RTA@mail.gmail.com>
References: <CAD=fgeJpR6xJbHxmp3EfWa1SOn_dx6ibQ4ffBTdf492UYrR06w@mail.gmail.com>
	<s5haabk9xud.wl%tiwai@suse.de>
	<CAD=fgeLDRisd8V88NL7L8Vfty95kCqaWUDM6onxSPNbd2udwRw@mail.gmail.com>
	<s5hk4aogrhu.wl%tiwai@suse.de>
	<CAD=fgeJrbWs9faGKf_wah7qOLV3juDHSDNtTnhy3XQ2u2WzM4w@mail.gmail.com>
	<s5hmxfkf505.wl%tiwai@suse.de>
	<CAD=fge+x+wPPROTsnOSkwUM+PXKLajYxLczZFhmRqksd25oKJA@mail.gmail.com>
	<s5h39hceyqw.wl%tiwai@suse.de>
	<CAD=fge+v1C9mNU8Bq06HTsY-qmXB76UZkXP3kPyvefrzXEQp8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 27ABE24686
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 00:13:25 +0200 (CEST)
Received: by vws20 with SMTP id 20so3699736vws.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2011 15:13:24 -0700 (PDT)
In-Reply-To: <CAD=fge+v1C9mNU8Bq06HTsY-qmXB76UZkXP3kPyvefrzXEQp8g@mail.gmail.com>
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

Okay, after waking up and stopped being stupid, I cloned latest alsa-kernel,
this however still resulted in your patch failing, but I
managed to install it manually.

I still can't run speaker-test with more than 2 channels.
(HDMI is card1 now)
--
/proc/asound/card1/eld#0.0
monitor_present 1
eld_valid 1
monitor_name
connection_type HDMI
eld_version [0x0] reserved
edid_version [0x0] no CEA EDID Timing Extension block present
manufacture_id 0x0
product_id 0x0
port_id 0x0
support_hdcp 0
support_ai 0
audio_sync_delay 0
speakers [0xffff] FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC FLW/FRW FLH/FRH TC
FCH
sad_count 0
--

Now monitor is present (which I should add, it also was when I updated to
kernel 3.0 without any alsa patch), and there are many more channels,
which is probably because due to your patch hardcoding the channel count.

--
codec#0
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
  Converter: stream=3D1, channel=3D0
  Digital: Enabled
  Digital category: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D03, enabled=3D1
  Connection: 1
     0x02
--

2011/8/8 Andr=E9e 'Glaucous' <glakke1@gmail.com>

> I'm not quite sure which version (of patch_hdmi.c) you are using, since t=
he
> patch fails on kernel 3.0-stable.
>
> --
> patching file sound/pci/hda/patch_hdmi.c
> Hunk #1 FAILED at 923.
> Hunk #2 FAILED at 996.
> 2 out of 2 hunks FAILED -- saving rejects to file
> sound/pci/hda/patch_hdmi.c.rej
>
>
> On 8 August 2011 16:58, Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Mon, 8 Aug 2011 16:43:31 +0200,
>> Andr=E9e 'Glaucous' wrote:
>> >
>> > Thanks.
>> >
>> > # hda-verb /dev/snd/hwC2D0 0x03 GET_PIN_SENSE 0
>> > nid =3D 0x3, verb =3D 0xf09, param =3D 0x0
>> > value =3D 0xffffffff
>>
>> This looks pretty invalid.
>>
>> > With monitor connected and outputting.
>>
>> So, either codec or the a driver is too lazy to give the info.
>>
>> Also, looking at your codec proc file, the codec doesn't give the
>> right channel count, too.
>>
>> What happens with the patch below?
>>
>>
>> Takashi
>>
>> ---
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 19cb72d..4da81b3 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -923,6 +923,7 @@ static void hdmi_present_sense(struct hda_codec
>> *codec, hda_nid_t pin_nid,
>>
>>        memset(eld, 0, sizeof(*eld));
>>
>> +       printk(KERN_INFO "XXX HDMI pin_sense =3D 0x%x\n", present);
>>        eld->monitor_present    =3D !!(present & AC_PINSENSE_PRESENCE);
>>        if (eld->monitor_present)
>>                eld->eld_valid  =3D !!(present & AC_PINSENSE_ELDV);
>> @@ -996,6 +997,7 @@ static int hdmi_add_cvt(struct hda_codec *codec,
>> hda_nid_t cvt_nid)
>>
>>        chans =3D get_wcaps(codec, cvt_nid);
>>        chans =3D get_wcaps_channels(chans);
>> +       chans =3D 8; /* XXX */
>>
>>        cvt_idx =3D spec->num_cvts;
>>        per_cvt =3D &spec->cvts[cvt_idx];
>>
>
>
