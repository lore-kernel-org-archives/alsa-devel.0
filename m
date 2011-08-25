From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] alsa-plugins: Pulse: only underrun if no
 more data has been written
Date: Thu, 25 Aug 2011 13:53:05 +0800
Message-ID: <CAN8cciZ046qj=2aaa0ETgCXtrOhu5Z8+p_dFNPjJ199vXtA7RQ@mail.gmail.com>
References: <4E4D2A67.9050507@canonical.com> <s5hobzllubm.wl%tiwai@suse.de>
	<4E4E31A5.2090100@canonical.com> <s5hliup7emd.wl%tiwai@suse.de>
	<4E53958A.5050602@canonical.com> <s5hbovgp7p4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E1C910380B
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 07:53:06 +0200 (CEST)
Received: by fxh10 with SMTP id 10so1534851fxh.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 22:53:06 -0700 (PDT)
In-Reply-To: <s5hbovgp7p4.wl%tiwai@suse.de>
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

2011/8/23 Takashi Iwai <tiwai@suse.de>:
 be enough just to have a
> boolean for underrun_detect yes/no.
>
> So, the patch would be like below.
>
> What do you think?
>
>
> Takashi
>
> ---
> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
> index d6c6792..b0e52ab 100644
> --- a/pulse/pcm_pulse.c
> +++ b/pulse/pcm_pulse.c
> @@ -42,6 +42,7 @@ typedef struct snd_pcm_pulse {
> =A0 =A0 =A0 =A0int handle_underrun;
>
> =A0 =A0 =A0 =A0size_t offset;
> + =A0 =A0 =A0 int64_t written;
>
> =A0 =A0 =A0 =A0pa_stream *stream;
>
> @@ -460,6 +461,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug_t=
 * io,
>
> =A0 =A0 =A0 =A0/* Make sure the buffer pointer is in sync */
> =A0 =A0 =A0 =A0pcm->last_size -=3D writebytes;
> + =A0 =A0 =A0 pcm->written +=3D writebytes;
> =A0 =A0 =A0 =A0ret =3D update_ptr(pcm);
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto finish;
> @@ -585,6 +587,15 @@ static void stream_request_cb(pa_stream * p, size_t =
length, void *userdata)
> =A0 =A0 =A0 =A0update_active(pcm);
> =A0}
>
> +#if defined(PA_CHECK_VERSION) && PA_CHECK_VERSION(0,99,0)

compile fail at these line since PA_CHECK_VERSION is not defined in
pulseaudio 0.9.14

seem that pcm->wriiten is application pointer of pulse device in bytes

does it mean that pa_stream_get_underflow_index(0 is the hardware pointer ?

does it mean that pulse device no longer can be run 7 x 24 non-stop
since pcm->written may overflow ?

> +#define DEFAULT_HANDLE_UNDERRUN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +#define do_underrun_detect(pcm, p) \
> + =A0 =A0 =A0 ((pcm)->written <=3D pa_stream_get_underflow_index(p))
> +#else
> +#define DEFAULT_HANDLE_UNDERRUN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> +#define do_underrun_detect(pcm, p) =A0 =A0 1 =A0 =A0 =A0 /* always true =
*/
> +#endif
> +
> =A0static void stream_underrun_cb(pa_stream * p, void *userdata)
> =A0{
> =A0 =A0 =A0 =A0snd_pcm_pulse_t *pcm =3D userdata;
> @@ -594,7 +605,8 @@ static void stream_underrun_cb(pa_stream * p, void *u=
serdata)
> =A0 =A0 =A0 =A0if (!pcm->p)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 pcm->underrun =3D 1;
> + =A0 =A0 =A0 if (do_underrun_detect(pcm, p))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcm->underrun =3D 1;
> =A0}
>
> =A0static void stream_latency_cb(pa_stream *p, void *userdata) {
> @@ -739,6 +751,7 @@ static int pulse_prepare(snd_pcm_ioplug_t * io)
>
> =A0 =A0 =A0 =A0pcm->offset =3D 0;
> =A0 =A0 =A0 =A0pcm->underrun =3D 0;
> + =A0 =A0 =A0 pcm->written =3D 0;
>
> =A0 =A0 =A0 =A0/* Reset fake ringbuffer */
> =A0 =A0 =A0 =A0pcm->last_size =3D 0;
> @@ -983,7 +996,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(pulse)
> =A0 =A0 =A0 =A0const char *server =3D NULL;
> =A0 =A0 =A0 =A0const char *device =3D NULL;
> =A0 =A0 =A0 =A0const char *fallback_name =3D NULL;
> - =A0 =A0 =A0 int handle_underrun =3D 0;
> + =A0 =A0 =A0 int handle_underrun =3D DEFAULT_HANDLE_UNDERRUN;
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0snd_pcm_pulse_t *pcm;
>
