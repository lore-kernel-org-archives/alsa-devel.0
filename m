From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH] ASoC: soc-core: verify Sound Card normality
Date: Thu, 30 Mar 2017 22:53:34 +0100
Message-ID: <20170330215334.zwashvjerpfnkk3u@sirena.org.uk>
References: <87vaqsajo0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x3oel5pzutyrre33"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87vaqsajo0.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--x3oel5pzutyrre33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29, 2017 at 02:45:37AM +0000, Kuninori Morimoto wrote:

> To avoid Sound Card crash in (2) case, what we can do now is, add dirty
> flag on Sound Card, and avoid to open Sound Card.
> This patch solved this issue.

I think this is a good direction to at least start to mitigate these
problems (which we really should be doing) and hopefully make it easier
to do further improvements in future.  There's obviously more places
where we should be checking the flag (controls for example) but they can
be added later.  One thing I would like to see is instead of setting the
flag directly when we see a problem call a function to do it.  That way
if we want to improve things in the future we can do that without having
to update the callers again.

--x3oel5pzutyrre33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljdfl0ACgkQJNaLcl1U
h9Bn/wf/SQnRbtCKRBktxq/cFG2p+1HRJsgl0XCHKwZmKyeQxq8v9Bz0o+GTPP6Q
VdN4B3TmWvRadr3YoEVjVIPUyCO4WVFtIt6sr+DhXY8pplw00jN5HADgMbBJ0mv7
3SpJJTXOOPqtv49PLRC1c3VOIIjBaWFDNME8O95tW9CUvP5VUae24zanrTdvPScx
av5fFkOgZH5nGj6qYdHrDme5U4Xipn3NpdDlNDW6VFmZjJIopF4jmerQz4rht6mP
AQoJucsywi8rV8WBbYba/toHU3+YcWJ01oGO78q0xW72JcTR4E5GNB3IofGDUlp0
oMLuRyTM76Xs9+OcNA818ZfRd83Wng==
=wdxb
-----END PGP SIGNATURE-----

--x3oel5pzutyrre33--
