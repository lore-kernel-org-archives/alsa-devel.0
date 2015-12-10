From: Danny Milosavljevic <dannym@scratchpost.org>
Subject: Re: [PATCH v5] sun4i-codec: add inputs
Date: Thu, 10 Dec 2015 21:52:27 +0100
Message-ID: <20151210215227.6453acc8@dayas>
References: <20151208042013.11d31f09@dayas>
	<20151210175420.GH27957@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151210175420.GH27957@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Maxime,

On Thu, 10 Dec 2015 18:54:20 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > +	SOC_DAPM_SINGLE("Mic1-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
> > +	SOC_DAPM_SINGLE("Mic2-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
> >  };
> 
> Do we need the -In part of FM, Mic1 and Mic2?

For consistency to what's in linux-sunxi.git, I will remove the "-In" from 
the Mic names in v7.

For FM, do we? I don't know. Are there ALSA devices which output to FM?

> Mic1 is already defined a few lines above.
> And you have the Mixers routes a bit above too.

Aha, Mic1 is there in <https://github.com/linux-sunxi/linux-sunxi.git> 
branch "sunxi-next".
In <git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git> 
branch "sunxi/for-next", it's not there. 
This patch is for the latter.

I'm currently rebasing on the former, but it will take some time. 
The differences between these driver versions are:
- Mic1 Preamplifier is registered as PGA instead of switch in the former.
- Mic1 is already an input in the former.
- VMIC is handled in the former.
- ADC Capturing support exists in the former.
That's it.

I'll retest a patch based on the former...

> [global mutation]
> We'll need to fix that, see the other discussion.

Yeah, I think I found a nicer way to do it in v6.

Thanks,
   Danny
