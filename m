From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add sound card driver for Snow board
Date: Wed, 23 Apr 2014 08:23:17 +0530
Message-ID: <CAHbNUh0hHE2J=jb8o5ErOJqGj2oNu8kzZXs_Bp=4pn8Sy+K7Yg@mail.gmail.com>
References: <1398153834-16199-1-git-send-email-tushar.behera@linaro.org>
	<20140422104447.GK12304@sirena.org.uk>
	<CAHbNUh3G5HLaGXddPgjthWTu_VQ95xo=2Lii2BM6iSc-ipnm=w@mail.gmail.com>
	<20140422183310.GD12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140422183310.GD12304@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-doc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, rdunlap@infradead.org, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 23 April 2014 00:03, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Apr 22, 2014 at 07:17:54PM +0530, Tushar Behera wrote:
>> On 22 April 2014 16:14, Mark Brown <broonie@kernel.org> wrote:
>
>> > In general this isn't up to modern standards, please do try to check
>> > that new code is following best practices.  Did the support for setting
>> > the clocking up in the device tree get merged already?
>
>> I didn't get this point. Would you please elaborate?
>
> The out of tree driver for these boards has a bunch of code in it which
> reprograms the clock tree that parents the I2S block so that the I2S
> block has inputs at suitable rates to allow it to generate useful
> outputs.
>

Currently the clocks are configured through clk-exynos-audss.c. The
reparenting of I2S bus clock is not done anymore, but is left to use
the default value set in bootloader. With default setup (XXTI as the
parent), I have tested wave files with various sample rates on Snow.

The missing part right now is setting XCLKOUT (mclk for the audio
codec) properly. In internal tree, I have directly programmed the
XCLKOUT register (we don't have a clock for it as this register is not
part of clock domain). I am now working on preparing a clock provider
for XCLKOUT.

>> > Please do also pay attention to the CC lists when posting patches, this
>> > seems to have been sent to a fairly random selection of people and
>> > lists.
>
>> Okay, I will update the CC list as per get_maintainer script during
>> next revision.
>
> Please think about the results when doing that - get_maintainers is very
> useful but it does generate false positives and miss people.
>

I will do my best to add relevant people in the discussion.

>> >> +     ret = snd_soc_dai_set_clkdiv(cpu_dai, SAMSUNG_I2S_DIV_BCLK, bfs);
>> >> +     if (ret < 0)
>> >> +             return ret;
>
>> > Set this stuff up on probe.  I'm surprised that you need to set BCLK at
>> > all...
>> >
>
>> Should I create a late_probe call for this (in line with tobermory.c)?
>
> Yes.

Ok.

Thanks.
-- 
Tushar Behera
