From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap settings
Date: Wed, 9 Jan 2019 18:46:04 +0000
Message-ID: <20190109184604.GJ10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4577713820405447056=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4577713820405447056==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 12:44:07AM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:

> > +       regcache_cache_bypass(i2s->regmap, true);
> >         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> > +       regcache_cache_bypass(i2s->regmap, false);

> IIRC the flush cache bit is self-clearing. So you likely want to mark
> this register as volatile. If it is marked as volatile, then all access
> to that register bypasses the cache, so the regcache_cache_bypass calls
> are unneeded.

Yes, that should be the case.

> However, looking at the code, the write would seem to be ignored if the
> regmap is in the cache_only state. We only set this when the bus clock
> is disabled. Under such a condition, bypassing the cache and forcing a
> write would be unwise, as the system either drops the write, or stalls
> altogether.

Right, access to a cache only register while the device is in cache only
mode is not a great idea - the usual reason we're in cache only mode is
that the device is in a state where I/O isn't going to work.  One thing
that can work for this if you need the register to be cached (but is a
bit gross) is to do a write setting the self clearing bit then another
immediately after resetting it back to the cleared state.  That works OK
for cases where the bit is a strobe and never retains state, though if
the device isn't operational then needing to write to the register might
indicate a bigger picture logic error (or it could be that the register
map mixes random things into one register).

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QWsACgkQJNaLcl1U
h9Czcgf/WEsr/xgxGR1vWUvTZ6HNUj2DdVfl5O8Fqvyh5XNwHUGt4I8gueUJSoRL
lRSRA1NqnXYhd1S27qKSWtJA4VgRg7bDT/SoD7PFAspmc4R8fZ9yPdKBqqTZB+yv
KCwF2H/u/8LIhGVJtqTpEpmwkmQh+H3he6HLSnDaVRtaqiEQKzD/1gP5NGW5AJdL
SgZsfpsGlefkKglwLqw62e2lnjjqShydhd5p9ciEO51Hc4rJzQgxYQYWTJwZ9jNK
XjGkwyVghD8WtKoEAnwrd7l1JR//Hapv52wmq4oSZ83in8TNXracdM1djPxxizjW
q6G62CFmh8On1d62dbYKwhdZxpQlvg==
=Yhg0
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--


--===============4577713820405447056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4577713820405447056==--
