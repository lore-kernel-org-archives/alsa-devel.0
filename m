From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v10 2/7] ASoC: codec: wm9712 simple DT bindings
Date: Sat, 27 Jul 2013 15:44:52 +0200
Message-ID: <20130727134452.GF16871@s25.your-server.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-3-git-send-email-mpa@pengutronix.de>
 <20130727115950.GF9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130727115950.GF9858@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 27, 2013 at 12:59:50PM +0100, Mark Brown wrote:
> On Sat, Jul 27, 2013 at 01:31:51PM +0200, Markus Pargmann wrote:
> 
> > +static const struct of_device_id wm9712_codec_of_dev_id[] = {
> > +	{
> > +		.compatible = "wlf,wm9712",
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +
> >  static struct platform_driver wm9712_codec_driver = {
> >  	.driver = {
> >  		.name = "wm9712-codec",
> >  		.owner = THIS_MODULE,
> > +		.of_match_table = wm9712_codec_of_dev_id,
> >  	},
> >  
> >  	.probe = wm9712_probe,
> 
> AC'97 is an enumerable bus, we shouldn't need this...

What do you mean exactly? Is there a way to automaticaly discover
connected codecs and register them?

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
