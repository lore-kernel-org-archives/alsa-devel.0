From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Tue, 26 May 2015 20:43:16 +0100
Message-ID: <20150526194316.GY21577@sirena.org.uk>
References: <20150522174106.GV21577@sirena.org.uk>
 <s5hsiao32g6.wl-tiwai@suse.de> <20150523055156.GZ3140@localhost>
 <20150525104828.GA21577@sirena.org.uk>
 <20150525112150.GE3140@localhost> <s5hbnh827n4.wl-tiwai@suse.de>
 <20150525135854.GV21391@sirena.org.uk>
 <s5h617f29os.wl-tiwai@suse.de>
 <20150526133256.GQ21577@sirena.org.uk>
 <s5hr3q3cv77.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5861231741771507183=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56154262606
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 21:43:24 +0200 (CEST)
In-Reply-To: <s5hr3q3cv77.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5861231741771507183==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0sfHBSTGnC+DeT4/"
Content-Disposition: inline


--0sfHBSTGnC+DeT4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 03:41:32PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > What are these objects supposed to be then and why does the bus for HDA
> > CODECs know about the differences between them?  They're both called HDA
> > CODECs which might lead one to think that they are supposed to represent
> > the same thing.

> Both legacy and ASoC drivers contain own codec drivers, but their
> classes inherit the same HD-audio core object class that is managed by
> HD-audio core bus.  Meanwhile, since the id table is (still) not
> embedded into HD-audio core object, the match method is still placed
> in each (asoc and legacy) driver core code.

This is still as clear as mud, sorry - why is the ID table not something
that the bus handles?  It seems like a core part of what a bus
abstracts.  Having two completely separate sets of controller and device
drivers that can't interact with each other (which seems like what we're
ending up with here) seems really worrying and I don't think I've seen
any plan for unification either.  It's not just the match function stuff
by the way, some of the later patches also made me wonder about the
mutiple implementations of the bus thing.

I think I'm really not understanding what this bus is supposed to be
doing.  It's possible that there is something I'm missing here (I
imagine there's been some off-list discussions of this) but right now
what I'm seeing is that either the bus is not yet at a point where it
abstracts enough to really be a bus (it's not clear to me how something
would use the bus) or the existing HDA code has been converted to use
the new bus before we're ready to do that. =20

What you all seem to be saying is that the existing code for HDA is too
fragile to touch much so we don't want to move much of its functionality
to the new bus yet.  I can believe that but I think I'd be a lot happier
if we were handling that by having the existing HDA code override bus
functionality rather than by implementing key bus functionality in
random places.  It feels like trying to use the bus now is adding
technical debt.

--0sfHBSTGnC+DeT4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZMzTAAoJECTWi3JdVIfQI0sH/iEjMbohcDYqPLtoNQn4jknl
QrOjkFI304u9mCxCB9KkfElW6NYzuURkoM0/spCtSzCBWuocYcs0plrx/NmlclyB
jZTUquJXwCmM/Hxug1rA0Ox+cKcM9Go33XM7G9wQViJ5s/8gDtVuSQ+I4XL7W2RL
Xn1OZAdC84DA3I1yRQjxjEk2KjsCIqGkNM5pwBOO2py6/cAYEKxUMUqnj/kR9cAh
Hm8lAWJI8P5iCZcLkr8DO5fyROasdDD8wqR3MrZE6BmwUpcg3QSBnj901hSsf90E
Xv/ka2RMU5CqT/kzESV537aS7q0t9LpU883WzkUu9ELYnW7BDmrZNA1pecgFmkE=
=A/49
-----END PGP SIGNATURE-----

--0sfHBSTGnC+DeT4/--

--===============5861231741771507183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5861231741771507183==--
