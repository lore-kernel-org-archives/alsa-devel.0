From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: spdif_transmitter: Add DT
	support.
Date: Mon, 29 Apr 2013 21:10:14 +0100
Message-ID: <20130429201014.GF3270@sirena.org.uk>
References: <1366895594-19596-1-git-send-email-marek.belisko@streamunlimited.com>
 <1366895594-19596-3-git-send-email-marek.belisko@streamunlimited.com>
 <517AD46A.2020402@gmail.com> <517E64A1.4020402@streamunlimited.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3589552766148606702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B64982616B4
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 22:10:24 +0200 (CEST)
In-Reply-To: <517E64A1.4020402@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@streamunlimited.com>
Cc: alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, tiwai@suse.de, Marek Belisko <marek.belisko@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, rob@landley.net, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3589552766148606702==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2013 at 02:16:33PM +0200, Marek Belisko wrote:
> Dear Sebastian Hesselbarth,

> >That is very generic and should allow to remove "linux," prefix.

> Not sure if linux, prefix can be removed. I believe (at least what
> documentation said) is that <manufacturer>,<model> must be format
> for compatible.

Yeah, you're supposed to have some prefix.  I guess for stuff that we're
really happy is totally generic we could use "generic" or something but
it doesn't make much practical difference.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRftOjAAoJELSic+t+oim9blkP/2E/DYIxp22J+jhTM0RlpPpx
byIIJ7j0AswDo/cn2qFA8ojvncHHMV8Ow5q3cb1qUfAGJCo3zwJDgkgyd8ERL1Mj
pFfKxkoo6ItsVWQDQEOzrrOti3pUqb4rV34P7QiuvaKybw7LNy1QLuw6reLTjsFX
qH/WLkwFtDzPNLXSY8RdPoFCqmT7+NAec4w/BXFQ8+kY1THkpb36FyIiURECpTY3
RCDGLrNffIVZT3lfZdBSHQbmP8pZ6tBPguugKhd7Iq4xZjneojhzaTnzKsF9/tNF
LX9pCSM3FknOfQKydDIEIIBJxUHNN3W/WSObD6nyaLjBPNi/Gj83leMuA/TvIo4B
QYg0zYddrS36osoGihCZBpY45o3gM9ryd1g5VQrlyuQ2biDJc6ZZu7kRm6rH9HPb
lQAmPV3lDuzqxXN7PwaRKyzac6NuLP9H9AQnS3r78iX0eJQnQF97ql0La0Hg24hz
ph1ZT27+0r4BOd0bsEsEBQWFM6+3BNx+t1mk4lJyZuPfFLzPs/GtHKTLJ7v2yasY
dlap1wi6HODgLC29l0nrB4tKcN30BA2y/Os/+xoV1Gx3TK+EndXIzIa/K2aILRmL
rRDDqdC5cjoZzNlUkAD401CN+l64u9MsYoNRaqA49A6NYTu0Kt3j39FpEvTZeIcj
7HKRltDeI4ruM8uNBTzS
=s4kH
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--

--===============3589552766148606702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3589552766148606702==--
