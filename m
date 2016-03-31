From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5514: add rt5514 SPI driver
Date: Thu, 31 Mar 2016 09:50:48 -0700
Message-ID: <20160331165048.GE2350@sirena.org.uk>
References: <1457953101-19348-1-git-send-email-oder_chiou@realtek.com>
 <20160329215121.GP2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCEA41@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3948639648200594209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BDEA2666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 18:50:55 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FCEA41@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "pc.liao@mediatek.com" <pc.liao@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3948639648200594209==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ou2/pFdZC1wHLsdF"
Content-Disposition: inline


--ou2/pFdZC1wHLsdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 06:29:51AM +0000, Oder Chiou wrote:
> > > +static void rt5514_enable_dsp_prepare(struct rt5514_priv *rt5514)
> > > +{
> > > +	/* Reset */
> > > +	regmap_write(rt5514->i2c_regmap, 0x18002000, 0x000010ec);

> > This is a *very* big table of magic numbers with what look like system
> > specific settings in there (there seem to be some things routing to and
> > from the ADC, and some clocking setup...).  Are you sure none of this
> > depends on the runtime configuration?

> Yes, it is independent of the ASoC runtime configuration. The table of
> magic numbers is the settings for the voice wake up, so it is not required
> to be run on ASoC framework.

Are you *positive* about that?  There look to be routing things going on
for example which might be system dependant.

--ou2/pFdZC1wHLsdF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/VVnAAoJECTWi3JdVIfQ0fAH/AmZAGAJVq+JITm6qSva6Bm8
pK7HSnEKbt9dKHe0fj33VmGHmXpbQGF9uf20LKU0pN6fU8uevkTqPNT7ekSYk+rz
gndoVu418q6hwQdE6kU5Fv5qLLxzfU722fTh6lE/4S7UTfXWty7a0iN6HonIix17
qjAULEMRONd/fhafOE0iBCA/3wU3o1ZZEt4NrbPsPnVXpRKJxz3H0iDE/5jsgYXk
KhIYEKTHdXwjiuVxUsHA8GBuhivXRLPh64/5w/2j2/pCEzvtLnx6AMIXl4ajrFJk
c83TZjPnkELqvxZjkdQ18FHYBFve0Z4ezf0YbgddpuE5lJvgZBkHJ1VOuN+WlEg=
=jrKt
-----END PGP SIGNATURE-----

--ou2/pFdZC1wHLsdF--

--===============3948639648200594209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3948639648200594209==--
