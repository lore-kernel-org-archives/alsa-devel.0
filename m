From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: cs42l51: fix mclk support
Date: Fri, 19 Oct 2018 17:06:22 +0100
Message-ID: <20181019160622.GO5895@sirena.org.uk>
References: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7354950602427386755=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1412E26751A
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 18:06:25 +0200 (CEST)
In-Reply-To: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Moysan <olivier.moysan@st.com>
Cc: alsa-devel@alsa-project.org, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org


--===============7354950602427386755==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XMHqbYJb993HXwLR"
Content-Disposition: inline


--XMHqbYJb993HXwLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 05:56:35PM +0200, Olivier Moysan wrote:
> Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")
>=20
> The MCLK clock is made optional for cs42l51 codec.
> However, ASoC DAPM clock supply widget, expects the clock to be defined
> unconditionally.
> Register MCLK DAPM conditionally in codec driver,
> depending on clock presence in DT.

I've applied this but TBH I think we should be doing this in the core -
I actually thought we had handling for that but I can't see it so I'm
obviously imagining things.  It's something that can be done later
anyway.

--XMHqbYJb993HXwLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvKAP0ACgkQJNaLcl1U
h9BF3Qf5AaeJZBaqJoRHji9hqrAa33wqz4EfrAdli0y2nm4Eq4cAeBoOyP757DH8
qzrJB810WvwHfsBEvWxkalsGBYb1wrWGh/zUpg0pmoJW4GbCAUYRxytBOrT6Dmx6
BOEkGD2qLqdLbhN1H2gFSu7D9dleu2SI0P49UjC7PsSnOgH0jMopaezI/upwZ57z
u5AROw2BJtCtb+FUyepG7Igv/znfbydyGrkB34Ta3p4AZMmBih00WzKQePXxVeZr
hROu2OnEBjBi7O7rTcbJ3VhSbSGAGcr713DKPHrliwizS43L0OffKA+RvuuE3Yy8
TxnPBm7bh24YUBeEeME01Y0qurc6ng==
=wR4T
-----END PGP SIGNATURE-----

--XMHqbYJb993HXwLR--

--===============7354950602427386755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7354950602427386755==--
