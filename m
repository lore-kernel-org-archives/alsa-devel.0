From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: ALSA 1.0.20 Speex PCM Plugin
Date: Wed, 10 Jun 2009 17:36:20 -0400
Message-ID: <b24e53350906101436j76eefe98m416ee53d30fac300@mail.gmail.com>
References: <b24e53350906021339r55bef955od429a2ae0f867ec6@mail.gmail.com>
	<s5h3aagqfh0.wl%tiwai@suse.de>
	<b24e53350906040653r1f264255x607b695b612c864e@mail.gmail.com>
	<b24e53350906080759k7cf0b845ye5b7aeabae4689d9@mail.gmail.com>
	<b24e53350906081256w20e83af6j9a3ee1ad7c3df2ce@mail.gmail.com>
	<s5hvdn5x22e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001e680f17341cfd74046c054470
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f217.google.com (mail-gx0-f217.google.com
	[209.85.217.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C3A4244E7
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 23:36:21 +0200 (CEST)
Received: by gxk17 with SMTP id 17so1345855gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 14:36:20 -0700 (PDT)
In-Reply-To: <s5hvdn5x22e.wl%tiwai@suse.de>
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
Cc: Jerry Geis <geisj@messagenetsystems.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001e680f17341cfd74046c054470
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2009 at 4:07 AM, Takashi Iwai<tiwai@suse.de> wrote:
> At Mon, 8 Jun 2009 15:56:38 -0400,
> Robert Krakora wrote:
>>
>> Takashi:
>>
>> I applied your Speex echo cancellation patch. =A0I had to modify it
>> since the 'buf_out' buffer was not being malloc'd. =A0Attached are the
>> files affected by your patch. =A0The echo cancellation seems to work
>> pretty well. =A0However, turning on 'denoise' seems to cause audio to
>> drop in and out at a very periodic rate. =A0Do you have any example of
>> how to set up all of the parameters? =A0A tutorial or something? =A0Than=
ks
>> again.
>
> No idea, I just wrote it up blindly :)
> Can the preprocessor be dropped, possibly, like the patch below?
>
>
> Takashi
>
> ---
> diff --git a/doc/speexdsp.txt b/doc/speexdsp.txt
> index 875fc19..5b5e5a0 100644
> --- a/doc/speexdsp.txt
> +++ b/doc/speexdsp.txt
> @@ -12,7 +12,7 @@ using libspeex DSP API. =A0You can use the plugin with =
the plugin type
>
> =A0Then record like
>
> - =A0 =A0 =A0 % arecord -fdat -c1 -Dplug:speex foo.wav
> + =A0 =A0 =A0 % arecord -fdat -c1 -Dplug:my_pcm foo.wav
>
> =A0so that you'll get 48kHz mono stream with the denoising effect.
>
> @@ -44,6 +44,15 @@ The following parameters can be set optionally:
>
> =A0 A boolean value to enable/disable dereverb function. =A0Default is no=
.
>
> +* echo
> +
> + =A0A boolean value to enable/disable echo-cancellation function.
> + =A0Default is no.
> +
> +* filter_length
> +
> + =A0Number of samples of echo to cancel. =A0As default it's 256.
> +
> =A0For example, you can enable agc like
>
> =A0 =A0 =A0 =A0pcm.my_pcm {
> diff --git a/speex/pcm_speex.c b/speex/pcm_speex.c
> index 7bb9213..757a400 100644
> --- a/speex/pcm_speex.c
> +++ b/speex/pcm_speex.c
> @@ -1,5 +1,5 @@
> =A0/*
> - * Speex preprocess plugin
> + * Speex DSP plugin
> =A0*
> =A0* Copyright (c) 2009 by Takashi Iwai <tiwai@suse.de>
> =A0*
> @@ -21,12 +21,15 @@
> =A0#include <alsa/asoundlib.h>
> =A0#include <alsa/pcm_external.h>
> =A0#include <speex/speex_preprocess.h>
> +#include <speex/speex_echo.h>
>
> -/* preprocessing parameters */
> +/* DSP parameters */
> =A0struct spx_parms {
> =A0 =A0 =A0 =A0int frames;
> =A0 =A0 =A0 =A0int denoise;
> =A0 =A0 =A0 =A0int agc;
> + =A0 =A0 =A0 int echo;
> + =A0 =A0 =A0 int filter_length;
> =A0 =A0 =A0 =A0float agc_level;
> =A0 =A0 =A0 =A0int dereverb;
> =A0 =A0 =A0 =A0float dereverb_decay;
> @@ -38,7 +41,9 @@ typedef struct {
> =A0 =A0 =A0 =A0struct spx_parms parms;
> =A0 =A0 =A0 =A0/* instance and intermedate buffer */
> =A0 =A0 =A0 =A0SpeexPreprocessState *state;
> + =A0 =A0 =A0 SpeexEchoState *echo_state;
> =A0 =A0 =A0 =A0short *buf;
> + =A0 =A0 =A0 short *outbuf;
> =A0 =A0 =A0 =A0/* running states */
> =A0 =A0 =A0 =A0unsigned int filled;
> =A0 =A0 =A0 =A0unsigned int processed;
> @@ -64,6 +69,18 @@ spx_transfer(snd_pcm_extplug_t *ext,
> =A0 =A0 =A0 =A0short *src =3D area_addr(src_areas, src_offset);
> =A0 =A0 =A0 =A0short *dst =3D area_addr(dst_areas, dst_offset);
> =A0 =A0 =A0 =A0unsigned int count =3D size;
> + =A0 =A0 =A0 short *databuf;
> +
> + =A0 =A0 =A0 if (!spx->state && !spx->echo_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no DSP processing */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(dst, src, count * 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return size;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (spx->echo_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 databuf =3D spx->outbuf;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 databuf =3D spx->buf;
>
> =A0 =A0 =A0 =A0while (count > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int chunk;
> @@ -72,14 +89,20 @@ spx_transfer(snd_pcm_extplug_t *ext,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chunk =3D count;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (spx->processed)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(dst, spx->buf + spx-=
>filled, chunk * 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(dst, databuf + spx->=
filled, chunk * 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(dst, 0, chunk * 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dst +=3D chunk;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(spx->buf + spx->filled, src, chunk =
* 2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spx->filled +=3D chunk;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (spx->filled =3D=3D spx->parms.frames) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_preprocess_run(spx->s=
tate, spx->buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spx->echo_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_echo_=
capture(spx->echo_state, spx->buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0spx->outbuf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spx->state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_prepr=
ocess_run(spx->state, databuf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spx->echo_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_echo_=
playback(spx->echo_state, databuf);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spx->processed =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spx->filled =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -94,6 +117,9 @@ static int spx_init(snd_pcm_extplug_t *ext)
> =A0{
> =A0 =A0 =A0 =A0snd_pcm_speex_t *spx =3D (snd_pcm_speex_t *)ext;
>
> + =A0 =A0 =A0 spx->filled =3D 0;
> + =A0 =A0 =A0 spx->processed =3D 0;
> +
> =A0 =A0 =A0 =A0if (!spx->buf) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spx->buf =3D malloc(spx->parms.frames * 2)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!spx->buf)
> @@ -101,12 +127,43 @@ static int spx_init(snd_pcm_extplug_t *ext)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0memset(spx->buf, 0, spx->parms.frames * 2);
>
> - =A0 =A0 =A0 if (spx->state)
> + =A0 =A0 =A0 if (!spx->outbuf) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spx->outbuf =3D malloc(spx->parms.frames * =
2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!spx->outbuf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 memset(spx->outbuf, 0, spx->parms.frames * 2);
> +
> + =A0 =A0 =A0 if (spx->state) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speex_preprocess_state_destroy(spx->state)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spx->state =3D NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (spx->echo_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_echo_state_destroy(spx->echo_state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spx->echo_state =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (spx->parms.echo) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spx->echo_state =3D speex_echo_state_init(s=
px->parms.frames,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 spx->parms.filter_length);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!spx->echo_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_echo_ctl(spx->echo_state, SPEEX_ECHO_=
SET_SAMPLING_RATE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&spx->ext.ra=
te);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* no preprocessor? */
> + =A0 =A0 =A0 if (!spx->parms.denoise && !spx->parms.agc && !spx->parms.d=
ereverb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0spx->state =3D speex_preprocess_state_init(spx->parms.fram=
es,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 spx->ext.rate);
> =A0 =A0 =A0 =A0if (!spx->state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
> + =A0 =A0 =A0 if (spx->echo_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_preprocess_ctl(spx->state,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SPEEX_PREPROCESS_SET_ECHO_STATE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
spx->echo_state);
>
> =A0 =A0 =A0 =A0speex_preprocess_ctl(spx->state, SPEEX_PREPROCESS_SET_DENO=
ISE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &spx->parms.denoi=
se);
> @@ -120,18 +177,18 @@ static int spx_init(snd_pcm_extplug_t *ext)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &spx->parms.derev=
erb_decay);
> =A0 =A0 =A0 =A0speex_preprocess_ctl(spx->state, SPEEX_PREPROCESS_SET_DERE=
VERB_LEVEL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &spx->parms.derev=
erb_level);
> -
> - =A0 =A0 =A0 spx->filled =3D 0;
> - =A0 =A0 =A0 spx->processed =3D 0;
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static int spx_close(snd_pcm_extplug_t *ext)
> =A0{
> =A0 =A0 =A0 =A0snd_pcm_speex_t *spx =3D (snd_pcm_speex_t *)ext;
> + =A0 =A0 =A0 free(spx->outbuf);
> =A0 =A0 =A0 =A0free(spx->buf);
> =A0 =A0 =A0 =A0if (spx->state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speex_preprocess_state_destroy(spx->state)=
;
> + =A0 =A0 =A0 if (spx->echo_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 speex_echo_state_destroy(spx->echo_state);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -205,6 +262,8 @@ SND_PCM_PLUGIN_DEFINE_FUNC(speex)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dereverb =3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dereverb_decay =3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.dereverb_level =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .echo =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .filter_length =3D 256,
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0snd_config_for_each(i, next, conf) {
> @@ -242,6 +301,13 @@ SND_PCM_PLUGIN_DEFINE_FUNC(speex)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &=
parms.dereverb_level);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto ok;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_bool_parm(n, id, "echo", &parms=
.echo);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ok;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D get_int_parm(n, id, "filter_length"=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&par=
ms.filter_length);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ok;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDERR("Unknown field %s", id);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EINVAL;
> =A0 =A0 =A0 =A0ok:
> @@ -259,7 +325,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(speex)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0spx->ext.version =3D SND_PCM_EXTPLUG_VERSION;
> - =A0 =A0 =A0 spx->ext.name =3D "Speex Denoise Plugin";
> + =A0 =A0 =A0 spx->ext.name =3D "Speex DSP Plugin";
> =A0 =A0 =A0 =A0spx->ext.callback =3D &speex_callback;
> =A0 =A0 =A0 =A0spx->ext.private_data =3D spx;
> =A0 =A0 =A0 =A0spx->parms =3D parms;
>
>

Takashi:

Finally, I have your patch applied successfully and all seems to be
working well.  See the attached files.

Best Regards,

--=20
Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax

--001e680f17341cfd74046c054470
Content-Type: text/x-csrc; charset=US-ASCII; name="chan_alsa.c"
Content-Disposition: attachment; filename="chan_alsa.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvsk74k40

LyoKICogQXN0ZXJpc2sgLS0gQW4gb3BlbiBzb3VyY2UgdGVsZXBob255IHRvb2xraXQuCiAqCiAq
IENvcHlyaWdodCAoQykgMTk5OSAtIDIwMDUsIERpZ2l1bSwgSW5jLgogKgogKiBCeSBNYXR0aGV3
IEZyZWRyaWNrc29uIDxjcmVzbGluQGRpZ2l1bS5jb20+CiAqCiAqIFNlZSBodHRwOi8vd3d3LmFz
dGVyaXNrLm9yZyBmb3IgbW9yZSBpbmZvcm1hdGlvbiBhYm91dAogKiB0aGUgQXN0ZXJpc2sgcHJv
amVjdC4gUGxlYXNlIGRvIG5vdCBkaXJlY3RseSBjb250YWN0CiAqIGFueSBvZiB0aGUgbWFpbnRh
aW5lcnMgb2YgdGhpcyBwcm9qZWN0IGZvciBhc3Npc3RhbmNlOwogKiB0aGUgcHJvamVjdCBwcm92
aWRlcyBhIHdlYiBzaXRlLCBtYWlsaW5nIGxpc3RzIGFuZCBJUkMKICogY2hhbm5lbHMgZm9yIHlv
dXIgdXNlLgogKgogKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZSwgZGlzdHJpYnV0ZWQg
dW5kZXIgdGhlIHRlcm1zIG9mCiAqIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBWZXJz
aW9uIDIuIFNlZSB0aGUgTElDRU5TRSBmaWxlCiAqIGF0IHRoZSB0b3Agb2YgdGhlIHNvdXJjZSB0
cmVlLgogKi8KCi8qISBcZmlsZSAKICogXGJyaWVmIEFMU0Egc291bmQgY2FyZCBjaGFubmVsIGRy
aXZlciAKICoKICogXGF1dGhvciBNYXR0aGV3IEZyZWRyaWNrc29uIDxjcmVzbGluQGRpZ2l1bS5j
b20+CiAqCiAqIFxwYXIgU2VlIGFsc28KICogXGFyZyBDb25maWdfYWxzYQogKgogKiBcaW5ncm91
cCBjaGFubmVsX2RyaXZlcnMKICovCgovKioqIE1PRFVMRUlORk8KCTxkZXBlbmQ+YXNvdW5kPC9k
ZXBlbmQ+CiAqKiovCgojaW5jbHVkZSAiYXN0ZXJpc2suaCIKCkFTVEVSSVNLX0ZJTEVfVkVSU0lP
TihfX0ZJTEVfXywgIiRSZXZpc2lvbjogMTY3MDk1ICQiKQoKI2luY2x1ZGUgPHVuaXN0ZC5oPgoj
aW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwu
aD4KI2luY2x1ZGUgPHN5cy90aW1lLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0
ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW8uaD4KCiNkZWZpbmUgQUxTQV9QQ01fTkVXX0hXX1BBUkFN
U19BUEkKI2RlZmluZSBBTFNBX1BDTV9ORVdfU1dfUEFSQU1TX0FQSQojaW5jbHVkZSA8YWxzYS9h
c291bmRsaWIuaD4KCiNpbmNsdWRlICJhc3Rlcmlzay9mcmFtZS5oIgojaW5jbHVkZSAiYXN0ZXJp
c2svbG9nZ2VyLmgiCiNpbmNsdWRlICJhc3Rlcmlzay9jaGFubmVsLmgiCiNpbmNsdWRlICJhc3Rl
cmlzay9tb2R1bGUuaCIKI2luY2x1ZGUgImFzdGVyaXNrL29wdGlvbnMuaCIKI2luY2x1ZGUgImFz
dGVyaXNrL3BieC5oIgojaW5jbHVkZSAiYXN0ZXJpc2svY29uZmlnLmgiCiNpbmNsdWRlICJhc3Rl
cmlzay9jbGkuaCIKI2luY2x1ZGUgImFzdGVyaXNrL3V0aWxzLmgiCiNpbmNsdWRlICJhc3Rlcmlz
ay9jYXVzZXMuaCIKI2luY2x1ZGUgImFzdGVyaXNrL2VuZGlhbi5oIgojaW5jbHVkZSAiYXN0ZXJp
c2svc3RyaW5nZmllbGRzLmgiCiNpbmNsdWRlICJhc3Rlcmlzay9hYnN0cmFjdF9qYi5oIgojaW5j
bHVkZSAiYXN0ZXJpc2svbXVzaWNvbmhvbGQuaCIKCiNpbmNsdWRlICJidXN5X3RvbmUuaCIKI2lu
Y2x1ZGUgInJpbmdfdG9uZS5oIgojaW5jbHVkZSAicmluZzEwLmgiCiNpbmNsdWRlICJhbnN3ZXIu
aCIKCiNpZmRlZiBBTFNBX01PTklUT1IKI2luY2x1ZGUgImFsc2EtbW9uaXRvci5oIgojZW5kaWYK
Ci8qISBHbG9iYWwgaml0dGVyYnVmZmVyIGNvbmZpZ3VyYXRpb24gLSBieSBkZWZhdWx0LCBqYiBp
cyBkaXNhYmxlZCAqLwpzdGF0aWMgc3RydWN0IGFzdF9qYl9jb25mIGRlZmF1bHRfamJjb25mID0g
ewoJLmZsYWdzID0gMCwKCS5tYXhfc2l6ZSA9IC0xLAoJLnJlc3luY190aHJlc2hvbGQgPSAtMSwK
CS5pbXBsID0gIiIKfTsKc3RhdGljIHN0cnVjdCBhc3RfamJfY29uZiBnbG9iYWxfamJjb25mOwoK
I2RlZmluZSBERUJVRyAwCi8qIFdoaWNoIGRldmljZSB0byB1c2UgKi8KI2RlZmluZSBBTFNBX0lO
REVWICJkZWZhdWx0IgojZGVmaW5lIEFMU0FfT1VUREVWICJkZWZhdWx0IgojZGVmaW5lIERFU0lS
RURfUkFURSA4MDAwCgovKiBMZXRzIHVzZSAxNjAgc2FtcGxlIGZyYW1lcywganVzdCBsaWtlIEdT
TS4gICovCiNkZWZpbmUgRlJBTUVfU0laRSAxNjAKI2RlZmluZSBQRVJJT0RfRlJBTUVTIDgwCQkv
KiA4MCBGcmFtZXMsIGF0IDIgYnl0ZXMgZWFjaCAqLwoKLyogV2hlbiB5b3Ugc2V0IHRoZSBmcmFt
ZSBzaXplLCB5b3UgaGF2ZSB0byBjb21lIHVwIHdpdGgKICAgdGhlIHJpZ2h0IGJ1ZmZlciBmb3Jt
YXQgYXMgd2VsbC4gKi8KLyogNSA2NC1ieXRlIGZyYW1lcyA9IG9uZSBmcmFtZSAqLwojZGVmaW5l
IEJVRkZFUl9GTVQgKChidWZmZXJzaXplICogMTApIDw8IDE2KSB8ICgweDAwMDYpOwoKLyogRG9u
J3Qgc3dpdGNoIGJldHdlZW4gcmVhZC93cml0ZSBtb2RlcyBmYXN0ZXIgdGhhbiBldmVyeSAzMDAg
bXMgKi8KI2RlZmluZSBNSU5fU1dJVENIX1RJTUUgNjAwCgojaWYgX19CWVRFX09SREVSID09IF9f
TElUVExFX0VORElBTgpzdGF0aWMgc25kX3BjbV9mb3JtYXRfdCBmb3JtYXQgPSBTTkRfUENNX0ZP
Uk1BVF9TMTZfTEU7CiNlbHNlCnN0YXRpYyBzbmRfcGNtX2Zvcm1hdF90IGZvcm1hdCA9IFNORF9Q
Q01fRk9STUFUX1MxNl9CRTsKI2VuZGlmCgpzdGF0aWMgY2hhciBpbmRldm5hbWVbNTBdID0gQUxT
QV9JTkRFVjsKc3RhdGljIGNoYXIgb3V0ZGV2bmFtZVs1MF0gPSBBTFNBX09VVERFVjsKCiNpZiAw
CnN0YXRpYyBzdHJ1Y3QgdGltZXZhbCBsYXN0dGltZTsKI2VuZGlmCgpzdGF0aWMgaW50IHNpbGVu
Y2VzdXBwcmVzc2lvbiA9IDA7CnN0YXRpYyBpbnQgc2lsZW5jZXRocmVzaG9sZCA9IDEwMDA7CgpB
U1RfTVVURVhfREVGSU5FX1NUQVRJQyhhbHNhbG9jayk7CgpzdGF0aWMgY29uc3QgY2hhciB0ZGVz
Y1tdID0gIkFMU0EgQ29uc29sZSBDaGFubmVsIERyaXZlciI7CnN0YXRpYyBjb25zdCBjaGFyIGNv
bmZpZ1tdID0gImFsc2EuY29uZiI7CgpzdGF0aWMgY2hhciBjb250ZXh0W0FTVF9NQVhfQ09OVEVY
VF0gPSAiZGVmYXVsdCI7CnN0YXRpYyBjaGFyIGxhbmd1YWdlW01BWF9MQU5HVUFHRV0gPSAiIjsK
c3RhdGljIGNoYXIgZXh0ZW5bQVNUX01BWF9FWFRFTlNJT05dID0gInMiOwpzdGF0aWMgY2hhciBt
b2hpbnRlcnByZXRbTUFYX01VU0lDQ0xBU1NdOwoKc3RhdGljIGludCBob29rc3RhdGUgPSAwOwoK
c3RhdGljIHNob3J0IHNpbGVuY2VbRlJBTUVfU0laRV0gPSB7IDAsIH07CgpzdHJ1Y3Qgc291bmQg
ewoJaW50IGluZDsKCXNob3J0ICpkYXRhOwoJaW50IGRhdGFsZW47CglpbnQgc2FtcGxlbjsKCWlu
dCBzaWxlbmNlbGVuOwoJaW50IHJlcGVhdDsKfTsKCnN0YXRpYyBzdHJ1Y3Qgc291bmQgc291bmRz
W10gPSB7Cgl7QVNUX0NPTlRST0xfUklOR0lORywgcmluZ3RvbmUsIHNpemVvZihyaW5ndG9uZSkg
LyAyLCAxNjAwMCwgMzIwMDAsIDF9LAoJe0FTVF9DT05UUk9MX0JVU1ksIGJ1c3ksIHNpemVvZihi
dXN5KSAvIDIsIDQwMDAsIDQwMDAsIDF9LAoJe0FTVF9DT05UUk9MX0NPTkdFU1RJT04sIGJ1c3ks
IHNpemVvZihidXN5KSAvIDIsIDIwMDAsIDIwMDAsIDF9LAoJe0FTVF9DT05UUk9MX1JJTkcsIHJp
bmcxMCwgc2l6ZW9mKHJpbmcxMCkgLyAyLCAxNjAwMCwgMzIwMDAsIDF9LAoJe0FTVF9DT05UUk9M
X0FOU1dFUiwgYW5zd2VyLCBzaXplb2YoYW5zd2VyKSAvIDIsIDIyMDAsIDAsIDB9LAp9OwoKLyog
U291bmQgY29tbWFuZCBwaXBlICovCnN0YXRpYyBpbnQgc25kY21kWzJdOwoKc3RhdGljIHN0cnVj
dCBjaGFuX2Fsc2FfcHZ0IHsKCS8qIFdlIG9ubHkgaGF2ZSBvbmUgQUxTQSBzdHJ1Y3R1cmUgLS0g
bmVhciBzaWdodGVkIHBlcmhhcHMsIGJ1dCBpdAoJICAga2VlcHMgdGhpcyBkcml2ZXIgYXMgc2lt
cGxlIGFzIHBvc3NpYmxlIC0tIGFzIGl0IHNob3VsZCBiZS4gKi8KCXN0cnVjdCBhc3RfY2hhbm5l
bCAqb3duZXI7CgljaGFyIGV4dGVuW0FTVF9NQVhfRVhURU5TSU9OXTsKCWNoYXIgY29udGV4dFtB
U1RfTUFYX0NPTlRFWFRdOwojaWYgMAoJc25kX3BjbV90ICpjYXJkOwojZW5kaWYKCXNuZF9wY21f
dCAqaWNhcmQsICpvY2FyZDsKCn0gYWxzYTsKCi8qIE51bWJlciBvZiBidWZmZXJzLi4uICBFYWNo
IGlzIEZSQU1FU0laRS84IG1zIGxvbmcuICBGb3IgZXhhbXBsZQogICB3aXRoIDE2MCBzYW1wbGUg
ZnJhbWVzLCBhbmQgYSBidWZmZXIgc2l6ZSBvZiAzLCB3ZSBoYXZlIGEgNjBtcyBidWZmZXIsIAog
ICB1c3VhbGx5IHBsZW50eS4gKi8KCnB0aHJlYWRfdCBzdGhyZWFkOwoKI2RlZmluZSBNQVhfQlVG
RkVSX1NJWkUgMTAwCgovKiBGaWxlIGRlc2NyaXB0b3JzIGZvciBzb3VuZCBkZXZpY2UgKi8Kc3Rh
dGljIGludCByZWFkZGV2ID0gLTE7CnN0YXRpYyBpbnQgd3JpdGVkZXYgPSAtMTsKCnN0YXRpYyBp
bnQgYXV0b2Fuc3dlciA9IDE7CgpzdGF0aWMgaW50IGN1cnNvdW5kID0gLTE7CnN0YXRpYyBpbnQg
c2FtcHNlbnQgPSAwOwpzdGF0aWMgaW50IHNpbGVuY2VsZW4gPSAwOwpzdGF0aWMgaW50IG9mZnNl
dCA9IDA7CnN0YXRpYyBpbnQgbm9zb3VuZCA9IDA7CgovKiBaWiAqLwpzdGF0aWMgc3RydWN0IGFz
dF9jaGFubmVsICphbHNhX3JlcXVlc3QoY29uc3QgY2hhciAqdHlwZSwgaW50IGZvcm1hdCwgdm9p
ZCAqZGF0YSwgaW50ICpjYXVzZSk7CnN0YXRpYyBpbnQgYWxzYV9kaWdpdChzdHJ1Y3QgYXN0X2No
YW5uZWwgKmMsIGNoYXIgZGlnaXQsIHVuc2lnbmVkIGludCBkdXJhdGlvbik7CnN0YXRpYyBpbnQg
YWxzYV90ZXh0KHN0cnVjdCBhc3RfY2hhbm5lbCAqYywgY29uc3QgY2hhciAqdGV4dCk7CnN0YXRp
YyBpbnQgYWxzYV9oYW5ndXAoc3RydWN0IGFzdF9jaGFubmVsICpjKTsKc3RhdGljIGludCBhbHNh
X2Fuc3dlcihzdHJ1Y3QgYXN0X2NoYW5uZWwgKmMpOwpzdGF0aWMgc3RydWN0IGFzdF9mcmFtZSAq
YWxzYV9yZWFkKHN0cnVjdCBhc3RfY2hhbm5lbCAqY2hhbik7CnN0YXRpYyBpbnQgYWxzYV9jYWxs
KHN0cnVjdCBhc3RfY2hhbm5lbCAqYywgY2hhciAqZGVzdCwgaW50IHRpbWVvdXQpOwpzdGF0aWMg
aW50IGFsc2Ffd3JpdGUoc3RydWN0IGFzdF9jaGFubmVsICpjaGFuLCBzdHJ1Y3QgYXN0X2ZyYW1l
ICpmKTsKc3RhdGljIGludCBhbHNhX2luZGljYXRlKHN0cnVjdCBhc3RfY2hhbm5lbCAqY2hhbiwg
aW50IGNvbmQsIGNvbnN0IHZvaWQgKmRhdGEsIHNpemVfdCBkYXRhbGVuKTsKc3RhdGljIGludCBh
bHNhX2ZpeHVwKHN0cnVjdCBhc3RfY2hhbm5lbCAqb2xkY2hhbiwgc3RydWN0IGFzdF9jaGFubmVs
ICpuZXdjaGFuKTsKCnN0YXRpYyBjb25zdCBzdHJ1Y3QgYXN0X2NoYW5uZWxfdGVjaCBhbHNhX3Rl
Y2ggPSB7CgkudHlwZSA9ICJDb25zb2xlIiwKCS5kZXNjcmlwdGlvbiA9IHRkZXNjLAoJLmNhcGFi
aWxpdGllcyA9IEFTVF9GT1JNQVRfU0xJTkVBUiwKCS5yZXF1ZXN0ZXIgPSBhbHNhX3JlcXVlc3Qs
Cgkuc2VuZF9kaWdpdF9lbmQgPSBhbHNhX2RpZ2l0LAoJLnNlbmRfdGV4dCA9IGFsc2FfdGV4dCwK
CS5oYW5ndXAgPSBhbHNhX2hhbmd1cCwKCS5hbnN3ZXIgPSBhbHNhX2Fuc3dlciwKCS5yZWFkID0g
YWxzYV9yZWFkLAoJLmNhbGwgPSBhbHNhX2NhbGwsCgkud3JpdGUgPSBhbHNhX3dyaXRlLAoJLmlu
ZGljYXRlID0gYWxzYV9pbmRpY2F0ZSwKCS5maXh1cCA9IGFsc2FfZml4dXAsCn07CgpzdGF0aWMg
aW50IHNlbmRfc291bmQodm9pZCkKewoJc2hvcnQgbXlmcmFtZVtGUkFNRV9TSVpFXTsKCWludCB0
b3RhbCA9IEZSQU1FX1NJWkU7CglzaG9ydCAqZnJhbWUgPSBOVUxMOwoJaW50IGFtdCA9IDAsIHJl
cywgbXlvZmY7CglzbmRfcGNtX3N0YXRlX3Qgc3RhdGU7CgoJaWYgKGN1cnNvdW5kID09IC0xKQoJ
CXJldHVybiAwOwoJCglyZXMgPSB0b3RhbDsKCWlmIChzYW1wc2VudCA8IHNvdW5kc1tjdXJzb3Vu
ZF0uc2FtcGxlbikgewoJCW15b2ZmID0gMDsKCQl3aGlsZSAodG90YWwpIHsKCQkJYW10ID0gdG90
YWw7CgkJCWlmIChhbXQgPiAoc291bmRzW2N1cnNvdW5kXS5kYXRhbGVuIC0gb2Zmc2V0KSkKCQkJ
CWFtdCA9IHNvdW5kc1tjdXJzb3VuZF0uZGF0YWxlbiAtIG9mZnNldDsKCQkJbWVtY3B5KG15ZnJh
bWUgKyBteW9mZiwgc291bmRzW2N1cnNvdW5kXS5kYXRhICsgb2Zmc2V0LCBhbXQgKiAyKTsKCQkJ
dG90YWwgLT0gYW10OwoJCQlvZmZzZXQgKz0gYW10OwoJCQlzYW1wc2VudCArPSBhbXQ7CgkJCW15
b2ZmICs9IGFtdDsKCQkJaWYgKG9mZnNldCA+PSBzb3VuZHNbY3Vyc291bmRdLmRhdGFsZW4pCgkJ
CQlvZmZzZXQgPSAwOwoJCX0KCQkvKiBTZXQgaXQgdXAgZm9yIHNpbGVuY2UgKi8KCQlpZiAoc2Ft
cHNlbnQgPj0gc291bmRzW2N1cnNvdW5kXS5zYW1wbGVuKQoJCQlzaWxlbmNlbGVuID0gc291bmRz
W2N1cnNvdW5kXS5zaWxlbmNlbGVuOwoJCWZyYW1lID0gbXlmcmFtZTsKCX0gZWxzZSB7CgkJaWYg
KHNpbGVuY2VsZW4gPiAwKSB7CgkJCWZyYW1lID0gc2lsZW5jZTsKCQkJc2lsZW5jZWxlbiAtPSBy
ZXM7CgkJfSBlbHNlIHsKCQkJaWYgKHNvdW5kc1tjdXJzb3VuZF0ucmVwZWF0KSB7CgkJCQkvKiBT
dGFydCBvdmVyICovCgkJCQlzYW1wc2VudCA9IDA7CgkJCQlvZmZzZXQgPSAwOwoJCQl9IGVsc2Ug
ewoJCQkJY3Vyc291bmQgPSAtMTsKCQkJCW5vc291bmQgPSAwOwoJCQl9CgkJCXJldHVybiAwOwoJ
CX0KCX0KCQoJaWYgKHJlcyA9PSAwIHx8ICFmcmFtZSkKCQlyZXR1cm4gMDsKCiNpZmRlZiBBTFNB
X01PTklUT1IKCWFsc2FfbW9uaXRvcl93cml0ZSgoY2hhciAqKSBmcmFtZSwgcmVzICogMik7CiNl
bmRpZgogICAgaWYgKGFsc2Eub2NhcmQgPiAwKSB7CgkJc3RhdGUgPSBzbmRfcGNtX3N0YXRlKGFs
c2Eub2NhcmQpOwoJCWlmIChzdGF0ZSA9PSBTTkRfUENNX1NUQVRFX1hSVU4pCgkJCXNuZF9wY21f
cHJlcGFyZShhbHNhLm9jYXJkKTsKCQl3aGlsZSAoKHJlcyA9IHNuZF9wY21fd3JpdGVpKGFsc2Eu
b2NhcmQsIGZyYW1lLCByZXMpKSA9PSAtRUFHQUlOKSB7CgkJCXVzbGVlcCgxKTsKCQl9CgkJaWYg
KHJlcyA+IDApCgkJCXJldHVybiAwOwoJfQoKCXJldHVybiAwOwp9CgpzdGF0aWMgdm9pZCAqc291
bmRfdGhyZWFkKHZvaWQgKnVudXNlZCkKewoJZmRfc2V0IHJmZHM7CglmZF9zZXQgd2ZkczsKCWlu
dCBtYXgsIHJlczsKCglmb3IgKDs7KSB7CgkJRkRfWkVSTygmcmZkcyk7CgkJRkRfWkVSTygmd2Zk
cyk7CgkJbWF4ID0gc25kY21kWzBdOwoJCUZEX1NFVChzbmRjbWRbMF0sICZyZmRzKTsKCQlpZiAo
Y3Vyc291bmQgPiAtMSAmJiB3cml0ZWRldiA+IC0xKSB7CgkJCUZEX1NFVCh3cml0ZWRldiwgJndm
ZHMpOwoJCQlpZiAod3JpdGVkZXYgPiBtYXgpCgkJCQltYXggPSB3cml0ZWRldjsKCQl9CiNpZmRl
ZiBBTFNBX01PTklUT1IKCQlpZiAoIWFsc2Eub3duZXIgJiYgcmVhZGRldiA+IC0xKSB7CgkJCUZE
X1NFVChyZWFkZGV2LCAmcmZkcyk7CgkJCWlmIChyZWFkZGV2ID4gbWF4KQoJCQkJbWF4ID0gcmVh
ZGRldjsKCQl9CiNlbmRpZgoJCXJlcyA9IGFzdF9zZWxlY3QobWF4ICsgMSwgJnJmZHMsICZ3ZmRz
LCBOVUxMLCBOVUxMKTsKCQlpZiAocmVzIDwgMSkgewoJCQlhc3RfbG9nKExPR19XQVJOSU5HLCAi
c2VsZWN0IGZhaWxlZDogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CgkJCWNvbnRpbnVlOwoJCX0K
I2lmZGVmIEFMU0FfTU9OSVRPUgoJCWlmIChyZWFkZGV2ID4gLTEgJiYgRkRfSVNTRVQocmVhZGRl
diwgJnJmZHMpKSB7CgkJCS8qIEtlZXAgdGhlIHBpcGUgZ29pbmcgd2l0aCByZWFkIGF1ZGlvICov
CgkJCXNuZF9wY21fc3RhdGVfdCBzdGF0ZTsKCQkJc2hvcnQgYnVmW0ZSQU1FX1NJWkVdOwoJCQlp
bnQgcjsKCgkJCWlmIChhbHNhLm9jYXJkID4gMCkgewoJCQkJc3RhdGUgPSBzbmRfcGNtX3N0YXRl
KGFsc2Eub2NhcmQpOwoJCQkJaWYgKHN0YXRlID09IFNORF9QQ01fU1RBVEVfWFJVTikgewoJCQkJ
CXNuZF9wY21fcHJlcGFyZShhbHNhLm9jYXJkKTsKCQkJCX0KCQkJfQoJCQlyID0gc25kX3BjbV9y
ZWFkaShhbHNhLmljYXJkLCBidWYsIEZSQU1FX1NJWkUpOwoJCQlpZiAociA9PSAtRVBJUEUpIHsK
I2lmIERFQlVHCgkJCQlhc3RfbG9nKExPR19FUlJPUiwgIlhSVU4gcmVhZFxuIik7CiNlbmRpZgoJ
CQkJc25kX3BjbV9wcmVwYXJlKGFsc2EuaWNhcmQpOwoJCQl9IGVsc2UgaWYgKHIgPT0gLUVTVFJQ
SVBFKSB7CgkJCQlhc3RfbG9nKExPR19FUlJPUiwgIi1FU1RSUElQRVxuIik7CgkJCQlzbmRfcGNt
X3ByZXBhcmUoYWxzYS5pY2FyZCk7CgkJCX0gZWxzZSBpZiAociA8IDApIHsKCQkJCWFzdF9sb2co
TE9HX0VSUk9SLCAiUmVhZCBlcnJvcjogJXNcbiIsIHNuZF9zdHJlcnJvcihyKSk7CgkJCX0gZWxz
ZQoJCQkJYWxzYV9tb25pdG9yX3JlYWQoKGNoYXIgKikgYnVmLCByICogMik7CgkJfQojZW5kaWYK
CQlpZiAoRkRfSVNTRVQoc25kY21kWzBdLCAmcmZkcykpIHsKCQkJaWYgKHJlYWQoc25kY21kWzBd
LCAmY3Vyc291bmQsIHNpemVvZihjdXJzb3VuZCkpIDwgMCkgewoJCQkJYXN0X2xvZyhMT0dfV0FS
TklORywgInJlYWQoKSBmYWlsZWQ6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwoJCQl9CgkJCXNp
bGVuY2VsZW4gPSAwOwoJCQlvZmZzZXQgPSAwOwoJCQlzYW1wc2VudCA9IDA7CgkJfQoKICAgICAg
ICBpZiAod3JpdGVkZXYgPiAtMSAmJiBGRF9JU1NFVCh3cml0ZWRldiwgJndmZHMpKQoJCQlpZiAo
c2VuZF9zb3VuZCgpKQoJCQkJYXN0X2xvZyhMT0dfV0FSTklORywgIkZhaWxlZCB0byB3cml0ZSBz
b3VuZFxuIik7Cgl9CgkvKiBOZXZlciByZWFjaGVkICovCglyZXR1cm4gTlVMTDsKfQoKc3RhdGlj
IHNuZF9wY21fdCAqYWxzYV9jYXJkX2luaXQoY2hhciAqZGV2LCBzbmRfcGNtX3N0cmVhbV90IHN0
cmVhbSkKewoJaW50IGVycjsKCWludCBkaXJlY3Rpb247CglzbmRfcGNtX3QgKmhhbmRsZSA9IE5V
TEw7CglzbmRfcGNtX2h3X3BhcmFtc190ICpod3BhcmFtcyA9IE5VTEw7CglzbmRfcGNtX3N3X3Bh
cmFtc190ICpzd3BhcmFtcyA9IE5VTEw7CglzdHJ1Y3QgcG9sbGZkIHBmZDsKCXNuZF9wY21fdWZy
YW1lc190IHBlcmlvZF9zaXplID0gUEVSSU9EX0ZSQU1FUyAqIDQ7CgkvKiBpbnQgcGVyaW9kX2J5
dGVzID0gMDsgKi8KCXNuZF9wY21fdWZyYW1lc190IGJ1ZmZlcl9zaXplID0gMDsKCgl1bnNpZ25l
ZCBpbnQgcmF0ZSA9IERFU0lSRURfUkFURTsKI2lmIDAKCXVuc2lnbmVkIGludCBwZXJfbWluID0g
MTsKI2VuZGlmCgkvKiB1bnNpZ25lZCBpbnQgcGVyX21heCA9IDg7ICovCglzbmRfcGNtX3VmcmFt
ZXNfdCBzdGFydF90aHJlc2hvbGQsIHN0b3BfdGhyZXNob2xkOwoKCWVyciA9IHNuZF9wY21fb3Bl
bigmaGFuZGxlLCBkZXYsIHN0cmVhbSwgU05EX1BDTV9OT05CTE9DSyk7CglpZiAoZXJyIDwgMCkg
ewoJCWFzdF9sb2coTE9HX0VSUk9SLCAic25kX3BjbV9vcGVuIGZhaWxlZDogJXNcbiIsIHNuZF9z
dHJlcnJvcihlcnIpKTsKCQlyZXR1cm4gTlVMTDsKCX0gZWxzZQoJCWFzdF9sb2coTE9HX0RFQlVH
LCAiT3BlbmluZyBkZXZpY2UgJXMgaW4gJXMgbW9kZVxuIiwgZGV2LCAoc3RyZWFtID09IFNORF9Q
Q01fU1RSRUFNX0NBUFRVUkUpID8gInJlYWQiIDogIndyaXRlIik7CgoJaHdwYXJhbXMgPSBhbGxv
Y2Eoc25kX3BjbV9od19wYXJhbXNfc2l6ZW9mKCkpOwoJbWVtc2V0KGh3cGFyYW1zLCAwLCBzbmRf
cGNtX2h3X3BhcmFtc19zaXplb2YoKSk7CglzbmRfcGNtX2h3X3BhcmFtc19hbnkoaGFuZGxlLCBo
d3BhcmFtcyk7CgoJZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X2FjY2VzcyhoYW5kbGUsIGh3
cGFyYW1zLCBTTkRfUENNX0FDQ0VTU19SV19JTlRFUkxFQVZFRCk7CglpZiAoZXJyIDwgMCkKCQlh
c3RfbG9nKExPR19FUlJPUiwgInNldF9hY2Nlc3MgZmFpbGVkOiAlc1xuIiwgc25kX3N0cmVycm9y
KGVycikpOwoKCWVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9mb3JtYXQoaGFuZGxlLCBod3Bh
cmFtcywgZm9ybWF0KTsKCWlmIChlcnIgPCAwKQoJCWFzdF9sb2coTE9HX0VSUk9SLCAic2V0X2Zv
cm1hdCBmYWlsZWQ6ICVzXG4iLCBzbmRfc3RyZXJyb3IoZXJyKSk7CgoJZXJyID0gc25kX3BjbV9o
d19wYXJhbXNfc2V0X2NoYW5uZWxzKGhhbmRsZSwgaHdwYXJhbXMsIDEpOwoJaWYgKGVyciA8IDAp
CgkJYXN0X2xvZyhMT0dfRVJST1IsICJzZXRfY2hhbm5lbHMgZmFpbGVkOiAlc1xuIiwgc25kX3N0
cmVycm9yKGVycikpOwoKCWRpcmVjdGlvbiA9IDA7CgllcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19z
ZXRfcmF0ZV9uZWFyKGhhbmRsZSwgaHdwYXJhbXMsICZyYXRlLCAmZGlyZWN0aW9uKTsKCWlmIChy
YXRlICE9IERFU0lSRURfUkFURSkKCQlhc3RfbG9nKExPR19XQVJOSU5HLCAiUmF0ZSBub3QgY29y
cmVjdCwgcmVxdWVzdGVkICVkLCBnb3QgJWRcbiIsIERFU0lSRURfUkFURSwgcmF0ZSk7CgoJZGly
ZWN0aW9uID0gMDsKCWVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9wZXJpb2Rfc2l6ZV9uZWFy
KGhhbmRsZSwgaHdwYXJhbXMsICZwZXJpb2Rfc2l6ZSwgJmRpcmVjdGlvbik7CglpZiAoZXJyIDwg
MCkKCQlhc3RfbG9nKExPR19FUlJPUiwgInBlcmlvZF9zaXplKCVsZCBmcmFtZXMpIGlzIGJhZDog
JXNcbiIsIHBlcmlvZF9zaXplLCBzbmRfc3RyZXJyb3IoZXJyKSk7CgllbHNlCgkJYXN0X2xvZyhM
T0dfREVCVUcsICJQZXJpb2Qgc2l6ZSBpcyAlZFxuIiwgZXJyKTsKCglidWZmZXJfc2l6ZSA9IDQw
OTYgKiAyOwkJLyogcGVyaW9kX3NpemUgKiAxNjsgKi8KCWVyciA9IHNuZF9wY21faHdfcGFyYW1z
X3NldF9idWZmZXJfc2l6ZV9uZWFyKGhhbmRsZSwgaHdwYXJhbXMsICZidWZmZXJfc2l6ZSk7Cglp
ZiAoZXJyIDwgMCkKCQlhc3RfbG9nKExPR19XQVJOSU5HLCAiUHJvYmxlbSBzZXR0aW5nIGJ1ZmZl
ciBzaXplIG9mICVsZDogJXNcbiIsIGJ1ZmZlcl9zaXplLCBzbmRfc3RyZXJyb3IoZXJyKSk7Cgll
bHNlCgkJYXN0X2xvZyhMT0dfREVCVUcsICJCdWZmZXIgc2l6ZSBpcyBzZXQgdG8gJWQgZnJhbWVz
XG4iLCBlcnIpOwoKI2lmIDAKCWRpcmVjdGlvbiA9IDA7CgllcnIgPSBzbmRfcGNtX2h3X3BhcmFt
c19zZXRfcGVyaW9kc19taW4oaGFuZGxlLCBod3BhcmFtcywgJnBlcl9taW4sICZkaXJlY3Rpb24p
OwoJaWYgKGVyciA8IDApCgkJYXN0X2xvZyhMT0dfRVJST1IsICJwZXJpb2RzX21pbjogJXNcbiIs
IHNuZF9zdHJlcnJvcihlcnIpKTsKCgllcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19zZXRfcGVyaW9k
c19tYXgoaGFuZGxlLCBod3BhcmFtcywgJnBlcl9tYXgsIDApOwoJaWYgKGVyciA8IDApCgkJYXN0
X2xvZyhMT0dfRVJST1IsICJwZXJpb2RzX21heDogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsK
I2VuZGlmCgoJZXJyID0gc25kX3BjbV9od19wYXJhbXMoaGFuZGxlLCBod3BhcmFtcyk7CglpZiAo
ZXJyIDwgMCkKCQlhc3RfbG9nKExPR19FUlJPUiwgIkNvdWxkbid0IHNldCB0aGUgbmV3IGh3IHBh
cmFtczogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKCglzd3BhcmFtcyA9IGFsbG9jYShzbmRf
cGNtX3N3X3BhcmFtc19zaXplb2YoKSk7CgltZW1zZXQoc3dwYXJhbXMsIDAsIHNuZF9wY21fc3df
cGFyYW1zX3NpemVvZigpKTsKCXNuZF9wY21fc3dfcGFyYW1zX2N1cnJlbnQoaGFuZGxlLCBzd3Bh
cmFtcyk7CgojaWYgMQoJaWYgKHN0cmVhbSA9PSBTTkRfUENNX1NUUkVBTV9QTEFZQkFDSykKCQlz
dGFydF90aHJlc2hvbGQgPSBwZXJpb2Rfc2l6ZTsKCWVsc2UKCQlzdGFydF90aHJlc2hvbGQgPSAx
OwoKCWVyciA9IHNuZF9wY21fc3dfcGFyYW1zX3NldF9zdGFydF90aHJlc2hvbGQoaGFuZGxlLCBz
d3BhcmFtcywgc3RhcnRfdGhyZXNob2xkKTsKCWlmIChlcnIgPCAwKQoJCWFzdF9sb2coTE9HX0VS
Uk9SLCAic3RhcnQgdGhyZXNob2xkOiAlc1xuIiwgc25kX3N0cmVycm9yKGVycikpOwojZW5kaWYK
CiNpZiAxCglpZiAoc3RyZWFtID09IFNORF9QQ01fU1RSRUFNX1BMQVlCQUNLKQoJCXN0b3BfdGhy
ZXNob2xkID0gYnVmZmVyX3NpemU7CgllbHNlCgkJc3RvcF90aHJlc2hvbGQgPSBidWZmZXJfc2l6
ZTsKCgllcnIgPSBzbmRfcGNtX3N3X3BhcmFtc19zZXRfc3RvcF90aHJlc2hvbGQoaGFuZGxlLCBz
d3BhcmFtcywgc3RvcF90aHJlc2hvbGQpOwoJaWYgKGVyciA8IDApCgkJYXN0X2xvZyhMT0dfRVJS
T1IsICJzdG9wIHRocmVzaG9sZDogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKI2VuZGlmCiNp
ZiAwCgllcnIgPSBzbmRfcGNtX3N3X3BhcmFtc19zZXRfeGZlcl9hbGlnbihoYW5kbGUsIHN3cGFy
YW1zLCBQRVJJT0RfRlJBTUVTKTsKCWlmIChlcnIgPCAwKQoJCWFzdF9sb2coTE9HX0VSUk9SLCAi
VW5hYmxlIHRvIHNldCB4ZmVyIGFsaWdubWVudDogJXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsK
I2VuZGlmCgojaWYgMAoJZXJyID0gc25kX3BjbV9zd19wYXJhbXNfc2V0X3NpbGVuY2VfdGhyZXNo
b2xkKGhhbmRsZSwgc3dwYXJhbXMsIHNpbGVuY2V0aHJlc2hvbGQpOwoJaWYgKGVyciA8IDApCgkJ
YXN0X2xvZyhMT0dfRVJST1IsICJVbmFibGUgdG8gc2V0IHNpbGVuY2UgdGhyZXNob2xkOiAlc1xu
Iiwgc25kX3N0cmVycm9yKGVycikpOwojZW5kaWYKCWVyciA9IHNuZF9wY21fc3dfcGFyYW1zKGhh
bmRsZSwgc3dwYXJhbXMpOwoJaWYgKGVyciA8IDApCgkJYXN0X2xvZyhMT0dfRVJST1IsICJzd19w
YXJhbXM6ICVzXG4iLCBzbmRfc3RyZXJyb3IoZXJyKSk7CgoJZXJyID0gc25kX3BjbV9wb2xsX2Rl
c2NyaXB0b3JzX2NvdW50KGhhbmRsZSk7CglpZiAoZXJyIDw9IDApCgkJYXN0X2xvZyhMT0dfRVJS
T1IsICJVbmFibGUgdG8gZ2V0IGEgcG9sbCBkZXNjcmlwdG9ycyBjb3VudCwgZXJyb3IgaXMgJXNc
biIsIHNuZF9zdHJlcnJvcihlcnIpKTsKCWlmIChlcnIgIT0gMSkKCQlhc3RfbG9nKExPR19ERUJV
RywgIkNhbid0IGhhbmRsZSBtb3JlIHRoYW4gb25lIGRldmljZVxuIik7CgoJc25kX3BjbV9wb2xs
X2Rlc2NyaXB0b3JzKGhhbmRsZSwgJnBmZCwgZXJyKTsKCWFzdF9sb2coTE9HX0RFQlVHLCAiQWNx
dWlyZWQgZmQgJWQgZnJvbSB0aGUgcG9sbCBkZXNjcmlwdG9yXG4iLCBwZmQuZmQpOwoKCWlmIChz
dHJlYW0gPT0gU05EX1BDTV9TVFJFQU1fQ0FQVFVSRSkKCQlyZWFkZGV2ID0gcGZkLmZkOwoJZWxz
ZQoJCXdyaXRlZGV2ID0gcGZkLmZkOwoKCXJldHVybiBoYW5kbGU7Cn0KCnN0YXRpYyBpbnQgc291
bmRjYXJkX2luaXQodm9pZCkKewoJYWxzYS5pY2FyZCA9IGFsc2FfY2FyZF9pbml0KGluZGV2bmFt
ZSwgU05EX1BDTV9TVFJFQU1fQ0FQVFVSRSk7CglhbHNhLm9jYXJkID0gYWxzYV9jYXJkX2luaXQo
b3V0ZGV2bmFtZSwgU05EX1BDTV9TVFJFQU1fUExBWUJBQ0spOwoKCWlmICghYWxzYS5pY2FyZCAm
JiAhYWxzYS5vY2FyZCkgewoJCWFzdF9sb2coTE9HX0VSUk9SLCAiUHJvYmxlbSBvcGVuaW5nIGFs
c2EgSS9PIGRldmljZXNcbiIpOwoJCXJldHVybiAtMTsKCX0KCglyZXR1cm4gMDsKfQoKc3RhdGlj
IGludCBhbHNhX2RpZ2l0KHN0cnVjdCBhc3RfY2hhbm5lbCAqYywgY2hhciBkaWdpdCwgdW5zaWdu
ZWQgaW50IGR1cmF0aW9uKQp7Cglhc3RfbXV0ZXhfbG9jaygmYWxzYWxvY2spOwoJYXN0X3ZlcmJv
c2UoIiA8PCBDb25zb2xlIFJlY2VpdmVkIGRpZ2l0ICVjIG9mIGR1cmF0aW9uICV1IG1zID4+IFxu
IiwgCgkJZGlnaXQsIGR1cmF0aW9uKTsKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCXJl
dHVybiAwOwp9CgpzdGF0aWMgaW50IGFsc2FfdGV4dChzdHJ1Y3QgYXN0X2NoYW5uZWwgKmMsIGNv
bnN0IGNoYXIgKnRleHQpCnsKCWFzdF9tdXRleF9sb2NrKCZhbHNhbG9jayk7Cglhc3RfdmVyYm9z
ZSgiIDw8IENvbnNvbGUgUmVjZWl2ZWQgdGV4dCAlcyA+PiBcbiIsIHRleHQpOwoJYXN0X211dGV4
X3VubG9jaygmYWxzYWxvY2spOwoJcmV0dXJuIDA7Cn0KCnN0YXRpYyB2b2lkIGdyYWJfb3duZXIo
dm9pZCkKewoJd2hpbGUgKGFsc2Eub3duZXIgJiYgYXN0X211dGV4X3RyeWxvY2soJmFsc2Eub3du
ZXItPmxvY2spKSB7CgkJREVBRExPQ0tfQVZPSURBTkNFKCZhbHNhbG9jayk7Cgl9Cn0KCnN0YXRp
YyBpbnQgYWxzYV9jYWxsKHN0cnVjdCBhc3RfY2hhbm5lbCAqYywgY2hhciAqZGVzdCwgaW50IHRp
bWVvdXQpCnsKCWludCByZXMgPSAzOwoJc3RydWN0IGFzdF9mcmFtZSBmID0geyBBU1RfRlJBTUVf
Q09OVFJPTCB9OwoJYXN0X211dGV4X2xvY2soJmFsc2Fsb2NrKTsKCWFzdF92ZXJib3NlKCIgPDwg
Q2FsbCBwbGFjZWQgdG8gJyVzJyBvbiBjb25zb2xlID4+IFxuIiwgZGVzdCk7CglpZiAoYXV0b2Fu
c3dlcikgewoJCWFzdF92ZXJib3NlKCIgPDwgQXV0by1hbnN3ZXJlZCA+PiBcbiIpOwoJCWdyYWJf
b3duZXIoKTsKCQlpZiAoYWxzYS5vd25lcikgewoJCQlmLnN1YmNsYXNzID0gQVNUX0NPTlRST0xf
QU5TV0VSOwoJCQlhc3RfcXVldWVfZnJhbWUoYWxzYS5vd25lciwgJmYpOwoJCQlhc3RfbXV0ZXhf
dW5sb2NrKCZhbHNhLm93bmVyLT5sb2NrKTsKCQl9Cgl9IGVsc2UgewoJCWFzdF92ZXJib3NlKCIg
PDwgVHlwZSAnYW5zd2VyJyB0byBhbnN3ZXIsIG9yIHVzZSAnYXV0b2Fuc3dlcicgZm9yIGZ1dHVy
ZSBjYWxscyA+PiBcbiIpOwoJCWdyYWJfb3duZXIoKTsKCQlpZiAoYWxzYS5vd25lcikgewoJCQlm
LnN1YmNsYXNzID0gQVNUX0NPTlRST0xfUklOR0lORzsKCQkJYXN0X3F1ZXVlX2ZyYW1lKGFsc2Eu
b3duZXIsICZmKTsKCQkJYXN0X211dGV4X3VubG9jaygmYWxzYS5vd25lci0+bG9jayk7CgkJfQoJ
CWlmICh3cml0ZShzbmRjbWRbMV0sICZyZXMsIHNpemVvZihyZXMpKSA8IDApIHsKCQkJYXN0X2xv
ZyhMT0dfV0FSTklORywgIndyaXRlKCkgZmFpbGVkOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsK
CQl9Cgl9CgogICAgaWYgKGFsc2EuaWNhcmQgPiAwKSB7CgkJc25kX3BjbV9wcmVwYXJlKGFsc2Eu
aWNhcmQpOwoJCXNuZF9wY21fc3RhcnQoYWxzYS5pY2FyZCk7Cgl9Cglhc3RfbXV0ZXhfdW5sb2Nr
KCZhbHNhbG9jayk7CglyZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgYW5zd2VyX3NvdW5kKHZvaWQp
CnsKCWludCByZXM7CgoJbm9zb3VuZCA9IDE7CglyZXMgPSA0OwoJaWYgKHdyaXRlKHNuZGNtZFsx
XSwgJnJlcywgc2l6ZW9mKHJlcykpIDwgMCkgewoJCWFzdF9sb2coTE9HX1dBUk5JTkcsICJ3cml0
ZSgpIGZhaWxlZDogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7Cgl9Cn0KCnN0YXRpYyBpbnQgYWxz
YV9hbnN3ZXIoc3RydWN0IGFzdF9jaGFubmVsICpjKQp7Cglhc3RfbXV0ZXhfbG9jaygmYWxzYWxv
Y2spOwoJYXN0X3ZlcmJvc2UoIiA8PCBDb25zb2xlIGNhbGwgaGFzIGJlZW4gYW5zd2VyZWQgPj4g
XG4iKTsKCWFuc3dlcl9zb3VuZCgpOwoJYXN0X3NldHN0YXRlKGMsIEFTVF9TVEFURV9VUCk7Cglj
dXJzb3VuZCA9IC0xOwogICAgaWYgKGFsc2EuaWNhcmQgPiAwKSB7CgkJc25kX3BjbV9wcmVwYXJl
KGFsc2EuaWNhcmQpOwoJCXNuZF9wY21fc3RhcnQoYWxzYS5pY2FyZCk7CiAgICB9Cglhc3RfbXV0
ZXhfdW5sb2NrKCZhbHNhbG9jayk7CglyZXR1cm4gMDsKfQoKc3RhdGljIGludCBhbHNhX2hhbmd1
cChzdHJ1Y3QgYXN0X2NoYW5uZWwgKmMpCnsKCWludCByZXM7Cglhc3RfbXV0ZXhfbG9jaygmYWxz
YWxvY2spOwoJY3Vyc291bmQgPSAtMTsKCWMtPnRlY2hfcHZ0ID0gTlVMTDsKCWFsc2Eub3duZXIg
PSBOVUxMOwoJYXN0X3ZlcmJvc2UoIiA8PCBIYW5ndXAgb24gY29uc29sZSA+PiBcbiIpOwoJYXN0
X21vZHVsZV91bnJlZihhc3RfbW9kdWxlX2luZm8tPnNlbGYpOwoJaWYgKGhvb2tzdGF0ZSkgewoJ
CWhvb2tzdGF0ZSA9IDA7CgkJaWYgKCFhdXRvYW5zd2VyKSB7CgkJCS8qIENvbmdlc3Rpb24gbm9p
c2UgKi8KCQkJcmVzID0gMjsKCQkJaWYgKHdyaXRlKHNuZGNtZFsxXSwgJnJlcywgc2l6ZW9mKHJl
cykpIDwgMCkgewoJCQkJYXN0X2xvZyhMT0dfV0FSTklORywgIndyaXRlKCkgZmFpbGVkOiAlc1xu
Iiwgc3RyZXJyb3IoZXJybm8pKTsKCQkJfQoJCX0KCX0KCglpZiAoYWxzYS5pY2FyZCA+IDApIHsK
CQlzbmRfcGNtX2Ryb3AoYWxzYS5pY2FyZCk7CiAgICB9Cglhc3RfbXV0ZXhfdW5sb2NrKCZhbHNh
bG9jayk7CglyZXR1cm4gMDsKfQoKc3RhdGljIGludCBhbHNhX3dyaXRlKHN0cnVjdCBhc3RfY2hh
bm5lbCAqY2hhbiwgc3RydWN0IGFzdF9mcmFtZSAqZikKewoJc3RhdGljIGNoYXIgc2l6YnVmWzgw
MDBdOwoJc3RhdGljIGludCBzaXpwb3MgPSAwOwoJaW50IGxlbiA9IHNpenBvczsKCWludCBwb3M7
CglpbnQgcmVzID0gMDsKCS8qIHNpemVfdCBmcmFtZXMgPSAwOyAqLwoJc25kX3BjbV9zdGF0ZV90
IHN0YXRlOwoKCS8qIEltbWVkaWF0ZWx5IHJldHVybiBpZiBubyBzb3VuZCBpcyBlbmFibGVkICov
CglpZiAobm9zb3VuZCB8fCAhYWxzYS5vY2FyZCkKCQlyZXR1cm4gMDsKCglhc3RfbXV0ZXhfbG9j
aygmYWxzYWxvY2spOwoJLyogU3RvcCBhbnkgY3VycmVudGx5IHBsYXlpbmcgc291bmQgKi8KCWlm
IChjdXJzb3VuZCAhPSAtMSkgewoJCXNuZF9wY21fZHJvcChhbHNhLm9jYXJkKTsKCQlzbmRfcGNt
X3ByZXBhcmUoYWxzYS5vY2FyZCk7CgkJY3Vyc291bmQgPSAtMTsKCX0KCgoJLyogV2UgaGF2ZSB0
byBkaWdlc3QgdGhlIGZyYW1lIGluIDE2MC1ieXRlIHBvcnRpb25zICovCglpZiAoZi0+ZGF0YWxl
biA+IHNpemVvZihzaXpidWYpIC0gc2l6cG9zKSB7CgkJYXN0X2xvZyhMT0dfV0FSTklORywgIkZy
YW1lIHRvbyBsYXJnZVxuIik7CgkJcmVzID0gLTE7Cgl9IGVsc2UgewoJCW1lbWNweShzaXpidWYg
KyBzaXpwb3MsIGYtPmRhdGEsIGYtPmRhdGFsZW4pOwoJCWxlbiArPSBmLT5kYXRhbGVuOwoJCXBv
cyA9IDA7CiNpZmRlZiBBTFNBX01PTklUT1IKCQlhbHNhX21vbml0b3Jfd3JpdGUoc2l6YnVmLCBs
ZW4pOwojZW5kaWYKCQlzdGF0ZSA9IHNuZF9wY21fc3RhdGUoYWxzYS5vY2FyZCk7CgkJaWYgKHN0
YXRlID09IFNORF9QQ01fU1RBVEVfWFJVTikKCQkJc25kX3BjbV9wcmVwYXJlKGFsc2Eub2NhcmQp
OwoJCXdoaWxlICgocmVzID0gc25kX3BjbV93cml0ZWkoYWxzYS5vY2FyZCwgc2l6YnVmLCBsZW4g
LyAyKSkgPT0gLUVBR0FJTikgewoJCQl1c2xlZXAoMSk7CgkJfQoJCWlmIChyZXMgPT0gLUVQSVBF
KSB7CiNpZiBERUJVRwoJCQlhc3RfbG9nKExPR19ERUJVRywgIlhSVU4gd3JpdGVcbiIpOwojZW5k
aWYKCQkJc25kX3BjbV9wcmVwYXJlKGFsc2Eub2NhcmQpOwoJCQl3aGlsZSAoKHJlcyA9IHNuZF9w
Y21fd3JpdGVpKGFsc2Eub2NhcmQsIHNpemJ1ZiwgbGVuIC8gMikpID09IC1FQUdBSU4pIHsKCQkJ
CXVzbGVlcCgxKTsKCQkJfQoJCQlpZiAocmVzICE9IGxlbiAvIDIpIHsKCQkJCWFzdF9sb2coTE9H
X0VSUk9SLCAiV3JpdGUgZXJyb3I6ICVzXG4iLCBzbmRfc3RyZXJyb3IocmVzKSk7CgkJCQlyZXMg
PSAtMTsKCQkJfSBlbHNlIGlmIChyZXMgPCAwKSB7CgkJCQlhc3RfbG9nKExPR19FUlJPUiwgIldy
aXRlIGVycm9yICVzXG4iLCBzbmRfc3RyZXJyb3IocmVzKSk7CgkJCQlyZXMgPSAtMTsKCQkJfQoJ
CX0gZWxzZSB7CgkJCWlmIChyZXMgPT0gLUVTVFJQSVBFKQoJCQkJYXN0X2xvZyhMT0dfRVJST1Is
ICJZb3UndmUgZ290IHNvbWUgYmlnIHByb2JsZW1zXG4iKTsKCQkJZWxzZSBpZiAocmVzIDwgMCkK
CQkJCWFzdF9sb2coTE9HX05PVElDRSwgIkVycm9yICVkIG9uIHdyaXRlXG4iLCByZXMpOwoJCX0K
CX0KCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCWlmIChyZXMgPiAwKQoJCXJlcyA9IDA7
CglyZXR1cm4gcmVzOwp9CgoKc3RhdGljIHN0cnVjdCBhc3RfZnJhbWUgKmFsc2FfcmVhZChzdHJ1
Y3QgYXN0X2NoYW5uZWwgKmNoYW4pCnsKCXN0YXRpYyBzdHJ1Y3QgYXN0X2ZyYW1lIGY7CglzdGF0
aWMgc2hvcnQgX19idWZbRlJBTUVfU0laRSArIEFTVF9GUklFTkRMWV9PRkZTRVQgLyAyXTsKCXNo
b3J0ICpidWY7CglzdGF0aWMgaW50IHJlYWRwb3MgPSAwOwoJc3RhdGljIGludCBsZWZ0ID0gRlJB
TUVfU0laRTsKCXNuZF9wY21fc3RhdGVfdCBzdGF0ZTsKCWludCByID0gMDsKCWludCBvZmYgPSAw
OwoKCWFzdF9tdXRleF9sb2NrKCZhbHNhbG9jayk7CgkvKiBBY2tub3dsZWRnZSBhbnkgcGVuZGlu
ZyBjbWQgKi8KCWYuZnJhbWV0eXBlID0gQVNUX0ZSQU1FX05VTEw7CglmLnN1YmNsYXNzID0gMDsK
CWYuc2FtcGxlcyA9IDA7CglmLmRhdGFsZW4gPSAwOwoJZi5kYXRhID0gTlVMTDsKCWYub2Zmc2V0
ID0gMDsKCWYuc3JjID0gIkNvbnNvbGUiOwoJZi5tYWxsb2NkID0gMDsKCWYuZGVsaXZlcnkudHZf
c2VjID0gMDsKCWYuZGVsaXZlcnkudHZfdXNlYyA9IDA7CiAgICAgICAgCiAgICBpZiAoYWxzYS5p
Y2FyZCA+IDApIHsKICAgIAlzdGF0ZSA9IHNuZF9wY21fc3RhdGUoYWxzYS5pY2FyZCk7CiAgICAJ
aWYgKChzdGF0ZSAhPSBTTkRfUENNX1NUQVRFX1BSRVBBUkVEKSAmJiAoc3RhdGUgIT0gU05EX1BD
TV9TVEFURV9SVU5OSU5HKSkgewogICAgCQlzbmRfcGNtX3ByZXBhcmUoYWxzYS5pY2FyZCk7CiAg
ICAJfQogICAgCiAgICAJYnVmID0gX19idWYgKyBBU1RfRlJJRU5ETFlfT0ZGU0VUIC8gMjsKICAg
IAogICAgCXIgPSBzbmRfcGNtX3JlYWRpKGFsc2EuaWNhcmQsIGJ1ZiArIHJlYWRwb3MsIGxlZnQp
OwogICAgCWlmIChyID09IC1FUElQRSkgewojaWYgREVCVUcKICAgIAkJYXN0X2xvZyhMT0dfRVJS
T1IsICJYUlVOIHJlYWRcbiIpOwojZW5kaWYKICAgIAkJc25kX3BjbV9wcmVwYXJlKGFsc2EuaWNh
cmQpOwogICAgCX0gZWxzZSBpZiAociA9PSAtRVNUUlBJUEUpIHsKICAgIAkJYXN0X2xvZyhMT0df
RVJST1IsICItRVNUUlBJUEVcbiIpOwogICAgCQlzbmRfcGNtX3ByZXBhcmUoYWxzYS5pY2FyZCk7
CiAgICAJfSBlbHNlIGlmIChyIDwgMCkgewogICAgCQlhc3RfbG9nKExPR19FUlJPUiwgIlJlYWQg
ZXJyb3I6ICVzXG4iLCBzbmRfc3RyZXJyb3IocikpOwogICAgCX0gZWxzZSBpZiAociA+PSAwKSB7
CiAgICAJCW9mZiAtPSByOwogICAgCX0KICAgIAkvKiBVcGRhdGUgcG9zaXRpb25zICovCiAgICAJ
cmVhZHBvcyArPSByOwogICAgCWxlZnQgLT0gcjsKICAgIAogICAgCWlmIChyZWFkcG9zID49IEZS
QU1FX1NJWkUpIHsKICAgIAkJLyogQSByZWFsIGZyYW1lICovCiAgICAJCXJlYWRwb3MgPSAwOwog
ICAgCQlsZWZ0ID0gRlJBTUVfU0laRTsKICAgIAkJaWYgKGNoYW4tPl9zdGF0ZSAhPSBBU1RfU1RB
VEVfVVApIHsKICAgIAkJCS8qIERvbid0IHRyYW5zbWl0IHVubGVzcyBpdCdzIHVwICovCiAgICAJ
CQlhc3RfbXV0ZXhfdW5sb2NrKCZhbHNhbG9jayk7CiAgICAJCQlyZXR1cm4gJmY7CiAgICAJCX0K
ICAgIAkJZi5mcmFtZXR5cGUgPSBBU1RfRlJBTUVfVk9JQ0U7CiAgICAJCWYuc3ViY2xhc3MgPSBB
U1RfRk9STUFUX1NMSU5FQVI7CiAgICAJCWYuc2FtcGxlcyA9IEZSQU1FX1NJWkU7CiAgICAJCWYu
ZGF0YWxlbiA9IEZSQU1FX1NJWkUgKiAyOwogICAgCQlmLmRhdGEgPSBidWY7CiAgICAJCWYub2Zm
c2V0ID0gQVNUX0ZSSUVORExZX09GRlNFVDsKICAgIAkJZi5zcmMgPSAiQ29uc29sZSI7CiAgICAJ
CWYubWFsbG9jZCA9IDA7CiNpZmRlZiBBTFNBX01PTklUT1IKICAgICAgICAgICAgYWxzYV9tb25p
dG9yX3JlYWQoKGNoYXIgKikgYnVmLCBGUkFNRV9TSVpFICogMik7CiNlbmRpZgogICAgCX0KICAg
IH0KCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCXJldHVybiAmZjsKfQoKc3RhdGljIGlu
dCBhbHNhX2ZpeHVwKHN0cnVjdCBhc3RfY2hhbm5lbCAqb2xkY2hhbiwgc3RydWN0IGFzdF9jaGFu
bmVsICpuZXdjaGFuKQp7CglzdHJ1Y3QgY2hhbl9hbHNhX3B2dCAqcCA9IG5ld2NoYW4tPnRlY2hf
cHZ0OwoJYXN0X211dGV4X2xvY2soJmFsc2Fsb2NrKTsKCXAtPm93bmVyID0gbmV3Y2hhbjsKCWFz
dF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IGFsc2Ff
aW5kaWNhdGUoc3RydWN0IGFzdF9jaGFubmVsICpjaGFuLCBpbnQgY29uZCwgY29uc3Qgdm9pZCAq
ZGF0YSwgc2l6ZV90IGRhdGFsZW4pCnsKCWludCByZXMgPSAwOwoKCWFzdF9tdXRleF9sb2NrKCZh
bHNhbG9jayk7CgoJc3dpdGNoIChjb25kKSB7CgljYXNlIEFTVF9DT05UUk9MX0JVU1k6CgkJcmVz
ID0gMTsKCQlicmVhazsKCWNhc2UgQVNUX0NPTlRST0xfQ09OR0VTVElPTjoKCQlyZXMgPSAyOwoJ
CWJyZWFrOwoJY2FzZSBBU1RfQ09OVFJPTF9SSU5HSU5HOgoJY2FzZSBBU1RfQ09OVFJPTF9QUk9H
UkVTUzoKCQlicmVhazsKCWNhc2UgLTE6CgkJcmVzID0gLTE7CgkJYnJlYWs7CgljYXNlIEFTVF9D
T05UUk9MX1ZJRFVQREFURToKCQlyZXMgPSAtMTsKCQlicmVhazsKCWNhc2UgQVNUX0NPTlRST0xf
SE9MRDoKCQlhc3RfdmVyYm9zZSgiIDw8IENvbnNvbGUgSGFzIEJlZW4gUGxhY2VkIG9uIEhvbGQg
Pj4gXG4iKTsKCQlhc3RfbW9oX3N0YXJ0KGNoYW4sIGRhdGEsIG1vaGludGVycHJldCk7CgkJYnJl
YWs7CgljYXNlIEFTVF9DT05UUk9MX1VOSE9MRDoKCQlhc3RfdmVyYm9zZSgiIDw8IENvbnNvbGUg
SGFzIEJlZW4gUmV0cmlldmVkIGZyb20gSG9sZCA+PiBcbiIpOwoJCWFzdF9tb2hfc3RvcChjaGFu
KTsKCQlicmVhazsKCWNhc2UgQVNUX0NPTlRST0xfU1JDVVBEQVRFOgoJCWJyZWFrOwoJZGVmYXVs
dDoKCQlhc3RfbG9nKExPR19XQVJOSU5HLCAiRG9uJ3Qga25vdyBob3cgdG8gZGlzcGxheSBjb25k
aXRpb24gJWQgb24gJXNcbiIsIGNvbmQsIGNoYW4tPm5hbWUpOwoJCXJlcyA9IC0xOwoJfQoKCWlm
IChyZXMgPiAtMSkgewoJCWlmICh3cml0ZShzbmRjbWRbMV0sICZyZXMsIHNpemVvZihyZXMpKSA8
IDApIHsKCQkJYXN0X2xvZyhMT0dfV0FSTklORywgIndyaXRlKCkgZmFpbGVkOiAlc1xuIiwgc3Ry
ZXJyb3IoZXJybm8pKTsKCQl9Cgl9CgoJYXN0X211dGV4X3VubG9jaygmYWxzYWxvY2spOwoKCXJl
dHVybiByZXM7Cn0KCnN0YXRpYyBzdHJ1Y3QgYXN0X2NoYW5uZWwgKmFsc2FfbmV3KHN0cnVjdCBj
aGFuX2Fsc2FfcHZ0ICpwLCBpbnQgc3RhdGUpCnsKCXN0cnVjdCBhc3RfY2hhbm5lbCAqdG1wID0g
TlVMTDsKCQoJaWYgKCEodG1wID0gYXN0X2NoYW5uZWxfYWxsb2MoMSwgc3RhdGUsIDAsIDAsICIi
LCBwLT5leHRlbiwgcC0+Y29udGV4dCwgMCwgIkFMU0EvJXMiLCBpbmRldm5hbWUpKSkKCQlyZXR1
cm4gTlVMTDsKCgl0bXAtPnRlY2ggPSAmYWxzYV90ZWNoOwoJdG1wLT5mZHNbMF0gPSByZWFkZGV2
OwoJdG1wLT5uYXRpdmVmb3JtYXRzID0gQVNUX0ZPUk1BVF9TTElORUFSOwoJdG1wLT5yZWFkZm9y
bWF0ID0gQVNUX0ZPUk1BVF9TTElORUFSOwoJdG1wLT53cml0ZWZvcm1hdCA9IEFTVF9GT1JNQVRf
U0xJTkVBUjsKCXRtcC0+dGVjaF9wdnQgPSBwOwoJaWYgKCFhc3Rfc3RybGVuX3plcm8ocC0+Y29u
dGV4dCkpCgkJYXN0X2NvcHlfc3RyaW5nKHRtcC0+Y29udGV4dCwgcC0+Y29udGV4dCwgc2l6ZW9m
KHRtcC0+Y29udGV4dCkpOwoJaWYgKCFhc3Rfc3RybGVuX3plcm8ocC0+ZXh0ZW4pKQoJCWFzdF9j
b3B5X3N0cmluZyh0bXAtPmV4dGVuLCBwLT5leHRlbiwgc2l6ZW9mKHRtcC0+ZXh0ZW4pKTsKCWlm
ICghYXN0X3N0cmxlbl96ZXJvKGxhbmd1YWdlKSkKCQlhc3Rfc3RyaW5nX2ZpZWxkX3NldCh0bXAs
IGxhbmd1YWdlLCBsYW5ndWFnZSk7CglwLT5vd25lciA9IHRtcDsKCWFzdF9tb2R1bGVfcmVmKGFz
dF9tb2R1bGVfaW5mby0+c2VsZik7Cglhc3RfamJfY29uZmlndXJlKHRtcCwgJmdsb2JhbF9qYmNv
bmYpOwoJaWYgKHN0YXRlICE9IEFTVF9TVEFURV9ET1dOKSB7CgkJaWYgKGFzdF9wYnhfc3RhcnQo
dG1wKSkgewoJCQlhc3RfbG9nKExPR19XQVJOSU5HLCAiVW5hYmxlIHRvIHN0YXJ0IFBCWCBvbiAl
c1xuIiwgdG1wLT5uYW1lKTsKCQkJYXN0X2hhbmd1cCh0bXApOwoJCQl0bXAgPSBOVUxMOwoJCX0K
CX0KCglyZXR1cm4gdG1wOwp9CgpzdGF0aWMgc3RydWN0IGFzdF9jaGFubmVsICphbHNhX3JlcXVl
c3QoY29uc3QgY2hhciAqdHlwZSwgaW50IGZvcm1hdCwgdm9pZCAqZGF0YSwgaW50ICpjYXVzZSkK
ewoJaW50IG9sZGZvcm1hdCA9IGZvcm1hdDsKCXN0cnVjdCBhc3RfY2hhbm5lbCAqdG1wID0gTlVM
TDsKCglmb3JtYXQgJj0gQVNUX0ZPUk1BVF9TTElORUFSOwoJaWYgKCFmb3JtYXQpIHsKCQlhc3Rf
bG9nKExPR19OT1RJQ0UsICJBc2tlZCB0byBnZXQgYSBjaGFubmVsIG9mIGZvcm1hdCAnJWQnXG4i
LCBvbGRmb3JtYXQpOwoJCXJldHVybiBOVUxMOwoJfQoKCWFzdF9tdXRleF9sb2NrKCZhbHNhbG9j
ayk7CgoJaWYgKGFsc2Eub3duZXIpIHsKCQlhc3RfbG9nKExPR19OT1RJQ0UsICJBbHJlYWR5IGhh
dmUgYSBjYWxsIG9uIHRoZSBBTFNBIGNoYW5uZWxcbiIpOwoJCSpjYXVzZSA9IEFTVF9DQVVTRV9C
VVNZOwoJfSBlbHNlIGlmICghKHRtcCA9IGFsc2FfbmV3KCZhbHNhLCBBU1RfU1RBVEVfRE9XTikp
KQoJCWFzdF9sb2coTE9HX1dBUk5JTkcsICJVbmFibGUgdG8gY3JlYXRlIG5ldyBBTFNBIGNoYW5u
ZWxcbiIpOwoKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCglyZXR1cm4gdG1wOwp9Cgpz
dGF0aWMgaW50IGNvbnNvbGVfYXV0b2Fuc3dlcl9kZXByZWNhdGVkKGludCBmZCwgaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkKewoJaW50IHJlcyA9IFJFU1VMVF9TVUNDRVNTOwoKCWlmICgoYXJnYyAh
PSAxKSAmJiAoYXJnYyAhPSAyKSkKCQlyZXR1cm4gUkVTVUxUX1NIT1dVU0FHRTsKCglhc3RfbXV0
ZXhfbG9jaygmYWxzYWxvY2spOwoKCWlmIChhcmdjID09IDEpIHsKCQlhc3RfY2xpKGZkLCAiQXV0
byBhbnN3ZXIgaXMgJXMuXG4iLCBhdXRvYW5zd2VyID8gIm9uIiA6ICJvZmYiKTsKCX0gZWxzZSB7
CgkJaWYgKCFzdHJjYXNlY21wKGFyZ3ZbMV0sICJvbiIpKQoJCQlhdXRvYW5zd2VyID0gLTE7CgkJ
ZWxzZSBpZiAoIXN0cmNhc2VjbXAoYXJndlsxXSwgIm9mZiIpKQoJCQlhdXRvYW5zd2VyID0gMDsK
CQllbHNlCgkJCXJlcyA9IFJFU1VMVF9TSE9XVVNBR0U7Cgl9CgoJYXN0X211dGV4X3VubG9jaygm
YWxzYWxvY2spOwoKCXJldHVybiByZXM7Cn0KCnN0YXRpYyBpbnQgY29uc29sZV9hdXRvYW5zd2Vy
KGludCBmZCwgaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJaW50IHJlcyA9IFJFU1VMVF9TVUND
RVNTOzsKCWlmICgoYXJnYyAhPSAyKSAmJiAoYXJnYyAhPSAzKSkKCQlyZXR1cm4gUkVTVUxUX1NI
T1dVU0FHRTsKCWFzdF9tdXRleF9sb2NrKCZhbHNhbG9jayk7CglpZiAoYXJnYyA9PSAyKSB7CgkJ
YXN0X2NsaShmZCwgIkF1dG8gYW5zd2VyIGlzICVzLlxuIiwgYXV0b2Fuc3dlciA/ICJvbiIgOiAi
b2ZmIik7Cgl9IGVsc2UgewoJCWlmICghc3RyY2FzZWNtcChhcmd2WzJdLCAib24iKSkKCQkJYXV0
b2Fuc3dlciA9IC0xOwoJCWVsc2UgaWYgKCFzdHJjYXNlY21wKGFyZ3ZbMl0sICJvZmYiKSkKCQkJ
YXV0b2Fuc3dlciA9IDA7CgkJZWxzZQoJCQlyZXMgPSBSRVNVTFRfU0hPV1VTQUdFOwoJfQoJYXN0
X211dGV4X3VubG9jaygmYWxzYWxvY2spOwoJcmV0dXJuIHJlczsKfQoKc3RhdGljIGNoYXIgKmF1
dG9hbnN3ZXJfY29tcGxldGUoY29uc3QgY2hhciAqbGluZSwgY29uc3QgY2hhciAqd29yZCwgaW50
IHBvcywgaW50IHN0YXRlKQp7CiNpZm5kZWYgTUlOCiNkZWZpbmUgTUlOKGEsYikgKChhKSA8IChi
KSA/IChhKSA6IChiKSkKI2VuZGlmCglzd2l0Y2ggKHN0YXRlKSB7CgkJY2FzZSAwOgoJCQlpZiAo
IWFzdF9zdHJsZW5femVybyh3b3JkKSAmJiAhc3RybmNhc2VjbXAod29yZCwgIm9uIiwgTUlOKHN0
cmxlbih3b3JkKSwgMikpKQoJCQkJcmV0dXJuIGFzdF9zdHJkdXAoIm9uIik7CgkJY2FzZSAxOgoJ
CQlpZiAoIWFzdF9zdHJsZW5femVybyh3b3JkKSAmJiAhc3RybmNhc2VjbXAod29yZCwgIm9mZiIs
IE1JTihzdHJsZW4od29yZCksIDMpKSkKCQkJCXJldHVybiBhc3Rfc3RyZHVwKCJvZmYiKTsKCQlk
ZWZhdWx0OgoJCQlyZXR1cm4gTlVMTDsKCX0KCXJldHVybiBOVUxMOwp9CgpzdGF0aWMgY29uc3Qg
Y2hhciBhdXRvYW5zd2VyX3VzYWdlW10gPQoJIlVzYWdlOiBjb25zb2xlIGF1dG9hbnN3ZXIgW29u
fG9mZl1cbiIKCSIgICAgICAgRW5hYmxlcyBvciBkaXNhYmxlcyBhdXRvYW5zd2VyIGZlYXR1cmUu
ICBJZiB1c2VkIHdpdGhvdXRcbiIKCSIgICAgICAgYXJndW1lbnQsIGRpc3BsYXlzIHRoZSBjdXJy
ZW50IG9uL29mZiBzdGF0dXMgb2YgYXV0b2Fuc3dlci5cbiIKCSIgICAgICAgVGhlIGRlZmF1bHQg
dmFsdWUgb2YgYXV0b2Fuc3dlciBpcyBpbiAnYWxzYS5jb25mJy5cbiI7CgpzdGF0aWMgaW50IGNv
bnNvbGVfYW5zd2VyX2RlcHJlY2F0ZWQoaW50IGZkLCBpbnQgYXJnYywgY2hhciAqYXJndltdKQp7
CglpbnQgcmVzID0gUkVTVUxUX1NVQ0NFU1M7CgoJaWYgKGFyZ2MgIT0gMSkKCQlyZXR1cm4gUkVT
VUxUX1NIT1dVU0FHRTsKCglhc3RfbXV0ZXhfbG9jaygmYWxzYWxvY2spOwoKCWlmICghYWxzYS5v
d25lcikgewoJCWFzdF9jbGkoZmQsICJObyBvbmUgaXMgY2FsbGluZyB1c1xuIik7CgkJcmVzID0g
UkVTVUxUX0ZBSUxVUkU7Cgl9IGVsc2UgewoJCWhvb2tzdGF0ZSA9IDE7CgkJY3Vyc291bmQgPSAt
MTsKCQlncmFiX293bmVyKCk7CgkJaWYgKGFsc2Eub3duZXIpIHsKCQkJc3RydWN0IGFzdF9mcmFt
ZSBmID0geyBBU1RfRlJBTUVfQ09OVFJPTCwgQVNUX0NPTlRST0xfQU5TV0VSIH07CgkJCWFzdF9x
dWV1ZV9mcmFtZShhbHNhLm93bmVyLCAmZik7CgkJCWFzdF9tdXRleF91bmxvY2soJmFsc2Eub3du
ZXItPmxvY2spOwoJCX0KCQlhbnN3ZXJfc291bmQoKTsKCX0KCiAgICBpZiAoYWxzYS5pY2FyZCA+
IDApIHsKCQlzbmRfcGNtX3ByZXBhcmUoYWxzYS5pY2FyZCk7CgkJc25kX3BjbV9zdGFydChhbHNh
LmljYXJkKTsKICAgIH0KCglhc3RfbXV0ZXhfdW5sb2NrKCZhbHNhbG9jayk7CgoJcmV0dXJuIFJF
U1VMVF9TVUNDRVNTOwp9CgpzdGF0aWMgaW50IGNvbnNvbGVfYW5zd2VyKGludCBmZCwgaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKewoJaW50IHJlcyA9IFJFU1VMVF9TVUNDRVNTOwoKCWlmIChhcmdj
ICE9IDIpCgkJcmV0dXJuIFJFU1VMVF9TSE9XVVNBR0U7CgoJYXN0X211dGV4X2xvY2soJmFsc2Fs
b2NrKTsKCglpZiAoIWFsc2Eub3duZXIpIHsKCQlhc3RfY2xpKGZkLCAiTm8gb25lIGlzIGNhbGxp
bmcgdXNcbiIpOwoJCXJlcyA9IFJFU1VMVF9GQUlMVVJFOwoJfSBlbHNlIHsKCQlob29rc3RhdGUg
PSAxOwoJCWN1cnNvdW5kID0gLTE7CgkJZ3JhYl9vd25lcigpOwoJCWlmIChhbHNhLm93bmVyKSB7
CgkJCXN0cnVjdCBhc3RfZnJhbWUgZiA9IHsgQVNUX0ZSQU1FX0NPTlRST0wsIEFTVF9DT05UUk9M
X0FOU1dFUiB9OwoJCQlhc3RfcXVldWVfZnJhbWUoYWxzYS5vd25lciwgJmYpOwoJCQlhc3RfbXV0
ZXhfdW5sb2NrKCZhbHNhLm93bmVyLT5sb2NrKTsKCQl9CgkJYW5zd2VyX3NvdW5kKCk7Cgl9CgoJ
aWYgKGFsc2EuaWNhcmQgPiAwKSB7CiAgICAgICAgCXNuZF9wY21fcHJlcGFyZShhbHNhLmljYXJk
KTsKCQlzbmRfcGNtX3N0YXJ0KGFsc2EuaWNhcmQpOwoJfQoKCWFzdF9tdXRleF91bmxvY2soJmFs
c2Fsb2NrKTsKCglyZXR1cm4gUkVTVUxUX1NVQ0NFU1M7Cn0KCnN0YXRpYyBjaGFyIHNlbmR0ZXh0
X3VzYWdlW10gPQoJIlVzYWdlOiBjb25zb2xlIHNlbmQgdGV4dCA8bWVzc2FnZT5cbiIKCSIgICAg
ICAgU2VuZHMgYSB0ZXh0IG1lc3NhZ2UgZm9yIGRpc3BsYXkgb24gdGhlIHJlbW90ZSB0ZXJtaW5h
bC5cbiI7CgpzdGF0aWMgaW50IGNvbnNvbGVfc2VuZHRleHRfZGVwcmVjYXRlZChpbnQgZmQsIGlu
dCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWludCB0bXBhcmcgPSAyOwoJaW50IHJlcyA9IFJFU1VM
VF9TVUNDRVNTOwoKCWlmIChhcmdjIDwgMikKCQlyZXR1cm4gUkVTVUxUX1NIT1dVU0FHRTsKCglh
c3RfbXV0ZXhfbG9jaygmYWxzYWxvY2spOwoKCWlmICghYWxzYS5vd25lcikgewoJCWFzdF9jbGko
ZmQsICJObyBvbmUgaXMgY2FsbGluZyB1c1xuIik7CgkJcmVzID0gUkVTVUxUX0ZBSUxVUkU7Cgl9
IGVsc2UgewoJCXN0cnVjdCBhc3RfZnJhbWUgZiA9IHsgQVNUX0ZSQU1FX1RFWFQsIDAgfTsKCQlj
aGFyIHRleHQyc2VuZFsyNTZdID0gIiI7CgkJdGV4dDJzZW5kWzBdID0gJ1wwJzsKCQl3aGlsZSAo
dG1wYXJnIDwgYXJnYykgewoJCQlzdHJuY2F0KHRleHQyc2VuZCwgYXJndlt0bXBhcmcrK10sIHNp
emVvZih0ZXh0MnNlbmQpIC0gc3RybGVuKHRleHQyc2VuZCkgLSAxKTsKCQkJc3RybmNhdCh0ZXh0
MnNlbmQsICIgIiwgc2l6ZW9mKHRleHQyc2VuZCkgLSBzdHJsZW4odGV4dDJzZW5kKSAtIDEpOwoJ
CX0KCQl0ZXh0MnNlbmRbc3RybGVuKHRleHQyc2VuZCkgLSAxXSA9ICdcbic7CgkJZi5kYXRhID0g
dGV4dDJzZW5kOwoJCWYuZGF0YWxlbiA9IHN0cmxlbih0ZXh0MnNlbmQpICsgMTsKCQlncmFiX293
bmVyKCk7CgkJaWYgKGFsc2Eub3duZXIpIHsKCQkJYXN0X3F1ZXVlX2ZyYW1lKGFsc2Eub3duZXIs
ICZmKTsKCQkJZi5mcmFtZXR5cGUgPSBBU1RfRlJBTUVfQ09OVFJPTDsKCQkJZi5zdWJjbGFzcyA9
IEFTVF9DT05UUk9MX0FOU1dFUjsKCQkJZi5kYXRhID0gTlVMTDsKCQkJZi5kYXRhbGVuID0gMDsK
CQkJYXN0X3F1ZXVlX2ZyYW1lKGFsc2Eub3duZXIsICZmKTsKCQkJYXN0X211dGV4X3VubG9jaygm
YWxzYS5vd25lci0+bG9jayk7CgkJfQoJfQoKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsK
CglyZXR1cm4gcmVzOwp9CgpzdGF0aWMgaW50IGNvbnNvbGVfc2VuZHRleHQoaW50IGZkLCBpbnQg
YXJnYywgY2hhciAqYXJndltdKQp7CglpbnQgdG1wYXJnID0gMzsKCWludCByZXMgPSBSRVNVTFRf
U1VDQ0VTUzsKCglpZiAoYXJnYyA8IDMpCgkJcmV0dXJuIFJFU1VMVF9TSE9XVVNBR0U7CgoJYXN0
X211dGV4X2xvY2soJmFsc2Fsb2NrKTsKCglpZiAoIWFsc2Eub3duZXIpIHsKCQlhc3RfY2xpKGZk
LCAiTm8gb25lIGlzIGNhbGxpbmcgdXNcbiIpOwoJCXJlcyA9IFJFU1VMVF9GQUlMVVJFOwoJfSBl
bHNlIHsKCQlzdHJ1Y3QgYXN0X2ZyYW1lIGYgPSB7IEFTVF9GUkFNRV9URVhULCAwIH07CgkJY2hh
ciB0ZXh0MnNlbmRbMjU2XSA9ICIiOwoJCXRleHQyc2VuZFswXSA9ICdcMCc7CgkJd2hpbGUgKHRt
cGFyZyA8IGFyZ2MpIHsKCQkJc3RybmNhdCh0ZXh0MnNlbmQsIGFyZ3ZbdG1wYXJnKytdLCBzaXpl
b2YodGV4dDJzZW5kKSAtIHN0cmxlbih0ZXh0MnNlbmQpIC0gMSk7CgkJCXN0cm5jYXQodGV4dDJz
ZW5kLCAiICIsIHNpemVvZih0ZXh0MnNlbmQpIC0gc3RybGVuKHRleHQyc2VuZCkgLSAxKTsKCQl9
CgkJdGV4dDJzZW5kW3N0cmxlbih0ZXh0MnNlbmQpIC0gMV0gPSAnXG4nOwoJCWYuZGF0YSA9IHRl
eHQyc2VuZDsKCQlmLmRhdGFsZW4gPSBzdHJsZW4odGV4dDJzZW5kKSArIDE7CgkJZ3JhYl9vd25l
cigpOwoJCWlmIChhbHNhLm93bmVyKSB7CgkJCWFzdF9xdWV1ZV9mcmFtZShhbHNhLm93bmVyLCAm
Zik7CgkJCWYuZnJhbWV0eXBlID0gQVNUX0ZSQU1FX0NPTlRST0w7CgkJCWYuc3ViY2xhc3MgPSBB
U1RfQ09OVFJPTF9BTlNXRVI7CgkJCWYuZGF0YSA9IE5VTEw7CgkJCWYuZGF0YWxlbiA9IDA7CgkJ
CWFzdF9xdWV1ZV9mcmFtZShhbHNhLm93bmVyLCAmZik7CgkJCWFzdF9tdXRleF91bmxvY2soJmFs
c2Eub3duZXItPmxvY2spOwoJCX0KCX0KCglhc3RfbXV0ZXhfdW5sb2NrKCZhbHNhbG9jayk7CgoJ
cmV0dXJuIHJlczsKfQoKc3RhdGljIGNoYXIgYW5zd2VyX3VzYWdlW10gPQoJIlVzYWdlOiBjb25z
b2xlIGFuc3dlclxuIgoJIiAgICAgICBBbnN3ZXJzIGFuIGluY29taW5nIGNhbGwgb24gdGhlIGNv
bnNvbGUgKEFMU0EpIGNoYW5uZWwuXG4iOwoKc3RhdGljIGludCBjb25zb2xlX2hhbmd1cF9kZXBy
ZWNhdGVkKGludCBmZCwgaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJaW50IHJlcyA9IFJFU1VM
VF9TVUNDRVNTOwoKCWlmIChhcmdjICE9IDEpCgkJcmV0dXJuIFJFU1VMVF9TSE9XVVNBR0U7CgoJ
Y3Vyc291bmQgPSAtMTsKCglhc3RfbXV0ZXhfbG9jaygmYWxzYWxvY2spOwoKCWlmICghYWxzYS5v
d25lciAmJiAhaG9va3N0YXRlKSB7CgkJYXN0X2NsaShmZCwgIk5vIGNhbGwgdG8gaGFuZ3VwIHVw
XG4iKTsKCQlyZXMgPSBSRVNVTFRfRkFJTFVSRTsKCX0gZWxzZSB7CgkJaG9va3N0YXRlID0gMDsK
CQlncmFiX293bmVyKCk7CgkJaWYgKGFsc2Eub3duZXIpIHsKCQkJYXN0X3F1ZXVlX2hhbmd1cChh
bHNhLm93bmVyKTsKCQkJYXN0X211dGV4X3VubG9jaygmYWxzYS5vd25lci0+bG9jayk7CgkJfQoJ
fQoKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCglyZXR1cm4gcmVzOwp9CgpzdGF0aWMg
aW50IGNvbnNvbGVfaGFuZ3VwKGludCBmZCwgaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJaW50
IHJlcyA9IFJFU1VMVF9TVUNDRVNTOwoKCWlmIChhcmdjICE9IDIpCgkJcmV0dXJuIFJFU1VMVF9T
SE9XVVNBR0U7CgoJY3Vyc291bmQgPSAtMTsKCglhc3RfbXV0ZXhfbG9jaygmYWxzYWxvY2spOwoK
CWlmICghYWxzYS5vd25lciAmJiAhaG9va3N0YXRlKSB7CgkJYXN0X2NsaShmZCwgIk5vIGNhbGwg
dG8gaGFuZ3VwIHVwXG4iKTsKCQlyZXMgPSBSRVNVTFRfRkFJTFVSRTsKCX0gZWxzZSB7CgkJaG9v
a3N0YXRlID0gMDsKCQlncmFiX293bmVyKCk7CgkJaWYgKGFsc2Eub3duZXIpIHsKCQkJYXN0X3F1
ZXVlX2hhbmd1cChhbHNhLm93bmVyKTsKCQkJYXN0X211dGV4X3VubG9jaygmYWxzYS5vd25lci0+
bG9jayk7CgkJfQoJfQoKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fsb2NrKTsKCglyZXR1cm4gcmVz
Owp9CgpzdGF0aWMgY2hhciBoYW5ndXBfdXNhZ2VbXSA9CgkiVXNhZ2U6IGNvbnNvbGUgaGFuZ3Vw
XG4iCgkiICAgICAgIEhhbmdzIHVwIGFueSBjYWxsIGN1cnJlbnRseSBwbGFjZWQgb24gdGhlIGNv
bnNvbGUuXG4iOwoKc3RhdGljIGludCBjb25zb2xlX2RpYWxfZGVwcmVjYXRlZChpbnQgZmQsIGlu
dCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWNoYXIgdG1wWzI1Nl0sICp0bXAyOwoJY2hhciAqbXll
LCAqbXljOwoJY2hhciAqZDsKCWludCByZXMgPSBSRVNVTFRfU1VDQ0VTUzsKCglpZiAoKGFyZ2Mg
IT0gMSkgJiYgKGFyZ2MgIT0gMikpCgkJcmV0dXJuIFJFU1VMVF9TSE9XVVNBR0U7CgoJYXN0X211
dGV4X2xvY2soJmFsc2Fsb2NrKTsKCglpZiAoYWxzYS5vd25lcikgewoJCWlmIChhcmdjID09IDIp
IHsKCQkJZCA9IGFyZ3ZbMV07CgkJCWdyYWJfb3duZXIoKTsKCQkJaWYgKGFsc2Eub3duZXIpIHsK
CQkJCXN0cnVjdCBhc3RfZnJhbWUgZiA9IHsgQVNUX0ZSQU1FX0RUTUYgfTsKCQkJCXdoaWxlICgq
ZCkgewoJCQkJCWYuc3ViY2xhc3MgPSAqZDsKCQkJCQlhc3RfcXVldWVfZnJhbWUoYWxzYS5vd25l
ciwgJmYpOwoJCQkJCWQrKzsKCQkJCX0KCQkJCWFzdF9tdXRleF91bmxvY2soJmFsc2Eub3duZXIt
PmxvY2spOwoJCQl9CgkJfSBlbHNlIHsKCQkJYXN0X2NsaShmZCwgIllvdSdyZSBhbHJlYWR5IGlu
IGEgY2FsbC4gIFlvdSBjYW4gdXNlIHRoaXMgb25seSB0byBkaWFsIGRpZ2l0cyB1bnRpbCB5b3Ug
aGFuZ3VwXG4iKTsKCQkJcmVzID0gUkVTVUxUX0ZBSUxVUkU7CgkJfQoJfSBlbHNlIHsKCQlteWUg
PSBleHRlbjsKCQlteWMgPSBjb250ZXh0OwoJCWlmIChhcmdjID09IDIpIHsKCQkJY2hhciAqc3Ry
aW5ncCA9IE5VTEw7CgkJCWFzdF9jb3B5X3N0cmluZyh0bXAsIGFyZ3ZbMV0sIHNpemVvZih0bXAp
KTsKCQkJc3RyaW5ncCA9IHRtcDsKCQkJc3Ryc2VwKCZzdHJpbmdwLCAiQCIpOwoJCQl0bXAyID0g
c3Ryc2VwKCZzdHJpbmdwLCAiQCIpOwoJCQlpZiAoIWFzdF9zdHJsZW5femVybyh0bXApKQoJCQkJ
bXllID0gdG1wOwoJCQlpZiAoIWFzdF9zdHJsZW5femVybyh0bXAyKSkKCQkJCW15YyA9IHRtcDI7
CgkJfQoJCWlmIChhc3RfZXhpc3RzX2V4dGVuc2lvbihOVUxMLCBteWMsIG15ZSwgMSwgTlVMTCkp
IHsKCQkJYXN0X2NvcHlfc3RyaW5nKGFsc2EuZXh0ZW4sIG15ZSwgc2l6ZW9mKGFsc2EuZXh0ZW4p
KTsKCQkJYXN0X2NvcHlfc3RyaW5nKGFsc2EuY29udGV4dCwgbXljLCBzaXplb2YoYWxzYS5jb250
ZXh0KSk7CgkJCWhvb2tzdGF0ZSA9IDE7CgkJCWFsc2FfbmV3KCZhbHNhLCBBU1RfU1RBVEVfUklO
R0lORyk7CgkJfSBlbHNlCgkJCWFzdF9jbGkoZmQsICJObyBzdWNoIGV4dGVuc2lvbiAnJXMnIGlu
IGNvbnRleHQgJyVzJ1xuIiwgbXllLCBteWMpOwoJfQoKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fs
b2NrKTsKCglyZXR1cm4gcmVzOwp9CgpzdGF0aWMgaW50IGNvbnNvbGVfZGlhbChpbnQgZmQsIGlu
dCBhcmdjLCBjaGFyICphcmd2W10pCnsKCWNoYXIgdG1wWzI1Nl0sICp0bXAyOwoJY2hhciAqbXll
LCAqbXljOwoJY2hhciAqZDsKCWludCByZXMgPSBSRVNVTFRfU1VDQ0VTUzsKCglpZiAoKGFyZ2Mg
IT0gMikgJiYgKGFyZ2MgIT0gMykpCgkJcmV0dXJuIFJFU1VMVF9TSE9XVVNBR0U7CgoJYXN0X211
dGV4X2xvY2soJmFsc2Fsb2NrKTsKCglpZiAoYWxzYS5vd25lcikgewoJCWlmIChhcmdjID09IDMp
IHsKCQkJZCA9IGFyZ3ZbMl07CgkJCWdyYWJfb3duZXIoKTsKCQkJaWYgKGFsc2Eub3duZXIpIHsK
CQkJCXN0cnVjdCBhc3RfZnJhbWUgZiA9IHsgQVNUX0ZSQU1FX0RUTUYgfTsKCQkJCXdoaWxlICgq
ZCkgewoJCQkJCWYuc3ViY2xhc3MgPSAqZDsKCQkJCQlhc3RfcXVldWVfZnJhbWUoYWxzYS5vd25l
ciwgJmYpOwoJCQkJCWQrKzsKCQkJCX0KCQkJCWFzdF9tdXRleF91bmxvY2soJmFsc2Eub3duZXIt
PmxvY2spOwoJCQl9CgkJfSBlbHNlIHsKCQkJYXN0X2NsaShmZCwgIllvdSdyZSBhbHJlYWR5IGlu
IGEgY2FsbC4gIFlvdSBjYW4gdXNlIHRoaXMgb25seSB0byBkaWFsIGRpZ2l0cyB1bnRpbCB5b3Ug
aGFuZ3VwXG4iKTsKCQkJcmVzID0gUkVTVUxUX0ZBSUxVUkU7CgkJfQoJfSBlbHNlIHsKCQlteWUg
PSBleHRlbjsKCQlteWMgPSBjb250ZXh0OwoJCWlmIChhcmdjID09IDMpIHsKCQkJY2hhciAqc3Ry
aW5ncCA9IE5VTEw7CgkJCWFzdF9jb3B5X3N0cmluZyh0bXAsIGFyZ3ZbMl0sIHNpemVvZih0bXAp
KTsKCQkJc3RyaW5ncCA9IHRtcDsKCQkJc3Ryc2VwKCZzdHJpbmdwLCAiQCIpOwoJCQl0bXAyID0g
c3Ryc2VwKCZzdHJpbmdwLCAiQCIpOwoJCQlpZiAoIWFzdF9zdHJsZW5femVybyh0bXApKQoJCQkJ
bXllID0gdG1wOwoJCQlpZiAoIWFzdF9zdHJsZW5femVybyh0bXAyKSkKCQkJCW15YyA9IHRtcDI7
CgkJfQoJCWlmIChhc3RfZXhpc3RzX2V4dGVuc2lvbihOVUxMLCBteWMsIG15ZSwgMSwgTlVMTCkp
IHsKCQkJYXN0X2NvcHlfc3RyaW5nKGFsc2EuZXh0ZW4sIG15ZSwgc2l6ZW9mKGFsc2EuZXh0ZW4p
KTsKCQkJYXN0X2NvcHlfc3RyaW5nKGFsc2EuY29udGV4dCwgbXljLCBzaXplb2YoYWxzYS5jb250
ZXh0KSk7CgkJCWhvb2tzdGF0ZSA9IDE7CgkJCWFsc2FfbmV3KCZhbHNhLCBBU1RfU1RBVEVfUklO
R0lORyk7CgkJfSBlbHNlCgkJCWFzdF9jbGkoZmQsICJObyBzdWNoIGV4dGVuc2lvbiAnJXMnIGlu
IGNvbnRleHQgJyVzJ1xuIiwgbXllLCBteWMpOwoJfQoKCWFzdF9tdXRleF91bmxvY2soJmFsc2Fs
b2NrKTsKCglyZXR1cm4gcmVzOwp9CgpzdGF0aWMgY2hhciBkaWFsX3VzYWdlW10gPQoJIlVzYWdl
OiBjb25zb2xlIGRpYWwgW2V4dGVuc2lvbltAY29udGV4dF1dXG4iCgkiICAgICAgIERpYWxzIGEg
Z2l2ZW4gZXh0ZW5zaW9uIChhbmQgY29udGV4dCBpZiBzcGVjaWZpZWQpXG4iOwoKc3RhdGljIHN0
cnVjdCBhc3RfY2xpX2VudHJ5IGNsaV9hbHNhX2Fuc3dlcl9kZXByZWNhdGVkID0gewoJeyAiYW5z
d2VyIiwgTlVMTCB9LAoJY29uc29sZV9hbnN3ZXJfZGVwcmVjYXRlZCwgTlVMTCwKCU5VTEwgfTsK
CnN0YXRpYyBzdHJ1Y3QgYXN0X2NsaV9lbnRyeSBjbGlfYWxzYV9oYW5ndXBfZGVwcmVjYXRlZCA9
IHsKCXsgImhhbmd1cCIsIE5VTEwgfSwKCWNvbnNvbGVfaGFuZ3VwX2RlcHJlY2F0ZWQsIE5VTEws
CglOVUxMIH07CgpzdGF0aWMgc3RydWN0IGFzdF9jbGlfZW50cnkgY2xpX2Fsc2FfZGlhbF9kZXBy
ZWNhdGVkID0gewoJeyAiZGlhbCIsIE5VTEwgfSwKCWNvbnNvbGVfZGlhbF9kZXByZWNhdGVkLCBO
VUxMLAoJTlVMTCB9OwoKc3RhdGljIHN0cnVjdCBhc3RfY2xpX2VudHJ5IGNsaV9hbHNhX3NlbmRf
dGV4dF9kZXByZWNhdGVkID0gewoJeyAic2VuZCIsICJ0ZXh0IiwgTlVMTCB9LAoJY29uc29sZV9z
ZW5kdGV4dF9kZXByZWNhdGVkLCBOVUxMLAoJTlVMTCB9OwoKc3RhdGljIHN0cnVjdCBhc3RfY2xp
X2VudHJ5IGNsaV9hbHNhX2F1dG9hbnN3ZXJfZGVwcmVjYXRlZCA9IHsKCXsgImF1dG9hbnN3ZXIi
LCBOVUxMIH0sCgljb25zb2xlX2F1dG9hbnN3ZXJfZGVwcmVjYXRlZCwgTlVMTCwKCU5VTEwsIGF1
dG9hbnN3ZXJfY29tcGxldGUgfTsKCnN0YXRpYyBzdHJ1Y3QgYXN0X2NsaV9lbnRyeSBjbGlfYWxz
YVtdID0gewoJeyB7ICJjb25zb2xlIiwgImFuc3dlciIsIE5VTEwgfSwKCWNvbnNvbGVfYW5zd2Vy
LCAiQW5zd2VyIGFuIGluY29taW5nIGNvbnNvbGUgY2FsbCIsCglhbnN3ZXJfdXNhZ2UsIE5VTEws
ICZjbGlfYWxzYV9hbnN3ZXJfZGVwcmVjYXRlZCB9LAoKCXsgeyAiY29uc29sZSIsICJoYW5ndXAi
LCBOVUxMIH0sCgljb25zb2xlX2hhbmd1cCwgIkhhbmd1cCBhIGNhbGwgb24gdGhlIGNvbnNvbGUi
LAoJaGFuZ3VwX3VzYWdlLCBOVUxMLCAmY2xpX2Fsc2FfaGFuZ3VwX2RlcHJlY2F0ZWQgfSwKCgl7
IHsgImNvbnNvbGUiLCAiZGlhbCIsIE5VTEwgfSwKCWNvbnNvbGVfZGlhbCwgIkRpYWwgYW4gZXh0
ZW5zaW9uIG9uIHRoZSBjb25zb2xlIiwKCWRpYWxfdXNhZ2UsIE5VTEwsICZjbGlfYWxzYV9kaWFs
X2RlcHJlY2F0ZWQgfSwKCgl7IHsgImNvbnNvbGUiLCAic2VuZCIsICJ0ZXh0IiwgTlVMTCB9LAoJ
Y29uc29sZV9zZW5kdGV4dCwgIlNlbmQgdGV4dCB0byB0aGUgcmVtb3RlIGRldmljZSIsCglzZW5k
dGV4dF91c2FnZSwgTlVMTCwgJmNsaV9hbHNhX3NlbmRfdGV4dF9kZXByZWNhdGVkIH0sCgoJeyB7
ICJjb25zb2xlIiwgImF1dG9hbnN3ZXIiLCBOVUxMIH0sCgljb25zb2xlX2F1dG9hbnN3ZXIsICJT
ZXRzL2Rpc3BsYXlzIGF1dG9hbnN3ZXIiLAoJYXV0b2Fuc3dlcl91c2FnZSwgYXV0b2Fuc3dlcl9j
b21wbGV0ZSwgJmNsaV9hbHNhX2F1dG9hbnN3ZXJfZGVwcmVjYXRlZCB9LAp9OwoKc3RhdGljIGlu
dCBsb2FkX21vZHVsZSh2b2lkKQp7CglpbnQgcmVzOwoJc3RydWN0IGFzdF9jb25maWcgKmNmZzsK
CXN0cnVjdCBhc3RfdmFyaWFibGUgKnY7CgoJLyogQ29weSB0aGUgZGVmYXVsdCBqYiBjb25maWcg
b3ZlciBnbG9iYWxfamJjb25mICovCgltZW1jcHkoJmdsb2JhbF9qYmNvbmYsICZkZWZhdWx0X2pi
Y29uZiwgc2l6ZW9mKHN0cnVjdCBhc3RfamJfY29uZikpOwoKCXN0cmNweShtb2hpbnRlcnByZXQs
ICJkZWZhdWx0Iik7CgoJaWYgKChjZmcgPSBhc3RfY29uZmlnX2xvYWQoY29uZmlnKSkpIHsKCQl2
ID0gYXN0X3ZhcmlhYmxlX2Jyb3dzZShjZmcsICJnZW5lcmFsIik7CgkJZm9yICg7IHY7IHYgPSB2
LT5uZXh0KSB7CgkJCS8qIGhhbmRsZSBqYiBjb25mICovCgkJCWlmICghYXN0X2piX3JlYWRfY29u
ZigmZ2xvYmFsX2piY29uZiwgdi0+bmFtZSwgdi0+dmFsdWUpKQoJCQkJY29udGludWU7CgoJCQlp
ZiAoIXN0cmNhc2VjbXAodi0+bmFtZSwgImF1dG9hbnN3ZXIiKSkKCQkJCWF1dG9hbnN3ZXIgPSBh
c3RfdHJ1ZSh2LT52YWx1ZSk7CgkJCWVsc2UgaWYgKCFzdHJjYXNlY21wKHYtPm5hbWUsICJzaWxl
bmNlc3VwcHJlc3Npb24iKSkKCQkJCXNpbGVuY2VzdXBwcmVzc2lvbiA9IGFzdF90cnVlKHYtPnZh
bHVlKTsKCQkJZWxzZSBpZiAoIXN0cmNhc2VjbXAodi0+bmFtZSwgInNpbGVuY2V0aHJlc2hvbGQi
KSkKCQkJCXNpbGVuY2V0aHJlc2hvbGQgPSBhdG9pKHYtPnZhbHVlKTsKCQkJZWxzZSBpZiAoIXN0
cmNhc2VjbXAodi0+bmFtZSwgImNvbnRleHQiKSkKCQkJCWFzdF9jb3B5X3N0cmluZyhjb250ZXh0
LCB2LT52YWx1ZSwgc2l6ZW9mKGNvbnRleHQpKTsKCQkJZWxzZSBpZiAoIXN0cmNhc2VjbXAodi0+
bmFtZSwgImxhbmd1YWdlIikpCgkJCQlhc3RfY29weV9zdHJpbmcobGFuZ3VhZ2UsIHYtPnZhbHVl
LCBzaXplb2YobGFuZ3VhZ2UpKTsKCQkJZWxzZSBpZiAoIXN0cmNhc2VjbXAodi0+bmFtZSwgImV4
dGVuc2lvbiIpKQoJCQkJYXN0X2NvcHlfc3RyaW5nKGV4dGVuLCB2LT52YWx1ZSwgc2l6ZW9mKGV4
dGVuKSk7CgkJCWVsc2UgaWYgKCFzdHJjYXNlY21wKHYtPm5hbWUsICJpbnB1dF9kZXZpY2UiKSkK
CQkJCWFzdF9jb3B5X3N0cmluZyhpbmRldm5hbWUsIHYtPnZhbHVlLCBzaXplb2YoaW5kZXZuYW1l
KSk7CgkJCWVsc2UgaWYgKCFzdHJjYXNlY21wKHYtPm5hbWUsICJvdXRwdXRfZGV2aWNlIikpCgkJ
CQlhc3RfY29weV9zdHJpbmcob3V0ZGV2bmFtZSwgdi0+dmFsdWUsIHNpemVvZihvdXRkZXZuYW1l
KSk7CgkJCWVsc2UgaWYgKCFzdHJjYXNlY21wKHYtPm5hbWUsICJtb2hpbnRlcnByZXQiKSkKCQkJ
CWFzdF9jb3B5X3N0cmluZyhtb2hpbnRlcnByZXQsIHYtPnZhbHVlLCBzaXplb2YobW9oaW50ZXJw
cmV0KSk7CgkJfQoJCWFzdF9jb25maWdfZGVzdHJveShjZmcpOwoJfQoJcmVzID0gcGlwZShzbmRj
bWQpOwoJaWYgKHJlcykgewoJCWFzdF9sb2coTE9HX0VSUk9SLCAiVW5hYmxlIHRvIGNyZWF0ZSBw
aXBlXG4iKTsKCQlyZXR1cm4gLTE7Cgl9CglyZXMgPSBzb3VuZGNhcmRfaW5pdCgpOwoJaWYgKHJl
cyA8IDApIHsKCQlpZiAob3B0aW9uX3ZlcmJvc2UgPiAxKSB7CgkJCWFzdF92ZXJib3NlKFZFUkJP
U0VfUFJFRklYXzIgIk5vIHNvdW5kIGNhcmQgZGV0ZWN0ZWQgLS0gY29uc29sZSBjaGFubmVsIHdp
bGwgYmUgdW5hdmFpbGFibGVcbiIpOwoJCQlhc3RfdmVyYm9zZShWRVJCT1NFX1BSRUZJWF8yICJU
dXJuIG9mZiBBTFNBIHN1cHBvcnQgYnkgYWRkaW5nICdub2xvYWQ9Y2hhbl9hbHNhLnNvJyBpbiAv
ZXRjL2FzdGVyaXNrL21vZHVsZXMuY29uZlxuIik7CgkJfQoJCXJldHVybiAwOwoJfQoKCXJlcyA9
IGFzdF9jaGFubmVsX3JlZ2lzdGVyKCZhbHNhX3RlY2gpOwoJaWYgKHJlcyA8IDApIHsKCQlhc3Rf
bG9nKExPR19FUlJPUiwgIlVuYWJsZSB0byByZWdpc3RlciBjaGFubmVsIGNsYXNzICdDb25zb2xl
J1xuIik7CgkJcmV0dXJuIC0xOwoJfQoJYXN0X2NsaV9yZWdpc3Rlcl9tdWx0aXBsZShjbGlfYWxz
YSwgc2l6ZW9mKGNsaV9hbHNhKSAvIHNpemVvZihzdHJ1Y3QgYXN0X2NsaV9lbnRyeSkpOwoKCWFz
dF9wdGhyZWFkX2NyZWF0ZV9iYWNrZ3JvdW5kKCZzdGhyZWFkLCBOVUxMLCBzb3VuZF90aHJlYWQs
IE5VTEwpOwojaWZkZWYgQUxTQV9NT05JVE9SCglpZiAoYWxzYV9tb25pdG9yX3N0YXJ0KCkpCgkJ
YXN0X2xvZyhMT0dfRVJST1IsICJQcm9ibGVtIHN0YXJ0aW5nIE1vbml0b3JpbmdcbiIpOwojZW5k
aWYKCXJldHVybiAwOwp9CgpzdGF0aWMgaW50IHVubG9hZF9tb2R1bGUodm9pZCkKewoJYXN0X2No
YW5uZWxfdW5yZWdpc3RlcigmYWxzYV90ZWNoKTsKCWFzdF9jbGlfdW5yZWdpc3Rlcl9tdWx0aXBs
ZShjbGlfYWxzYSwgc2l6ZW9mKGNsaV9hbHNhKSAvIHNpemVvZihzdHJ1Y3QgYXN0X2NsaV9lbnRy
eSkpOwoKCWlmIChhbHNhLmljYXJkID4gMCkKCQlzbmRfcGNtX2Nsb3NlKGFsc2EuaWNhcmQpOwoJ
aWYgKGFsc2Eub2NhcmQgPiAwKQoJCXNuZF9wY21fY2xvc2UoYWxzYS5vY2FyZCk7CglpZiAoc25k
Y21kWzBdID4gMCkgewoJCWNsb3NlKHNuZGNtZFswXSk7CgkJY2xvc2Uoc25kY21kWzFdKTsKCX0K
CWlmIChhbHNhLm93bmVyKQoJCWFzdF9zb2Z0aGFuZ3VwKGFsc2Eub3duZXIsIEFTVF9TT0ZUSEFO
R1VQX0FQUFVOTE9BRCk7CglpZiAoYWxzYS5vd25lcikKCQlyZXR1cm4gLTE7CglyZXR1cm4gMDsK
fQoKQVNUX01PRFVMRV9JTkZPX1NUQU5EQVJEKEFTVEVSSVNLX0dQTF9LRVksICJBTFNBIENvbnNv
bGUgQ2hhbm5lbCBEcml2ZXIiKTsK
--001e680f17341cfd74046c054470
Content-Type: application/octet-stream; name="asound.conf"
Content-Disposition: attachment; filename="asound.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvsk78xo1

IyBNZXNzYWdlTmV0IFN5c3RlbXMgQUxTQSBzb3VuZCBjb25maWd1cmF0aW9uIGZpbGUKIyBBbGxv
d2luZyBtdWx0aXBsZSBwbGF5YmFjayBhbmQgY2FwdHVyZSAKCnBjbS4hZGVmYXVsdCB7CiAgICB0
eXBlIHBsdWcKICAgIHNsYXZlLnBjbSAiZHVwbGV4Igp9CnBjbS5udWxscGNtIHsKICAgIHR5cGUg
bnVsbAp9CnBjbS5kdXBsZXggewogICAgdHlwZSBhc3ltCiAgICBwbGF5YmFjay5wY20gImRtaXhl
ciIKICAgIGNhcHR1cmUucGNtICJhbmFsb2dfaW5wdXQiCn0KcGNtLmRtaXhlciB7CiAgICB0eXBl
IGRtaXgKICAgIGlwY19rZXkgMTAyNAogICAgaXBjX3Blcm0gMDY2NgogICAgc2xhdmUgewogICAg
ICAgIHBjbSAiaHc6MSwzIgogICAgICAgIHBlcmlvZF90aW1lIDAKICAgICAgICBwZXJpb2Rfc2l6
ZSAxMDI0CiAgICAgICAgYnVmZmVyX3NpemUgODE5MgogICAgfQogICAgYmluZGluZ3MgewogICAg
ICAgMCAwCiAgICAgICAxIDEKICAgIH0KfQpwY20uYW5hbG9nX2lucHV0CnsKICAgIHR5cGUgZHNu
b29wCiAgICBpcGNfa2V5IDIwNDgKICAgIGlwY19wZXJtIDA2NjYKICAgIHNsYXZlewogICAgICAg
cGNtICJodzowLDIiCiAgICB9Cn0KcGNtLmRzcDAgewogICAgdHlwZSBwbHVnCiAgICBzbGF2ZS5w
Y20gImRtaXhlciIKfQpjdGwubWl4ZXIwIHsKICAgIHR5cGUgaHcKICAgIGNhcmQgMAp9CnBjbS5y
ZWNvcmRfbGVmdCB7CiAgICB0eXBlIGRzbm9vcAogICAgaXBjX2tleSAxMDI0CiAgICBpcGNfcGVy
bSAwNjY2CiAgICBzbGF2ZSB7CiAgICAgICAgcGNtICJodzowLDAiCiAgICAgICAgY2hhbm5lbHMg
MgogICAgfQogICAgYmluZGluZ3MuMCAgMAp9CnBjbS5yZWNvcmRfcmlnaHQgewogICAgdHlwZSBk
c25vb3AKICAgIGlwY19rZXkgMTAyNAogICAgaXBjX3Blcm0gMDY2NgogICAgc2xhdmUgewogICAg
ICAgIHBjbSAiaHc6MCwwIgogICAgICAgIGNoYW5uZWxzIDIKICAgIH0KICAgIGJpbmRpbmdzLjAg
IDEKfQpwY20ubXlfcGNtIHsKICAgIHR5cGUgc3BlZXgKICAgIHNsYXZlLnBjbSAicmVjb3JkX3Jp
Z2h0IgogICAgZnJhbWVzIDEyOCAKICAgIGRlbm9pc2UgMCAKICAgIGFnYyAxCiAgICBlY2hvIDEK
ICAgIGZpbHRlcl9sZW5ndGggODE5MgogICAgYWdjX2xldmVsIDgwMDAKICAgIGRlcmV2ZXJiIDAK
ICAgIGRlcmV2ZXJiX2RlY2F5IDAKICAgIGRlcmV2ZXJiX2xldmVsIDAKfQoK
--001e680f17341cfd74046c054470
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001e680f17341cfd74046c054470--
