From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/4] alsa: add locked variant for
	snd_ctl_remove_id
Date: Mon, 15 Feb 2016 14:02:24 +0000
Message-ID: <20160215140224.GK18988@sirena.org.uk>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
 <1455538772-24926-3-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3455149297246045684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 271452612DF
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 15:02:29 +0100 (CET)
In-Reply-To: <1455538772-24926-3-git-send-email-vaibhav.agarwal@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============3455149297246045684==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 05:49:30PM +0530, Vaibhav Agarwal wrote:
> While removing kcontrols due to dynamic dai_link/codec removal,
> mutex/semaphore for soc-card/sound card is already acquired.
> Thus, added lock already acquired variant for ctl_remove_id.

Please use subject lines matching the style for the subsystem and
remember to CC maintainers on patch submission.

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwdpvAAoJECTWi3JdVIfQioYH/irzor3MJ86GXAe0QXmr2fKn
OWPRuIeV/j+jQjimyHixv+oXJKZQpkWiIor4bRCGwbzbjtIqHdSql82kwRlqAGyY
kJnpzM9QPf1Tlpvo+zg176R+VRRm2fp2LGENqSlEAnDK3sqriDZP7zIn32PK8qkz
8oC0pnSFPr+selpy0z3mj6sL6727NE3xLFniDEbobm1pT54M8xpv4Z3zO1oy+OOX
Pzjyxg3OXqLvVXhhlqFKyoERjBVDcTXS8lpT6E17d7TkmnlKyoI+rsVBD6WzS9y+
LEDjJLL4WwMxB52Iv7lOPFKYt4Uyqi9m401IFoPFydr4XjlM/6RFAixKuPCMO+I=
=PeOc
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--

--===============3455149297246045684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3455149297246045684==--
