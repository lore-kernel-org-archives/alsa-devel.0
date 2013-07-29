From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10] ASoC: dapm: Add
 snd_soc_dapm_add_path() helper function
Date: Mon, 29 Jul 2013 18:45:17 +0100
Message-ID: <20130729174517.GA9858@sirena.org.uk>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
 <1375110845-8069-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7220562936105066746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EC5BC264EFA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 19:45:21 +0200 (CEST)
In-Reply-To: <1375110845-8069-8-git-send-email-lars@metafoo.de>
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


--===============7220562936105066746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cZrq4fZnoGmrTPgK"
Content-Disposition: inline


--cZrq4fZnoGmrTPgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2013 at 05:14:02PM +0200, Lars-Peter Clausen wrote:
> snd_soc_dapm_add_path() is similar to snd_soc_dapm_add_route() except that it
> expects the pointer to the source and sink widgets instead of their names. This
> allows us to simplify the case where we already have a pointer to widgets. (E.g.
> as we have in snd_soc_dapm_link_dai_widgets()). snd_soc_dapm_add_route() will be
> updated to just look up the widget and then use snd_soc_dapm_add_path() to
> handle everything else.

I've applied everything up to patch 9, this is all really good stuff.
This one would've been a bit easier to review if the refactoring were
split out from the changes to the users (who could've continued to use
add_route() for the time being).

Patch 10 I want to have a bit more of a think about and probably try
using it in something.

--cZrq4fZnoGmrTPgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9qopAAoJELSic+t+oim9BgQP/2Gi1Wkv25yurjvYHkD9Zxwq
EGD7RyfuJlrcgX/aQ7JTD8V8ezblBKO2eXwk3VNi2cbLBcnCGy01OCydXEUnR5YO
2KgxRzNUMVdZcNe+c6QPGU49hB9CJL7KX30djLO5METV0IDE06ueTD1ezQzVNkiz
CkQ9dac00ydJCvcJC0y6ma77owO4QXxkjFP6fQNTIzd3IZe5hHMroFbyJBZiHpQR
jTPmcLIQ17P23fXTsaHG1Z0zcDyOR+OBZU7L/iHuPAg/pr5Am+mmAiXPcqi7Exy5
MLp6MbhFSbl4RoI0vX/oe2C9651b3kwv0PBbNiOp38+/DTFJZ1DXh5G/Qmevwc9x
o0viTWJVRVWJCgA9I5QMPHl2w6AZVfbIJuekZjubBgIEJjdyS6pZ9VzdDMhRWkAG
UV2TZNTiibFJXeWQxdgbqWrYgwRvruTWNReFZB7sZayVtM1I7xGgovgk1O8kCw/i
4gfXfzx5hrpeaTFdO4mOD6U3JZlsVH8S2G1d7+kSEJtqRCyGn01HKMGKX3nUc9C2
HSQAKcvPbtRI1Q4mxecSphpARseGCbx+Dm4P8B7+Xw7eRUeFIWt9SHWmkiSQOoea
V6+OLNvblaYrHwEcVWgblVZoLMgprRw0k/5bt2HxisV5PQQ4+BeAYXHnurgOUaAL
ldDZ+C+bWdJiC8WnVMeI
=2Wy8
-----END PGP SIGNATURE-----

--cZrq4fZnoGmrTPgK--

--===============7220562936105066746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7220562936105066746==--
