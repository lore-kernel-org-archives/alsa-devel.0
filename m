From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Date: Tue, 24 Jul 2018 13:47:57 -0700
Message-ID: <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
References: <20180606193811.16007-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606193811.16007-1-malat@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>
Cc: James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Matthieu,

On Wed, Jun 06, 2018 at 09:38:08PM +0200, Mathieu Malaterre wrote:
> diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
> index 1a354a6b6e87..35d82d96e781 100644
> --- a/sound/soc/jz4740/Kconfig
> +++ b/sound/soc/jz4740/Kconfig
> @@ -1,20 +1,20 @@
>  config SND_JZ4740_SOC
> -	tristate "SoC Audio for Ingenic JZ4740 SoC"
> -	depends on MACH_JZ4740 || COMPILE_TEST
> +	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
> +	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST

Perhaps this could be MACH_INGENIC, or even just MIPS?

Thanks,
    Paul
