From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mcbsp: Trivial cleanup in
	asoc-ti-mcbsp.h
Date: Mon, 30 Dec 2013 11:50:11 +0000
Message-ID: <20131230115011.GH31886@sirena.org.uk>
References: <1388380068-31424-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2596998223393505445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E5222261684
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 12:50:14 +0100 (CET)
In-Reply-To: <1388380068-31424-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2596998223393505445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jVH9MMcXWLfwoO6"
Content-Disposition: inline


--9jVH9MMcXWLfwoO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2013 at 10:37:48AM +0530, Sachin Kamat wrote:
> Commit 2203747c9771 ("ARM: omap: move platform_data definitions")
> moved the file to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.

Applied, thanks.

--9jVH9MMcXWLfwoO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwV3wAAoJELSic+t+oim99p8P/3pzOa+MRQ+m3/rrXAE78xyK
fapuiFHo2ZB3sKF5Cd0Gzbv0HZRO9SJaQQl91FfdmD95UwItxNMa4kLTcP2sZNth
ohWR4af6mRFY7nHTaWkbM/UysuTeol9UxGwFDrpkEZIi1nda7GzuenomiP1eC5/b
q3N5gDzeBkJk4szVEf2Hc8D2SPHrBlOVPHPrTinIfdQJN/NrlULPw5GalZeklRUi
Cu6TcYflvssM49cmCYB7s84S3ltRtkeM1b8kyv7a/aUZj5AFBSTeeLPRmGt7I6Yk
P7haZDJXbBOg3J35KjSnDFzET1/8t3sqm5/di+9AnD3Q2Pdawh7R4GjI2MQ9Yyc3
s05SybRu24QZyBKZuxwPK46HGk76mraDASdpqP80usd7LuvQ7NxBUDguwEN4kBKt
GxrumF+ul+cu6lXkbQvQWQXF9TotmnSeyeVhc84GfY36kYsTkYnQHOvYCx2KhM/u
qg3JWYycwxTTCCvSWEb2D/o8zapQAevJGDDm8GeJgubLZpOzN4PpPXSLsvxBh3Hj
r1MduAqZj1fotz0/lby3MvhO31emW4CAuiyOn2RopNgZ9glh2+zllmNvm7KbCR6k
PXpbAfucmKDcEQpLdaHrnAYPKj4bAaXQOQANVOv0B7BkipFQyDxdRXstvT7n9f4C
3iA7x2PAgVHkxNsRGiPS
=rghN
-----END PGP SIGNATURE-----

--9jVH9MMcXWLfwoO6--

--===============2596998223393505445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2596998223393505445==--
