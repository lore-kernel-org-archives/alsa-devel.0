From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: rcar: off by one in
	rsnd_scu_set_route()
Date: Tue, 12 Nov 2013 01:26:13 +0000
Message-ID: <20131112012613.GJ2674@sirena.org.uk>
References: <20131108094610.GE27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7982006873740958222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D1EAE2615AE
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 02:26:20 +0100 (CET)
In-Reply-To: <20131108094610.GE27977@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7982006873740958222==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Content-Disposition: inline


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 12:46:10PM +0300, Dan Carpenter wrote:
> If "id == ARRAY_SIZE(routes)" then we read one space beyond the end of
> the routes[] array.

Applied, thanks.

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgYOyAAoJELSic+t+oim9riIP/3e/M/mBEHTUXuPiERAix4Sw
pmxkuWdRxiZsnakiZHOp5UHxAyBCYM2BwPynNVgl9mQv6+lbmTQZrFsBYy/+8TpT
KN/B9P8BVyYbABq3AcNueoo8++DehjChfFnIQCyA3DfQBSRa4/7PsKQpfyG6jUS9
ZGZxz248sAUT9HnfK4DEL1zM+Frr5WoG6YOTY+1omA8mKDI27T08Ca3SZDOHHj9Z
g0dtGMPIjWHXhFs9+YB72CYtM7SXLVSV4xmxCU94NX5dfUDdObjaaxeMltiOcwNp
JfzHT2npaNIcJ7HfNa0Gw07o4hrayxIdgeNX2YikB7j3AWLgSxqRNc93OuR5FjM+
vlTASxrthLVOaxKb0Rw+5XWaaOp7XbcJNXfzEtn/5lJ5LchDdnVGlaCq+Cdwo+5p
efTcyh9C3gK9gcDZu4KUj+NInO9hl4swBExWrKaJQFgZyQErgdWJ/PQCiKsLpFPi
5BmNegX4XAxB/n28CdWeEMZQOJI1BnQQ/MuH60hMHn08ywx8Ajbx+KjguNXYzJGp
XHgXakmHGXdUw7tQKh9Vc4t4Yv4kzhKOWbj8CU4i39SgZHyqx8AB2UzI7Hrlkri1
3ijLHbrhC6QgLq/SnDFWDi2lHO7fGTdDCKRNlcHyrWGLp+4R+kMAWYhgRtoty0i/
fMk3VeBEwnTFaF+ToMH+
=rxYp
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--

--===============7982006873740958222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7982006873740958222==--
