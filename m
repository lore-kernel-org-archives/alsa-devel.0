From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Wed, 27 Feb 2019 13:01:05 -0500
Message-ID: <CAGngYiWESOoKSp09=7W_EEdKJ5r47LQwVAanadAKOO=goy61qg@mail.gmail.com>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190225140334.uy3qf55u2jjk3ith@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F02CAF896A5
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 19:01:18 +0100 (CET)
Received: by mail-ot1-x342.google.com with SMTP id n71so15139473ota.10
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 10:01:18 -0800 (PST)
In-Reply-To: <20190225140334.uy3qf55u2jjk3ith@shell.armlinux.org.uk>
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

On Wed, Feb 27, 2019 at 6:47 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> Given that, we do need some way to validate the bclk_ratio when it is
> set, and not during hw_params which would (a) lead to ALSA devices
> failing when userspace is negotiating the parameters and (b) gives no
> way in the kernel for set_bclk_ratio() to discover whether a particular
> ratio is supported by the codec.
>
> So, I think there's three possible ways around this:
> 1. adding a set_bclk_ratio() method to hdmi_codec_ops
> 2. calling hw_params() when our set_bclk_ratio() method is called
>    (what if the rest of the format isn't set or incompatible, which
>    may cause the hw_params() method to fail?)
> 3. adding a list of acceptable bclk_ratio values to hdmi_codec_pdata
>

Again excuse my obvious ignorance, but would these solutions work well in the
more general case?

Imagine a cpu dai that supports 16x2/16x2, 20x2/20x2, 24x2/24x2
(sample bits/frame bits -- wire format), sending audio to our tda998x
hdmi xmitter.
Depending on the type of samples that userspace chooses to play, one of the
above formats gets selected by the ASoC core, resulting in a bclk_ratio of
16x2, 20x2 or 32x2. It's up to the card driver to call set_bclk_ratio(), right?
So now this card driver needs intimate knowledge of bclk_ratios vs formats for
the cpu dai. Also it needs knowledge of which bclk_ratios are supported by the
hdmi xmitter, and a mechanism to filter our the 20x2 blk_ratio format.
Which may not be trivial, and also prevents it from being generic,
i.e. we can no longer use simple-card ?

But it gets worse. Imagine a hypothetical cpu dai that supports 20x2/20x2 and
20x2/24x2. When the dai is sending to a codec that doesn't care about
bclk_ratio,
it should pick 20x2/20x2, because that's most efficient, right? Except
on a tda998x
it should select 20x2/24x2. So how would a card driver now even begin to
deal with this, given that there appears to be no mechanism to even describe
these differences? Because the params_physical_width() describes the memory
format, and not the wire format, correct?

So all this kind of suggests to me that the bclk_ratio could be part of the
format description, or something?

static struct snd_soc_dai_driver acme_cpu_dai = {
        .playback = {
                .formats = SNDRV_PCM_FMTBIT_S20_3LE_20 |
                                SNDRV_PCM_FMTBIT_S20_3LE_24,
                                SNDRV_PCM_FMTBIT_S16_LE | //
bclk_ratio 16 implied
                                SNDRV_PCM_FMTBIT_S24_LE | //
bclk_ratio 24 implied
                                SNDRV_PCM_FMTBIT_S24_LE_32
        },
};

static struct snd_soc_dai_driver hdmi_dai = {
        .playback = {
                .formats = SNDRV_PCM_FMTBIT_S20_3LE_24 |
                                SNDRV_PCM_FMTBIT_S16_LE | //
bclk_ratio 16 implied
                                SNDRV_PCM_FMTBIT_S24_LE | //
bclk_ratio 24 implied
                                SNDRV_PCM_FMTBIT_S24_LE_32,
        },
};

In this case, the capabilities get negotiated correctly, and the tda998x's
hw_params() could just call params_bclk_ratio(params) to get the ratio, right?

And the fsl_ssi could resort to a rule to filter out all non-32x2 bclk_ratio
formats only in master mode.

As I said, I'm way out of my depth here. No idea how realistic or hypothetical
this is, or if this would go against the grain of the existing ASoC
architecture.

I really hope there's a much better solution than this that will solve the
general case.
