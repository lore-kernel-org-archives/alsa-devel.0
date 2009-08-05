From: John Bonesio <bones@secretlab.ca>
Subject: Re: [PATCH] ASoC: WM9712 Codec: Workaround an unmute
 problem (Was: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap around)
Date: Wed, 05 Aug 2009 09:30:53 -0700
Message-ID: <1249489853.4582.58.camel@riker>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker> <20090802114950.GA1778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id C8912244CD
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 18:31:01 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m16so29735waf.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 09:31:00 -0700 (PDT)
In-Reply-To: <20090802114950.GA1778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I've retitled the email to better reflect the real patch. I believe
there has been some general confusion because I originally sent the
wrong patch.

You wrote:

> Like I said before, exactly which control are you adjusting here?
> 
My description of this got lost in all the confusion. Let me try again.
We are adjusting the mixer bits for mute/unmute on two of the mixer
settings. The first one is general headphone mute setting on register
0x4 (bit 15). The second one is the PCM mute setting on register 0x18
(bit 15).

What we are seeing is that if we first unmute the general headphone (reg
0x4 bit15), then unmute the PCM (reg 0x18 bit 15) [HPL PCM in the
alsamixer application], the general headphone gets muted again, even
though software didn't write to that register.

> 
> > If there is code in software doing this, it's very subtle.
> 
> My money would be on the AC97 controller having problems; the quality of
> SoC AC97 controllers is variable.  It certainly doesn't sound like a
> WM9712 issue; as I say I'd be very surprised if such an issue hadn't
> come up before given how widely deployed the part is.

We don't have access to an AC97 analyzer. Do you have any suggestions on
other ways we can pinpoint the error?

- John


Here's the patch again for reference:

Author: John Bonesio <bones@secretlab.ca>
Date:   Fri Jul 31 16:01:33 2009 -0700

    ASoC: WM9712 Codec: Workaround an unmute  problem
    
    When setting the PCM mixer (unuting), the main Headphone mixer
setting gets
    set back to mute. At this time it appears this is occuring in
hardware.
    
    Signed-off-by: John Bonesio <bones@secretlab.ca>

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index b57c817..6f8d164 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -28,6 +28,7 @@ static unsigned int ac97_read(struct snd_soc_codec
*codec,
 	unsigned int reg);
 static int ac97_write(struct snd_soc_codec *codec,
 	unsigned int reg, unsigned int val);
+static int ac97_flush(struct snd_soc_codec *codec, unsigned int reg);
 
 /*
  * WM9712 register cache
@@ -177,9 +178,14 @@ static int mixer_event(struct snd_soc_dapm_widget
*w,
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
@@ -472,6 +478,17 @@ static int ac97_write(struct snd_soc_codec *codec,
unsigned int reg,
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


On Sun, 2009-08-02 at 12:49 +0100, Mark Brown wrote:
> On Sat, Aug 01, 2009 at 08:04:56AM -0700, John Bonesio wrote:
> 
> > When I umuted the PCM mixer setting, this printk text did not appear,
> > yet when I read the mixer register setting for the headphone, it was set
> > back to mute.
> 
> Like I said before, exactly which control are you adjusting here?
> 
> > If there is code in software doing this, it's very subtle.
> 
> My money would be on the AC97 controller having problems; the quality of
> SoC AC97 controllers is variable.  It certainly doesn't sound like a
> WM9712 issue; as I say I'd be very surprised if such an issue hadn't
> come up before given how widely deployed the part is.
