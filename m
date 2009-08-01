From: John Bonesio <bones@secretlab.ca>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Sat, 01 Aug 2009 08:04:56 -0700
Message-ID: <1249139096.4582.13.camel@riker>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3OuCfmlE7wntN9J+RSz+"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DE2F2441E
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 17:05:06 +0200 (CEST)
Received: by pzk5 with SMTP id 5so1871710pzk.23
	for <alsa-devel@alsa-project.org>; Sat, 01 Aug 2009 08:05:05 -0700 (PDT)
In-Reply-To: <9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org


--=-3OuCfmlE7wntN9J+RSz+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

Woops! Yep, this is the wrong patch. I've included the correct one. I've
also attached the patch in case email messes with its formatting. Sorry
about the confusion.

Jon,

I put in a debug hook in the out_be32() routine. It would printk output
anytime the AC97_HEADPHONE register was written to. This printk text
would come out as expected when the Headphone mixer setting was
muted/unmuted.

When I umuted the PCM mixer setting, this printk text did not appear,
yet when I read the mixer register setting for the headphone, it was set
back to mute.

If there is code in software doing this, it's very subtle.

- John

----- correct patch -----

>From 24b52cf2836f711118fd6d2c8895c91c944978cd Mon Sep 17 00:00:00 2001
From: John Bonesio <bones@secretlab.ca>
Date: Fri, 31 Jul 2009 16:01:33 -0700
Subject: [PATCH] ASoC: WM9712 Codec: Workaround an unmute  problem

When setting the PCM mixer (unuting), the main Headphone mixer setting gets
set back to mute. At this time it appears this is occuring in hardware.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---
 sound/soc/codecs/wm9712.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index b57c817..6f8d164 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -28,6 +28,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg);
 static int ac97_write(struct snd_soc_codec *codec,
 	unsigned int reg, unsigned int val);
+static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg);
 
 /*
  * WM9712 register cache
@@ -177,9 +178,14 @@ static int mixer_event(struct snd_soc_dapm_widget *w,
 	else
 		ac97_write(w->codec, AC97_VIDEO, mic | 0x8000);
 
-	if (l & 0x2 || r & 0x2)
+	if (l & 0x2 || r & 0x2) {
 		ac97_write(w->codec, AC97_PCM, pcm & 0x7fff);
-	else
+		/*
+		 * Workaround an apparent bug where the headphone mute setting
+		 * is modified when the PCM mute setting is enabled.
+		 */
+		ac97_flush(w->codec, AC97_HEADPHONE);
+	} else
 		ac97_write(w->codec, AC97_PCM, pcm | 0x8000);
 
 	if (l & 0x4 || r & 0x4)
@@ -472,6 +478,17 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
+static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int val;
+	u16 *cache = codec->reg_cache;
+
+	if ((reg >> 1) < (ARRAY_SIZE(wm9712_reg))) {
+		val = cache[reg >> 1];
+		soc_ac97_ops.write(codec->ac97, reg, val);
+	}
+}
+
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-- 
1.6.0.4


-------------------------



On Sat, 2009-08-01 at 09:47 -0400, Jon Smirl wrote:
> On Fri, Jul 31, 2009 at 7:08 PM, John Bonesio<bones@secretlab.ca> wrote:
> > We've encountered strange behavior in the alsamixer settings using the wm9712
> > codec. If we unmute the headphone output and then unmute the PCM output, the
> > headphone output gets reset to mute in the hardware register. At this point
> > the hardware register does not match the value in the register cache.
> >
> > I've spent some time debugging this, and the headphone setting is set outside
> > of any code path that would call the ac97_write() routine. As best as I can
> > tell, there is something strange going on in hardware.
> 
> This could be something wrong in the mpc5200 code that writes the AC97
> registers too. Maybe a register write command is getting generated
> when it wasn't supposed to.
> 
> You can set the mpc5200 to generate an interrupt everything it
> finishes writing a AC97 register. If you get more interrupts than you
> expected the problem is in the driver.
> 
> > I've provided this patch that works around the problem.
> >
> > Have any of you seen this before? Is this patch the right approach?
> >
> > - John
> >
> > The code in psc_dma_bcom_enqueue_tx() didn't account for the fact that
> > s->runtime->control->appl_ptr can wrap around to the beginning of the
> > buffer. This change fixes this problem.
> >
> > Signed-off-by: John Bonesio <bones@secretlab.ca>
> > ---
> >
> >  sound/soc/fsl/mpc5200_dma.c |   17 +++++++++++++++++
> >  1 files changed, 17 insertions(+), 0 deletions(-)
> >
> > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > index cfe0ea4..2551c58 100644
> > --- a/sound/soc/fsl/mpc5200_dma.c
> > +++ b/sound/soc/fsl/mpc5200_dma.c
> > @@ -70,6 +70,23 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
> >
> >  static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
> >  {
> > +       if (s->appl_ptr > s->runtime->control->appl_ptr) {
> > +               /*
> > +                * In this case s->runtime->control->appl_ptr has wrapped around.
> > +                * Play the data to the end of the boundary, then wrap our own
> > +                * appl_ptr back around.
> > +                */
> > +               while (s->appl_ptr < s->runtime->boundary) {
> > +                       if (bcom_queue_full(s->bcom_task))
> > +                               return;
> > +
> > +                       s->appl_ptr += s->period_size;
> > +
> > +                       psc_dma_bcom_enqueue_next_buffer(s);
> > +               }
> > +               s->appl_ptr -= s->runtime->boundary;
> > +       }
> > +
> >        while (s->appl_ptr < s->runtime->control->appl_ptr) {
> >
> >                if (bcom_queue_full(s->bcom_task))
> >
> >
> 
> 
> 

--=-3OuCfmlE7wntN9J+RSz+
Content-Disposition: attachment; filename="0001-ASoC-WM9712-Codec-Workaround-an-unmute-problem.patch"
Content-Type: text/x-patch; name="0001-ASoC-WM9712-Codec-Workaround-an-unmute-problem.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 24b52cf2836f711118fd6d2c8895c91c944978cd Mon Sep 17 00:00:00 2001
From: John Bonesio <bones@secretlab.ca>
Date: Fri, 31 Jul 2009 16:01:33 -0700
Subject: [PATCH] ASoC: WM9712 Codec: Workaround an unmute  problem

When setting the PCM mixer (unuting), the main Headphone mixer setting gets
set back to mute. At this time it appears this is occuring in hardware.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---
 sound/soc/codecs/wm9712.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index b57c817..6f8d164 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -28,6 +28,7 @@ static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg);
 static int ac97_write(struct snd_soc_codec *codec,
 	unsigned int reg, unsigned int val);
+static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg);
 
 /*
  * WM9712 register cache
@@ -177,9 +178,14 @@ static int mixer_event(struct snd_soc_dapm_widget *w,
 	else
 		ac97_write(w->codec, AC97_VIDEO, mic | 0x8000);
 
-	if (l & 0x2 || r & 0x2)
+	if (l & 0x2 || r & 0x2) {
 		ac97_write(w->codec, AC97_PCM, pcm & 0x7fff);
-	else
+		/*
+		 * Workaround an apparent bug where the headphone mute setting
+		 * is modified when the PCM mute setting is enabled.
+		 */
+		ac97_flush(w->codec, AC97_HEADPHONE);
+	} else
 		ac97_write(w->codec, AC97_PCM, pcm | 0x8000);
 
 	if (l & 0x4 || r & 0x4)
@@ -472,6 +478,17 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
+static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int val;
+	u16 *cache = codec->reg_cache;
+
+	if ((reg >> 1) < (ARRAY_SIZE(wm9712_reg))) {
+		val = cache[reg >> 1];
+		soc_ac97_ops.write(codec->ac97, reg, val);
+	}
+}
+
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-- 
1.6.0.4


--=-3OuCfmlE7wntN9J+RSz+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-3OuCfmlE7wntN9J+RSz+--
