From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/31] ASoC: s6000: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:34:34 +0000
Message-ID: <20131106103434.GY11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-18-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0609214521412582995=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C814261736
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:34:37 +0100 (CET)
In-Reply-To: <1383673218-18405-18-git-send-email-tiwai@suse.de>
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


--===============0609214521412582995==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GcSOTaE82DYSpZPK"
Content-Disposition: inline


--GcSOTaE82DYSpZPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:04PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--GcSOTaE82DYSpZPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehs3AAoJELSic+t+oim9/s8P/jON69OD6Kry0NsmOyRJIA/y
CCdRdOy9fmBq274La83naNkTNPtOfq7FGJ7JlALo3IpU8R+6gFPpFF7vDjFEJZHF
R2yNvsZKCnpcI8B4s6iMY9CA49b1xHxAApnQVDHg2fz22VUsOuMkxDl8imHqtQaq
x2U9CVQvBO4V2zZOoanS6FJv9YuL1xwO2qe5sraWVci4Syx9bxYbnKfFL7FA2Y19
Dfdfdm0/c6nyV75OK9n16hjBoVPntQkKdx21i1BfACengh65gyftpVCwiIk4n4Mj
Jevfs+VeB59R2IpmJnuJYrfmT4hbBhomJE1HrIOoV7Z5tOqyLmPC8xSVf63/vJaW
vygupgZYmoE5ieJKxQ7FNfParuju4nMp44u9FfQbJsIzHnDrWsWB4ltwoUymtH5j
+njh3gqXtuXwlas3Q/tPsB8cUfdMOx7y41Y054NHACkCKFs/Cf37CM1gv8Dk1V/H
8MLQI468nsXoBNEURMQkeWICz/clliOV7gSCii9Dslu/W1idOiH9tQhFA/H6gGlN
SMuXZBuLrBJx6P2Im/ZAxcDUWff4RyH2CELyk7MBVLY5L8gqWc1YW9nvupsoin/L
jGRoanhSAm/YcpLGGdFcvBdCGID822XgShFQLFQkF8CBcjUknUt9GRMe6MfhfTlg
L9PhmDKPY5fjSITh/C8l
=xc/f
-----END PGP SIGNATURE-----

--GcSOTaE82DYSpZPK--

--===============0609214521412582995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0609214521412582995==--
