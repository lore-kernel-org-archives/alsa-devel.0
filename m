From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA - HDA - Add period time constraint to
	hda-intel
Date: Thu, 26 May 2011 10:01:14 +0800
Message-ID: <BANLkTim2oO6JnFQre97U6PdaFe6C91AeXg@mail.gmail.com>
References: <BANLkTimy_SFEFfTx55wFNdQmNPbDiguFdg@mail.gmail.com>
	<s5hlixw4ol3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4A2CF24400
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 04:01:15 +0200 (CEST)
Received: by fxm5 with SMTP id 5so404057fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 19:01:14 -0700 (PDT)
In-Reply-To: <s5hlixw4ol3.wl%tiwai@suse.de>
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

2011/5/24 Takashi Iwai <tiwai@suse.de>:

>> ALSA hda_intel.c:1680: azx_pcm_prepare: bufsize=3D0x1aeb00, format=3D0x4=
111
>> ...
>> ALSA pcm_native.c:1531: playback drain error (DMA or IRQ trouble?)
>
> Wouldn't it be better to fix the PCM timeout itself?
> Does the patch below work?
>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index abfeff16..a754722 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -1756,8 +1756,16 @@ static int wait_for_avail(struct snd_pcm_substream=
 *substream,
> =A0 =A0 =A0 =A0wait_queue_t wait;
> =A0 =A0 =A0 =A0int err =3D 0;
> =A0 =A0 =A0 =A0snd_pcm_uframes_t avail =3D 0;
> + =A0 =A0 =A0 long wait_time =3D 10; /* 10 seconds timeout as default */
> =A0 =A0 =A0 =A0long tout;
>
> + =A0 =A0 =A0 if (runtime->rate) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 long t =3D (runtime->period_size * 2 + runt=
ime->rate - 1) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 runtime->rate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_time =3D max(t, wait_time);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 wait_time =3D msecs_to_jiffies(wait_time * 1000);
> +
> =A0 =A0 =A0 =A0init_waitqueue_entry(&wait, current);
> =A0 =A0 =A0 =A0add_wait_queue(&runtime->tsleep, &wait);
> =A0 =A0 =A0 =A0for (;;) {
> @@ -1767,7 +1775,7 @@ static int wait_for_avail(struct snd_pcm_substream =
*substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(TASK_INTERRUPTIBLE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_stream_unlock_irq(substream);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tout =3D schedule_timeout(msecs_to_jiffies(=
10000));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tout =3D schedule_timeout(wait_time);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_pcm_stream_lock_irq(substream);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (runtime->status->state) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case SNDRV_PCM_STATE_SUSPENDED:
>

you patch only fix the playback write/capture read error .

does it mean that even when the application (e.g. PA server) set
stop_threshold to boundary can only freerun for 10 seconds only ?


The drain error in pcm_native.c still occur when application use a
period time longer than 10 seconds and some of the audio signal at the
end seem lost in snd_pcm_drain()



		tout =3D schedule_timeout(10 * HZ);

...

		if (tout =3D=3D 0) {
			if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_SUSPENDED)
				result =3D -ESTRPIPE;
			else {
				snd_printd("playback drain error (DMA or IRQ trouble?)\n");
				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
				result =3D -EIO;
			}
			break;
		}
