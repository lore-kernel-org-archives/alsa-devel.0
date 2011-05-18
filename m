From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALC892 Support (Intel HDA) - HDMI
Date: Wed, 18 May 2011 10:26:47 +0800
Message-ID: <BANLkTi=rcp_oq52A18E5h1H5YyZXyriotA@mail.gmail.com>
References: <F8FDC04B-B0AC-48F8-A6FB-E533F1931DC7@gmail.com>
	<BANLkTinGpqJc9Pnr5rn-NqR6aztr2nv1bA@mail.gmail.com>
	<A90C44D0-5C9F-4B97-BEE8-2EBBB5EAFFED@gmail.com>
	<BANLkTikseuwof1PXqyw1mk928JPWT1TqWA@mail.gmail.com>
	<CA212CA8-737E-429F-9C26-C8FCBED8B701@gmail.com>
	<A684A82E-8E42-4614-BAC4-211E33623058@sittercity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 678A11037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 04:26:48 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1034332fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 19:26:48 -0700 (PDT)
In-Reply-To: <A684A82E-8E42-4614-BAC4-211E33623058@sittercity.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/18 Jeremy Bush <jbush@sittercity.com>:
>
> On May 15, 2011, at 10:50 PM, Jeremy Bush wrote:
>
>>
>> On May 15, 2011, at 10:45 PM, Raymond Yau wrote:
>>
>>> 2011/5/16 Jeremy Bush <contractfrombelow@gmail.com>
>>>
>>>>>> However, it seems that the ALSA drivers (even the ones from the real=
tek
>>>>>> website) limit the output to 2 channels, 16bit, 88.2KHz.
>>>>>>
>>>>>> Here is my system information that you can see these results:
>>>>>>
>>>>>>
>>>> http://www.alsa-project.org/db/?f=3D5b55a63fea6580dfcbf1a85c7c734f977d=
f798f1
>>>>>>
>>>>>> I see the ALC892 as being supported in the ALSA changelog, but I don=
't
>>>> see
>>>>>> any model options in Documentation/HD-Audio-Models.txt. I'm currently
>>>> using
>>>>>> "options snd-hda-intel model=3D6stack-digout" (as I have 6-jack with=
 a
>>>> SPDIF
>>>>>> out on the motherboard) but I'm not sure that is actually doing
>>>> anything.
>>>>>>
>>>>>>
>>>>> As your codec info does not have "Side Playback Channel" and "Side
>>>> Playback
>>>>> Switch", it look like the model is used for 5stack motherboard which
>>>> support
>>>>> 5.1
>>>>>
>>>>> Do you hear any noise since Valerio reported noise appear when using =
the
>>>>> model=3Dauto in
>>>>>
>>>>> http://thread.gmane.org/gmane.linux.alsa.devel/84653/focus=3D84724
>>>>
>>>> I'm not actually trying to get analog working or the front-panel outpu=
t.
>>>> Only surround sound over HDMI. I have tried model=3Dauto and didn't no=
tice
>>>> anything different than specifying the model.
>>>>
>>>>>> Is what I'm getting now the best I should expect over HDMI? I saw
>>>> support
>>>>>> in ALSA and bought the motherboard expecting it to be fully supported
>>>> since
>>>>>> the changelogs say support was added.
>>>>>
>>>>> Codec: Intel CougarPoint HDMI
>>>>>
>>>>> Address: 3
>>>>> AFG Function Id: 0x1 (unsol 0)
>>>>> Vendor Id: 0x80862805
>>>>> Subsystem Id: 0x80862805
>>>>> Revision Id: 0x100000
>>>>> No Modem Function Group found
>>>>>
>>>>> Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
>>>>>
>>>>> Control: name=3D"IEC958 Playback Con Mask", index=3D1, device=3D0
>>>>> Control: name=3D"IEC958 Playback Pro Mask", index=3D1, device=3D0
>>>>> Control: name=3D"IEC958 Playback Default", index=3D1, device=3D0
>>>>> Control: name=3D"IEC958 Playback Switch", index=3D1, device=3D0
>>>>> Device: name=3D"HDMI 0", type=3D"HDMI", device=3D3
>>>>> Converter: stream=3D8, channel=3D0
>>>>> Digital: Enabled
>>>>> Digital category: 0x0
>>>>> PCM:
>>>>> =A0rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
>>>>> =A0bits [0x1e]: 16 20 24 32
>>>>> =A0formats [0x5]: PCM AC3
>>>>> Power states: =A0D0 D3 EPSS
>>>>> Power: setting=3DD0, actual=3DD0
>>>>>
>>>>> Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
>>>>> Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>>>>> Amp-Out vals: =A0[0x00 0x00]
>>>>> Pincap 0x09000094: OUT Detect HBR HDMI DP
>>>>> Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
>>>>> =A0Conn =3D Digital, Color =3D Unknown
>>>>> =A0DefAssociation =3D 0x2, Sequence =3D 0x0
>>>>> Pin-ctls: 0x40: OUT
>>>>> Unsolicited: tag=3D06, enabled=3D1
>>>>> Power states: =A0D0 D3 EPSS
>>>>> Power: setting=3DD0, actual=3DD0
>>>>> Connection: 1
>>>>> =A0 0x03
>>>>
>>>> So this seems to say I should be getting 7.1 over the HDMI output. Wha=
t do
>>>> I need to change in my config to actually get it? I tried messing arou=
nd
>>>> with /sys/class/sound/hwC1D3/user_pin_configs but I'm not sure what to
>>>> change.
>>>>
>>>>
>>> Do your hdmi monitor support 7.1 ?
>>>
>>> [ 2.090473] HDMI: detected monitor at connection type HDMI
>>> [ =A0 =A02.090475] HDMI: available speakers: FL/FR
>>> [ =A0 =A02.090477] HDMI: supports coding type LPCM: channels =3D 2, rat=
es =3D
>>> 44100 48000 88200, bits =3D 16
>>> [ =A0 =A02.090480] HDMI hot plug event: Pin=3D6 Presence_Detect=3D1 ELD=
_Valid=3D1
>>
>> Yes, it's connected to an Onkyo TX-SR607 7.2-Channel receiver.
>
>
> I've also upgraded to the latest nightly build of alsa, and still experie=
nce the same behavior.
>
> Jeremy

you have to check the video driver since it is the video driver query
hdmi monitor and pass back ELD to audio driver

>>> [    2.090475] HDMI: available speakers: FL/FR
>>> [    2.090477] HDMI: supports coding type LPCM: channels =3D 2, rates =
=3D
>>> 44100 48000 88200, bits =3D 16
