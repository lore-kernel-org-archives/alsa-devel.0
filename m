From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [alsa-devel] [PATCH 1/9] ASoC: da7210: Add support for line
 out and DAC
Date: Thu, 13 Oct 2011 14:23:34 +0530
Message-ID: <1318496015.12107.434.camel@matrix>
References: <1318431375.12107.398.camel@matrix>
	 <20111012144940.GN3647@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111012144940.GN3647@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-10-12 at 15:49 +0100, Mark Brown wrote:
> On Wed, Oct 12, 2011 at 08:26:15PM +0530, Ashish Chavan wrote:
> 
> > +	SOC_DOUBLE_R_TLV("DAC Playback Volume",
> > +			 DA7210_DAC_L, DA7210_DAC_R,
> > +			 0, 0x77, 1, dac_gain_tlv),
> 
> Digital Playback Volume.

OK, will update it.

> 
> > +	/* Set default DAC gain */
> > +	snd_soc_write(codec, DA7210_DAC_L, DA7210_DFLT_DAC_GAIN);
> > +	snd_soc_write(codec, DA7210_DAC_R, DA7210_DFLT_DAC_GAIN);
> 
> No, use chip defaults.
> 

I see.
