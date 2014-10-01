From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoc: tegra: Add platform driver for
	rt5677 audio codec
Date: Wed, 1 Oct 2014 19:17:04 +0100
Message-ID: <20141001181704.GJ4273@sirena.org.uk>
References: <1412113939-11071-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6386162069784683581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A7562604CE
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 20:17:26 +0200 (CEST)
In-Reply-To: <1412113939-11071-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@nvidia.com, Anatol Pomozov <anatol@google.com>, bardliao@realtek.com, ldahan@nvidia.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org


--===============6386162069784683581==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vCQF5Fh1eN3mBuH/"
Content-Disposition: inline


--vCQF5Fh1eN3mBuH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2014 at 02:52:19PM -0700, Anatol Pomozov wrote:
> The driver will support Ryu board

> +- nvidia,audio-codec : The phandle of the RT5677 audio codec. This binding
> +  assumes that AIF1 on the CODEC is connected to Tegra.
> +- nvidia,speaker-codec: The phandle of the SSM4567 amplifier. This binding
> +  assumes that AIF2 on the audio CODEC is connected to this speaker amplifier.

This isn't as generic as all that, it relies on the specific speaker
driver.  I'd suggest either just saying it's board specific or making
the speaker CODEC optional.

--vCQF5Fh1eN3mBuH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULEUgAAoJECTWi3JdVIfQp6gH/RdLwW5R2SM8Y8RGtxtAruia
9y2J05/QBTo12/pVoz3lnof8KyAg58/IIcc7TB509LcIMahAZpxTruCNwVJglvoq
TZOvTPvwdFrHPU51EvctXjVbxelsDyEiAamjts43HdURhyeMvmKepmGOgobbFW5y
wUDiFEWt/ZYVpssdRSPNGr2Dbes758kC9GFJb7PXX93afI5N12Y/r1dt6SfUlVeo
QXOtLmJjGS56Kp7l1h1Yc3HzCRkK9KD4u61YsFnWcdanB7YAN+WeE/rSnGjcaLqu
Lc345r2w2GW5afk9ewQqlVQSGOL9nNMdiifsVnPIE3uDbDCMkfkGpk4M5OmphbQ=
=CEou
-----END PGP SIGNATURE-----

--vCQF5Fh1eN3mBuH/--

--===============6386162069784683581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6386162069784683581==--
