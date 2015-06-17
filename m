From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH v2] ASoC: wm8960: add dapm kcontrols to
	select left/right ADC input source
Date: Wed, 17 Jun 2015 14:09:08 +0100
Message-ID: <20150617130908.GO32730@opensource.wolfsonmicro.com>
References: <1434435799-26829-1-git-send-email-zidan.wang@freescale.com> <20150616121839.GM32730@opensource.wolfsonmicro.com> <20150617085828.GA17972@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150617085828.GA17972@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 17, 2015 at 04:58:30PM +0800, Zidan Wang wrote:
> On Tue, Jun 16, 2015 at 01:18:39PM +0100, Charles Keepax wrote:
> > On Tue, Jun 16, 2015 at 02:23:19PM +0800, Zidan Wang wrote:
> > > Add dapm kcontrols to select left/right ADC input source, one to select
> > > the left ADC input source and one for the right ADC input source.
> > > 
> > > In default, the left ADC will select the left input, and the right ADC will
> > > select the right input. When the left(right) ADC select the right(left) input,
> > > the left(right) input path will be powered down.
> > > 
> > > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > > ---
> > > -	{ "Left ADC", NULL, "Left Input Mixer" },
> > > -	{ "Right ADC", NULL, "Right Input Mixer" },
> > > +	{ "ADCL Source", "Left", "Left Input Mixer" },
> > > +	{ "ADCL Source", "Right", "Right Input Mixer" },
> > > +
> > > +	{ "ADCR Source", "Left", "Left Input Mixer" },
> > > +	{ "ADCR Source", "Right", "Right Input Mixer" },
> > > +
> > > +	{ "Left ADC", NULL, "ADCL Source" },
> > > +	{ "Right ADC", NULL, "ADCR Source" },
> > 
> > Are you sure this is correct? My reading is that those bits don't
> > affect routing at all, they mearly determine how the channel is
> > sent out on the AIF.
> > 
> I have tested on my board, it can works, but it has something wrong.
> 
> If set "ADCR Source" to "Left", RINPUT1(RINPUT2 and RINPUT3)->"Right Input Mixer" will
> be powered down, but "Right ADC" is still powered up. Do you have some best method to 
> set the audio route?

I think your last patch that didn't touch DAPM for this was
closer to correct, I would revert back to something similar to
that but fixing up for the other comments on it.

Thanks,
Charles
