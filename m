From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/31] ASoC: rcar: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 10:34:54 +0000
Message-ID: <20131106103454.GZ11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-19-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8207769976886966926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A86B32619D5
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:34:57 +0100 (CET)
In-Reply-To: <1383673218-18405-19-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============8207769976886966926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JefYhWJ8RkX3aR0a"
Content-Disposition: inline


--JefYhWJ8RkX3aR0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:05PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--JefYhWJ8RkX3aR0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehtLAAoJELSic+t+oim9T6kP/3XAqCdSBrirb7LA0n9bBONz
Qw3Yuev0UgCi0y3QBIF32aW9aR6JHjdFysdkKdAe5y5pyOQviYNS/yqWe9btMVpE
HeMi0cVEWzIP8AsNgjJy1h8TmBWDmuOgLr6WkTZBF/V4LWDy2XKRuBqg2YZCTYhQ
vZMIfI7LV17M5omRt1FiLFFfOQ3bWFFDpOlaaWcyy7sqLHtLGNR4ODrwwcp12gez
5ON/T4dMaMfWvT6bpb9VpwQWTac3R8F7tFENgd408Ok5cJtQ2nQcwyyk3g3+EKCO
MyqM5JwKB47Go6Q0SJN+FhsrEmDdflyWebm1ohTqbEJoQNdDRaxndbqX0UItaTfA
3XeP/371iT7YeQOA4qgOxDt2XIrPg59rW0YZZ/oHekEwtNg/qI7RgjXMMbsm0M5B
0kGweJlE68VfgCLsH0WD5lpn2d8iNOZWr7mz1RkzDeCm//hBJERWpVYc0YTMGv/P
R36hjEqn25SJ9XcEfH0MgZUhqEAU5DeO6tMmaKEwVzBGma7IdKwXan35Lej16n7C
49UkmgduC5/FZHMoW8/Zcht+Uo4/O+zA3hZCgUvuxug2sAClt3iDG6iAU6L67Xn3
r7frPJawkiIfLPvupx3iUIfKNce1iAFQc/Ul9QEH9w9hR9X3NuCo9rWq79ts8ThN
NkTxkhhjXrlIGshXRazw
=yCxa
-----END PGP SIGNATURE-----

--JefYhWJ8RkX3aR0a--

--===============8207769976886966926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8207769976886966926==--
