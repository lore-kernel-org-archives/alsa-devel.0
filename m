From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: don't select SSP for
	COMPILE_TESTing
Date: Mon, 7 Aug 2017 12:48:37 +0100
Message-ID: <20170807114837.3bqsroayi3sipf4h@sirena.org.uk>
References: <20170807104101.3540159-1-arnd@arndb.de>
 <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
 <CAK8P3a3Zuu7HE4CphQR_wpbGvnupYRSdy3xFZu5UgsuvoOjnLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6207558775937705735=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E786D2669F6
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 13:49:20 +0200 (CEST)
In-Reply-To: <CAK8P3a3Zuu7HE4CphQR_wpbGvnupYRSdy3xFZu5UgsuvoOjnLQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============6207558775937705735==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="642exchf7ywsubvj"
Content-Disposition: inline


--642exchf7ywsubvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 01:36:09PM +0200, Arnd Bergmann wrote:
> On Mon, Aug 7, 2017 at 1:20 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 07, 2017 at 12:40:44PM +0200, Arnd Bergmann wrote:
> >> When the audio driver selects CONFIG_PXA_SSP to be a loadable
> >> module on a platform other than PXA, and the PXA SPI driver
> >> is built-in, we get a link error in the SPI driver:

> > Why doesn't this cause problems on PXA?

> On PXA, we 'make' descends into arch/arm/plat-pxa/, where ssp.o
> is located. On other ARM platforms (I guess except for MMP),
> PLAT_PXA is not set, and on non-ARM architectures, we can't
> get there anyway.

Still missing a few steps of reasoning here...

--642exchf7ywsubvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmIU5QACgkQJNaLcl1U
h9CNWAf/bfYfjuT97uDqwMd2sTroknT/mvdOEGFtaK0wH93lIOWp1b1JJgX3oHhF
xRZAOgk3SpHsp3/+/5L6QPJfDuUpuFjaf6gSYNHYLgExmG1Tsiul0LO1ofaLkYIQ
bYXQV72RGE/nuDmke3yMxwHyYR9SVl7iT8J9SayjnaKigsJon8LOCwm7lBd1ID2/
wFuaxZSxcmS9k11Tabny9NXQD2pdF493CxDmy7ckvGyGZW4lAPpmdKW9rKYw0gwI
fQb8I25zsXDYDlVMWaXTBnOapqtlh5pH4FLkmGNkCCknk2kn7Ti1LFa6dvT1uVmU
QRBE55mySm/KaBjLRCM32GAazdCA0g==
=pnOt
-----END PGP SIGNATURE-----

--642exchf7ywsubvj--

--===============6207558775937705735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6207558775937705735==--
