From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Date: Tue, 7 Sep 2010 09:11:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1009070910370.1345@axis700.grange>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
 <w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
 <Pine.LNX.4.64.1009060932430.20387@axis700.grange>
 <20100906102557.GE10367@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20100906102557.GE10367@rakim.wolfsonmicro.main>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Sep 2010, Mark Brown wrote:

> On Mon, Sep 06, 2010 at 10:27:56AM +0200, Guennadi Liakhovetski wrote:
> > On Tue, 31 Aug 2010, Kuninori Morimoto wrote:
> 
> > > +static int sh_hdmi_snd_write(struct snd_soc_codec *codec,
> > > +			     unsigned int reg,
> > > +			     unsigned int value)
> > > +{
> > > +	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
> > > +
> > > +	hdmi_write(hdmi, value, reg);
> > > +	return 0;
> > > +}
> 
> > Are these two actually needed? As long as you don't have a register cache 
> > - no need for these?
> 
> Something needs to translate the ASoC register I/O functions into what
> the HDMI layer code is expecting.

AFAICS, with ->reg_cache_size = 0 the ASoC core will not attempt to call 
them.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
