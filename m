From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Fri, 1 Mar 2013 18:08:27 +0800
Message-ID: <20130301100820.GU25302@opensource.wolfsonmicro.com>
References: <1631475.f7GPhLiLxV@ganymedes> <8652573.mejjkM8Cr8@ganymedes>
 <512F241F.9080305@topic.nl> <2559045.s5gCxPtNFX@ganymedes>
 <512F5959.9030004@gmail.com> <512F5B1C.4020508@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4746500233710087427=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28A0B265DC7
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:08:57 +0100 (CET)
In-Reply-To: <512F5B1C.4020508@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4746500233710087427==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b3OyYALfe3DXUU4J"
Content-Disposition: inline


--b3OyYALfe3DXUU4J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 28, 2013 at 02:26:52PM +0100, Daniel Mack wrote:
> On 28.02.2013 14:19, Daniel Mack wrote:

> > Be careful with such changes. In general, DT bindings are forever in
> > general, because you can't update all the users out there, and so every
> > binding that has ever existed has to be supported in the future, for
> > backwards compatibility.

> > In this case, we might make an exception, given that for AM33xx, the
> > necessary DMA bits are still not missing, and Davinci is not yet fully
> > ported to DT either. So nobody really uses the driver on this platforms.

> Sorry, let me rephrase that last paragraph:

> In this case, we might make an exception, given that for AM33xx, the
> necessary DMA bits are still missing, and Davinci is not yet fully
> ported to DT either. So supposedly nobody really uses the driver on this
> platforms via DT.

Sounds plausible, though without having seen the actual change I can't
comment for certain.

--b3OyYALfe3DXUU4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMH4NAAoJELSic+t+oim9o6YP/3JojW3GEU7AjpfgXfT/lk6S
Gvd/HKGqOYXECGXDC8mq3xqSJ9IHvLuqxzOO7oV5zEubUMczFVxuip07hk6yp4N8
Qb1XtBvIN3xWlzEVX+pNJTJb2fImCm9C/HDBBrRzlWALWf5dnN6qmXWwJMTprG3n
vme2xtDrRggHi4v3TnSgdjcvCJEnY+T3mBpAiJVCbKV+7+UZTREorsiVg8/e4vsS
GtM2LgSN3LB+bk9Ya4cYXi2Gkr/pS27AiMFR6yY5AGweEA8KNh4frXRtJpYt0jQs
/R0j/TbywO8T48pmywiiD+y50mRlODgy30Qk6BxLXTmLD7R5eQ0AlmSSKtX59qBB
G7SDZKqkblDFOuqNccyPIlQiZnvJaGsyDCX/RrCzMZ9JthFULupVGcUySJbRoWAr
Z6To517GzrsDjEFtoxs3oKw5V9ctWeEvcW0C9Vgz6GD5W31Q6NJV9Tuj5ln32B7G
/78s8tLir860Xkvs0q2bk+MVj1nv32PlP74t2oaM1xTDrTX6Jo/12bh8kuy84mSt
rd03nPw8EU0wOu/A2S8nkDFOagGysJ8zBbohlmRdtbKSHo4LJtmfsqiw0/GHHSI1
4iE3JwP1cYOMFRr98yB7upKnJANbFhWsYIjxAAh8Idn8SBjYwkwEU5+FyDzKy0jn
FSeZWrzeqBbdSi4KriiE
=DwGQ
-----END PGP SIGNATURE-----

--b3OyYALfe3DXUU4J--

--===============4746500233710087427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4746500233710087427==--
