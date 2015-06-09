From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: wm_adsp: Add code_probe and codec_remove
	stubs
Date: Tue, 9 Jun 2015 17:13:56 +0100
Message-ID: <20150609161356.GB27675@opensource.wolfsonmicro.com>
References: <1433863017-25349-1-git-send-email-rf@opensource.wolfsonmicro.com> <20150609160043.GD14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150609160043.GD14071@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2015 at 05:00:43PM +0100, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 04:16:56PM +0100, Richard Fitzgerald wrote:
> 
> > +	ret = wm_adsp2_codec_probe(&priv->core.adsp[0], codec);
> > +	if (ret)
> > +		return ret;
> > +
> 
> I'm still not a big fan of the double registration that's being done -
> if nothing else the fact that it's not also factoring out the creation
> of the DSP controls seems wrong.

I don't see the point of trying to fight against the design of ASoC with
the second probe. ASoC gives us what we need at the codec_probe stage
so why try to invent something different?
