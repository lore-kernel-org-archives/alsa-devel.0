From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5110: Add in OSR controls for
	OUT5/6
Date: Mon, 7 Apr 2014 10:44:31 +0100
Message-ID: <20140407094431.GY14763@sirena.org.uk>
References: <1396696308-1814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2157536919772716116=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E1F7260799
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 11:44:48 +0200 (CEST)
In-Reply-To: <1396696308-1814-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2157536919772716116==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yAnL4aV/QzGiAmsL"
Content-Disposition: inline


--yAnL4aV/QzGiAmsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 05, 2014 at 12:11:48PM +0100, Charles Keepax wrote:
> There are no OSR controls on outputs 1-4 on wm5110, however when these
> were removed the ones on output 5 and 6 were also accidentally removed,
> but those actually exist. This patch adds these controls back in.

Applied, thanks.

--yAnL4aV/QzGiAmsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQnN7AAoJELSic+t+oim9O/IP/jCl6ClkOwtCSLqMwVwKhU78
9c/262jgi0+J9NXcjDugV1boOyhs5Q1ZmkU3zLN4rAtUCaj4TufIMn2Qt0wjCoOk
srxypPf8agpe4Z0qa+h0p6PsTL8rrcIgFQOju36FWbhdYjrZ4bSapeUxlnltM2NJ
LQOUenX7YaEIMGndLknPiaYLRmeqotx+/Uz8x5dKdzJXdQsuN8GQH+2MRHoVujdK
//9FkI/n8qckRerPPVWL/465w9UVXATvmybsPqfz73SQB+Pw766l+UoGjNdEODEj
oYfMWuu9s9ADXfigITTlkeSBapsBOtBOqbtuh0kS0VokDLfIjtpXkWTcTbMmrenM
TCE9koXzljyG0/P1nTB4cCNCeK07a39P21UG6q9b9tqBlx8KGRPcXOjjI5UfcNAQ
wflMr674Ou/rpMLqdqG/39v94WSb5cjqQFv+7pJLurcRMyx5lSQrOuBxLmv1ts18
p0wB5i+elh3Me9lYcdvXSpaF5z26vpZ+HIATl2iIbENq524zO47ioIEN5cxg31lQ
t8vDrY/lGBXVg8QrtS4zRvSKXJvimjsWWJ3EszcXpBD2G+YriI9apiFsTO8JNol/
/rUtlSuajfaF1aBK2eTXDw4ATO21KB0KSyBKBRCLbJ3LO3ZiJuj1bxSBTLpNLqL+
r0t7sAo9icqvMlUpIWXc
=mhGg
-----END PGP SIGNATURE-----

--yAnL4aV/QzGiAmsL--

--===============2157536919772716116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2157536919772716116==--
