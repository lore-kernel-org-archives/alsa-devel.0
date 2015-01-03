From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] sound: pci: hda: patch_analog: Remove some
	unused functions
Date: Sat, 3 Jan 2015 01:14:54 +0100
Message-ID: <CAKXHbyMPZ6agrhbCoQQzZvH4cB_gtumhxsB-uhQXqggFq4GQ=g@mail.gmail.com>
References: <1420221508-32319-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1420222637.9624.36.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 92F7E26058A
 for <alsa-devel@alsa-project.org>; Sat,  3 Jan 2015 01:14:56 +0100 (CET)
Received: by mail-ie0-f175.google.com with SMTP id x19so17325410ier.20
 for <alsa-devel@alsa-project.org>; Fri, 02 Jan 2015 16:14:55 -0800 (PST)
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com.
 [209.85.213.170])
 by mx.google.com with ESMTPSA id n36sm23502589ioe.4.2015.01.02.16.14.54
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 02 Jan 2015 16:14:54 -0800 (PST)
Received: by mail-ig0-f170.google.com with SMTP id r2so1003397igi.3
 for <alsa-devel@alsa-project.org>; Fri, 02 Jan 2015 16:14:54 -0800 (PST)
In-Reply-To: <1420222637.9624.36.camel@x220>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2015-01-02 19:17 GMT+01:00 Paul Bolle <pebolle@tiscali.nl>:

> On Fri, 2015-01-02 at 18:58 +0100, Rickard Strandqvist wrote:
> > Removes some functions that are not used anywhere:
> > ad198x_ch_mode_put() ad198x_ch_mode_info()
> >
> > This was partially found by using a static code analysis program called
> cppcheck.
> >
> > Signed-off-by: Rickard Strandqvist <
> rickard_strandqvist@spectrumdigital.se>
> > ---
>
> You apparently overlooked _your_ commit 57da6bdd4823 ("ALSA: hda -
> patch_analog.c: Remove some unused functions") in linux-next.
>
> >  sound/pci/hda/patch_analog.c |   21 ---------------------
> >  1 file changed, 21 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
> > index 06275f8..ed0b71c 100644
> > --- a/sound/pci/hda/patch_analog.c
> > +++ b/sound/pci/hda/patch_analog.c
> > @@ -698,15 +698,6 @@ static int patch_ad1981(struct hda_codec *codec)
> >   */
> >
> >  #ifdef ENABLE_AD_STATIC_QUIRKS
> > -static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
> > -                            struct snd_ctl_elem_info *uinfo)
> > -{
> > -     struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> > -     struct ad198x_spec *spec = codec->spec;
> > -     return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mode,
> > -                                 spec->num_channel_mode);
> > -}
> > -
> >  static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
> >                             struct snd_ctl_elem_value *ucontrol)
> >  {
> > @@ -716,18 +707,6 @@ static int ad198x_ch_mode_get(struct snd_kcontrol
> *kcontrol,
> >                                  spec->num_channel_mode,
> spec->multiout.max_channels);
> >  }
> >
> > -static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
> > -                           struct snd_ctl_elem_value *ucontrol)
> > -{
> > -     struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> > -     struct ad198x_spec *spec = codec->spec;
> > -     int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
> > -                                   spec->num_channel_mode,
> > -                                   &spec->multiout.max_channels);
> > -     if (err >= 0 && spec->need_dac_fix)
> > -             spec->multiout.num_dacs = spec->multiout.max_channels / 2;
> > -     return err;
> > -}
> >  #endif /* ENABLE_AD_STATIC_QUIRKS */
> >
> >  static int ad1988_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
>
> Thanks,
>
>
> Paul Bolle
>
>

Hi Paul

Sorry about that!

Have tried to change my script to avoid just that, so that all functions to
be removed in a file, with the same patch.

Everything was solved correctly in the commit 57da6bdd4823
So ignore this patch.



Kind regards
Rickard Strandqvist
