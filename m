From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Mon, 26 Nov 2018 21:23:28 +0200
Message-ID: <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
 <20181126140200.GC9715@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E7B226770D
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 20:23:42 +0100 (CET)
Received: by mail-io1-f65.google.com with SMTP id v10so9263970ios.13
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 11:23:42 -0800 (PST)
In-Reply-To: <20181126140200.GC9715@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 26, 2018 at 4:02 PM Mark Brown <broonie@kernel.org> wrote:

> On Sat, Nov 24, 2018 at 10:05:42PM +0200, Dimitris Papavasiliou wrote:
>
> > +static int pcm512x_digital_playback_switch_get(struct snd_kcontrol
> *kcontrol,
> > +                                            struct snd_ctl_elem_value
> *ucontrol)
> > +{
> > +     struct snd_soc_component *component =
> snd_soc_kcontrol_component(kcontrol);
> > +     struct pcm512x_priv *pcm512x =
> snd_soc_component_get_drvdata(component);
> > +
> > +     mutex_lock(&pcm512x->mutex);
> > +     ucontrol->value.integer.value[0] = !(pcm512x->mute & 0x4);
> > +     ucontrol->value.integer.value[1] = !(pcm512x->mute & 0x2);
> > +     mutex_unlock(&pcm512x->mutex);
> > +
> > +     return 0;
> > +}
>
> Just remove the control, no need to jump through these hoops.
>

 Sorry, I probably misunderstand.  Do you propose removing
the "Digital Playback Switch" control entirely?  It would
certainly simplify things, as far as implementing the
.digital_mute callback is concerned, but it would remove the only
way of manually muting the DAC.  The "Digital Playback Volume"
control is the main (and basically sole, apart from a switchable
-6dB analog gain control) volume control of the DAC and removing
the Switch component would make it unmutable.

The current implementation uses the control to keep track of the
user's desired mute state and allows the .digital_mute callback to
override it, in a way that is transparent to the user.
