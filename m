From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 012/102] ASoC: wm8804: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:57:32 +0900
Message-ID: <20140220015732.GA2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-10-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1503328517378209020=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D20B26538B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:57:56 +0100 (CET)
In-Reply-To: <1392723148-12597-10-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1503328517378209020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dEwQdD7sIwWKqM6n"
Content-Disposition: inline


--dEwQdD7sIwWKqM6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:24PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--dEwQdD7sIwWKqM6n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWEIAAoJELSic+t+oim91coQAI8rV5V5Sz+TZOr0g1uOtIWg
kfMJCTbmZgwznH0ts0ik+4edkLdLcKMKHh4wBEb2Jc9KeO6qz3Wu/tEOdh6Y+e+x
G+AoLg3dEV/oXCZD83zaeKJICmNIDsE0NJcp4flza9ir9tNtMdS94cNAUDTOYX2n
rZ57F9RyDj35OgM1wN5bjrhKWjuPvd252lBXHtdJbuCpFcy8gEJGx4gUCJW0WuZk
rPm2g3LIYwTmH3MeEueIuCCXjCKDhBftlxjpg3ybu68zaDQX1oGMStNJpkvA5f0u
XAbfSntjC3cq2BEbJNIBd4K3hvEPj6hjOIH5YfO6oF1BAo0rqsWtWSEGPmXMSnnm
V8RyIEsz9/HntGia7bK4FxABUG04w17QWV60kHRwxkQiLBeR/9H5suawWWnvZPrJ
Qv2E+7CaAMyx8YHOrqPXTHm+kGMtTxaln5tZ+OIVqF/54DAhjsddLWKSCYQ8ccI+
coE6TpUWC7g1CNfIuG8HBunfMr/dLMhZXHQSVgzXA3LlAE+oiLI8bK0bkKy7aTy1
to9yEktyMqLQhOo830OAfmaDicYheC3Wk1F5o0qdsiOm8Aqg/SDGIqyTuxc421Pn
Dxm0EAb9gq0VNdkS3Ydr9yJEdJ+VBS0W1RuKJXd0qaiJfUicKUD3wn67R0ZvM1Ci
ZRC7kXmKIk7DcL+MfefX
=30D/
-----END PGP SIGNATURE-----

--dEwQdD7sIwWKqM6n--

--===============1503328517378209020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1503328517378209020==--
