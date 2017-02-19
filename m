From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cx2092x: Add DT bingings doc for
	CX2092X DSP
Date: Sun, 19 Feb 2017 16:20:49 +0000
Message-ID: <20170219162049.3ezlsqoyagrwfzmw@sirena.org.uk>
References: <1487427991-18174-1-git-send-email-simon.ho@conexant.com>
 <1487427991-18174-2-git-send-email-simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6075530451952186632=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C9B426583C
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 17:21:47 +0100 (CET)
In-Reply-To: <1487427991-18174-2-git-send-email-simon.ho@conexant.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: simon.ho.cnxt@gmail.com
Cc: Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6075530451952186632==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nmld4bnshboqfl4o"
Content-Disposition: inline


--nmld4bnshboqfl4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 18, 2017 at 10:26:30PM +0800, simon.ho.cnxt@gmail.com wrote:

> +  - reset-gpio:  A GPIO spec to define which pin is connected to the chip's
> +                 !RESET pin. If specified, the driver will assert a hardware
> +                 reset at probe time.

The DT people say all GPIO specifier names have to be pluralised so this
needs to be -gpios even if there's only one GPIO.

--nmld4bnshboqfl4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlipxeAACgkQJNaLcl1U
h9A4HQf/UoGhuYpOwFoAM7kUYIirJPurDjuKnmCn/iKQovhDBnBy2g2nWTW7pOA8
Ulh/z9i7iBIi8obmzgswQtgcEp6n2IkRODgcfcyNlsOWmYJlXmsMJVSe/UBap7LK
O6Scwh4bIEQeDDRlf4Ol43s3SnSBEJKbcsQYC1sC+CWWq1LdoPiqhQnMr+haQzNC
eEYDev2tFwZkd/tLcpReebN/a5siForanhrU1NFH0gfI1Wo6j/yIJGzdXbYWB2wP
RdjHrnUbIeXd0HwgMpjEHQ946xH3R2lAuTdtQ6yVCrT43MTM821NKVzhg/D39WO6
JD+ltmDBx81YlVxsLfji9rIr803hFw==
=GUoj
-----END PGP SIGNATURE-----

--nmld4bnshboqfl4o--

--===============6075530451952186632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6075530451952186632==--
