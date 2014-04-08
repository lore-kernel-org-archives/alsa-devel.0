From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add rt5639 support
Date: Tue, 8 Apr 2014 21:21:23 +0100
Message-ID: <20140408202123.GN6518@sirena.org.uk>
References: <1396957200-13647-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7664704751850696801=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37337265567
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 22:21:39 +0200 (CEST)
In-Reply-To: <1396957200-13647-1-git-send-email-oder_chiou@realtek.com>
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
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============7664704751850696801==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 07:40:00PM +0800, Oder Chiou wrote:
> This patch adds the rt5639 support

I've applied this since it's fine in itself however you need to add
rt5639 to the list of OF compatible strings, the binding document and
the list of I2C device IDs.  People doing machine integration ought to
be able to use the correct name for the chip.  Please send a followup
patch doing this.

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRFpAAAoJELSic+t+oim9h8wQAIN9rw/tMT6kvLilkBgAesBV
OXagrFFwO2R3t3hknQfO9WOBUSXHlunPMMTH0TYK037jIOaElWARuE3zX/mYeo2g
x5qQdbA/JDlDiKD1seH5ITZM8O6iKhIY/sAvNhhvtEFGC6bkHQcYgacxb/rgC1S/
/oyYVvSBJU2TP7QcScPeWxI4/YN/bTleqKV3LZEjBmh/tqpj/LEwFBssdmfEQFWY
4+fCUkXfJZEx40cP2Nob4r2otobDCdmcZ4V6Yn4eo3nQx0ZpMlNqIQQvmfOvFsxk
p5onZ5pBt0P6429KmVVHFsFtbTtx38V9idSIVTYVHZLTPqd8LECFtDnFQnySrOKp
WJiAesCAMEtpwRydMXNeO+XDeA6uylty4oJbMbIB4L2ipXdTyWeG6ZjzYiSH7PLo
HRGAeGIgJibevz/YN8v41tfNQKuWwyyHZr6yu0kzowSD2jYI0VmhhIIo9e8YaKAB
ljbap1eVbxzOEEwZRWdOLS2KN8ACMoWQjqBBwVKAaHRTW+KDJh0F5GvnzNXICDxR
jU3F7dFVZC1rg61HRfRuyxgWxQWkLolL0/oWoVWXNnmvsVyE+TyTbAS9nQW1FKo5
tqDfyb/RsAqUQgr6vxR0fQ5KWmJGkjuxoGvRjbZp1UGTNIgOCeUJeHEmmSX7CQZN
YKi5dhAmiKWKv3YntfST
=R2g9
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--

--===============7664704751850696801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7664704751850696801==--
