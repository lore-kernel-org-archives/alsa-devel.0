From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 18:36:46 +0100
Message-ID: <20130723173646.GL9858@sirena.org.uk>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
 <1374583782.2475.26.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1993925141363802897=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC9D26510F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 19:36:56 +0200 (CEST)
In-Reply-To: <1374583782.2475.26.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1993925141363802897==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q6M0GVIna3Wg/yP0"
Content-Disposition: inline


--q6M0GVIna3Wg/yP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 01:49:42PM +0100, Liam Girdwood wrote:
> On Tue, 2013-07-23 at 11:12 +0200, Lars-Peter Clausen wrote:

> > Add methods to retrieve snd_card and soc_card from dapm context.") but have
> > remained unused so far. Considering that the dapm context actually has a direct
> > pointer to the card the functions also seem to be unnecessary. E.g. the
> > expressions 'dapm_get_soc_card(dapm)' and 'dapm->card' yield the same result.

> Peter may have a user for these, but maybe not ?

We can always add them back in later if they get a user.

--q6M0GVIna3Wg/yP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7r8rAAoJELSic+t+oim9o2QP/iSaj+bQmumchBK6xdlhKmom
5dBJImL49NwhzYplZ3OKzliagOYRu4ysJiJCPbUESOhYoAvDI6BY67iGIjElIaRr
zHhWkVyl23J9uQl/70ImOAJBX+evWNQTqy/cG6prwTzG7ygR3oLjya00lMz7O9qh
WyGaJcx7l/WkOA/kiO0EEuFkjWiJAQlIDULE/9bYwEyLcbUJSefqyGF/Gt6odtm9
YJRzOJw5soqQH3BjsMk+aYD4onrmRAksNdA7Pl76Qt87rD30kOaJIhfr+xtwh6lq
kEtkD+riGS6E4UWRVvYOiIbPHK1bOWi8Jp7eGYqhqtyzgjZVF9D0cbFEt+vbGLnk
yLfx9knsSafPkDZL1eXFEP7PyaZC7DkznMJFMlkq0vB8eI+knez/RKBEP0lGIMnC
CfbSTf9tmqYMbnbKDswgwI4tPKCr8J9e+JVS+Dv/hxWCOQxuTz75bf4tiqp/Sy6p
deYUZGrXquj2jY2xfkP6p1LGebzgVaKILXT7VPM4bXZe0A1Q/nK50pge1e1yPzYx
WB58i9PhSe3N+vOc7OfbFUVC9249uQhOC+6qVyMPD7NhHDxuwaEs1y30oG9XikVu
EGEx6KHYRrENKR4Jm99jPwgGgBlg4Z8V+QV0rRtNvCoCPThuBxtPHAftF2YD4Fgu
UnxS+5rHtbyJz6KPBYdp
=gYPn
-----END PGP SIGNATURE-----

--q6M0GVIna3Wg/yP0--

--===============1993925141363802897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1993925141363802897==--
