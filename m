From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] ASoC: pxa: e800_wm9712: Convert to
 table based DAPM setup
Date: Mon, 3 Mar 2014 10:05:14 +0800
Message-ID: <20140303020514.GX2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808776695116687697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3337F265588
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:36:24 +0100 (CET)
In-Reply-To: <1393685300-5307-4-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1808776695116687697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/BvujNCPFVhiGON"
Content-Disposition: inline


--o/BvujNCPFVhiGON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:16PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the DAPM widgets and routes. This on one hand
> makes the code a bit cleaner and on the other hand the board level DAPM elements
> get registered in the card's DAPM context rather than in the CODEC's DAPM
> context.

Applied, thanks.

--o/BvujNCPFVhiGON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+NXAAoJELSic+t+oim9lTUP/i5ntCtdd3OrUyFcncpHU9eQ
geAt3tcQjjx7ph8yv/7MhMGyc9VIqABMENVPilPHbvoXUF/dhoqWxIxSb+V1pTiK
/VT+CHZGU/sV6w1N2+1v7MD9cmhNXL8/F8TaNYNKvTCJc156qP8st0R5i2LBLfI9
+3Cb152DoFVv+d8EC0aL7VehFerxn/CwQ2dFhQUuLRmVF+8zjiaDnSEXzuzfQl1B
QwYxkLItXGbdGtqPorQTEMR8iGh1ONigje+rNvQ4pOxaqjUK+ePOw87SJnEbNYCl
/c/jMUz3DEgYFbyrBVZz4BLjYX3aXQoVQ6W/eZoL43uKqHlwWZKfERDo7Ze/HFft
CE9PyzoI5yb3kwaiNBoLWfynRawe3MIKR3lHF9qMp5QnfGcfCSasRwefee17yk7r
SmFk5K7wmUqjBOOlE1UCHSsjnQD7AX+K9bogyTG2y4wagHkmbgJhixEJivwtEJK6
bBZwOowEHnb/8A84cAmTB9EVM3qqSCMhkHY57jZdn2FyRKRVj+kIXYbJLzlEuY7H
3PE9IS9h56RelXNFWg++WOSyjXUg8tm4rfTS4pm2AFtqMA8wXYleup/C44dqOHdr
jAtZBLojXVzMbbhDGZ0LBURq+nWbfzV6Ql9sdUSYXwaMxCd3uvspvGECcmJgkHOE
ndNlOMPyljHePGWiVpiu
=3Agz
-----END PGP SIGNATURE-----

--o/BvujNCPFVhiGON--

--===============1808776695116687697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1808776695116687697==--
