From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm0010: Set IRQ as a wake source
Date: Thu, 30 May 2013 11:48:20 +0100
Message-ID: <20130530104819.GF5180@sirena.org.uk>
References: <1369904761-8355-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0131132458078577780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BFB14265117
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 12:48:33 +0200 (CEST)
In-Reply-To: <1369904761-8355-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0131132458078577780==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2013 at 10:06:01AM +0100, Charles Keepax wrote:
> The DSPs IRQ should be a wake source as several of the possible
> algorithms may run whilst the AP is asleepi and require to wake the AP
> to push or pull more data, such as compressed playback.

Applied, thanks.

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpy5wAAoJELSic+t+oim9Va0P/ikGQY5haoloGd/b9SzMwmKa
QHAkpXcOttB24xCWv4WglABBcfC3QVx7dNt4Rzujwlt9uYiuTa4PRMttr3I8U2En
KnuHp2JqKdwdiLsg5nJJSwkM7ESgY8pHuGWnMoOUaNz+bUD/gJ9WbQyKRBg3Duzx
AuY0MgwOxSFSr7yNv3BuOZcDtRO9txScGRLMVk9ZyGf9P3D9IImssTBoodvG1mN1
u7AJUpEsdtMRF568HU1iWuj8zW677sOs/9NIWe1aUyuojg/WFA72B5enljk3pHvt
5e7tj0Yrnyae2D+FFoLA9GdBiidbcEBau6mwbeNifPJT+E3LMcvIJFs8s43AIJpE
4chmwmp51P1U+eUgcBieSCe94uMmzI8TPDsgC0c8z8y1XwOnzlYDrqoF3nX7TLQw
GGNT1g8ScA5y+rx/zk+tbmy/gIaJagO3oWPwnKoL098kpYe3+sSzaQyuiDaiYYFM
yQMslwqED7ufyaB7Tmjp9pQZ9Hb3dp6TU9ojegyAmTVun9wzeeijqjgGzspWK/nx
+0G5RaoTHEf1ONO/cOVuQIjxrXRoPvHI/ywSzOK0c+RbLnI4Rjvw+WjKi+FsQEeW
C1FV71t389owqFWFalEKXxBfu47acjeEtMK8aYeX0mZJqvJ/+Txo3un+o8Q438PZ
/Bdk/AitO13a56bauL71
=a5qq
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--

--===============0131132458078577780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0131132458078577780==--
