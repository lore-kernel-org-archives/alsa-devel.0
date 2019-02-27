From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Wed, 27 Feb 2019 15:22:50 -0500
Message-ID: <CAGngYiWHt3scSd_rZq3pGWocAH+dpWyHFdxr0E1OaRqa8o=RKA@mail.gmail.com>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190225140334.uy3qf55u2jjk3ith@shell.armlinux.org.uk>
 <CAGngYiWESOoKSp09=7W_EEdKJ5r47LQwVAanadAKOO=goy61qg@mail.gmail.com>
 <20190227195600.jwhrjekyqz72xfmc@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02A8CF896A1
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 21:23:03 +0100 (CET)
Received: by mail-oi1-x244.google.com with SMTP id w66so14569289oia.4
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 12:23:03 -0800 (PST)
In-Reply-To: <20190227195600.jwhrjekyqz72xfmc@shell.armlinux.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Russell, thank you for the amazing explanation, and for your continued patience.

On Wed, Feb 27, 2019 at 2:56 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Now, the problem is... there doesn't seem to be an existing hardware
> parameter for the on-wire frame bits

Could a case be made to make the resolution core "bclk_ratio" aware ?
Of course if this is just to support tda998x, it would be like a cannon to
kill a fly...

>
> > So all this kind of suggests to me that the bclk_ratio could be part of the
> > format description, or something?
> >
> > static struct snd_soc_dai_driver acme_cpu_dai = {
> >         .playback = {
> >                 .formats = SNDRV_PCM_FMTBIT_S20_3LE_20 |
> >                                 SNDRV_PCM_FMTBIT_S20_3LE_24,
> >                                 SNDRV_PCM_FMTBIT_S16_LE | //
> > bclk_ratio 16 implied
> >                                 SNDRV_PCM_FMTBIT_S24_LE | //
> > bclk_ratio 24 implied
> >                                 SNDRV_PCM_FMTBIT_S24_LE_32
>
> I don't think this is going to work.  Firstly, it'll break userspace,
> becuase userspace would need to be taught about all these new format
> identifiers.  Secondly, it massively increases the number of formats
> to number_of_existing_formats * number_of_possible_bclk_ratios.

How about

static struct snd_soc_dai_driver acme_dai_template = {
        .playback = {
                .stream_name = "CPU-Playback",
                .channels_min = 1,
                .channels_max = 32,
                .rates = SNDRV_PCM_RATE_CONTINUOUS,
                .formats = FSLSSI_I2S_FORMATS,

                .bclk_ratio_min = 8,
                .bclk_ratio_max = 64,
                or
                .bclk_ratios = RATIO_8 | RATIO_16 | RATIO_32 | RATIO_64,
        },
};

Then if codec/cpu cares about bclk_ratios, it would have to put rules in place
such as:
- SNDRV_PCM_FMTBIT_S16_LE -> bclk_ratio = 16x2 only
- SNDRV_PCM_FMTBIT_S24_LE -> slave : bclk_ratio = [ 24x2 to 32x2 ]
                          -> master: bclk_ratio = 32x2 only
