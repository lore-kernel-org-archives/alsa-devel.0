From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: core: add a helper for extended
 byte controls using TLV
Date: Wed, 16 Jul 2014 22:20:20 +0100
Message-ID: <20140716212020.GY17528@sirena.org.uk>
References: <1405440288-15958-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4695298454967867251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26DAD2654F1
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:20:34 +0200 (CEST)
In-Reply-To: <1405440288-15958-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <Charles.Keepax@Wolfsonmicro.com>, Dimitris Papastamos <Dimitris.Papastamos@Wolfsonmicro.com>, tiwai@suse.de, lgirdwood@gmail.com, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4695298454967867251==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cUjMc5fB5G+GsIM6"
Content-Disposition: inline


--cUjMc5fB5G+GsIM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2014 at 09:34:48PM +0530, Vinod Koul wrote:
> From: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
>=20
> ALSA supports arbitrary length TLVs for each kcontrol that can be used
> to pass metadata about the control (e.g. volumes, enum information). The
> same transport mechanism is now used for arbitrary length data by
> defining a new helper.

Applied, thanks.

--cUjMc5fB5G+GsIM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxuyRAAoJELSic+t+oim9AAUP/iRXsxe9erKXiFj/Ww4LoJL3
UmaDYelDYXTVlzjT6wkLmTWlTsOHMf+AXyPCGmaXc8yn65fER1yTUam9m5V0E5pF
K6InlbwEIeFP4pcFjf/YEwrkvFrMnSbQphlPurzRqcNU6wo+Sp9rANLtRYeUCxH+
COrcmyHuzgALuuMbZrFsY9ocigZlvG8aAaF0y2BoR3e2Ve10xVsvU/gEEXkMXK3O
PhYWAW3wthGbMADTcVHGBBqU/30kDAfsfuk6t8huMLKF+vLyhOf5m6juObQ90ozj
9KYJz/5Xg7WLCIHY41XPtMwTE0tFgK/kl0wAQ/rGKdKjXQdB+izo4gzjTYIz/YHZ
9dD+2rQBa9nAy7yvOHYzQ8B+3iEJ29SdfbeCAFWnoj2Z4B+QFoMpfIWyBKpovpSv
yN1NMZ9Y4togn0DzkpasU0RkUZXowFjcgaZ7PmAZEdd59tTDU9VfOgFGwFFSZJOp
87PiXkPz6KT9gKhoARoLc6uD4mCBRZwW3GSwUVJbcFFZc1xfiRQjObW3cRgv/HLh
rHoVNf4rUf5EIW4zn5Ogq/05ETexahy76I31fYVU9JNr7RKBcixdtoAP2h7sVv29
RHcY3QfRafpDlvBVKOIJrByfHvh7pDUNHwf5hvnfhX7FrCcunc20uRQq6653Q0w5
rJDpkHD9ivRETRJfcw3g
=/dqS
-----END PGP SIGNATURE-----

--cUjMc5fB5G+GsIM6--

--===============4695298454967867251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4695298454967867251==--
