From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: limitations on number of alsa controls for a card
Date: Thu, 1 Nov 2012 14:25:58 +0000
Message-ID: <20121101142558.GF4413@opensource.wolfsonmicro.com>
References: <1351692451.7077.40.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8124322085207521589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 809AA2616E7
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:26:00 +0100 (CET)
In-Reply-To: <1351692451.7077.40.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Liam <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8124322085207521589==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 07:37:31PM +0530, Vinod Koul wrote:

> Is there any limitation on maximum number of controls we can have.

> I had some platform side controls to represent DSP and adding them made
> some of codec controls to vanish. And looks like if I register these
> platform controls not all codec controls are visible in userpsace.
> Is there nay max limit I am hitting?

Not that I'm aware of beyond sizeof() type stuff which you're probably
still a way away from.  How are you listing the controls and are there
any name collisons?

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkoZvAAoJELSic+t+oim9tBwP/j7qnfRLmSSVx2RsW479ejIn
+XNLk6S9awVwUZoSfYA0VppLpcn11rMy2J8GBd0tWOIX1duOmon0oDJZ/t9vxoTP
7Sax4ao2BwKlbwvpDaDnZQywKUkuhwHAu6l2Rbvno8sH/TVXWg91oE9BEvsdfULj
9RYpf4OT523psFCAye74kcYi3DLqe+8jHbQoIiSsdh/7OiCTnWTYOQyOS0jgbBDZ
cWoQfokh1d+n48xNi7GVW6x4B09nAkHJvkBSxaxGD88H4KC0gha6zlX3KbRVBiuj
iWej3ZgRqC4m76YIyAacxCeTOdxwHeV8T5G/gtkumlPxqh1wuAVKx05uOU4foupu
hSfbr5D3BlM6JGr22a73EJ470xuGwg5S9xxErVBhzww119tyT4I2l8Tm8mm/+MDy
EiVD3O1cvOpvcxzY7yD5XYuH4vsMVREQiNLhQtPWGSDNClLyw+g6v/125Lp3PZME
/oaIC9BKplOqROVyJWM39GVwCxIiD41gkJfj6CwSmhf6bNHZuYwcqbm5x04is4bm
Zbs3HiFQTs1cqJctSBvuTU1lG/VIlC0Ah7rngoj3CslMDM9nvysBbuoB16fl+pn7
pcoKDSZ3sU2+36CgurIjDjJtLPQVZs7+m9jpjP33zMWzdLKzP1Vfu9wwYGLXOGgb
DHhro8i8OeQ+c82jl8be
=Y32i
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--

--===============8124322085207521589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8124322085207521589==--
