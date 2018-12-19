From: Mark Brown <broonie@kernel.org>
Subject: Re: [Sound-open-firmware] Loading coefficients for
	Audio IP
Date: Wed, 19 Dec 2018 17:18:47 +0000
Message-ID: <20181219171847.GI8130@sirena.org.uk>
References: <CAEnQRZAr22Yg=zSPJ5LEoqnkSp2dskKVXHiwwW698Ta3Bd_GTQ@mail.gmail.com>
 <15c1ae7e-94ee-64a6-0fad-67b53d70495c@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3947690741245242327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <15c1ae7e-94ee-64a6-0fad-67b53d70495c@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3947690741245242327==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YhFoJY/gx7awiIuK"
Content-Disposition: inline


--YhFoJY/gx7awiIuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 10:26:36AM -0600, Pierre-Louis Bossart wrote:

> 1. how do we download binary tables that are related to hardware interfaces
> or firmware modules?

> In that case the "coefficients" don't depend on use cases but are set in
> stone either at build time or when the device is flashed. They never vary
> once the boot starts. You absolutely do not want these coefficients in the
> kernel, and I can think of two ways of dealing with this case

> 1.a. request_firmware(). If you are using the topology framework, there may
> be a way of adding tokens so that the file names for the coefficient doesn't
> have to be a constant string in the kernel.

This is probably the easiest one I guess.

> In the notes from the last two or three ALSA miniconfs there are mentions of
> looking into other directions such as hwdep:. I must admit I am not familiar
> with this interface so there's some learning needed on my side. Patrick Lai
> from Qualcomm also mentioned a number of times the need to support
> 'calibration' files and I wonder what the need really is.

Yeah, hwdep is where everyone is heading.  Unfortunately it'll need work
in all the userspace tooling for new interfaces.

> I am also wondering if there is a need for reads of large binary data. I can
> see cases where you could extract state information, but this could be

I've not heard that one, indeed even in the cases where coefficients are
very large my understanding has been that there's multiple coefficient
sets in the blob and not all of the blob will actually be used at once.

--YhFoJY/gx7awiIuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwafXYACgkQJNaLcl1U
h9ATaAf+PFDYXKnMCQkY6EP08mofjbglpGXh9JRCGGbkJ20dzmDS6291D6/6vOlS
EBuPyvI9+GEtpWmgQACYzzDf5e/azpbV2J/AsETuS2sbx7s1j2sLoyOkBQRDsCdk
LM5z76vxieAzkIIUzrMWx6c9OYCWDTBXVpIDyit+QhaxNzziEypo9FAhFcgOh4a/
mdv/VkP779g1oa1Ea2E4PqT9Wbjsa+78kUve/ATtFu3esBzCOPyjgY9S9NO9a6d0
SJxUNI08GkQsviOygWetLGculIO2R2SL8xyeNrFRfvcOS6gwEV07kHVjzAyzpWIz
yaY94skqCyGMRh1OCeqOpFtu6CwlMQ==
=Rg2B
-----END PGP SIGNATURE-----

--YhFoJY/gx7awiIuK--

--===============3947690741245242327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3947690741245242327==--
