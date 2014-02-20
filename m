From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 011/102] ASoC: sta529: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:57:18 +0900
Message-ID: <20140220015718.GZ2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0387420660250742258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DA8E265649
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:57:31 +0100 (CET)
In-Reply-To: <1392723148-12597-9-git-send-email-tiwai@suse.de>
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


--===============0387420660250742258==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hDl4S+7NSo1UGeDS"
Content-Disposition: inline


--hDl4S+7NSo1UGeDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:23PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--hDl4S+7NSo1UGeDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWD7AAoJELSic+t+oim9ZL4P+wXx+QbGtSDRqVrapfPvAb8N
I8qfV4dvVPFrO4ggAzxqt/NtYaG3DsRDiE3xYPzfD4JFqssOz6pgTLxGLIEylr5v
3kgv7xUZZeiOVkpDpbaskpF0hsTa249FvDTUtuSatME0vp9pmoqm9xFDepv7m9oh
G/ONTrqo92E+f8IUMT9H/yZFqDk5wYFXx56N3H+HQCj0bSXD3qOAfkhFWbaOWDt3
nDPG7BrZDEcJUappRtZMX14utVyFxYk1JoMjb4QSueDKx5GI6GVz3RBZp+OJSLFO
BRrIP9aK4CXTu/nSFYwYLUq08fFPfVbgbBVzzpnAcztBXUbe0KCY2j2Hra5wVYb7
cRn4fGpW0X3PzG+xqCbq7NDKyg55ua4tuXITJM0R+uxUUz6HpR3NRRIZIvtbOQ02
NSM6H8BudnNAjkBk0aTjb94GNPJNl9uz2D58D5xPgoT6B4vB5DMpPTEgNmJGrXzr
iKYpVup7AkEAgNgM4HvIGht2zhYKZOwBFlXgZUy2nMCJ2SzohyNQJ/Ww4eODvSMK
QxlwvrJ3n6nrvHQHarVok5JZs3b4KARnsqC4Jg+VSUAWhSvaZaw0k5d3cyDwtToQ
95L4gUeWEeKCUHXuOYp0Itn8JgP4hujaNwLgiNkA8O0zNAUi2/zMJxLvYyJu5P8z
tAoCBKAcq0JciGpQDp7/
=ar/S
-----END PGP SIGNATURE-----

--hDl4S+7NSo1UGeDS--

--===============0387420660250742258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0387420660250742258==--
