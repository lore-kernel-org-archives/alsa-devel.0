From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S
 input controller
Date: Sat, 24 Oct 2015 07:57:23 +0900
Message-ID: <20151023225723.GO29919@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk>
 <56293472.7000401@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqN4RWvJTb9VNux/"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56293472.7000401-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--tqN4RWvJTb9VNux/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2015 at 08:09:38PM +0100, Damien Horsley wrote:
> On 19/10/15 18:47, Mark Brown wrote:
> > On Mon, Oct 12, 2015 at 01:40:29PM +0100, Damien Horsley wrote:

> > The APIs here all seem a bit odd - for example the enable API taking a
> > register value as an argument (normally reg is a register address BTW)
> > and returning a value but the disable API doing a read/modify/write
> > cycle.

> Sure. It reduces the number of register accesses this way, but the
> difference in execution time is not significant. Would you prefer these
> to both do read-modify-writes?

I would prefer that the functions look consistent with each other and
ideally resemble common register acceess idioms in the kernel.

> >> +static inline void img_i2s_in_flush(struct img_i2s_in *i2s)
> >> +{
> >> +	int i;
> >> +	u32 reg;
> >> +
> >> +	for (i = 0; i < i2s->active_channels; i++) {
> >> +		reg = img_i2s_in_ch_disable(i2s, i);
> >> +		reg |= IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
> >> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
> >> +		reg &= ~IMG_I2S_IN_CH_CTL_FIFO_FLUSH_MASK;
> >> +		img_i2s_in_ch_writel(i2s, i, reg, IMG_I2S_IN_CH_CTL);
> >> +		img_i2s_in_ch_enable(i2s, i, reg);
> >> +	}
> >> +}

> > This all seems to be connected to this, which is itself slightly funky
> > especially in the context of the only user...

> They are also used during hw_params and set_format.

My point is that the flush function has only one user.

> >> +	case SNDRV_PCM_TRIGGER_STOP:
> >> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> >> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >> +		reg = img_i2s_in_readl(i2s, IMG_I2S_IN_CTL);
> >> +		reg &= ~IMG_I2S_IN_CTL_ME_MASK;
> >> +		img_i2s_in_writel(i2s, reg, IMG_I2S_IN_CTL);
> >> +		img_i2s_in_flush(i2s);
> >> +		break;

> > ...which looks like it'll enable everything, then disable and reenable.
> > Plus needing to do a flush on trigger seems weird.

> If the FIFOs are not flushed, some samples from the previous stream will
> be transferred to the user application when the block is started again

Shouldn't we be doing that flush on stream close instead?  If nothing
else the flush is going to discard a bit of data if the stream is just
paused.

> >> +	if ((channels < 2) ||
> >> +			(channels > (i2s->max_i2s_chan * 2)) ||
> >> +			(channels % 2))
> >> +		return -EINVAL;

> > This indentation is very weird.

> Ok. What is the correct indentation for this?

Align the continuation lines of the if condition with the first line.

--tqN4RWvJTb9VNux/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKrtPAAoJECTWi3JdVIfQgsYIAINHYdjg6vp6XDqih/XHxo42
QLxVUK+e2sPsxWrlFeOfX81XPpfkzhN5i5Ocs1BUulVyau9d7EedvL9La1ObBUMK
m2p6BW0eF6n97FJrPPZvTXq6PbCUe5giOIfDS3Ajgq/cDUsnXdpnsSr+M2k8EK7M
IG+6cL0nDhl/vhuAjEjjOYXWpliJKjApa8GlkzqDwq2bBslvmo+qjMAVsr1DRZqK
RUuFQZ2HuQVSasTety5m8p95JGRHYEgx+RCufKT2F4xlvtboEhexWN9HWKw/Nyp3
iDXxrVs6gIV+bH+PC8l2UINVnVf3Jz4jNrWTY+NqzUH/ByvGYSAMzx/jnx9I978=
=hXci
-----END PGP SIGNATURE-----

--tqN4RWvJTb9VNux/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
