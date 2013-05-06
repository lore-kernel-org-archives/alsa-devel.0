From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Mon, 6 May 2013 23:06:50 +0100
Message-ID: <20130506220650.GJ7478@sirena.org.uk>
References: <1367610549-25542-1-git-send-email-festevam@gmail.com>
 <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8346211914204037306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F556260856
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 00:06:55 +0200 (CEST)
In-Reply-To: <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, zengzm.kernel@gmail.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8346211914204037306==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Content-Disposition: inline


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 03:19:27PM -0500, Matt Sealey wrote:

> I have asked before and I will ask again; does anyone have any insight

Not on the list you haven't as far as I can tell...  this is the first
I've heard of any concern about this code, I'd not be surprised if
others were similarly unaware of any concerns.

> The patch came from out of nowhere, and the comments seem to say that
> the LDO gets enabled on every chip higher than a specific version.
> Now, this is totally against the design documentation for the SGTL5000
> which specifically states that using the internal LDO is quite
> possibly the *worst* power consuming case and NOT best practise for
> putting the codec on a design, with the sole benefit being reduced
> external component count.

Are you sure it's purely about power consumption?  A common application
for LDOs in this situation is to clean up noise on the incoming power
supply, improving rejection of noise.  This is mostly irrelevant for
digital supplies but can be desirable for analogue ones.  Of course this
looks like it's being used as a digital supply so...

I have to say your explanation is a little curious, though - normally an
LDO would require an external capacitor and so would either increase the
component count (adding the capactior) or have no effect (if one is
already present for decoupling).  What is the supply for this LDO and
where does the output go?

> What happens if we just take out the internal LDO setup conditional on
> version, and only initialize it if VDDD is missing? Do boards that

If the LDO is enabled and connected to a supply which is also driven
externally that's not a clever idea, the two regulators will both be
trying to regulate the same supply.

> I am not entirely sure how well the commit linked by Fabio would work
> on mainline since if it uses hw_read/write it should also be updating
> the cache with those values to be sure they can later be modified...
> the BSP code does that then fills the cache with the existing values
> afterwards.

That commit is just bogus in the way it interacts with the cache, half
of it looks awfully like it's trying to work around some breakage in the
way the cache was being set up.

> So maybe we don't disable the cache, or it gets ported to regmap, but
> the order should be enable regulators in a non-cached way then fill
> the cache AFTERWARDS - the code at ToT mainline doesn't fix the cache

I'm sorry, this makes no sense to me.  If we know the physical defaults
for the device and we can get the device into that state then we should
have no need to read from the cache.  If we don't know what they are
then they shouldn't be listed.

> after it does regulator/power regs setup, I assume because cache
> filling is now somehow automated in ASoC (and if this is the case,

There is no cache filling to automate, if (as is the case here) register
defaults are provided they're used.

> then the cache io setup needs to be done after regulator/power setup,
> the defaults list/cache needs to be updated for those registers before
> any register caching io is done..). And maybe setting up the regulator
> is kind of pointless anyway (meaning that whole caching/not-caching
> thing just falls away?)

Again this makes no sense, it seems like you're very confused here.  The
whole purpose of the register defaults is to reflect the default values
of the registers.  The infrastructure relies on this being the case,
otherwise it will get confused for example during cache sync when it
decides if a write to the device is required. =20

I think the point that you lost me was your assumption that the
regulator enable needs to be done without the cache.  What makes you
believe that this is the case?

Note that as I said in another post the driver is currently totally
broken with regard to anything that actually powers off the device,
there's never any attempt made to restore the register cache.

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiCl2AAoJELSic+t+oim9bboQAJWgxf98BILRLnnPYkBOIkBE
jrhR2YMZwiEy9qTpxKD3N+yPU5dLR2RezANPfb/8so7meBQ49ccfkrS2tpnNTv3g
OYCTMgpDbH/UOBuKqHZ8mnHOhMNQ2asKvbdZxDDH4ZXmqDAASXinLnSz3FA2dNxw
8hwLAOUFUD0d/i3CEC/AAEsYLD1o9N1GCAQrx4x9ESRM8QPDavBBW6i3vqbMma+h
gpHT85LnJ+YS4QkDNwONcuMl6rEEY+SKNBqNVHQPXjOgYJ7xZEGg3fMzrpvT11z7
V4iJPwNzJSPEnrLvWrkZw5NoHBbO7STkKivBDSBazGgu+Y1BaY6ZAxyGFtxIvEu8
c59bTzD3AdkVi1oJltBlET3V/CZc9neXJwBaTMwwtc0Vx1p6AEoj3uAeS8mtV/sR
VZ8YlClejO4ZVVTrxG7wRJnw8ejrml5PzMpl/OmNCVWOZ1BdbdoBwfHa2RD0cPIs
QRvkeZf+G/yWEEr7G7dIcsuIgDQQucjpXCHCFgaUyIsB1KA9lRh9eLwBkc+xGriL
F+NtZvDtukk3IitUCw4kWIrFyQAu680lNLdnPmQw+sWnU/5pYfTVF/UtzY3iqXWd
/7aI4SO+XFCKxkVoS7c6jDPISSP+FoYjj7l5tQUSraXXakIklEx1cZkpbHPMkvRK
t2Vtp6TqW6Xuaz9EcjSI
=Ky3d
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--

--===============8346211914204037306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8346211914204037306==--
