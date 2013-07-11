From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] ASoC: Regression fix for OMAP in DT
 boot (3.11)
Date: Thu, 11 Jul 2013 17:36:19 +0100
Message-ID: <20130711163619.GR24508@sirena.org.uk>
References: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
 <51DEBAE2.6060709@metafoo.de> <51DEBFDC.4000607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5954214273403907277=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3338F26507F
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 18:36:25 +0200 (CEST)
In-Reply-To: <51DEBFDC.4000607@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============5954214273403907277==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hCenlVgnDQUGHXTR"
Content-Disposition: inline


--hCenlVgnDQUGHXTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2013 at 04:23:24PM +0200, Peter Ujfalusi wrote:
> On 07/11/2013 04:02 PM, Lars-Peter Clausen wrote:

> > But I'm wondering who do you register the PCM device in the DT case? Do you
> > have a separate DT node for the PCM device?

> It is a platform_device right now registered in arch/arm/mach-omap2/devices.c
> We do not have and I don't plan to have DT node for it. The device for the PCM
> is registered if soc audio is selected for OMAP.

The standard thing there is to trigger the instantiation from the DAI
driver if the DMA driver isn't hardware in itself but rather an adaptor
to a shared DMA controller.

--hCenlVgnDQUGHXTR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3t7+AAoJELSic+t+oim9KtsQAJC6S24RKoib+AFzQWrtGJMI
8DKsr8E4JJnDYrfiCzeQ05qXcFbHAlrne8E/g2Tfjj+LvFJZVhBpQmYua9+5fSa7
6e0Tax4KZSNm1AWiTbTuxuE2XlksEpnDrn71MiQtxd11aSZGrFsARXtAa+DyeYmC
JnxqkCxdHfp0AGAlmdX1XMssOPDsqmAEV0cv6UBpuNAkj/SDwGkhgrjrOgYF9cHs
PZXIC9ieajOVOl5+TrJWEbfmN4t3bO/ZehMaNSUl7VFwtohV2z2Bi5shpHN5Fasm
kSK+pNSzqJoBRCczytZpq4nfXaGwUbsz8U1kz8af3CTgjnOUXr9E7PeEAIvEQmLR
YaiqJ+0iRlWiWEHltHnJTcPmcF7uL90iArEQjEorHTDpEbDTMx5Dlc2kLAtFqe3K
K+KGWYeYUThIB3dksh1kbZTP+K2MhHiF57jLdLQUAsKZnrQpzZDzLp4ZNu2ON35T
9xqdfnwkDAJQrxLLHX2ksZcCMDftg2ih/VC9qJ5lDOwYVhmW0lFp7y4o39owi6Dt
C/+hby4LgAFsD9krIvhmHzdehJ1NZNhYKY3ft1aZY78wlFCC817R1TV7gGTRCGbT
O6vqYdGafM8j3i9u7KW5hBV9vLqlV/K/TjoIWU5oSM8C+r74rPmA2EtcGHzafsjS
UkdBygAumd/EvLNHxigd
=fOFo
-----END PGP SIGNATURE-----

--hCenlVgnDQUGHXTR--

--===============5954214273403907277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5954214273403907277==--
