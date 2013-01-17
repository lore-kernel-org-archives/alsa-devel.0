From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Thu, 17 Jan 2013 11:51:48 +0800
Message-ID: <CAN8ccib5gpbsyLPmfoaC4edwYjird8ViZbKKiTbo-iP4DsjsOA@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <20130114133122.52cadb99@gmail.com> <s5h7gngc4lt.wl%tiwai@suse.de>
 <20130114135947.1f0bbbf4@gmail.com> <s5h1udndihf.wl%tiwai@suse.de>
 <20130114172354.1f47f49b@gmail.com>
 <CAN8cciaoAt75sRUtLM6Ov4VGBQ1pFgPwO-EZT88q6d1gm-JggQ@mail.gmail.com>
 <20130115095325.7aa2dfdd@gmail.com>
 <CAN8cciYrMSBhpp-9QjHdE8aVMHh_JwHswwfPfjtGY6OB_E4NcQ@mail.gmail.com>
 <20130116094941.0e1170b2@gmail.com> <s5hwqvd33va.wl%tiwai@suse.de>
 <20130116133952.18449985@gmail.com> <s5hbocpp9tn.wl%tiwai@suse.de>
 <20130116140412.01c73523@gmail.com> <s5h8v7tp8s8.wl%tiwai@suse.de>
 <20130116145509.434c0bb9@gmail.com> <s5h1udlp5to.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f54.google.com (mail-vb0-f54.google.com
 [209.85.212.54])
 by alsa0.perex.cz (Postfix) with ESMTP id F23A226167D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 04:51:49 +0100 (CET)
Received: by mail-vb0-f54.google.com with SMTP id l1so2067538vba.13
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 19:51:49 -0800 (PST)
In-Reply-To: <s5h1udlp5to.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: basinilya@gmail.com, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > >> >> >> >> >> >Yes, testing the latest code with real machines is
highly
> > >> >> >> >> >> >appreciated.  Try sound-unstable git tree, either
master or
> > >> >> >> >> >> >test/hda-migrate branch.
> > >> >> >> >> >> >  git://
> > >> >> >> >
git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
> > >> >> >> >> >> >
> > >> >> >> >> >> >Alternatively you can build the external alsa-driver
modules from
> > >> >> >> >> >> >alsa-driver-unstable snapshot tarball, too
> > >> >> >> >> >> >
> > >> >> >> >> >
> > >> >> >> >
ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
> > >> >> >> >> >> >
> > >> >> >> >> >> >Note that only the behavior of model=auto has been
changed in the tree
> > >> >> >> >> >> >above.  The other model behaviors of AD codecs are
unchanged at all.

> > >> >> >> >
> > >> >> >> >Seen many ad1988 controls are missing ?
> > >> >> >> >
> > >> >> >> >1) rear Mic, line , front Mic  playback volume and switch
> > >> >> >> >2) CD playback switch
> > >> >> >> >3) input mix in input source
> > >> >> >> >4) analog loopback mix volume and mute switch

> > But the number of controls is smaller than in linux stable 3.7.2. I
> > don't know if that's a regression.
>
>
> Unless you see *functional* degradation, it's no regression but
> regarded rather as a cleanup

Refer to commit

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-unstable.git;a=commitdiff;h=f3fc0b0b1fe31e0ec9a72ab85b421e74c696f00d;hp=3a65bcdc577a338712c2eaefc194909de79d4982

The Stereo Mix of those VIA codecs allow ADD capture  DAC signal

ad1988 and those realtek codecs can select input source from the audio
mixer which can mix the input pins

- snd_hda_add_imux_item(imux, "Mix", 9, NULL);

Those  static models (3stack , 3stack-dig, 6stack and 6stack-dig )still
have the input source "mix"

static const struct hda_input_mux ad1988_6stack_capture_source = {
        .num_items = 5,
       .items = {
               { "Front Mic", 0x1 },   /* port-B */
                { "Line", 0x2 },        /* port-C */
                { "Mic", 0x4 },         /* port-E */
                { "CD", 0x5 },
                 { "Mix", 0x9 },
       },
};

Most  desktop codecs can pass the blue Jack signal to green Jack by unmute
line playback switch and line playback volume

-- if ((err = add_control(spec, AD_CTL_WIDGET_VOL,
- "Analog Mix Playback Volume",
- HDA_COMPOSE_AMP_VAL(0x21, 3, 0x0, HDA_OUTPUT))) < 0)
- return err;
- if ((err = add_control(spec, AD_CTL_WIDGET_MUTE, - "Analog Mix Playback
Switch",
- HDA_COMPOSE_AMP_VAL(0x21, 3, 0x0, HDA_OUTPUT))) < 0) - return err;
