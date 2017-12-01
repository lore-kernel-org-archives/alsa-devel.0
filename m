From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: hdac_hdmi: introduce macro to
 access HDMI private data" to the asoc tree
Date: Fri, 1 Dec 2017 16:40:49 +0000
Message-ID: <20171201164049.q3egpkfoau446lqj@sirena.org.uk>
References: <1512119602-2416-2-git-send-email-rakesh.a.ughreja@intel.com>
 <E1eKlcI-0001RU-QR@debutante> <s5hindqjydq.wl-tiwai@suse.de>
 <20171201155358.2uz224exbtl4s7q4@sirena.org.uk>
 <s5h1skejv26.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6617330896160426195=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 838CC267CEC
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 17:40:57 +0100 (CET)
In-Reply-To: <s5h1skejv26.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Rakesh A <rakesh.a.ughreja@intel.com>, Ughreja@sirena.org.uk
List-Id: alsa-devel@alsa-project.org


--===============6617330896160426195==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgq4eaqjelydtkmc"
Content-Disposition: inline


--fgq4eaqjelydtkmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 05:02:09PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Fri, Dec 01, 2017 at 03:50:25PM +0100, Takashi Iwai wrote:

> > > Isn't it a RFC patchset?  Please hold on.

> > These just look like useful cleanups to improve consistency and so on of
> > the code - they're nowhere near the meat of the series.

> The first three do just rename, not really cleanups, so they make
> little sense without the rest changes.

Really?  2 and 3 looked kind of neutral to me, and patch 1 looked fairly
clearly useful.

> > Right, I've not touched any of that stuff.

> My concern at this point is that we need to coordinate the common
> branch for the all stuff.  It's a kind of cross-tree things.

Sure, I was expecting this to end up getting pulled into your tree.

--fgq4eaqjelydtkmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohhhAACgkQJNaLcl1U
h9AC9Qf/VyGxn000WR272BwmR6kyPhMGIq77po3wDFod74/nFO+FIhIioIIffmF/
335PrMEVt9kGXGm942TJh+wy+0/pJK1tunFdkTMLSyOd63/4miFVGJT3QYCZdZMV
1iw/FFB380YvRMyhu2sfySxGZQrqHN1Z0zHwE/0A5UlqdxQZbJfCQfXTVTiZxRaT
+AjRWIPpltsqFTo/HP9/pwFIkrlh3xYbYpMzbGwO2yDe/mxPJ0wXFjASdjbGdZwR
/CCiFs7f3PVCn+4Ivln7F1wBoHF5+vi+sk4D/BMkgcoFBYhoshLq2zP0sTDZYiK4
x24g/b8O7lWJv0/fu4KNEEfvKuDbjA==
=ibk6
-----END PGP SIGNATURE-----

--fgq4eaqjelydtkmc--

--===============6617330896160426195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6617330896160426195==--
