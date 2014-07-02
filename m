From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: add driver for Rockchip RK3xxx I2S controller
Date: Wed, 2 Jul 2014 11:23:10 +0100
Message-ID: <20140702102310.GC410@sirena.org.uk>
References: <1404203860-30712-1-git-send-email-xjq@rock-chips.com>
 <1404204458-30881-1-git-send-email-xjq@rock-chips.com>
 <20140701170747.GA15028@sirena.org.uk>
 <53B359FD.3080809@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53B359FD.3080809-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kfx-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2014 at 09:01:49AM +0800, Huang Tao wrote:
> =E4=BA=8E 2014=E5=B9=B407=E6=9C=8802=E6=97=A5 01:07, Mark Brown =E5=86=99=
=E9=81=93:
> >> +static inline void i2s_writel(struct rk_i2s_dev *i2s, u32 value,
> >> > +			      unsigned int offset)
> >> > +{
> >> > +	writel_relaxed(value, i2s->regs + offset);
> >> > +}
> >> > +
> >> > +static inline u32 i2s_readl(struct rk_i2s_dev *i2s, unsigned int of=
fset)
> >> > +{
> >> > +	return readl_relaxed(i2s->regs + offset);
> >> > +}
> > Perhaps use regmap?  The main advantage would be the debug
> > infrastructure, though you could also use _update_bits() to reduce the
> > amount of time spent locked.

> Are you sure? This is a I2S driver, we can write the register directly,
> do not through I2C or SPI bus.
> Write a register is only a few instructions on ARM, but write through
> regmap, it may take a long path.
> I think it will just consume CPU power and make the whole thing more
> complex.
> Could you tell me what benefits we can get if use regmap? Or something I
> just missing?

The main thing is the diagnostic infrastructure, plus the cache if you
find you need that for suspend and resume (which you didn't implement
yet) - that's the main reason things use regmap for memory mapped
registers.  There is some overhead but it's not *that* big.

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTs92LAAoJELSic+t+oim9de0QAIpJDfitV4KZmuWJpXf2qW3r
StUJ7OzJ1eiE+SXAoFhbJ099e4g3czFMrpukLktYrCqfrASt6/9r5GV8AAJirKQV
cVZ9StXmo1ZcLw9QPiHHlfaZeU5ZqdKzuFfYufG/d4PNfkz6Vf+hRJ6VVrL4C4ky
iRsjvJ/MCuolmMJKMgRCL1S8og+MxQCe6kMt8RUz6jxt/5//VtL6WVtMNu2ee+Bx
VcF2IizQLS7JgBE5UTDVIL4ENMGZy82eGjfTPvgGzZIimnSUIm2zWmMip8nuXg2O
QO0mvLfwgoE8ZOsPg7wlT3jfOKIFe1C3zsZPNFqaYRnkXTSHXyDZcaCg//7juh6I
9sj65KDp3USfqcVGuJZCOB/jVy2IJORYxYJfVQNLqLfL5Sv+yilCEJ0iP+uq8RLn
b4+HUxjNBPIuKBFwxQcAbqQir2PTQZRggGBnNBONMMuDmpQxY8kmMwaq1zy8GxZb
OQDAipvE1zaxAPhrd3UfEJAnFMVVfaNjGfUNvSAgqgI4h2ax68wVG685vf+6QxLh
hrH9YjT/qaKlK1Dr3i55s3JJ0vY3KS8Ilzl+0KYHglMBds8sSg3uS6OZTO0uPcqR
uNZBiQzd97z1Pv2KaIMWqfEhKDk5t168tUn8wfb5bPqV2JcXVseM1Yv6SZVosFIK
3GQUR0iwthdOuLNuY9Mt
=mzwd
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
