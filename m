From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: [PATCH 002/003] snd-powermac: AWACS and Screamer
	mixers for PM7500, Beige, and iMac SL
Date: Tue, 15 Apr 2008 20:56:00 +0300
Message-ID: <46e1c7760804151056x7b0e35e5pdf02b2330c1ebc3b@mail.gmail.com>
References: <46e1c7760804141012v3ab4d9a2g160ec8bced54291d@mail.gmail.com>
	<s5h1w5747p0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A4810383C
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 19:56:03 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so590258ana.80
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 10:56:01 -0700 (PDT)
In-Reply-To: <s5h1w5747p0.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/4/15, Takashi Iwai <tiwai@suse.de>:
>
> The embedded patch seems broken.  Could you check your MUA?
>
Hmm, looks like copying from the other list changed tabs to spaces.

>
>
> The coding style fixes should be in a dedicated patch.
>  Otherwise it makes hard to follow the logical changes.
>
I'll split it in 2.

>
>  > @@ -493,14 +500,14 @@ static struct snd_kcontrol_new snd_pmac_
>  >         .private_value = AMP_CH_HD,
>  >       },
>  >       { .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>  > -       .name = "Tone Control - Bass",
>  > +       .name = "Tone Control - Bass Playback Volume",
>
>
> This shouldn't be changed.  "Tone Control - Bass" is the correct
>  standard control name.
>
>
>  >         .info = snd_pmac_awacs_info_tone_amp,
>  >         .get = snd_pmac_awacs_get_tone_amp,
>  >         .put = snd_pmac_awacs_put_tone_amp,
>  >         .private_value = 0,
>  >       },
>  >       { .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>  > -       .name = "Tone Control - Treble",
>  > +       .name = "Tone Control - Treble Playback Volume",
>
>
> Ditto.
>
The reason for this was that the tone controls appeared on Capture
page, too, even though they don't actually belong there.

>
>  > -static int build_mixers(struct snd_pmac *chip, int nums, struct
>  > snd_kcontrol_new *mixers)
>  > +static int build_mixers(struct snd_pmac *chip, int nums,
>  > +                     struct snd_kcontrol_new *mixers)
>  >  {
>  >       int i, err;
>  >
>  >       for (i = 0; i < nums; i++) {
>  > -             if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&mixers[i], chip))) < 0)
>  > +             if ((err = snd_ctl_add(chip->card,
>  > +                                    snd_ctl_new1(&mixers[i], chip))) < 0)
>  >                       return err;
>
>
> This "if ((err = ..." doesn't comply the standard coding style.
>  Try once checkpatch.pl script included in $LINUX/scripts.
>
Actually, I did, and it complained, but I think it made an error. It
somehow didn't see the 'less than' comparison.

Risto
