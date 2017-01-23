From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: cs35l35: Add support for
 Cirrus CS35L35 Amplifier
Date: Mon, 23 Jan 2017 14:38:46 +0000
Message-ID: <20170123143846.GA1754@localhost.localdomain>
References: <7566bac5-e4c4-49ff-91b3-bcd578cef21b@EX3.ad.cirrus.com>
 <20161221105350.GR1867@localhost.localdomain>
 <alpine.DEB.2.10.1701230754300.32562@heelroid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1701230754300.32562@heelroid>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2017 at 08:02:34AM -0600, Brian Austin wrote:
> On Wed, 21 Dec 2016, Charles Keepax wrote:
> > > +		break;
> > > +	case SND_SOC_DAIFMT_PDM:
> > > +		cs35l35->pdm_mode = true;
> > > +		cs35l35->i2s_mode = false;
> > 
> > Feels a bit redundant to have both of these if they are only ever
> > a logical inversion of each other.
> Certain features are only available in these modes and once TDM is added 
> will make it easier to adjust settings based on mode
<snip>
> > > +			};
> > > +		} else {
> > > +			/* Only certain ratios supported in I2S MASTER Mode */
> > > +			switch (sp_sclks) {
> > > +			case CS35L35_SP_SCLKS_32FS:
> > > +			case CS35L35_SP_SCLKS_64FS:
> > > +			break;
> > > +			default:
> > > +				dev_err(codec->dev, "ratio not supported\n");
> > > +				return -EINVAL;
> > > +			};
> > > +		}
> > > +		ret = regmap_update_bits(cs35l35->regmap,
> > > +			CS35L35_CLK_CTL3, CS35L35_SP_SCLKS_MASK,
> > > +			sp_sclks << CS35L35_SP_SCLKS_SHIFT);
> > > +		if (ret != 0) {
> > > +			dev_err(codec->dev, "Failed to set fsclk %d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +	if (cs35l35->pdm_mode) {
> > > +		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
> > > +			CS35L35_PDM_MODE_MASK, 1 << CS35L35_PDM_MODE_SHIFT);
> > > +	} else {
> > > +		regmap_update_bits(cs35l35->regmap, CS35L35_AMP_INP_DRV_CTL,
> > > +			CS35L35_PDM_MODE_MASK, 0 << CS35L35_PDM_MODE_SHIFT);
> > > +	}
> > 
> > This if could be combined with the one above since pdm_mode ==
> > !i2s_mode.
> 
> Got it thanks

Probably best to ignore that comment given you mention the
addition of more flags and the potential for these to no longer
just be an inversion of each other in the future.

> > > +
> > > +	if (cs35l35->pdata.bst_ipk)
> > > +		regmap_update_bits(cs35l35->regmap, CS35L35_BST_PEAK_I,
> > > +			CS35L35_BST_IPK_MASK,
> > > +			cs35l35->pdata.bst_ipk << CS35L35_BST_IPK_SHIFT);
> > 
> > I believe zero is a valid value for this field, but not the
> > default. Are we happy that the user can never set this value?
> > 
> So here I can just AND in a set high bit that way the check will show true 
> even if 0. Isn't that what we thought would be the easiest?

Yeah seems easiest to me.

> > > +	if (classh->classh_algo_enable) {
> > > +		if (classh->classh_bst_override)
> > > +			regmap_update_bits(cs35l35->regmap,
> > > +				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_OVR_MASK,
> > > +				classh->classh_bst_override << CS35L35_CH_BST_OVR_SHIFT);
> > > +		if (classh->classh_bst_max_limit)
> > > +			regmap_update_bits(cs35l35->regmap,
> > > +				CS35L35_CLASS_H_CTL, CS35L35_CH_BST_LIM_MASK,
> > > +				classh->classh_bst_max_limit << CS35L35_CH_BST_LIM_SHIFT);
> > 
> > This is a single bit, but the default bit is 1, so this code can
> > never change the value of the field.
> This one and the rest apply to previous statement correct?
> 

Yeah would cover this one too.

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
