From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] regulator: arizona-ldo1: Do not control clocking
 from regulator
Date: Wed, 11 Jun 2014 14:54:48 +0100
Message-ID: <20140611135448.GH5099@sirena.org.uk>
References: <20140609150013.GA5229@opensource.wolfsonmicro.com>
 <20140609150435.GE5229@opensource.wolfsonmicro.com>
 <20140609184314.GB5099@sirena.org.uk>
 <20140611105926.GB12074@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uwpcjsn9Jass54ML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140611105926.GB12074@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, sameo@linux.intel.com, lee.jones@linaro.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Uwpcjsn9Jass54ML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 11:59:26AM +0100, Charles Keepax wrote:
> On Mon, Jun 09, 2014 at 07:43:14PM +0100, Mark Brown wrote:

> > IIRC this was deliberately coded in this fashion on advice from the
> > hardware engineers - there was more going on with that register than
> > there might at first appear and some actual sync with the LDO.  I
> > believe there was some different process to follow (possibly just
> > setting this mode all the time) when using an external regulator, though
> > it's also possible the hardware guys were just unsure at the time.

> I have had a good chat with the hardware engineers here and they
> are pretty adamant that the only constraint here is that we
> should never enable SUBSYS without 1.8V being supplied to the
> core.

OK, that sounds like the advice when the device was first produced was
not accurate - might be worth checking your datasheets here.  Might also
be worth updating the commit log.

--Uwpcjsn9Jass54ML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmF+kAAoJELSic+t+oim9gw8P/0yOiJVBA8zIaICfBWlLm+pp
7AnozjuD/SCmAJcmVgX3BrJp2m/pAer6Pzm5NMYR8eXVWIqVl3t9bMrLZ20DRMeF
XxVCe3SyVlQghNF5bk456Wy0AR45OK3ZjJZA0KLync9L72gy1TvMZsUx7QtjeEbx
4wXAFYE9qAeyYKxyfst/eB2dBqm8SAMy38vsxmJbH8JiRCf7C7VhE2p6f5ynJbDc
O/JhZZW0uH7RRzkv9syu1eU8A/tceKcNLhqnyIFbe5JBUqaPIZEXCMa6sojoElYp
FSxgGjs8k5s9shi+efBxSZ8cSzTEMmmw6+HytqWPEQRHVlzz18Lz634j1SE/AQVf
0pWSYR0YPgVbHK/tp5numwm/DzvBe1hrRddDyG+StwhbrJxmCOndgkMRYmrceoxL
b3a5OJHUhZrw4LYMhDqhxqK0oOU+9MOKqsWAXu++AbEKJahSNFYn867zYzHDwK+u
7WnfPx/Y5dCOY8UtV3wX9bkxcSWF9vDv8d+nD1gp5/gYUSc2Cs7HveVlnb7vGtg7
bPiXi7oYWlEuFUwWCAFPWnregEbHYC3JoBBlSyvBU8Gjb5b3qorVM3x2bFuK7mMf
6BiYOQogSjuUU7YuLq6xnxaf4BDmwpZ72lCY0V7aJCM4+82R0o5pSZ/FwOUyANaY
Ive0Vx5IMRWBFk9rZiKv
=4slq
-----END PGP SIGNATURE-----

--Uwpcjsn9Jass54ML--
