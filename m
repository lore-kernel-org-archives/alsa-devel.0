From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date: Fri, 31 Aug 2018 13:37:52 -0700
Message-ID: <20180831203752.37rsceiwotcmeses@pburton-laptop>
References: <20180606193811.16007-1-malat@debian.org>
 <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Matthieu,

On Tue, Jul 24, 2018 at 01:47:57PM -0700, Paul Burton wrote:
> On Wed, Jun 06, 2018 at 09:38:08PM +0200, Mathieu Malaterre wrote:
> > diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
> > index 1a354a6b6e87..35d82d96e781 100644
> > --- a/sound/soc/jz4740/Kconfig
> > +++ b/sound/soc/jz4740/Kconfig
> > @@ -1,20 +1,20 @@
> >  config SND_JZ4740_SOC
> > -	tristate "SoC Audio for Ingenic JZ4740 SoC"
> > -	depends on MACH_JZ4740 || COMPILE_TEST
> > +	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
> > +	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST
> 
> Perhaps this could be MACH_INGENIC, or even just MIPS?

Further to that, this series doesn't seem to work for me. With
v4.19-rc1, with the patch from [1] & then this series applied I see the
following when booting a ci20_defconfig kernel:

  [    0.846684] ALSA device list:
  [    0.849642]   No soundcards found.

Nothing else looks obviously relevant, but here's the full boot log for
reference:

  https://gist.github.com/paulburton/336fa3a6ed756f9bbb587f01dcd520e5/6a5042a258348ed5e5d3d0cb1a72076abf31d85b

Thanks,
    Paul
