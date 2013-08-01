From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Fix kcontrol path list
	corruption
Date: Thu, 1 Aug 2013 19:45:11 +0100
Message-ID: <20130801184511.GY9858@sirena.org.uk>
References: <1375358887-9160-1-git-send-email-lars@metafoo.de>
 <1375358887-9160-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5666155658520623106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A4094261698
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 20:45:18 +0200 (CEST)
In-Reply-To: <1375358887-9160-2-git-send-email-lars@metafoo.de>
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
Cc: Olof Johansson <olof@lixom.net>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============5666155658520623106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uwsFMdwXu6g/remW"
Content-Disposition: inline


--uwsFMdwXu6g/remW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 02:08:07PM +0200, Lars-Peter Clausen wrote:
> When calling krealloc for the kcontrol data the items in the path list that
> point back to the head of the list will now point to freed memory, which causes
> the list to become corrupted. To fix this, instead of resizing the whole data
> struct, only resize the widget list.

Applied, thanks - in conjunction with your fix for the list_empty()
check this now boots fine for me.

--uwsFMdwXu6g/remW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+qy0AAoJELSic+t+oim9fXIP/3xQbuwSKigIDvT7uIpgsXaJ
oEWclrxJ5CyAoxGBxeBlhkDe7Sm3PZxzBFk43DXq3y0FStt8+2QW90ieRoNaIM3R
T8LR8t0c+MdNbp1HIbOZkvZ/l9HiQ1ak1PvPw4Urtjln9tQK7DYXV5NAnwx1MY37
xUFWcn1MFftNDhtcmEcJsjosYCSe4+isPBIMHGNukyFxMabgibMqKmE+ChIKSxxI
4RIOihufgZzXTZjl3dwLm+FVUUly/PmGv44GPTwCMxvTaxmA56uaQKGxMSJ7Wl4i
TcH1JIS00k734BJcJzGTYJTloudLqlepQr6O/XK8BARwSZJdrdkt+OlgwiYMLn1q
q2fbKbNVbP0kKDhNsp3zPjaF7dV5miTW0BOsHQ/lxaPQ1pXtjvyKjp0Jc/Skdeev
987XRLcXrieLRAYMzb9m8t7mx7nyP4JsKtzj3fBHVGZw4XLS+ooXmQhw6dO3xG7+
JoMOEvf6YPHgUC67W1BwnfeuWbyR70n0SAq3iEmNx7JGdhOVraaQvlAMKvpGHdhY
LP03l1xv50nvQ5fbUbJmSwHlon7HQRZmT9Uc08LeZIPf5WMfJav7Mb5dqb7TpFIr
yd9VkkYTY5DixY8XKl3EiXjfhG6YJth03XKFykpJwrADh3RyZP8ih1oJ+ftBQP+y
E39YcwTLb/4750XAH+in
=7Y2p
-----END PGP SIGNATURE-----

--uwsFMdwXu6g/remW--

--===============5666155658520623106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5666155658520623106==--
