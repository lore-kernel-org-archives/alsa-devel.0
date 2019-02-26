From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for
	bclk_ratio
Date: Tue, 26 Feb 2019 09:53:22 -0500
Message-ID: <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 567B9F8966C
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 15:53:34 +0100 (CET)
Received: by mail-oi1-x243.google.com with SMTP id i8so10515769oib.10
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 06:53:34 -0800 (PST)
In-Reply-To: <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 26, 2019 at 4:11 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> This code actually requires a lot more thought - while it may solve
> Sven's issue, it isn't generic.

Wholeheartedly agree. My patches are marked RFC in the hope that they will be
picked apart by folks much more in touch with the "big audio picture" than
I am. It's great to learn from this process.

> So far, I have this table put
> together from various sources of information:
>
>                         bclk_ratio
> sample width    current mcasp   fslssi  kirkwood
> 16              32      32      64      64
> 24              48      48      64      64
> 32              64      64      64      64
>
> Let's also consider whether it should depend on the number of channels.
> I2S uses a WS/LRCLK signal to differentiate each channel and to demark
> where the MSB bit is.
>
> If userspace negotiates one channel, what happens - if WS becomes
> static, then there is no signal indicating where the MSB bit is in
> the stream, so there is no way for a receiver to synchronise.  So,
> it is highly unlikely that bclk_ratio = channels * sample_width.
>
> If the signal continues toggling, what does it do for the inactive
> channel - is that just one BCLK period long or does it assume there
> is still the second channel?  If the former, it means we could end
> up with bclk_ratios of 17, 25, 33 which imho is unlikely, and
> would mess up TDA998x's CTS measurement.

Good point. i2s with a single channel makes no sense.

>
> What about setups where we have multiple I2S data signals (to support
> multi-channel audio) - if we have four channels transmitted on two
> data lines (as would be required by the TDA998x), that doesn't mean
> BCLK becomes sample_width * 4.
>
> So, I don't think the number of channels comes into the bclk_ratio
> calculation at all.  Given the above code, it effectively means we'd
> always specify channels = 2 to snd_soc_calc_frame_size().

I notice that hdmi-codec.c supports up to 8 channels in hdmi multi-channel
playback mode. If we had a _theoretical_ hdmi xmitter with 8chan support,
would the bclk_ratio not be 8 x slot_size - or 8 x 32 if using an fsl_ssi
in master mode?

This will of course never happen with the tda998x, because
        .max_i2s_channels = 2,
but we are thinking about a generic solution here.

>
> Given that it is normal to talk about I2S being clocked at "64fs",
> "32fs" etc, wouldn't it just be much neater to specify _this_ value
> in DT, rather than half that value?
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
