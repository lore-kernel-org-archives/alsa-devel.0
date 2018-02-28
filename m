From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH,
 alsa-lib] ASoC: topology: Fix bclk and fsync inversion in
 set_link_hw_format()
Date: Wed, 28 Feb 2018 15:59:10 +0000
Message-ID: <20180228155910.GC6722@sirena.org.uk>
References: <20180227203317.17274-2-k.marinushkin@gmail.com>
 <20180227203541.17343-1-k.marinushkin@gmail.com>
 <20180228152403.GB6722@sirena.org.uk>
 <s5h7eqxm8th.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7569773402899554042=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B20F2677AC
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 16:59:14 +0100 (CET)
In-Reply-To: <s5h7eqxm8th.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7569773402899554042==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2018 at 04:29:30PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Should we warn on use of "master" since it's being deprecated here (and
> > might be confusing for users)?

> Maybe.  OTOH, it looks fully backward-compatible, so far, so it's not
> that confusing yet.

Not a compatibility issue, yeah - more just that we've clearly already
got people confused so pushing people to the more explicit name might
avoid further issues down the line.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqW0c4ACgkQJNaLcl1U
h9CCkQf/d8QIiO1QjCJjqFPrJF6ovsKbLDEHCCLPodua2/Nb+xSiI8GejYeTduOC
UtZDWzKE/fGsQopGz20uHITji+FYtYpDF0omdhn3WbQzOR/NZ+LrIcGmY6Qno+y9
P8XxZyDhLT1VEKR+btyBToChkuBB7ORgurXqP8CerITiDlTROgvBaD0Jr82rDvCP
YvkSJ8JZiyIz6cowyqvJygaPl2zmIBW+tolX5Ykkjr0Flh7vx9O7/tvVaiJWzXUR
ueVs3n/9J5VJ9DHt3wtfARW/zTT0sJJiBqbXGLqAXib8zsVXHfwcGW8ZzASwzzEv
0aktJW+6P+mvqlfCJahYfntKjQuU/w==
=Quxb
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============7569773402899554042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7569773402899554042==--
