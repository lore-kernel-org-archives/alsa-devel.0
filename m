From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend] ASoC: wm8741: Fix rates constraints
 values
Date: Wed, 25 Mar 2015 08:27:35 -0700
Message-ID: <20150325152735.GD3572@sirena.org.uk>
References: <1427228002-10214-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3087212886148729792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C8A9265453
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 16:27:11 +0100 (CET)
In-Reply-To: <1427228002-10214-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org


--===============3087212886148729792==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 09:13:22PM +0100, Sergej Sawazki wrote:
> The WM8741 DAC supports the following typical audio sampling rates:
>   44.1kHz, 88.2kHz, 176.4kHz (eg: with a master clock of 22.5792MHz)
>   32kHz, 48kHz, 96kHz, 192kHz (eg: with a master clock of 24.576MHz)

Applied, thanks.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEtPmAAoJECTWi3JdVIfQZLYH/3IA9DWDrBJoi0pJ/tJ/E/XW
hrzq5QhUgrVD62ZC0zANhebZXDftklEMh56lEmVMtg3QlDvAarN7zddS6+eDI37B
e2SRDYpcGpIU4HWFVUGafUDAM5EzF0SYSFDYn8gK76uwjzeBKuGqQFy307/MN64Y
SH9nJ+pEPXdCceqvOuRFnwgkoqSVL0DliKK4DQviI1iFZd6/oGLligQ9PB+7SoBR
NlLDVRstPJb2FimcNabbOLNCiqm8zQk6ShH2yjTEwfxJJbsy2k2VfT7PRphZEiLs
d224giPcgYO2MC+b3tiQt8MlaKFOM5LahLsfdlWDeUQ1lfkq/J7JtqjX5f9LsdQ=
=wH/K
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

--===============3087212886148729792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3087212886148729792==--
