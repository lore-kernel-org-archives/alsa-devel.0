From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: SigmaTel STAC9221 - Mux Amp-Out > 0x02 ==
	microphone not working
Date: Tue, 29 May 2007 17:49:54 +0100
Message-ID: <3db1ec7f0705290949r6d1b3068l47fa147429a5d8ad@mail.gmail.com>
References: <3db1ec7f0705271550n4e61e012l245f888ff34558c0@mail.gmail.com>
	<s5h7iqr1xda.wl%tiwai@suse.de>
	<3db1ec7f0705290820y2de2fac6oaf3c17109b3ba7e2@mail.gmail.com>
	<s5h4plv1we1.wl%tiwai@suse.de> <s5hwsyrzjr3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by alsa0.perex.cz (Postfix) with ESMTP id BF42124374
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 18:49:57 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so588773ana
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 09:49:55 -0700 (PDT)
In-Reply-To: <s5hwsyrzjr3.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 5/29/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 29 May 2007 17:29:10 +0200,
> I wrote:
> >
> > At Tue, 29 May 2007 16:20:33 +0100,
> > Ivan N. Zlatev wrote:
> > >
> > > On 5/29/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > And, does this volume have any influence on the quality of recorded
> > > > sound at all?  If not, we should remove this control rather than
> > > > keeping a dangerous thing...
> > > >
> > >
> > > Yes. This controls the microphone boost level (without boost the sound
> > > recorded has *very* low volume). Also Windows shows  up a +20db
> > > microphone boost slider on this machine.
> >
> > Ah, OK.  Then the control seems indicates the wrong max level indeed.
> > So, we need two fixes:
> >
> > - rename "Mux Capture Volume" to more intuitive one, such as "Capture
> >   Boost" or something like that.
> >
> > - limit the max level of this volume to 2.
> >
> > The latter is a bit hard to fix.  Let's see whether I can do some
> > hack...
>
> Could you check the patch below?
> (This doesn't rename but just fix the latter item.)
>
>
> Takashi
>
> diff -r 200fc3a7ef62 pci/hda/hda_codec.c
> --- a/pci/hda/hda_codec.c       Tue May 29 18:01:06 2007 +0200
> +++ b/pci/hda/hda_codec.c       Tue May 29 18:17:15 2007 +0200
> @@ -711,6 +711,19 @@ static u32 query_amp_caps(struct hda_cod
>                         info->status |= INFO_AMP_CAPS;
>         }
>         return info->amp_caps;
> +}
> +
> +int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
> +                             unsigned int caps)
> +{
> +       struct hda_amp_info *info;
> +
> +       info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, dir, 0));
> +       if (!info)
> +               return -EINVAL;
> +       info->amp_caps = caps;
> +       info->status |= INFO_AMP_CAPS;
> +       return 0;
>  }
>
>  /*
> diff -r 200fc3a7ef62 pci/hda/hda_local.h
> --- a/pci/hda/hda_local.h       Tue May 29 18:01:06 2007 +0200
> +++ b/pci/hda/hda_local.h       Tue May 29 18:17:02 2007 +0200
> @@ -277,5 +277,7 @@ static inline u32 get_wcaps(struct hda_c
>         return codec->wcaps[nid - codec->start_nid];
>  }
>
> +int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
> +                             unsigned int caps);
>
>  #endif /* __SOUND_HDA_LOCAL_H */
> diff -r 200fc3a7ef62 pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c  Tue May 29 18:01:06 2007 +0200
> +++ b/pci/hda/patch_sigmatel.c  Tue May 29 18:12:30 2007 +0200
> @@ -2033,6 +2033,12 @@ static int patch_stac925x(struct hda_cod
>
>         codec->patch_ops = stac92xx_patch_ops;
>
> +       /* Fix Mux capture level; max to 2 */
> +       snd_hda_override_amp_caps(codec, 0x12, HDA_OUTPUT,
> +                                 (0 << AC_AMPCAP_OFFSET_SHIFT) |
> +                                 (2 << AC_AMPCAP_NUM_STEPS_SHIFT) |
> +                                 (0x27 << AC_AMPCAP_STEP_SIZE_SHIFT) |
> +                                 (0 << AC_AMPCAP_MUTE_SHIFT));
>         return 0;
>  }
>
>

Works, BUT the last hunk is at the wrong place. The
snd_hda_override_amp_caps call should be in patch_stac922x (...) and
not in patch_stac925x (...)

Cheers!
-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."
