From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: cs4265: Add native 32bit I2S
	transport
Date: Tue, 28 Aug 2018 19:56:52 +0100
Message-ID: <20180828185652.GJ2414@sirena.org.uk>
References: <20180826225844.13754-1-flatmax@flatmax.org>
 <20180826225844.13754-2-flatmax@flatmax.org>
 <20180827082843.GU32322@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1351843362462405214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 738D726777B
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 20:56:58 +0200 (CEST)
In-Reply-To: <20180827082843.GU32322@imbe.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org


--===============1351843362462405214==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3iqGNvuhWAyawlAA"
Content-Disposition: inline


--3iqGNvuhWAyawlAA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 27, 2018 at 09:28:43AM +0100, Charles Keepax wrote:

> Are you sure this is correct? The datasheet for the part only
> says it supports up to 24-bit audio and I thought the defines
> SNDRV_PCM_FMTBIT_S24_LE and U24 are expected to have 32-bits
> in the slot whilst on the bus.

No, they're not.  They're expected to be 32 bit in memory and 24 bit on
the bus.

--3iqGNvuhWAyawlAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFmvMACgkQJNaLcl1U
h9A8LAf/QJqYqCFgK5INGF801F6hnMCQz49cr6wuY57mmbdd24vkmCoZXnhaqXoh
knNIpVLEYeObf0z/KULo+WL71eoWDIGk2+gZdUjRraDrMoNa3/ZNJyqwHAI6h+LK
+86ayQMbBZ7CzJ37VaCsWquvMwsaH/ZuBv9jV3OHcxI6VL8rwiE/Z31U5Es3hei/
NMKhM5B/JwWECwLsnQWKjx925qT7rIQzkBd30bqE7QiQvUYLrGUJnLbvkG5Y/Na0
HzQawDB8YRN6Bs74w9TOc8VJmJRpascX91PDtBtg12hHtr7IEvNFafDTddJsSt2U
pVkgU+SlFyxIaBEaot1/KLZ1fxMILQ==
=D/U0
-----END PGP SIGNATURE-----

--3iqGNvuhWAyawlAA--

--===============1351843362462405214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1351843362462405214==--
