From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: wm8960: update pll and
	clock	setting function
Date: Mon, 10 Aug 2015 14:47:40 +0100
Message-ID: <20150810134740.GI25225@opensource.wolfsonmicro.com>
References: <ac311441efbc167953de3ab8706217c3c669f88d.1436776563.git.zidan.wang@freescale.com>
 <20150810083246.GH25225@opensource.wolfsonmicro.com>
 <20150810080805.GB15493@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 540432608BC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 15:47:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150810080805.GB15493@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2015 at 04:08:06PM +0800, Zidan Wang wrote:
> On Mon, Aug 10, 2015 at 09:32:46AM +0100, Charles Keepax wrote:
> > On Mon, Jul 13, 2015 at 04:41:00PM +0800, Zidan Wang wrote:
> > > Add sysclk auto mode. When it's sysclk auto mode, if the MCLK is
> > > available for clock configure, using MCLK to provide sysclk directly,
> > > otherwise, search a available pll out frequcncy and set pll.
> > > 
> > > Configure clock in hw_params may cause problems when using bypass style
> > > paths without hw_params in machine driver getting called. So add configure
> > > clock to set_bias_level.
> > > 
> > > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > > ---
> > <snip>
> > > @@ -711,6 +785,9 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
> > >  	case SND_SOC_BIAS_PREPARE:
> > >  		switch (snd_soc_codec_get_bias_level(codec)) {
> > >  		case SND_SOC_BIAS_STANDBY:
> > > +			ret = wm8960_configure_clocking(codec);
> > > +			if (ret)
> > > +				return ret;
> > 
> > Is it right that we are calling wm8960_configure_clocking before
> > clk_prepare_enable? As configure_clocking will enable the clocks
> > shouldn't mclk be available before then?
> The wm8960 codec don't need to enable MCLK to write register. So i think it's ok to enable MCLK at the last moment.

I would wager that this msleep is waiting for the PLL to lock
though:

static int wm8960_set_pll(struct snd_soc_codec *codec,
		unsigned int freq_in, unsigned int freq_out)

<snip>

	/* Turn it on */
	snd_soc_update_bits(codec, WM8960_POWER2, 0x1, 0x1);
	msleep(250);
	snd_soc_update_bits(codec, WM8960_CLOCK1, 0x1, 0x1);

If you don't have the MCLK ready before that then the FLL won't
be able to lock. It is possible things might still work as
perhaps the FLL lock time will get hidden by something else later
in the chain, but I would be surprised if it was a good idea to
enable the PLL without the source clock being available.

Thanks,
Charles
