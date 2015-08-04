From: Mark Brown <broonie@kernel.org>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Tue, 4 Aug 2015 17:13:35 +0100
Message-ID: <20150804161335.GW20873@sirena.org.uk>
References: <20150714150352.GW11162@sirena.org.uk> <55BC772C.50801@metafoo.de>
 <20150803032128.GO29916@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6891754723208013005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7113D260836
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 18:13:48 +0200 (CEST)
In-Reply-To: <20150803032128.GO29916@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6891754723208013005==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i1KFSYFbl/HTybMx"
Content-Disposition: inline


--i1KFSYFbl/HTybMx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 08:51:28AM +0530, Vinod Koul wrote:
> On Sat, Aug 01, 2015 at 09:37:16AM +0200, Lars-Peter Clausen wrote:

> > Full media controller integration for both ALSA and ASoC. How this can be
> > used to export topology information to userspace and how to for example
> > attach a specific volume control to a specific media controller entity. And
> > maybe also how to de-duplicate similar functionality between DAPM and media
> > controller.

> The recently merged topology core allows us to 'send' the complete topology
> information for a component to kernel drivers.

> So with this we now we have two additional choices:
> - assuming all components use topology framework, we don't need to query, we
>   use the topology information available in usermode. Some more support to
>   parse topology binary installed and show as controls in alsa-lib might be
>   required here

That'd require us to move all the DAPM information for drivers out of
the kernel and into userspace which seems a bit worrying - it's going to
be harder for things that need events and I worry about the effect on
quality of implementation if people stop sending things to get reviewed.

> - do a reverse path, based on dapm and control info (driver will need to add
>   code for linking the two) we add a new reverse API, which tells us the
>   topology information from kernel

That's basically what the media controller API discussion has been.

--i1KFSYFbl/HTybMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwOSuAAoJECTWi3JdVIfQn4gH/3Eyk1qJ/ekb8VJL0i72UtF6
1EAaKoDTctphxLQ9kO9Qpq++2qLQ/tojlFA8W11GbOqikNKmyVxLNycHqWhfhCq+
8lz+SDf96qKWJ0blKxIRMAPSahgTUJUn2UJybQU7gPhutBICnXBNw4nyAG82JPtu
PcDeqyccInb/0nRO3CiLsU7ee610TzUr6SglbSBcX4aYLd9YJTHCReaeU/UbPDYU
5NL+tL78S6MHz4FFNZVviCC5CMKGQnojReHAO0nbxiFYbAsBGKZ8KprOGYtnL2wU
+nPzn3m8lMEjNEPc/MEjB53x4pdjKwiQBQtgNZ9f9vJ/b2mJG20taz5xqVwsjH8=
=r3T5
-----END PGP SIGNATURE-----

--i1KFSYFbl/HTybMx--

--===============6891754723208013005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6891754723208013005==--
