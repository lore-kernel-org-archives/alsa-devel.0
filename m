From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Use core for applying
	symmetry constraints
Date: Tue, 3 Dec 2013 15:06:33 +0000
Message-ID: <20131203150633.GY27568@sirena.org.uk>
References: <1386015982-11346-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1326742963394121894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AFF6265200
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 16:06:39 +0100 (CET)
In-Reply-To: <1386015982-11346-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1326742963394121894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tupxyn/Ev+fVxhuX"
Content-Disposition: inline


--tupxyn/Ev+fVxhuX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 09:26:22PM +0100, Lars-Peter Clausen wrote:
> Let the core take care of applying sample rate and sample bits constraints
> instead of open-coding this in the driver.

Applied, thanks.

--tupxyn/Ev+fVxhuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfN2AAoJELSic+t+oim9x+4QAJe+XHuhtpMsZ4PcZz8owFIC
G8+nN/vg0eQrP4+MExu4BRBJIIFTz0BBrYJ8f76UnUyj+x5sLRXj7UTzHkKs6VO+
UlhwTVOdrlBOaE3M3sxZ/wwTKhW4cY/hVC6zELMPKkeUVgbhb9f+xTfVje+wU4Ft
G3WFtVtKUihajVIiygxLo6AdSpLH5ULnO2ozC+G3CgkceaFnRq4+Efm8gWGyWbj3
EO5CDU1tRlmZ5s3MhfwORwBQZcTh0M5b6W/2Wgm8b4XDFB+sICTlWAcc1uT5WjC/
kXUMFI8Hg+/BZoCSJZpX1TRsnO4J/EmLwz7T+OSgrm3crIG3doaXtGQ/TMEWjfMU
AKCjSqly62z6B2z4k6EpGx6emMwLZ2UYVCYS/PVkAFt3RNcOroILKRnus+5Y/NFw
eQqZ/fTQa8XZxLxCowRIhKPkRL+KFxLqaGLvtbOPBpf530km0BhNEyv2cYe4SsJa
lciUDznOE7KoGikejruZaKZgtTsxfQ5LaI/z1xUW3wmmZu3jJg+o3gN8EVIGxQjl
/ToBDUx/TeXVR3UjGAB4lrYhEgu9AAB7kFkG47E/b8AhexC7F7e3Z17mUzsDTS2Z
uSNs//HVkOfQctIy7LqxXjAgZVcyuyzaruXJUCIPHzPDPMvsS6eB72nZqrDuCm3a
HiGTaV4Q7Vr9kQi/B70T
=0qst
-----END PGP SIGNATURE-----

--tupxyn/Ev+fVxhuX--

--===============1326742963394121894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1326742963394121894==--
