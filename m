From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/9] ASoC: Intel: Skylake: Add pipe and
	modules handlers
Date: Sat, 15 Aug 2015 18:25:13 +0530
Message-ID: <20150815125513.GC13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-2-git-send-email-subhransu.s.prusty@intel.com>
 <20150814213031.GT10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2889523481473780078=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A4DF26084B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 14:53:13 +0200 (CEST)
In-Reply-To: <20150814213031.GT10748@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2889523481473780078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 10:30:31PM +0100, Mark Brown wrote:
> On Sat, Aug 08, 2015 at 01:06:16AM +0530, Subhransu S. Prusty wrote:
>=20
> > start adding building block for handling these. We add resource checks
> > (memory/mcps) for pipelines, find the modules in a pipeline, init modul=
es
>=20
> What are "mcps"?

Million Clocks Per Second. This represents the compute requirement of a
module, pipe and driver needs to track it so that we don't exceed available
MCPS

--=20
~Vinod

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVzzaxAAoJEHwUBw8lI4NHPGUP/jwyDLwjRey/FCog9Gk479Cx
a1lbOcvntHTud0WsldKuGdAdVFQxO7VmqOOPr7ahv8FJ9/vTTFGS86dl5TJe3fW0
WKTWAXZvlVanKdApcENycv7cN8J7895hGi+eLAUceANZV+/q6SLwewRetaKoikJo
C/k91ookzSpSEJsu9C4YV60frBrAbU1hj83gnBS3aqHfDdM9ZVPrTUZO9OC55gR+
kcq9YmeNh60XwiiwFpqa7clUMENZPrzS7LYeYVt5jvWkFXLDzLrrbrrz+htNjB0V
rToZmpCE42eQQJsGYZ4MRsTDNKdgAKlVWKHXXJ1dqNtchynYg4rKMcA+8zldHT5z
k/ArTzSUqPfLoc8eih1QJhFs7hQ7b+m4OPI4rySkJmysq9uZ56mAdD711ujEqV25
fopXuF6t5sEQbc5BsKcTMQ97n/9brOMP/j6cHMeC8FtPuq2vfbf7t/2hhDJYQ2IT
1UAQJnyHaUMaSqucNpID2kJa8JXpWtQEl2RRlB/XhAKdoyKepsWctPYaOcHEu+qp
k0RKXzo2i6GfVnI9GgOyIvybkNcDtWjrZBHVaj5lp/4NN7ZJuNhikMlx0HcqGZ0X
ZR1IwcbGR+NAdMJAS9sAZPM8UvAoczHb+Wf8yzc3eAtLTEqJ/e3YH4NokLJvuhz/
tkXULHQjBonnrEgOvh+U
=XhiS
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============2889523481473780078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2889523481473780078==--
