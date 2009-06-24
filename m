From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Wed, 24 Jun 2009 18:45:03 -0300
Message-ID: <d54969c50906241445t670343elef6f64949de9675e@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<d54969c50906221623j4fd17c6yb7fc2c9316d11766@mail.gmail.com>
	<d54969c50906231105k251880eahbf82cf74b699c7d8@mail.gmail.com>
	<1245796809.3640.10.camel@localhost>
	<d54969c50906231800p2f507c48h9e6977cc7d03461f@mail.gmail.com>
	<d54969c50906231832w48ce7315uc5cf8b3f81534c76@mail.gmail.com>
	<s5hbpoem7c3.wl%tiwai@suse.de>
	<d54969c50906241124o456a4938p173b9fbbd9cd46b3@mail.gmail.com>
	<d54969c50906241233kc51e746r691bd48c2e961a71@mail.gmail.com>
	<s5hljnhmiak.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id E930F248EE
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 23:45:06 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1411872qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 14:45:04 -0700 (PDT)
In-Reply-To: <s5hljnhmiak.wl%tiwai@suse.de>
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
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, Tony Vroon <tony@linx.net>, ALSA development ML <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/6/24 Takashi Iwai <tiwai@suse.de>:
> At Wed, 24 Jun 2009 16:33:26 -0300,
> Emilio L=F3pez wrote:
>>
>> Well, I finally got it to work. I had to triplicate the
>> "spec->autocfg.hp_pins", I don't know why, but it made it work.
>
> Hmm, does the patch below help?

Yes! Now, with just one "spec->autocfg.hp_pins", it works fine :) I
guess you can include the patch now
.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 3345331..12cc340 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -1401,6 +1401,7 @@ static void alc_automute_amp(struct hda_codec *code=
c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nid =3D spec->autocfg.hp_pins[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!nid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_read(codec, nid, 0, AC_VERB_S=
ET_PIN_SENSE, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val =3D snd_hda_codec_read(codec, nid, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 AC_VERB_GET_PIN_SENSE, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (val & AC_PINSENSE_PRESENCE) {
>
