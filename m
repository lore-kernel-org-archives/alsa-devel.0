From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Sat, 20 Jun 2009 21:23:30 -0300
Message-ID: <d54969c50906201723k66b7965and680ffcc798e61de@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<d54969c50905271227y76eefde2x2e784cd391cd6729@mail.gmail.com>
	<s5htz361d3i.wl%tiwai@suse.de> <s5hhbz61b8v.wl%tiwai@suse.de>
	<d54969c50905291035v19ab019fsdf455a6410b827de@mail.gmail.com>
	<d54969c50906052020m1202230eveab8ecc18c4b06ae@mail.gmail.com>
	<s5hhbytzq8z.wl%tiwai@suse.de>
	<d54969c50906061058g69f7c856v8fde1d48e7ec7f79@mail.gmail.com>
	<s5hiqj51xy3.wl%tiwai@suse.de>
	<d54969c50906131915x22c8f30el46ee51faf2fafe20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id CFD082458B
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 02:23:31 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so1272739qwj.56
	for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2009 17:23:30 -0700 (PDT)
In-Reply-To: <d54969c50906131915x22c8f30el46ee51faf2fafe20@mail.gmail.com>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Any news on this Takashi?

2009/6/13 Emilio L=F3pez <buhitoescolar@gmail.com>

>
>
> 2009/6/9 Takashi Iwai <tiwai@suse.de>
>
>> At Sat, 6 Jun 2009 14:58:47 -0300,
>> Emilio L=F3pez wrote:
>> >
>> > Just tried with model acer-aspire-8930g on 1.0.20, it works the same as
>> > acer-aspire-4930g. Mic works, the "tuba" thing doesn't. Googling a bit=
 I
>> found
>> > that acer-aspire-8930g is for ALC889, but mine is ALC888.
>> >
>> > I attach alsa-info.txt for this new model, just in case it's useful.
>>
>> OK, just to make things clear again:
>> you got the bass output controlled via "Side" volume when you pass
>> model=3Dacer.  Now the driver takes model=3Dacer-aspire-4930g as default,
>> and the bass doesn't work even if you change "Side" volume.
>>
>> Right?
>
>
> Right
>
>
>>
>>
>> As far as I see, the connection of "Side" volume, i.e. the pin widget
>> 0x0f, is also done for 4930g.  So, there should be anything else.
>>
>> How about the patch below?  If it still doesn't work, please give both
>> the working (model=3Dacer) and non-working (w/o model), on both "Side"
>> is set to the same level.
>
>
> The patch completely muted my system - I don't have any playback working
> (didn't test headphones though)
>
> Here is the alsa-infos you requested:
> model=3Dacer, working "side":
> http://files.getdropbox.com/u/553461/alsainfo-acer.txt
> model=3Dacer-aspire-4930g, with your patch applied (no playback):
> http://files.getdropbox.com/u/553461/alsainfo-acer-aspire-4930g%2Bpatch.t=
xt
> model=3Dacer-aspire-4930g, unpatched build, "side" not working:
> http://files.getdropbox.com/u/553461/alsainfo-acer-aspire-4930g.txt
>
> Thanks!
>
>
>>
>>
>> thanks,
>>
>> Takashi
>>
>> ---
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek=
.c
>> index 337d2a5..372a02a 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -1467,6 +1467,9 @@ static struct hda_verb
>> alc888_acer_aspire_4930g_verbs[] =3D {
>>        {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
>>        {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
>>        {0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
>> +        /* eanable EAPD? */
>> +       {0x20, AC_VERB_SET_COEF_INDEX, 0x07},
>> +       {0x20, AC_VERB_SET_PROC_COEF, 0x3050},
>>        { }
>>  };
>>
>>
> Emilio
