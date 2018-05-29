From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: set cpu dai clk in
	hw_params
Date: Tue, 29 May 2018 12:32:43 +0100
Message-ID: <20180529113243.GD23509@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-2-daniel@zonque.org>
 <20180529111632.GB23509@sirena.org.uk>
 <fd307a0e-483c-6e64-5017-ecdf98814b1d@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8280797155420518901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE5F267663
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 13:32:45 +0200 (CEST)
In-Reply-To: <fd307a0e-483c-6e64-5017-ecdf98814b1d@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============8280797155420518901==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2018 at 01:17:45PM +0200, Daniel Mack wrote:
> On Tuesday, May 29, 2018 01:16 PM, Mark Brown wrote:
> > On Mon, May 28, 2018 at 09:35:01PM +0200, Daniel Mack wrote:

> > > +		if (dai_props->cpu_dai.clk)
> > > +			clk_set_rate(dai_props->cpu_dai.clk, mclk);

> > We're ignoring the return value here.

> On purpose actually. Not all clocks might be settable, and in that case,
> this is a no-op. You think we should bail or warn?

If we need to set the rate and fail to set it then clearly we shouldn't
just carry on ignoring the error.  You might want some more involved
logic there around checking if it's actually a rate change before you
error out, and possibly some logic to carry on with whatever the rate is
and a reduced set of resulting sample rates.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNOlsACgkQJNaLcl1U
h9AnLgf+MyL5eaczJreLHGK/oF99RzVXArQo93MxxaaDOZZiGzqs7HzS+vaYhiuo
HWcm38wA17k7Bk9oaRtMY7mesxf2Ton2bEeUQTuJ+0vwS3Z7g2KeRnWFTBCeTsv6
78FqLUSR4SwLrIE4E3kIP5B0MKCHQj+orJ5Eyl2HzaIXdrwrciuKn0VP6AN0CEG7
LAliYpgoph2PJJV8RMmK6lDTqKdGHjJs/QQlYIsl+Q/rlitbclnO041v3bY296Qf
ljQPsvCLpNwaKye621B3JwBZpdZ1bUIr4jXwcy8ZpjLIcKMlzpOyytkluq4x1Odk
k94BTMVx6iygQ8oNlrGbnszh9uhk4A==
=Ggpl
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

--===============8280797155420518901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8280797155420518901==--
