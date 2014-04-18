From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH 1/5] ASoC: alc5623: Add device tree binding
Date: Fri, 18 Apr 2014 20:17:35 +0200
Message-ID: <20140418181735.GB32580@lunn.ch>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-2-git-send-email-andrew@lunn.ch>
 <20140418163351.GI12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140418163351.GI12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2014 at 05:33:51PM +0100, Mark Brown wrote:
> On Thu, Apr 17, 2014 at 05:53:10PM +0200, Andrew Lunn wrote:
> 
> > + - compatible:	"realtek,alc5623"
> 
> You've not added an ID table to the driver for this.

The driver already has:

static const struct i2c_device_id alc5623_i2c_table[] = {
        {"alc5621", 0x21},
        {"alc5622", 0x22},
        {"alc5623", 0x23},
        {}
};
MODULE_DEVICE_TABLE(i2c, alc5623_i2c_table);

which is enough for the i2c layer to load the driver when it walks the
nodes under the i2c bus driver in the DT.

> > +  - add-ctrl:	Default register value for Reg-40h, Additional Control Register.
> > +		If absent, the default is 0.
> 
> > +  - jack-det-ctrl:	Default register value for Reg-5Ah, Jack Detect
> > +			Control Register. If absent, the default is 0.
> 
> I would expect the default for these to be to leave the hardware
> defaults untouched - why is it different, what does setting to zero mean?

The description is wrong. I will fix it. If the property is absent, or
the value is zero, the register is left alone.

    Andrew
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
