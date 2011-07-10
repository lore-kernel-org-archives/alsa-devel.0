From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: max channels of 3 jacks 6 channels motherboard
 using model=auto realtek codec
Date: Sun, 10 Jul 2011 11:31:44 +0800
Message-ID: <CAN8cciZimvz1MnnWKXoaq+hNTwO8BcSoWyq7ga12EGE-KNBt-w@mail.gmail.com>
References: <CAN8cciZ58WH+sctP0DsaHsEBgkCpPPEHDpf3J=tVMaxvk+RRkg@mail.gmail.com>
	<s5hy60cdln2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C98110389A
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 12:46:43 +0200 (CEST)
Received: by fxh2 with SMTP id 2so4128643fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2011 03:46:42 -0700 (PDT)
In-Reply-To: <s5hy60cdln2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/7/6 Takashi Iwai <tiwai@suse.de>:
> At Wed, 6 Jul 2011 11:53:47 +0800,
> Raymond Yau wrote:
>>
>> Refer to commit ce764ab22e40a046065c9417ee5f04ad2a816ac1
>>
>> ALSA: hda - Add channel-mode support to Realtek auto-parser
>>
>> It seem that max channel is six instead of two when the channel mode
>> is 2ch for those 3 jacks motherboard
>>
>> using hda-emu and alsa-info from
>> http://thread.gmane.org/gmane.linux.alsa.devel/86816
>>
>> > PCM 0 p 44100 2 16
>> Open PCM ALC887 Analog for play
>> Available PCM parameters:
>> =A0 channels: 2/6
>> =A0 formats: S16_LE S32_LE
>> =A0 rates: 44100 48000 96000 192000
>> Prepare PCM, rate=3D44100, channels=3D2, format=3D16 bits
>>
>>
>> because
>>
>> =A0 =A0 =A0 spec->multiout.max_channels =3D spec->multiout.num_dacs * 2;
>>
>> is assigned after =A0alc_auto_add_multi_channel_mode() increase
>> spec->multiout.num_dacs from 1 to 3
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.num_dacs =3D num_pins + 1;
>
> Right, and this is intentional. =A0Since there should be enough amount
> of DACs, the driver keeps using the surround DACs statically.
> In that way, apps can keep opening the device in the surround mode
> while user can switch the outputs on the fly via channel-mode mixer
> enum.
>
>

How can the driver support 6 channels when the input jacks have not
been retasked as output ?

This behaviour seem different from model=3D3stack-6ch or
model=3D3stack-6ch-dig or those via codec with smart51 "OFF"

Another example is 4jacks 8 channels CLEVO P150HM notebook in

http://thread.gmane.org/gmane.linux.alsa.devel/86475/focus=3D86601

I wonder how PA server can know the notebook support multi channels
when it does not check the existence of "Channel Mode" or "Smart51"
control  since input jacks remain for input by default

http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/10096

Even jack dectect api cannot provide any info whether the jack is
retaskable or not or any event which indicate the jacks have been
retasked from input to output or vice versa
