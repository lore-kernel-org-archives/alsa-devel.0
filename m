From: Timur Tabi <timur@freescale.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 12:36:52 -0500
Message-ID: <ed82fe3e0904271036m4afe253cifeabd90578c0d6e3@mail.gmail.com>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A71C24612
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 19:36:54 +0200 (CEST)
Received: by qyk1 with SMTP id 1so101181qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 10:36:53 -0700 (PDT)
In-Reply-To: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 10:25 AM, Jon Smirl <jonsmirl@gmail.com> wrote:

> static snd_pcm_uframes_t
> psc_dma_pcm_pointer(struct snd_pcm_substream *substream)
> {
> =A0 =A0 =A0 =A0struct snd_pcm_runtime *runtime =3D substream->runtime;
> =A0 =A0 =A0 =A0struct snd_soc_pcm_runtime *rtd =3D substream->private_dat=
a;
> =A0 =A0 =A0 =A0struct psc_dma *psc_dma =3D rtd->dai->cpu_dai->private_dat=
a;
> =A0 =A0 =A0 =A0struct psc_dma_stream *s;
> =A0 =A0 =A0 =A0dma_addr_t count;
> =A0 =A0 =A0 =A0snd_pcm_uframes_t frames;
> =A0 =A0 =A0 =A0int delta;
>
> =A0 =A0 =A0 =A0if (substream->pstr->stream =3D=3D SNDRV_PCM_STREAM_CAPTUR=
E)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s =3D &psc_dma->capture;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s =3D &psc_dma->playback;
>
> =A0 =A0 =A0 =A0count =3D s->period_current_pt - s->period_start;
>
> =A0 =A0 =A0 =A0delta =3D jiffies - s->jiffies;
> =A0 =A0 =A0 =A0delta =3D delta * runtime->rate / HZ;
> =A0 =A0 =A0 =A0frames =3D bytes_to_frames(substream->runtime, count);

Have you considered using the timebase register instead of jiffies?
It's more accurate, and you can use tb_ticks_per_usec.

-- =

Timur Tabi
Linux kernel developer at Freescale
