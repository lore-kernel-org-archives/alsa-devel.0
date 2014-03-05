From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
Date: Wed, 5 Mar 2014 07:07:03 +0000
Message-ID: <6c950194cf4b40f0a07335a7732290da@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140305062114.GT13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140305062114.GT13126@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
> 
> On Thu, Feb 27, 2014 at 02:08:45AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > > +static const struct regmap_config fsl_ssi_regconfig = {
> > > +	.max_register = CCSR_SSI_SACCDIS,
> > > +	.reg_bits = 32,
> > > +	.val_bits = 32,
> > > +	.reg_stride = 4,
> > > +#ifdef PPC
> > > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > > +#endif
> 
> > Is this really needed for your PPC platforms?
> 
> > If so, I think this should depend on one specified platform, which
> > the CPU is in LE mode while the SSI is in BE mode...
> 
> Since the entire series depends on this patch due to the fact that it
> makes changes throughout the driver we need this resolving to make any
> progress here.  Perhaps it makes sense to restructure the series so that
> this is at the end rather than start of the series?

Yes, that's better, maybe this one need further discussing. 


Thanks,

--
Best Regards,
Xiubo
