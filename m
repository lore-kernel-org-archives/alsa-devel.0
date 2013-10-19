From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: dmaengine-pcm: Add support
 for querying DMA capabilities
Date: Sat, 19 Oct 2013 21:27:56 +0100
Message-ID: <20131019202756.GH2443@sirena.org.uk>
References: <1381237680-32654-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1932472968999235907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 22624262625
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 22:28:01 +0200 (CEST)
In-Reply-To: <1381237680-32654-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1932472968999235907==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="53tfuk7jz6ispOYh"
Content-Disposition: inline


--53tfuk7jz6ispOYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2013 at 03:07:59PM +0200, Lars-Peter Clausen wrote:
> Currently each platform making use the the generic dmaengine PCM driver still
> needs to provide a custom snd_pcm_hardware struct which specifies the
> capabilities of the DMA controller, e.g. the maximum period size that can be

Applied both, thanks.  It seems like if there's issues with the FIFO
stuff we can always clean it up later and this is definitely a step
forward in terms of usability for the API.

--53tfuk7jz6ispOYh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYutJAAoJELSic+t+oim9fuwP/3aJRm1SOOkFnVWtpTp2RjHg
RNxpdVS+O+zhbHzRgwCLppPQlp3mMorIbMNNLAwRkwA1Wg5VK1DgcG372iHjV9xf
dUQR8ho/pLJxFW2tpQG2iZId9iiqoYflKAObAhHx6P4FJaTt2oSX7L1er3b6R+v6
r3GewjFry/H2BiP10BO06CqNpHnPRy6IzRqbOuoQNAsrlZ2tHiBwTdGI0I4/rDiy
KqPpGdfV3ltG4eR9x+25y8jTeLLbNMA1GLPaieNFdDZxxK+nX9g0fMCrZF7ZJw3N
tEoBvcQWpIHScjYMdy7wxNkdGHmAYqwbF+ebEtXo53Ou9iagfOEo/xZZ/5TrKEBH
TZA8sQ60Bw97R6SlaHcAtO9+rnipO+ngfgbk15DBy6OjcqEUOfutFc9XR5maJZ8R
k9fe9JkY4Zhk3EgNV25ZcsEOS+bidOI5rvlPayAURsALd9Gx0XsqPlw/x9IU3f2M
xBKq69UN1b4HNEz6PZc595wvwHOhA9kuE7y8Og+6qR57p9/YBvKipoyQYk0W7rOz
C+DZuTL8bfGstL0dSniYOaBoZz5aMVHqD2f/JDsOH0p3UTbLk7TAQLn21klfcelA
MeytF45Pe8mLPlYDOmxtKZhhXPjfg/weT6QselE6/d32UkGOnLpR4JVHCVfCa/m3
78KGZ285UnAU5YtoRLRD
=yj9z
-----END PGP SIGNATURE-----

--53tfuk7jz6ispOYh--

--===============1932472968999235907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1932472968999235907==--
