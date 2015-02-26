From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Keep the ldo2 power
 while "Voice Wake Up" used in the suspend mode
Date: Thu, 26 Feb 2015 11:09:28 +0900
Message-ID: <20150226020928.GX6236@finisterre.sirena.org.uk>
References: <1424856974-18763-1-git-send-email-oder_chiou@realtek.com>
 <1424856974-18763-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5628781152848344664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED8A4261527
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 03:10:27 +0100 (CET)
In-Reply-To: <1424856974-18763-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5628781152848344664==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qmipW+P26gX+7YT5"
Content-Disposition: inline


--qmipW+P26gX+7YT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 25, 2015 at 05:36:14PM +0800, Oder Chiou wrote:
> The patch keeps the ldo2 power while the DSP function of "Voice Wake Up" used
> in the suspend mode.

Applied, thanks.  Please keep the subject lines of your commits well
under 80 colummns so things like git log work well.

--qmipW+P26gX+7YT5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7oBTAAoJECTWi3JdVIfQwikH/jbv05HA12jr34tW9O72l4Mc
GhvT4K4/z2CKrfyNFJyWStPxj9YGi5hdU1itiPATHTAW+vSXIpbTfCORsevbYhpq
1rmi3pe9057FW7hOBqfNCxzSr57FONBBQTSt8ygzyDCD9iL26/izToLdhMEHS2wv
gbhnd2dxtSW4E6DxFO46skO/n4H3eJAcaHlcnZFpSuwSFD7lhAKjqaQwkXvgS6nq
kWDDu7MZZ32cKBBuRKhclQtEufEu1DcLcQreLmMVGPnBB/0WZa+5iER44gsOVZ3O
BHS/CngSZJT6IfquHMBIOlfu7Y8tzZTg+lF8k7i9wUN7pY24TIqOoEYtmY0WDpg=
=mPVP
-----END PGP SIGNATURE-----

--qmipW+P26gX+7YT5--

--===============5628781152848344664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5628781152848344664==--
