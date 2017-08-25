From: Mark Brown <broonie@kernel.org>
Subject: Re: Developing a ti-pcm1863 (adc) codec driver
Date: Fri, 25 Aug 2017 14:47:06 +0100
Message-ID: <20170825134706.sthv3xe42laynhbs@sirena.org.uk>
References: <0d6606df-5770-62a0-0187-2abf995b5ff1@gmail.com>
 <15f613ba-a877-630b-9e13-93095c3a219e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6264594726250838070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EE9D266EA7
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 15:47:09 +0200 (CEST)
In-Reply-To: <15f613ba-a877-630b-9e13-93095c3a219e@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr =?iso-8859-1?Q?M=FCller?= <sanj3k@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6264594726250838070==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dmgphxi6njlubvnl"
Content-Disposition: inline


--dmgphxi6njlubvnl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 11:24:24AM +0200, Oleksandr M=FCller wrote:

> >  Use a route, that's the more modern way.
> Would then this be correct?

Yes.

> >  I'm not sure I understand the question here.

> I mean by default the adc takes VIN1 as an input and I need him to take
> VIN4. If I put my switch under sound controls do I have to trigger it, and
> if yes how? The corrected line should look like this?

That sounds like a DAPM mux?

> > This looks like you've got most of a driver here, probably the easiest
> > thing to do is submit it using the process outlined in
> > SubmittingPatches. The code looks mostly fine so this shouldn't be too
> > much of an issue.

> I dont know this process. At first I would want to get it working with my
> hardware before I would begin with a more detailed development with a lot
> more functionalities.

Like I say the process is documented in SubmittingPatches (in the kernel
tree).

--dmgphxi6njlubvnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmgKlkACgkQJNaLcl1U
h9AGUQf/QZyZemav6jSheFG/PrrozDIfZCdlO6tJrZCJic4FzwYxSPmFOisu5SQi
v06mpXoCxQ7LqW875mLsDl5e9rKna5HqxaUMVXxCWD/OEd8SZ32nbVTyR9KDIHcW
MaSaEw+bbckovVeNiZByIkAumtsxV+6cmMEqUBxsFRu8VK+qVc8J/tlDxN3EXpQF
1DLCZ1uBHbQhULoaGBYH948NsickzejIaGvpe2DRNe4PencnwKLBlaAqv9TOoSRt
LZv+TL/bBlUWSFnj1VBjdyBrPgrsw0qYn13IlatP3rCBDF2BGSG2ltxJnVD7snW6
uUMLGIiK7w6C6wmknmLaKHoW0H9s9A==
=oH4P
-----END PGP SIGNATURE-----

--dmgphxi6njlubvnl--

--===============6264594726250838070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6264594726250838070==--
