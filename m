From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/2] pcm_pulse: set prebuf parameter
 according to software parameters
Date: Thu, 15 Nov 2012 09:00:03 +0100
Message-ID: <50A4A103.1090802@canonical.com>
References: <201211142007.19751@leon.remlab.net>
 <1352916477-17552-1-git-send-email-remi@remlab.net>
 <1352916477-17552-2-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B83BE2615D9
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 09:00:03 +0100 (CET)
In-Reply-To: <1352916477-17552-2-git-send-email-remi@remlab.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/14/2012 07:07 PM, R=E9mi Denis-Courmont wrote:
> The current default value for prebuf is very high, almost the full
> virtual ALSA buffer. This breaks some application especially where
> low latency is involved.
>
> This patch makes pcm_pulse implement the sw_params callback and get
> the prebuf value from the ALSA software parameters. Thus the
> trigger latency is much more like what an ALSA application should
> expect from an ALSA PCM device.

This seems reasonable I believe; see review comments below.

> ---
>   pulse/pcm_pulse.c |   25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
> index 0165120..08b6cea 100644
> --- a/pulse/pcm_pulse.c
> +++ b/pulse/pcm_pulse.c
> @@ -859,6 +859,30 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
>   	return err;
>   }
>
> +static int pulse_sw_params(snd_pcm_ioplug_t *io, snd_pcm_sw_params_t *pa=
rams)
> +{
> +	snd_pcm_pulse_t *pcm =3D io->private_data;
> +	snd_pcm_uframes_t start_threshold;
> +
> +	assert(pcm);
> +
> +	if (!pcm->p || !pcm->p->mainloop)
> +		return -EBADFD;
> +
> +	pa_threaded_mainloop_lock(pcm->p->mainloop);
> +
> +	snd_pcm_sw_params_get_start_threshold(params, &start_threshold);
> +
> +	if (start_threshold < io->period_size)
> +		start_threshold =3D io->period_size;

Why do we need the above constraint?

> +
> +	pcm->buffer_attr.prebuf =3D start_threshold * pcm->frame_size;

This works only if sw_params is set after hw_params. It would be better =

if the patch could handle also if hw_params is set after sw_params.

> +
> +	pa_threaded_mainloop_unlock(pcm->p->mainloop);
> +
> +	return 0;
> +}
> +
>   static int pulse_close(snd_pcm_ioplug_t * io)
>   {
>   	snd_pcm_pulse_t *pcm =3D io->private_data;
> @@ -925,6 +949,7 @@ static const snd_pcm_ioplug_callback_t pulse_playback=
_callback =3D {
>   	.poll_revents =3D pulse_pcm_poll_revents,
>   	.prepare =3D pulse_prepare,
>   	.hw_params =3D pulse_hw_params,
> +	.sw_params =3D pulse_sw_params,
>   	.close =3D pulse_close,
>   	.pause =3D pulse_pause
>   };
>



-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
