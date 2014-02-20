From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/17 v2] ASoC: omap: n810: Update locking around use of
 DAPM pin API
Date: Thu, 20 Feb 2014 19:28:09 +0900
Message-ID: <20140220102809.GN2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-13-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L5G5seE8EpYrkPfX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-13-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--L5G5seE8EpYrkPfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:23PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--L5G5seE8EpYrkPfX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBdi2AAoJELSic+t+oim9+0gQAJpTY7gOXkq6GdEpGyTOWkUy
pCRMT9/dKgriNRaRAm/Awfi/ppQl+aDGUFObx4xt8uQcJPdGTcKHrFfu+SMGDMz+
RaOKoQBzH8wOcanRzphmY2Jl+pOG6erekuzkZyPuPnHnQx4Pl5ayudma/DyzyxGE
fJYpInVjGGSFZt/TgQ0lDcz8akeYxQmGlmTXon9MFEhMo05rCjfl54sQRr57q42n
YvcaoF7bIENGLtMwbQ+dOLE1eULrEpBd8t1vesgtMVuWk/bNl1a9fye1rQjne/pD
nJHZAk0sAFHa0AY21QFOUqXdxbaT5OcYut25bpZiMVuuGebdlSMotaKaxD4+d4L3
NvJnF10GqXjrQ98HnP+MtJxlOZoJp/Qb3ujY4fSrCkN+9hqfRIs9X8yhJay0P5W7
U0tTT0cVqK6lFgkhPBBWLHKdlvOptfQ870hpH+DPzNnc9eLFfmw+Zg1c5axWGDSo
zysZN24mXatNTbWYFqSqXKYX7GKGofEwbVWmsYr4ZKWrJcPShKSjwXHYSu656w7/
LsmgzqMoAaRxMyONla+f7SGCITMwlmnp0dL9XIa3FZmtkJkkLSwZme7p8sXN9oDd
fNjRTmIXHUPAnjiSBtbXofpRL/kFXKaxyssYQ1Cu/dCGI+91nRGHCKzZdztofLvr
yr1Q25c+xSNRiEJdk5at
=aFgv
-----END PGP SIGNATURE-----

--L5G5seE8EpYrkPfX--
