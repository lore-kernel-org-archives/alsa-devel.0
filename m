From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/31] ASoC: wm9713: Use WARN_ON() instead
	of BUG_ON()
Date: Wed, 6 Nov 2013 10:33:01 +0000
Message-ID: <20131106103301.GU11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-13-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2588363620870174644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CC49264F53
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:33:03 +0100 (CET)
In-Reply-To: <1383673218-18405-13-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2588363620870174644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DFFMAMYvrfM3lt66"
Content-Disposition: inline


--DFFMAMYvrfM3lt66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:59PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--DFFMAMYvrfM3lt66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehrZAAoJELSic+t+oim9s7cP/RVmSyjHh1kwfK49EwZzJghZ
zV6guL4SzWggUh6sUqUbsXwZ/B18dwR0WLZwsBXw5B8lsWGXMpFSGb/5lPonujZS
dimbwBwI+h5XI4GPzA8N4CEmghgvvZYJDs9T1jjg3irc2FlJUUm6IT3Saxxv95Qn
XdOw649QgjMxlYKaRPvZ0d6oI2uDCBKCrOUedniGwXdzUC9OC02TJ+M865o92gfb
XMRBwlRc21RHwPcvV24MYdFzlq9uJUMasc4nqj49KtIPISsKLhwRCF/oS2D+vBg/
5VdXwRv8aLu++l1NNkPr5sFynlSAcRnTOcvHQqK2YceATWx160WxFvc+U15Votrx
J4ghNUD0WuJFQoAwL8e9PTTcDzsWLBCK3++FgGBqcr0dwuCW+KmVm2yoDZS9MaGW
oUY1LyTO1u8JF5YtEopzDwmUlb4TO5XWkJ0vcnjBiNgfrJj2Vwg6EHN5GPpuVECD
LH3C2dJViHInjx1Gnwg53q0luLH5UJA3OAVVGGvuwer8AKmzJAW9Z0XkajmrVeum
5FCJGW9lseO392LQg68e+4KHXa/jtqpvVNzspIxxQh7urVO+8vb8mFCXKB4KGtl8
lRc+4DdZCrZ8auh05J2tFeu1oBmwFSMrAkH5bml49E9agfQRrJLan++v2Y/L7nU6
PDBfcB1kjTFTyBx6h4MI
=8UEs
-----END PGP SIGNATURE-----

--DFFMAMYvrfM3lt66--

--===============2588363620870174644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2588363620870174644==--
