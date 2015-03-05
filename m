From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix wrong detection of
 "Headphone+LO" or "Speaker+LO"
Date: Thu, 5 Mar 2015 19:43:04 +0800
Message-ID: <CAN8ccibTukVjjNgdJXwS2XAkEPAOX5spkYTmwqteChg=-ROA7A@mail.gmail.com>
References: <54F5DB0B.8020507@canonical.com>
 <54f82ff9.6829c1e7.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F61F260499
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 12:43:05 +0100 (CET)
Received: by obcuy5 with SMTP id uy5so6072795obc.11
 for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2015 03:43:04 -0800 (PST)
In-Reply-To: <54f82ff9.6829c1e7.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

>
> > Hmm. What do you think of the attached patch - would it work as well? It
> > removes the part that returns early for all three, letting it fall
> > through to the part that returns "Front" etc.
>
> > +++ b/sound/pci/hda/hda_generic.c
> > @@ -1100,11 +1100,9 @@ static const char *get_line_out_pfx(struct
> > hda_codec *codec, int ch,
> >                 if (!ch && cfg->speaker_outs && cfg->hp_outs) {
> >                         bool hp_lo_shared = !path_has_mixer(codec,
spec->hp_paths[0], ctl_type);
> >                         bool spk_lo_shared = !path_has_mixer(codec,
spec->speaker_paths[0], ctl_type);
> > -                       if (hp_lo_shared && spk_lo_shared)
> > -                               return spec->vmaster_mute.hook ? "PCM"
: "Master";
> > -                       if (hp_lo_shared)
> > +                       if (hp_lo_shared && !spk_lo_shared)
> >                                 return "Headphone+LO";
> > -                       if (spk_lo_shared)
> > +                       if (spk_lo_shared && !hp_lo_shared)
> >                                 return "Speaker+LO";
> >                 }
> >         }
>
> After a quick check, this seems better. Master is a real master now and
there
> is a Front control.

>> >> With the patch I'm getting a real Master (for all
Front/Surround/CLFE) and a
>> separate Front Volume Control in addition to Surround, Center and LFE
which >> is exactly how it should be.
> > > Hmm. What do you think of the attached patch - would it work as well?
It removes the part that returns early for all three, letting it fall
through to the part that returns "Front" etc.

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/mixer/paths/analog-output-headphones.conf?id=
96369919e5100865e2469e42fb8f4b8e38e41aef

Do you mean front playback volume is set to maximum when headphone is
plugged?

How do Pulseaudio calculate dB min of headphone path and lineout path?

Do it just put dB min of front playback volume in headphone path only when
there is no headphone playback volume?

BTW codec alc888 in buglink can use amp out in node 0x26 as Headphone
Playback volume

>
> However, due to the speaker having no path with my forced config, I cannot
> say whether this will work if the parser could find the multi-io config by
> itself (and until then there probably shouldn't be patches I suggested).
And,
> by the way, as a result of the no-path I'm getting a Speaker+LO control.
>
> Here a little additional debug output during the get_line_out_pfx() calls.
> The "path_has_mixer" output refers to a call which output is in the
following
> line, i. e. the call for getting spk_lo_shared:
>
> [    0.648407] sound hdaudioC1D0: get_line_out_pfx, AUTO_PIN_LINE_OUT:
hp_lo_shared=1
> [    0.648407] sound hdaudioC1D0: path_has_mixer: no path!
> [    0.648408] sound hdaudioC1D0: get_line_out_pfx, AUTO_PIN_LINE_OUT:
spk_lo_shared=1
> [    0.648409] sound hdaudioC1D0: get_line_out_pfx, AUTO_PIN_LINE_OUT:
hp_lo_shared=0
> [    0.648410] sound hdaudioC1D0: path_has_mixer: no path!
> [    0.648410] sound hdaudioC1D0: get_line_out_pfx, AUTO_PIN_LINE_OUT:
spk_lo_shared=1
>
> Ingo
