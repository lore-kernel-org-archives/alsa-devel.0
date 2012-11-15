From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/2] pcm_pulse: do not trigger immediately
 at start
Date: Thu, 15 Nov 2012 08:55:15 +0100
Message-ID: <50A49FE3.5040304@canonical.com>
References: <201211142007.19751@leon.remlab.net>
 <1352916477-17552-1-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DEE722615D9
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 08:55:16 +0100 (CET)
In-Reply-To: <1352916477-17552-1-git-send-email-remi@remlab.net>
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

Hi Remi, and thanks for your patch, this is indeed a thorny area where =

you change behaviour and fix one application and break another...that =

has at least been my experience with the alsa-pulse plugin...

On 11/14/2012 07:07 PM, R=E9mi Denis-Courmont wrote:
> There are no samples to play at that point so this is useless.

I'm not following this reasoning. The start callback corresponds to the =

_trigger callback in kernel, which wants the playback to start immediately.

For playback streams, you should not call the start callback (or any =

alsa-lib function that ends up calling it) from your application unless =

there are already samples in the buffer, or you will get an immediate =

underrun.

For recording streams, starting with an empty buffer is expected and not =

useless at all.

> The non-zero buffer_attr.prebuf ensures that the PulseAudio daemon will
> start streaming automatically (like ALSA sw_params start_threshold).

The start callback is for the cases where the application wants to =

explicitly start the stream before prebuf has been reached.

> ---
>   pulse/pcm_pulse.c |   12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
> index 24fd4da..0165120 100644
> --- a/pulse/pcm_pulse.c
> +++ b/pulse/pcm_pulse.c
> @@ -204,8 +204,8 @@ static void stream_success_cb(pa_stream * p, int succ=
ess, void *userdata)
>   static int pulse_start(snd_pcm_ioplug_t * io)
>   {
>   	snd_pcm_pulse_t *pcm =3D io->private_data;
> -	pa_operation *o, *u;
> -	int err =3D 0, err_o =3D 0, err_u =3D 0;
> +	pa_operation *o;
> +	int err =3D 0, err_o =3D 0;
>
>   	assert(pcm);
>
> @@ -224,18 +224,12 @@ static int pulse_start(snd_pcm_ioplug_t * io)
>   		goto finish;
>   	}
>
> -	u =3D pa_stream_trigger(pcm->stream, stream_success_cb, pcm);
> -
>   	pcm->underrun =3D 0;
>   	err_o =3D pulse_wait_operation(pcm->p, o);
> -	if (u)
> -		err_u =3D pulse_wait_operation(pcm->p, u);
>
>   	pa_operation_unref(o);
> -	if (u)
> -		pa_operation_unref(u);
>
> -	if (err_o < 0 || err_u < 0) {
> +	if (err_o < 0) {
>   		err =3D -EIO;
>   		goto finish;
>   	}
>



-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
