From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: note buggy I2S support when the
 codec masters LRCLK
Date: Wed, 27 Apr 2016 23:29:53 +0200
Message-ID: <29d9da68-789d-d3ea-cb9a-0230596e3069@axentia.se>
References: <1461747993-11516-1-git-send-email-peda@axentia.se>
 <20160427162344.GA3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160427162344.GA3217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2016-04-27 18:23, Mark Brown wrote:
> On Wed, Apr 27, 2016 at 11:06:33AM +0200, Peter Rosin wrote:
>
>> While the start condition is correct for the left channel word in the I2S
>> case, it is not correct that the right channel word follows immediately
>> after the left channel word. The start of the right channel word should
>> be triggered by a rising edge on LRCLK in the I2S case, something which
>> simply does not happen.
>
> Almost every programmable serial port does this, it's a very common
> issue which is why we always try to go for exact clocking where we can -
> it greatly improves the interoperability for I2S if there are no dead
> clocks.

Someone said: be conservative in what you send, be liberal in what you
accept. This is not that at all. This is more like: be conservative in
what you send, and accept only a subset of valid input.

It absolutely kills interoperability if you claim I2S and then don't
do I2S. If you are not looking at both edges of LRCLK it simply isn't I2S.
It's something else. Like "packed I2S" or "DSP moda A with inverted
symmetric LRCLK" or something, so why not invent a way to say that?

Dais could be taught that an I2S LRCLK slave is compatible with this
new mode as LRCLK master, but not the other way around. But since most
people are not making dai link decisions, that will probably be a lot
of work for questionable gain. What is needed is documenatation about
quirks such as this, hence my patch.

I have this codec which does I2S but there is no way to get rid of dead
clocks when it masters the clocks. It can divide MCLK with 1,2,4,8 or 16
to get a BCLK, or it can generate BCLK as 48x or 64x LRCLK. But it only
sports 16 bits per sample.

So, if it divides MCLK, and MCLK is not matched to the needed LRCLK (there
is no need, we currently use a 16MHz MCLK) there will almost certainly
be some dead BCLKs, and if LRCLK is used as base for BCLK, there will be
either 8 or 16 dead cycles per channel. In other words, it is difficult
or next to impossible to not get dead cycles with this codec. But it
does I2S correctly.

When you don't know beforehand that the clock slave (Atmel SSC) is lying
and isn't supporting I2S even though it claims so, it turned out to be a
huge time sink for me when I tried to bring up this new codec (max9860).
I naturally thought that the problem was with my new code and not the
old (assumed mature and mostly free of silly bugs) code. Especially for
something as well understood as I2S. I was baffled when I realized what
the problem was, it wasn't even on my map. I'm probably naive...

Cheers,
Peter
