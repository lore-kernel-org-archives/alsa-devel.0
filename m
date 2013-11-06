From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/31] ASoC: dapm: Use WARN_ON() instead of
	BUG_ON()
Date: Wed, 6 Nov 2013 16:03:04 +0000
Message-ID: <20131106160304.GA2674@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-22-git-send-email-tiwai@suse.de>
 <20131106102431.GM11602@sirena.org.uk>
 <s5htxfpvlib.wl%tiwai@suse.de>
 <20131106111529.GH11602@sirena.org.uk>
 <s5hppqdvk79.wl%tiwai@suse.de>
 <20131106114836.GK11602@sirena.org.uk>
 <s5hk3glvisi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2864924828536828019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 886CE26516A
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 17:03:08 +0100 (CET)
In-Reply-To: <s5hk3glvisi.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2864924828536828019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 01:03:41PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > The ones in DAPM are mostly about memory corruption; if this stuff is
> > getting confused then there's a good chance that the data structures
> > that it's looking at aren't what they're supposed to be.

> This isn't so easy to guess.  Such a bug is often a memory corruption
> indeed, but it's not necessarily so.  The data can be modified by the
> device drivers that are calling dapm, so everything is possible.
> Driver writers can do anything unbelievable you can never imagine...

If the driver is modifying the DAPM data then it looses anyway.

> Practically seen, using BUG_ON() makes such debugging even more
> difficult.

That's not been my experience at all with these ones, it's much more
common for people to ignore soft failures and then wonder why they get
breakage further down the line.

This is also partly a function of the usage model for these drivers - if
someone is triggering an issue they will almost certainly be doing
development on the system.  There aren't the problems with random system
configurations or unknown hardware that you see with specs like HDA.

> > > Because you must not issue *_POST_* events without *_PRE_* events.
> > > *_PRE_* are skipped for these entries in the previous WARN_ON()
> > > checks.

> > No, that's not the case at all - it's very rare for devices to have both
> > events in the first place.

> Hrm, are you saying that *_POST events can be issued without the
> corresponding *_PRE events, as an official dpam design?  I didn't
> expect such a bad consistency in API design level...

They shouldn't be generated unmatched but it's extremely rare for them
both to actually be used by one widget.  To the extent that they're used
matched it's with the PRE_PMU matched with POST_PMD and vice versa,
though using just one is quite common for inserting delays.  It's going
to cause more harm than good to actively suppress events.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSemgPAAoJELSic+t+oim98M4QAJJdkNwfBU/H5//5EaWHfaHH
3UBOaLQ8ZeEG7jr7QGQECNuavCyBQLT93KpnzPn/0rXpdiMsu/WobP/0OPeHl1Br
2U+uYctSU/wHKrNmKDagXY/ssL4KCFCQpWkZ5T9coD9CXiEMtdb1Iq6ZG6xReKtG
Y7KWlFOzI4QOmM94y2bi/toOFktbCYXMjg7N+d6KGzZslcfXj2t7AupWtNl6Q+YA
JfheR3dwSAnXUOqowGasMCBfCU2+opVePb+OzLSur7UKmsbIEHqx4a+ucRmLNbao
scnuNhmpYEC5JDV+sWDMPf8gX6DHSKbX0jnpVgKNdO9Ob71EcYVlPX/0f0oUDdQz
B834NmfaLfQJRsU8gsy8zA2LYw+pPZiRItxhXdp4XEUmpfxHL1Zy1NQgW0pvD6h4
nLbsjFSgo2b06BAse+p6zaDRAuYbn3PmooYQUKFzkyYJrUMOdPmuG7OaHFEzWniJ
iqys9VrixKXVjaLw6LbIQIRac+qdbLhOQmBOa70j6IJYTBzxODVzVxblhePj6vcE
8N+EG+AZKcOQj7saVwGxXVVjYbaRa4+9Mn198Y5V5JujLF959UM5r+pCJaGO3glx
gP2l135ZzU82tn3kMsVcX10KPiawNAJk9nz28Wnz6Av9PotlvolexR21ZTRktBmB
R4MHWMbOoZCj/RIX/Vpt
=UUF8
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============2864924828536828019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2864924828536828019==--
