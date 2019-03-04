From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Mon, 4 Mar 2019 11:59:38 -0500
Message-ID: <CAGngYiUNFc9N82duW1kwzx-dY3dk=1Sw9QffqpocoP=xz9OdVw@mail.gmail.com>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190301123629.GC7429@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 380DBF896EB
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 17:59:50 +0100 (CET)
Received: by mail-ot1-x341.google.com with SMTP id v20so4806421otk.7
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2019 08:59:50 -0800 (PST)
In-Reply-To: <20190301123629.GC7429@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 1, 2019 at 7:36 AM Mark Brown <broonie@kernel.org> wrote:
>
>
> As Russell outlined there's quite a bit of hopeful assumption in how
> ASoC handles the mapping of memory formats onto wire formats which works
> almost all the time but not always and definitely not through robust
> design

Yes, many of the painful tradeoffs in this discussion would go away, if the
alsa negotiation infrastructure was 'bclk_ratio aware'.

They say that a 100-line patch is often better than 1000 words. To help kick-
start a discussion, I offer a simple patch which adds bclk_ratio to
hw_params, which lets alsa 'negotiate' it the same way as the format,
channels, etc.

Obviously this is completely flawed, as it exposes bclk_ratio to userspace thru
snd_pcm_hw_params. Userspace has no business even knowing about this on-wire
property.

It may be flawed in a lot of other ways I can't see rn :)

As far as a flawed suggestion goes, it seems to behave quite well on my system.
The bclk_ratio is nicely constrained within the cpu and codec's supported
ranges and rules, and the lowest supported value is picked before hw_params()
gets called. Which is at least channels * sample_width.

Would there be a way to hide the bclk_ratio from userspace?

Is it even worth taking this forward? How likely is it for alsa components
to care about the bclk_ratio? Maybe this is a tda998x one-off?

Sven
