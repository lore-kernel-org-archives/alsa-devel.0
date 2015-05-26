From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: atmel: simplify Kconfig
Date: Tue, 26 May 2015 10:53:06 +0100
Message-ID: <20150526095306.GJ21577@sirena.org.uk>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0327260140986046681=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C76260690
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 11:53:18 +0200 (CEST)
In-Reply-To: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0327260140986046681==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibQy1PD9BIJOeb75"
Content-Disposition: inline


--ibQy1PD9BIJOeb75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 12:04:18AM +0200, Alexandre Belloni wrote:
> Enclose the options in if SND_ATMEL_SOC ... endif to remove the dependency.
> Also remove the useless description for SND_ATMEL_SOC_SSC.

Applied, thanks.

--ibQy1PD9BIJOeb75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZEKBAAoJECTWi3JdVIfQppYH/3nXO8vUVA8xkF4vodPzi2at
LYhQ/QyEyxyTqxUcYYacUCC+4kP9sCxdJMuiQYlnGhOcg3lo0DShWGxL4zrVprdk
8VHJGaqqaqlHE3R8sS6i0kLOAnIundSDhlUxKzaoWup5xQLeoOCA6POGC6FjKiC3
qnKoEN2PSXEYGQ1MM6j6FD3TE/afFGlA0EgEb71VZwqPt1hLxtHnJZA4RKzrAR1G
qC/Z8EUIo6WXPvMTINXXFGKXPN7A4XCza1CIhWL0CcVCSev+7QocQMqXr1E7BLHn
VGYogFH55+Qrq1FwYRjWU60JIsW7wo82wojf2rO7mOMSkXMsu7G4MjiX2Fq/YZg=
=XOs+
-----END PGP SIGNATURE-----

--ibQy1PD9BIJOeb75--

--===============0327260140986046681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0327260140986046681==--
