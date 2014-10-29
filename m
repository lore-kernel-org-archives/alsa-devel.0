From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: Add PM support to the
	HSW/BDW DSP core.
Date: Wed, 29 Oct 2014 20:50:54 +0000
Message-ID: <20141029205054.GK18557@sirena.org.uk>
References: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5765910827149041614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E048F260517
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:51:16 +0100 (CET)
In-Reply-To: <1414604443-7712-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5765910827149041614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6+OJJuqdn5ybvEId"
Content-Disposition: inline


--6+OJJuqdn5ybvEId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 05:40:41PM +0000, Liam Girdwood wrote:
> Add support for PM wake, sleep and stall calls to the core HSW/BDW driver.
> This includes reworking the reset and boot code and adding new calls
> for setting D3/D0 state.

Applied all, thanks.

--6+OJJuqdn5ybvEId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUVMtAAoJECTWi3JdVIfQoJwH/i9bNN/f2gwryEoHe+Fpu0rE
EEtk+P2+u5fo4fz3r5QULb13JmBZNq4psLBaCi7X9ELyw0p+DAg6UeRUgGPSX2IH
wpaxqiEMlxA0Ue0yZomFKpN14bd73AxJHmvqEbMdA1CiXXKlCj+8aIvFnmxkI+wl
O77yDkeDnHvWNIasAunbOXBjfeZiuQYQ0YmXqdZ5Ir6gnaYKPwDadrgtZ4rnyMt4
aV4PvZI50vYlxA9kYs96oYwIfGbq5GUfCAT0wr9AbR1g4sdcGvrFqKMsagGSKvMP
KkS/3091uGzbJM4vuJ80ztzomNae4irloJoFWOBF4DwxL2tGNEM/qURxL3Jk3OM=
=VpUk
-----END PGP SIGNATURE-----

--6+OJJuqdn5ybvEId--

--===============5765910827149041614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5765910827149041614==--
