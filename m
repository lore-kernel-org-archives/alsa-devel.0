From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3 v3] ASoC: TSCS42xx: Shorten lines and
 other cleanup
Date: Mon, 2 Apr 2018 16:23:35 +0100
Message-ID: <20180402152335.GQ29239@sirena.org.uk>
References: <20180328150809.GA303@t7-ThinkPad-E560>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5697195737990426365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F667267211
 for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2018 17:23:38 +0200 (CEST)
In-Reply-To: <20180328150809.GA303@t7-ThinkPad-E560>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5697195737990426365==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XMHqbYJb993HXwLR"
Content-Disposition: inline


--XMHqbYJb993HXwLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 10:08:22AM -0500, Steven Eckhoff wrote:
> Shorten lines greater than 80 chars
> Add const to struct snd_soc_component_driver

I only seem to have patches 1 and 2 here (and they aren't threaded with
each other which is a bit odd too).  I seem to recall this has been
happening quite a bit with your patches - in general if you're sending
things you should always send the entire series at once, ideally
threaded together.  Sending things separately makes it very error prone
to try to follow which patches go together.

--XMHqbYJb993HXwLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCSvcACgkQJNaLcl1U
h9CVJQf7B/UelqFwB4MvkQ66X4oZe/I8BRXnG6NHdlEwdSBSDFPMwI3JgNz+KgHB
0L94w8+i3bVq8Nk5XR0B02HH//aevPVyIdXmAqGqudIf6UdROWhL+4/fdqsSWGtZ
K4VayAdw69zvIGaWRxUvh4Nt7oumTjzfciTI7ZC3+vTwz0plhT1Cthcu6j6gHgZ0
6E/hn94e4gIJJenbxJXsVQChYmckKqpBGCuWeql7grawRzn6zzROJ1JpLo9RrfTP
Ai5hH5P6DZUDzgZoUJmeJf6nGvQ2jfJUWdEQkvuIYLxGfVtfV/S2cjBAbDngcxxI
4BrrO0XvfAK6fLDqRrbzU4HMPK05UA==
=WSy+
-----END PGP SIGNATURE-----

--XMHqbYJb993HXwLR--

--===============5697195737990426365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5697195737990426365==--
