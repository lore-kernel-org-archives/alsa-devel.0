From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Sat, 1 Aug 2009 12:30:17 -0400
Message-ID: <9e4733910908010930l18c9fa65t49732f54bd2c7d3@mail.gmail.com>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DA6424457
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 18:30:19 +0200 (CEST)
Received: by ywh39 with SMTP id 39so2709446ywh.16
	for <alsa-devel@alsa-project.org>; Sat, 01 Aug 2009 09:30:17 -0700 (PDT)
In-Reply-To: <1249139096.4582.13.camel@riker>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 1, 2009 at 11:04 AM, John Bonesio<bones@secretlab.ca> wrote:
> Hi All,
>
> Woops! Yep, this is the wrong patch. I've included the correct one. I've
> also attached the patch in case email messes with its formatting. Sorry
> about the confusion.
>
> Jon,
>
> I put in a debug hook in the out_be32() routine. It would printk output
> anytime the AC97_HEADPHONE register was written to. This printk text
> would come out as expected when the Headphone mixer setting was
> muted/unmuted.

I was thinking a stale register write may have gotten into the mpc5200
AC97 hardware somehow and not been sent immediately to the codec.
Something you do later causes it to be sent.  I don't trust the
mpc5200 AC97 register write hardware 100%, it was an after thought
added in the mpc5200b.

Some logic analyzers have AC97 protocol decode capability. That would
isolate easily isolate the problem.

>
> When I umuted the PCM mixer setting, this printk text did not appear,
> yet when I read the mixer register setting for the headphone, it was set
> back to mute.
>
> If there is code in software doing this, it's very subtle.
>
> - John
>
> ----- correct patch -----
>
> >From 24b52cf2836f711118fd6d2c8895c91c944978cd Mon Sep 17 00:00:00 2001
> From: John Bonesio <bones@secretlab.ca>
> Date: Fri, 31 Jul 2009 16:01:33 -0700
> Subject: [PATCH] ASoC: WM9712 Codec: Workaround an unmute =A0problem
>
> When setting the PCM mixer (unuting), the main Headphone mixer setting ge=
ts
> set back to mute. At this time it appears this is occuring in hardware.
>
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
> =A0sound/soc/codecs/wm9712.c | =A0 21 +++++++++++++++++++--
> =A01 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
> index b57c817..6f8d164 100644
> --- a/sound/soc/codecs/wm9712.c
> +++ b/sound/soc/codecs/wm9712.c
> @@ -28,6 +28,7 @@ static unsigned int ac97_read(struct snd_soc_codec *cod=
ec,
> =A0 =A0 =A0 =A0unsigned int reg);
> =A0static int ac97_write(struct snd_soc_codec *codec,
> =A0 =A0 =A0 =A0unsigned int reg, unsigned int val);
> +static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg);
>
> =A0/*
> =A0* WM9712 register cache
> @@ -177,9 +178,14 @@ static int mixer_event(struct snd_soc_dapm_widget *w,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ac97_write(w->codec, AC97_VIDEO, mic | 0x8=
000);
>
> - =A0 =A0 =A0 if (l & 0x2 || r & 0x2)
> + =A0 =A0 =A0 if (l & 0x2 || r & 0x2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ac97_write(w->codec, AC97_PCM, pcm & 0x7ff=
f);
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Workaround an apparent bug where the h=
eadphone mute setting
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is modified when the PCM mute setting =
is enabled.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ac97_flush(w->codec, AC97_HEADPHONE);
> + =A0 =A0 =A0 } else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ac97_write(w->codec, AC97_PCM, pcm | 0x800=
0);
>
> =A0 =A0 =A0 =A0if (l & 0x4 || r & 0x4)
> @@ -472,6 +478,17 @@ static int ac97_write(struct snd_soc_codec *codec, u=
nsigned int reg,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg)
> +{
> + =A0 =A0 =A0 unsigned int val;
> + =A0 =A0 =A0 u16 *cache =3D codec->reg_cache;
> +
> + =A0 =A0 =A0 if ((reg >> 1) < (ARRAY_SIZE(wm9712_reg))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D cache[reg >> 1];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 soc_ac97_ops.write(codec->ac97, reg, val);
> + =A0 =A0 =A0 }
> +}
> +
> =A0static int ac97_prepare(struct snd_pcm_substream *substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *dai)
> =A0{
> --
> 1.6.0.4
>
>
> -------------------------
>
>
>
> On Sat, 2009-08-01 at 09:47 -0400, Jon Smirl wrote:
>> On Fri, Jul 31, 2009 at 7:08 PM, John Bonesio<bones@secretlab.ca> wrote:
>> > We've encountered strange behavior in the alsamixer settings using the=
 wm9712
>> > codec. If we unmute the headphone output and then unmute the PCM outpu=
t, the
>> > headphone output gets reset to mute in the hardware register. At this =
point
>> > the hardware register does not match the value in the register cache.
>> >
>> > I've spent some time debugging this, and the headphone setting is set =
outside
>> > of any code path that would call the ac97_write() routine. As best as =
I can
>> > tell, there is something strange going on in hardware.
>>
>> This could be something wrong in the mpc5200 code that writes the AC97
>> registers too. Maybe a register write command is getting generated
>> when it wasn't supposed to.
>>
>> You can set the mpc5200 to generate an interrupt everything it
>> finishes writing a AC97 register. If you get more interrupts than you
>> expected the problem is in the driver.
>>
>> > I've provided this patch that works around the problem.
>> >
>> > Have any of you seen this before? Is this patch the right approach?
>> >
>> > - John
>> >
>> > The code in psc_dma_bcom_enqueue_tx() didn't account for the fact that
>> > s->runtime->control->appl_ptr can wrap around to the beginning of the
>> > buffer. This change fixes this problem.
>> >
>> > Signed-off-by: John Bonesio <bones@secretlab.ca>
>> > ---
>> >
>> > =A0sound/soc/fsl/mpc5200_dma.c | =A0 17 +++++++++++++++++
>> > =A01 files changed, 17 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
>> > index cfe0ea4..2551c58 100644
>> > --- a/sound/soc/fsl/mpc5200_dma.c
>> > +++ b/sound/soc/fsl/mpc5200_dma.c
>> > @@ -70,6 +70,23 @@ static void psc_dma_bcom_enqueue_next_buffer(struct=
 psc_dma_stream *s)
>> >
>> > =A0static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
>> > =A0{
>> > + =A0 =A0 =A0 if (s->appl_ptr > s->runtime->control->appl_ptr) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In this case s->runtime->control->a=
ppl_ptr has wrapped around.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Play the data to the end of the bou=
ndary, then wrap our own
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* appl_ptr back around.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (s->appl_ptr < s->runtime->boundar=
y) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bcom_queue_full(s->b=
com_task))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr +=3D s->peri=
od_size;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_nex=
t_buffer(s);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr -=3D s->runtime->boundary;
>> > + =A0 =A0 =A0 }
>> > +
>> > =A0 =A0 =A0 =A0while (s->appl_ptr < s->runtime->control->appl_ptr) {
>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bcom_queue_full(s->bcom_task))
>> >
>> >
>>
>>
>>
>



-- =

Jon Smirl
jonsmirl@gmail.com
