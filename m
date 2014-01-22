From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Add debug print to note
 that the DSP has shutdown
Date: Wed, 22 Jan 2014 11:45:53 +0000
Message-ID: <20140122114553.GF17314@sirena.org.uk>
References: <1390385351-3154-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2791110633711506052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67D3F261A80
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 12:46:06 +0100 (CET)
In-Reply-To: <1390385351-3154-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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


--===============2791110633711506052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qSUODgShzI+GU3D8"
Content-Disposition: inline


--qSUODgShzI+GU3D8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2014 at 10:09:11AM +0000, Charles Keepax wrote:
> It can be useful for debugging purposes to see at what point the DSP has
> powered down, so add a message to inform us of this.

Applied, thanks.

--qSUODgShzI+GU3D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS369uAAoJELSic+t+oim9HaIQAJPi5kokBz7Kbb3WvghtOWym
UnjRbojE1tmd2l6HnH/d12p81lLaHvAN73bQjJvaS+zWDmzIQfi82ozwGZH557dV
B3qre03Mx00/OQKqruMpnjAdEMGrwZopPp/xzfJOgLxeAZXpyFwMIlEYByodni+Q
2ev9t+wXNubmh4/mwSuFHADood1HhFVKgP+lPmvu2OirbclWWoSmIhPJXylQL3f/
7N1ZSECeNZoqNOWYHNv8cWCB3kcGPdlAyYc1jGYWlG36SU0sboGfHVSJr9xf16Cv
qhUOp89W+lJTeKs2cvwIgI+pdUJLbr1bfqelmXZQzociYDEasOvS+gGNIqOCsfVZ
TsZ9nYwaPsnHbAGJ40OFGhrZ6QKDw941zu4PlaPfRWxNf0MBgBlNVhoOU+Z0KHq7
ydy1p23JChY1wZoyPVHbpOPgGuDLFL2Fk1g3XCF7lqDwemtkkzRBoAeVIVjXeyGe
06pG32weTbWjbAk0nU8Vu0+E7CzumHQHpzosWaOpi7qxW5fS/5KoqBHbwaTSK9+0
bfvcz6CgYOOtpFBuXDG0OxmGcp/RHmh4df2TKJ/4Sp+ZUhZGta/lr6ShrPw5yGHJ
y2fxPMmcQw/Qp0Om7vhpQsg98U8A1tTJ0ZjB6R1uwRodXoYnfp3kypwSg1JaINl1
TTvd4QdFKx+UYRN6Wqeb
=MAVd
-----END PGP SIGNATURE-----

--qSUODgShzI+GU3D8--

--===============2791110633711506052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2791110633711506052==--
