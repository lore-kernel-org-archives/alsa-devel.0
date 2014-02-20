From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 005/102] ASoC: adau1373: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:55:46 +0900
Message-ID: <20140220015546.GT2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7437194717197243257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A25ED265645
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:56:35 +0100 (CET)
In-Reply-To: <1392723148-12597-3-git-send-email-tiwai@suse.de>
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


--===============7437194717197243257==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YtRCD/bhhyoMRoJW"
Content-Disposition: inline


--YtRCD/bhhyoMRoJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:17PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--YtRCD/bhhyoMRoJW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWCfAAoJELSic+t+oim9Mm0P/jI8JXZBEAVjXWcA1bEaoaB+
QHm5qMNTkdGW4SdgQrbBCiFz6yBgSl/5xPf0hovEhF/kIZuxxRYnHYm+fcGEMbGj
9etbpDUgzA44V0IbeBK4ONjT64or4BF+6NVOiAksZ+F1cfZfjJDudTHXzEJjd3zG
PtnmC6I5xWRFn/oiXyb+ojT5yAyro6xj6vciDjTX+t1nk9u9/nhBGxZiS8mC/1UR
AaubYpCRJe0JveshocNznI5gUZXlOVNSb6nHJziE4GR6EJLfhlmpCBT0RKiktdnt
Uy2Knrl+J/MuwTl9HnWw9kiJXLDMb/TzVkMip5qIBXTisfOzGFpcy9r1qM9c8IKw
j4kMOWfH878L4Kl3/49zx5CHMu2+IpROnsoGazexg4LiuYSwHjKWz/2u8vPdMYqj
l3S81oE+cTnvMZ2HalFxc5miGhPPiCruocrVKQEBG4+Na6MFkYAhDiJV0nMYFeE0
mZlA1N8FAWmQItT7wjJcSv9RdlsxMPjELQJ06KA9Nin0Q3PufQe6B5ldasjUunwW
zQwWJ84F0mFuUILwl6+n94Kd/9ygHEcyTx1lk+ap9FUQPRBprrFGjXrPbstGn+ZT
tfI14HG0GG+52shMTEVDQGPFD4NaDblrmvuKB2Sjc9b2bY0SzUVXpotfuaM0lePS
0PPSltsIC9e9uf9VcvTX
=xf63
-----END PGP SIGNATURE-----

--YtRCD/bhhyoMRoJW--

--===============7437194717197243257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7437194717197243257==--
