From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/13] ASoC: hdac_hdmi: Register widget
	event handlers
Date: Fri, 20 Jan 2017 13:35:35 +0000
Message-ID: <20170120133535.tun4a57dr3pkispw@sirena.org.uk>
References: <1484755493-30595-1-git-send-email-jeeja.kp@intel.com>
 <1484755493-30595-3-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2440572454986638965=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC2A1266725
 for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2017 14:35:45 +0100 (CET)
In-Reply-To: <1484755493-30595-3-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2440572454986638965==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rqr2zdwo67y7p5ho"
Content-Disposition: inline


--rqr2zdwo67y7p5ho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 09:34:42PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> In case of hdmi connect/disconnect or when stream need to be route to
> multiple monitors, corresponding port and audio infoframe needs to be
> reconfigured. Currently all the configuration are done in DAI ops which
> results in silence playback.

This doesn't apply against current code, please check and resend.

--rqr2zdwo67y7p5ho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliCEicACgkQJNaLcl1U
h9Cy0wf+If6EPWR8xrK/dB6RyjQJtcNy0Q9BOqMVznRnzdahoKH7m7Z+3Jh1LTKk
N/06haq7IKh7b7McprFLTFWPpOf/ztbGX3ZKW8Tb0b9y89caVT3RBHG0QYVc79w/
wFAL88RPyfBDvUkY/T7uOKQrODLsLGhxB6lP+B/9wIieuwOipOsS+hkQroR+MAx6
309MsctLNvzI5G9na1gxEe9BO9Tifft7XQnlPpA011dbCtOJWaJ2rrzISCRrHxq8
vlRQTaD1SYEG/wK7dLDsc55DsStdoaPaOqOCi8wx+irE5vAhKjzX3TGZ4DjcXDfh
qIi0rWv/RNfEsO03V6yxRxy0sevRTQ==
=0XAC
-----END PGP SIGNATURE-----

--rqr2zdwo67y7p5ho--

--===============2440572454986638965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2440572454986638965==--
