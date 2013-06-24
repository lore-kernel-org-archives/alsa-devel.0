From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: twl6040: Drop using
	devm_request_threaded_irq()
Date: Mon, 24 Jun 2013 16:06:26 +0100
Message-ID: <20130624150626.GR27646@sirena.org.uk>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
 <1372081326-6917-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5887427877773020245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EC3426501A
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 17:06:29 +0200 (CEST)
In-Reply-To: <1372081326-6917-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============5887427877773020245==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwSwrS9OkH+FvIfA"
Content-Disposition: inline


--rwSwrS9OkH+FvIfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2013 at 03:42:03PM +0200, Peter Ujfalusi wrote:
> We need to free the irq at twl6040_remove() which is called when the machine
> driver has been removed (the card has been removed).
> If we fail to do that, next time when the machine driver is loaded the
> codec's probe will fail since the irq has been already requested.

Applied all, thanks.

--rwSwrS9OkH+FvIfA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyGBvAAoJELSic+t+oim9064P/RqCCVgEVGYLl8IBoOu/R93A
5bsxlThBZ1LsSBzR5xzBsO2k3SqsUxbfpZ/FM0jwy9X8ft1JyTToW6rTtzeb6ryz
K8LWn91k2BAHgoDJljpn4j1wjQi+pOkV7U89UVGikksI0cvNostvJ/T3SISQzwst
FJO8/K2TCpSduXyIBOdyvweZUg0jsK3EtjjctSgNFu7yei0HBibkE0QWJU2x4uZL
xHg6qguAjPV+b9Cjoet0rRDb3hjL+2UGsZe/p2rDQ///y2uu8ul5XXrRb+vL64Ho
yFUaiP7s6P119pdYF/lvBhP9svAtlmSWJqEALyDfu6JT7jCoYBR68SK/2y4Yw35d
KA5aTTkulXHoDAUn7vBtYTGHFDbyzvtTCtjD7h9ozlmNVBGyd/ZXll4g7mrJS89J
VUfMHV++3KN1kAQ5xlfKonNnL2Nh0l50cfJI9S6gSu8IXx3UH+dy2XSELbDE5ipT
23aflYJURC2sCW756jAUuxCbRZPE4r+aJNw7chXV1+6bP0Mdzl7mtifJS9VuTHOm
TzFQXpWivDYU0rcknWT31cRr9ABjN9wC1E61QjLGli/hiGMNtLneMEd9d7J/2UFv
87qbTKrI3lAjrm+8V87Ce1yv477POXG54Oc28pvfW89jYd1mlBQGqcM6+GrFXr4w
GNo/wsLc/Iu43i22YAyB
=Nuzz
-----END PGP SIGNATURE-----

--rwSwrS9OkH+FvIfA--

--===============5887427877773020245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5887427877773020245==--
