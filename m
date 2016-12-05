From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add pre & post suspend calls
	in bxt machine
Date: Mon, 5 Dec 2016 11:44:13 +0000
Message-ID: <20161205114413.kzjm5w7s6bc7qnig@sirena.org.uk>
References: <1480673024-28608-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5913796494412309254=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8578266C72
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 12:44:20 +0100 (CET)
In-Reply-To: <1480673024-28608-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5913796494412309254==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ytjocpgup6obvmx3"
Content-Disposition: inline


--ytjocpgup6obvmx3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 02, 2016 at 03:33:44PM +0530, Vinod Koul wrote:
> We need to disable jack detection before entering suspend and
> enable it after resume.

> This was essential as headphone jack widget will always
> remain ON if a jack is inserted and this results in no audio
> after system resumes from a suspend.

This needs clarification - a lot of systems do keep jack detection
active during suspend and use it as a wake source in order to have
things like play/pause functionality via headset available.  This sounds
like there's some limitation with one of the drivers in the system that
is being worked around here instead.

--ytjocpgup6obvmx3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhFUwwACgkQJNaLcl1U
h9BNwQf/Qc1cnrzNahiWwDlZqwyscPjH/YHNSBkbxgqjs+9MkujPfhmVAcv54qIf
ZAJYqJPtH4NBS9Wl+u+sudiWfKkkjAGxovr7ZBSwG1dtkTko2g1LP2YAT+UzKGwx
VQv8+TZR7XgWmYiwtgRk56y4qiGZ10AwfVmgvg6kt+yo4vp/m3rcpB0OCILuzrw2
xiI+OIE7xe2Jmf6EBVmHIgVsouC+bKmv9YfZIHxhY7mYz7VJw24EDH1YrO5Dckls
uBK83MuGzDHsGStycMvURot41fAFzip3JWqyMOm4ZSov8XPzjvo3w+BtjCp7I8lO
vuJRahKalvcQKLdRBEe83C1SjTtXxA==
=YTS6
-----END PGP SIGNATURE-----

--ytjocpgup6obvmx3--

--===============5913796494412309254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5913796494412309254==--
