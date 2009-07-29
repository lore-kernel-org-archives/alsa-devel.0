From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: MPC5200: Changed how appl_ptr is
	initialized
Date: Wed, 29 Jul 2009 09:24:03 -0400
Message-ID: <9e4733910907290624m1021457ep49eceb4b53a131a1@mail.gmail.com>
References: <20090729052608.20653.62429.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.210.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CBB610383E
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 15:24:04 +0200 (CEST)
Received: by yxe7 with SMTP id 7so1338751yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 06:24:04 -0700 (PDT)
In-Reply-To: <20090729052608.20653.62429.stgit@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 29, 2009 at 1:26 AM, John Bonesio<bones@secretlab.ca> wrote:
> Hello,
>
> I've been working in the ALSA SOC area for the MPC5200. I've noticed that
> in the routine psc_dma_trigger() in sound/soc/fsl/mpc5200_dma.c there are
> times when the computed value for s->appl_ptr ends up wrapping negative. =
This
> occurs when
> =A0 =A0s->runtime->control->appl_ptr
> is less than
> =A0 =A0runtime->period_size * runtime->periods

I view it as a flaw in ALSA that the driver has having to use appl_ptr
in order to behave correctly.

This is a batch mode DMA device. ALSA provides the last fragment and
pads it with zeros. When the last fragment plays the interrupt occurs
and ALSA is notified. ALSA turns around and stops the DMA hardware.

But there is a latency before ALSA stops the DMA hardware. The
interrupt occurred after playing the last padded zero sample. During
the time it takes the interrupt to get into ALSA and back into the
driver to shut the DMA off, the driver is playing garage since ALSA
has not initialized the next fragment. This garbage is clearly audible
as a burst of noise at the end of every clip.

Monitoring appl_ptr allows the driver to shut the DMA off at the end
of the clip without waiting for ALSA.

> It seemed like this would occur at then of the data stream or when the da=
ta
> stream is small (smaller than runtime->period_size * runtime->periods).
>
> As far as I can tell, s->appl_ptr is supposed to be the previous value of
> s->runtime->control->appl_ptr, so the driver can send out the right number
> of bytes (from previous appl_ptr to current appl_ptr) to avoid pops and c=
licks
> at the end of the audio.

That was correct.

>
> So it appears the assumption in this code is wrong, that the previous
> s->runtime->control->appl_ptr is always
> rumtime->period_size * runtime->periods bytes prior to the current
> s->runtime->control->appl_ptr.

I missed the case of very small buffers.

>
> I took out this code and instead added code to intialize s->appl_ptr to 0
> in psc_dma_open().
>
> Does this fix seem right?
>
> - John
>
> The computation for appl_ptr in the trigger() routine made a bad assumpti=
on
> when the stream is at the end of the file and there is not
> (periods * period_size) bytes remaining in the data.
>
> This causes playback issues when the total stream size is less than this
> amount, as the s->appl_ptr wrapps negative and the data is never played.
>
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
>
> =A0sound/soc/fsl/mpc5200_dma.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index b2eba27..cfe0ea4 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -181,8 +181,6 @@ static int psc_dma_trigger(struct snd_pcm_substream *=
substream, int cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * end of stream and not over running it.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->runtime =3D runtime;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr =3D s->runtime->control->appl_p=
tr -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (runtime->p=
eriod_size * runtime->periods);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fill up the bestcomm bd queue and enabl=
e DMA.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * This will begin filling the PSC's fifo.
> @@ -287,6 +285,7 @@ static int psc_dma_open(struct snd_pcm_substream *sub=
stream)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0s->stream =3D substream;
> + =A0 =A0 =A0 s->appl_ptr =3D 0;
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
