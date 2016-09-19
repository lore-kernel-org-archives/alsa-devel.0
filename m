From: Mark Brown <broonie@kernel.org>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Mon, 19 Sep 2016 13:00:00 +0100
Message-ID: <20160919120000.GM10189@sirena.org.uk>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1210655952724251036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5803A266539
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 14:00:11 +0200 (CEST)
In-Reply-To: <20160919113415.GM8719@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Mylene Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: alsa-devel@alsa-project.org


--===============1210655952724251036==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
Content-Disposition: inline


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 19, 2016 at 01:34:15PM +0200, Maxime Ripard wrote:
> On Mon, Sep 19, 2016 at 12:12:47PM +0100, Mark Brown wrote:

> > Why not just represent those as a separate device?

> I don't know, this seems to be supplies to muxers, mixers, DACs, the
> amplifier (and the amplifier volume too, even though that's not a
> widget), and it looks really intertwinned, how would you separate
> them?

Based on which register map they're in?  They're probably separate IPs
on at least some level...

--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX39M/AAoJECTWi3JdVIfQoB8H/i3/TlQq9fHBKoPTP+A2xXhZ
rrLHYOnvVHOpaF8jHjOZB3HbTdTJiJjlgpksiNGPhYLmM/TE6BrW2ZRCtJNXwfbq
bodXoUw9PEMIiyFz4nlNTB7FPcc9b5vNtI3tiJfVKW23tbFKyv/DSpT7Q+GVI1cY
YYnYZ5S/9Z/CHT/tVF89YsILMob2QsT458nC1tYFjExPEEsAYSnSY9v0iXfMCrjS
6qWYjxd0tUJjMurZhklah9VxQx6nKXQ6K+MGBgznTn1sLNVLjMne+CGYHVZ3Am2H
zyVVPIDtfQnnG0nRZQ25U4GlJOQmYHAIyAQmeyZGqKVcFxE5nSPtBOmbaCf3jcM=
=7Hhh
-----END PGP SIGNATURE-----

--/t6ASE28jIy1gGy9--

--===============1210655952724251036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1210655952724251036==--
