From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ALSA: hda - Send CONNECT_SEL on capture
	start
Date: Wed, 16 Nov 2011 09:02:32 -0800
Message-ID: <CAEUnVG4rPO7jxZL39N2N52GvzbMq+Az6HnircJLbovUT_L=kMg@mail.gmail.com>
References: <1321431949-9065-1-git-send-email-dgreid@chromium.org>
	<s5h1ut878iw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 574DA24149
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 18:02:54 +0100 (CET)
Received: by eyz10 with SMTP id 10so684940eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 09:02:53 -0800 (PST)
In-Reply-To: <s5h1ut878iw.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 12:53 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 16 Nov 2011 00:25:49 -0800,
> Dylan Reid wrote:
>>
>> cur_adc is set to zero in cs_capture_pcm_prepare.
>
> Not really. =A0It's set to zero until cs_capture_pcm_preare() is called.
>
>> =A0This causes the
>> SET_CONNECT_SEL verb to be sent to node zero when doing automic after
>> recording. =A0Delay sending the command until we are about to start
>> capture and cur_adc is set to the correct NID.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>> =A0sound/pci/hda/patch_cirrus.c | =A0 16 ++++++++++------
>> =A01 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
>> index 2a2d864..30f2f6a 100644
>> --- a/sound/pci/hda/patch_cirrus.c
>> +++ b/sound/pci/hda/patch_cirrus.c
>> @@ -250,6 +250,9 @@ static int cs_capture_pcm_prepare(struct hda_pcm_str=
eam *hinfo,
>> =A0 =A0 =A0 spec->cur_adc =3D spec->adc_nid[spec->cur_input];
>> =A0 =A0 =A0 spec->cur_adc_stream_tag =3D stream_tag;
>> =A0 =A0 =A0 spec->cur_adc_format =3D format;
>> + =A0 =A0 snd_hda_codec_write(codec, spec->cur_adc, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_VERB_SET_CONNECT_SE=
L,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->adc_idx[spec->cu=
r_input]);
>> =A0 =A0 =A0 snd_hda_codec_setup_stream(codec, spec->cur_adc, stream_tag,=
 0, format);
>> =A0 =A0 =A0 return 0;
>> =A0}
>> @@ -685,13 +688,13 @@ static int change_cur_input(struct hda_codec *code=
c, unsigned int idx,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* stream is running, let's swap the current=
 ADC */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __snd_hda_codec_cleanup_stream(codec, spec->=
cur_adc, 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->cur_adc =3D spec->adc_nid[idx];
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, spec->cur_adc, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_VER=
B_SET_CONNECT_SEL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->=
adc_idx[idx]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_setup_stream(codec, spec->cur_=
adc,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0spec->cur_adc_stream_tag, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0spec->cur_adc_format);
>> =A0 =A0 =A0 }
>> - =A0 =A0 snd_hda_codec_write(codec, spec->cur_adc, 0,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_VERB_SET_CONNECT_SE=
L,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->adc_idx[idx]);
>
> This breaks the case when the input-source is changed dynamically
> during the recording with CS420x.
>
>
>> =A0 =A0 =A0 spec->cur_input =3D idx;
>> =A0 =A0 =A0 return 1;
>> =A0}
>> @@ -974,9 +977,10 @@ static void cs_automic(struct hda_codec *codec)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->cur_input =3D spec->la=
st_input;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write_cache(codec, spec->cur_adc=
, 0,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 AC_VERB_SET_CONNECT_SEL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 spec->adc_idx[spec->cur_input]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (spec->cur_adc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write_cache(code=
c, spec->cur_adc, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_VERB_SET_CO=
NNECT_SEL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->adc_idx[=
spec->cur_input]);
>
> Well, it'd be better to create a function instead of scattering the
> same verb call allover.
>
> How about the (untested) patch below instead?
That is better. I tested it this morning and it works like a charm.  Can you
apply that?

Thanks Takashi,

Dylan
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
> index 2a2d864..2fbab8e 100644
> --- a/sound/pci/hda/patch_cirrus.c
> +++ b/sound/pci/hda/patch_cirrus.c
> @@ -237,6 +237,15 @@ static int cs_dig_playback_pcm_cleanup(struct hda_pc=
m_stream *hinfo,
> =A0 =A0 =A0 =A0return snd_hda_multi_out_dig_cleanup(codec, &spec->multiou=
t);
> =A0}
>
> +static void cs_update_input_select(struct hda_codec *codec)
> +{
> + =A0 =A0 =A0 struct cs_spec *spec =3D codec->spec;
> + =A0 =A0 =A0 if (spec->cur_adc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, spec->cur_adc, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_=
VERB_SET_CONNECT_SEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spe=
c->adc_idx[spec->cur_input]);
> +}
> +
> =A0/*
> =A0* Analog capture
> =A0*/
> @@ -250,6 +259,7 @@ static int cs_capture_pcm_prepare(struct hda_pcm_stre=
am *hinfo,
> =A0 =A0 =A0 =A0spec->cur_adc =3D spec->adc_nid[spec->cur_input];
> =A0 =A0 =A0 =A0spec->cur_adc_stream_tag =3D stream_tag;
> =A0 =A0 =A0 =A0spec->cur_adc_format =3D format;
> + =A0 =A0 =A0 cs_update_input_select(codec);
> =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, spec->cur_adc, stream_ta=
g, 0, format);
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -689,10 +699,8 @@ static int change_cur_input(struct hda_codec *codec,=
 unsigned int idx,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 spec->cur_adc_stream_tag, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 spec->cur_adc_format);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 snd_hda_codec_write(codec, spec->cur_adc, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_VERB_SET_CONNECT=
_SEL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->adc_idx[idx]);
> =A0 =A0 =A0 =A0spec->cur_input =3D idx;
> + =A0 =A0 =A0 cs_update_input_select(codec);
> =A0 =A0 =A0 =A0return 1;
> =A0}
>
> @@ -973,10 +981,7 @@ static void cs_automic(struct hda_codec *codec)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->cur_input =3D spec->=
last_input;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write_cache(codec, spec->cur_=
adc, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 AC_VERB_SET_CONNECT_SEL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spec->adc_idx[spec->cur_input]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_update_input_select(codec);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (present)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0change_cur_input(codec, sp=
ec->automic_idx, 0);
> @@ -1073,9 +1078,7 @@ static void init_input(struct hda_codec *codec)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs_automic(codec);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->cur_adc =3D spec->ad=
c_nid[spec->cur_input];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, =
spec->cur_adc, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 AC_VERB_SET_CONNECT_SEL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spec->adc_idx[spec->cur_input]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_update_input_select(code=
c);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0change_cur_input(codec, spec->cur_input, 1=
);
>
