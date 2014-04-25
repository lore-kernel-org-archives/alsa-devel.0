From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: wm8955: Use
	devm_regulator_bulk_get()
Date: Fri, 25 Apr 2014 12:24:45 +0100
Message-ID: <20140425112445.GM12304@sirena.org.uk>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
 <1398389226-18569-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4579997934856722211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC839265382
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:24:54 +0200 (CEST)
In-Reply-To: <1398389226-18569-4-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4579997934856722211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U2xP9uQZMHHnshyX"
Content-Disposition: inline


--U2xP9uQZMHHnshyX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 10:27:06PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as =
we
> do not need to call regulator_bulk_free() in the error and remove paths.

Applied, thanks.

--U2xP9uQZMHHnshyX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWkX6AAoJELSic+t+oim9hkwP/jZFxXf9B8GZyfzMKaH+cpa4
KG3HJK8QraoSXf16tGog+pQeVRIiHOzECeInd9cabYrOVV9Hub+t316GQ4gRyB7g
d80K0uldRyHU+MReSFOeKKnAvxWOG57kgPOpgl+xuZYHcuU9HSi8WYefvYcQQP+d
xGtXZMqRhol1/a82OF9kFbd7eWOMypM43T+RuiZny5bP+voCKaDB+3Gw65mSln8e
RjOqm+QEG2urHHMzhL9kd+wiAmhnMo9ZY8zqSTTRor3vTGfS7h3zgGP+UmLnF+WE
udT/NacXZWPw+nKODQvf5t2DYeqrBCwDQ2Y0K9kq6eZW/Qcr4RiJT+QmohDAoDyp
pegpRb5PTwtiVoLgZlbnQz50JDlyr+Iilni0OjcEragsfWsoFDXRXU7K5QnXe3xD
BpKL/5Ti0zuPFFygk8y+EqO+mn1s9Iwyqq5CNt678gASoAQYpbcHIWgnShhysdsY
rofQn/hzv5KZv+6aJFQetcfxbEwBYl+ZwJ4hYcA2afqlErQSlUmYVCujKRk70Zwr
3VRjgmtWx2rXiV6b2pqn+Lgk9OhXRd+IYmhY0ggbLzjLrWMNpmozFWSzxB/loyOs
3cBaXdnc9LgWiBpG4hRliXcEgC/aYuM+ScAQLzhHhB+c4cJA4buxigs1gSxXoDZl
NBlulDRrzEoxBWAKOW9q
=9OXa
-----END PGP SIGNATURE-----

--U2xP9uQZMHHnshyX--

--===============4579997934856722211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4579997934856722211==--
