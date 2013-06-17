From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 12/15] ASoC: spear: Convert to use
 devm_ioremap_resource
Date: Mon, 17 Jun 2013 17:20:10 +0100
Message-ID: <20130617162010.GJ1403@sirena.org.uk>
References: <20130617102000.GB1403@sirena.org.uk>
 <1371465657-22981-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3247932807783577571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2439A261723
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2013 18:20:14 +0200 (CEST)
In-Reply-To: <1371465657-22981-1-git-send-email-tushar.behera@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, sachin.kamat@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, thierry.reding@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3247932807783577571==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6/RaK8Cbiy3x9M4"
Content-Disposition: inline


--A6/RaK8Cbiy3x9M4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2013 at 04:10:57PM +0530, Tushar Behera wrote:
> Commit 75096579c3ac ("lib: devres: Introduce devm_ioremap_resource()")
> introduced devm_ioremap_resource() and deprecated the use of
> devm_request_and_ioremap().

Applied, thanks.

--A6/RaK8Cbiy3x9M4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRvzc3AAoJELSic+t+oim9e0EP/0UhBdVI8dyz8+Avw6xsx6G+
NvByUFwaLyw4qWx3PvREyAFuwI+VYFa3eG6LGJtFOTXT92B08BX5phYKa/EEH+6/
lfuHLiuD88ksJDFiCCtRYoYD++7P5DHhR2trz3qgSMNWTUQRowKWyYjMhZhtrdcJ
ScG1djObnBeHsAHAtYvICfcQgbaCjSzbnvtieNsnBpnwpz5Th0jMwxq5BoZDJKUi
cpcpEcGJkxJwWaJcd8+T//OrbFHamNbBQ+fWibU3+wCqtDlNyKu+hSIA9Pgt5H7l
ltVYCwZfzVytUUk7FMtkRc+4UDr8oXIQj9Z/SyZQZWRCAFRqAHDRt5u+gWPgkNmY
nPeODbTCBJtoK2Keoysa+bnle4oxOJPx+8MPRSQ5S0Vgym7fohAJhgitdEMGIWDM
+prJmN9sfT/s+2qMali/eARk5gkXWbxN4SJCjRPeNhPXkG/F5EqmeLOaIMjhJfx7
rHRNXXheUvUsEciUFWFpXSlT1R/bMAavXXYegbeAmSR+CHxju7GOfiMTZRuNCyHb
llzaELdm9fhOqSprCsghex+zcEyEJdGnfPaPbPrjpZrepIU0z2yyEgI81EE7qbi3
dpae+OqDGbhtHi9ybEUXQUbkMXUzO5UDHNCRAzpAmeD7guo1iDXISsWZRO2xvPBt
1DAW/An9QYnlzDdW81Gx
=yL2B
-----END PGP SIGNATURE-----

--A6/RaK8Cbiy3x9M4--

--===============3247932807783577571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3247932807783577571==--
