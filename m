From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: sta32x: Use
 devm_gpiod_get_optional at appropriate place
Date: Tue, 12 May 2015 18:52:21 +0100
Message-ID: <20150512175221.GJ3066@sirena.org.uk>
References: <1431184113.5393.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3415336718896780115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02CBC2651A8
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 19:52:38 +0200 (CEST)
In-Reply-To: <1431184113.5393.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Johannes Stezenbach <js@sig21.net>, Sven Brandau <info@brandau.biz>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============3415336718896780115==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 09, 2015 at 11:08:33PM +0800, Axel Lin wrote:
> devm_gpiod_get_optional() is equivalent to devm_gpiod_get(), except that
> when no GPIO was assigned to the requested function it will return NULL.
> This is convenient for drivers that need to handle optional GPIOs.

Applied, thanks.

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUj3UAAoJECTWi3JdVIfQxPIH/R/FyILOZITPwKqvBLEc8s7W
kDhl1/yzXrRiJVXmSUcSO7nM+Yl8P7wOf4itjzbW4cMyWSPdaT1sAHK3xQsAL43x
3u4refn6D4VgAoKhB5nCxjQC/UOLxc29LalYN5RpwMja/klte7alhGV50xRZ9PTU
WiXa+rdBT9xHpvyQP636DzBxVgFkGw6jwdxsfdpN7ZfULC6VcT2dSOo5tAUhMEBs
yvTouNr4JgSHUceDlIN8QNOSbDd9A/RZeEiK9rMbWg4CpDgu0In90iaEX5We6u49
nl0qILXZCc+uGcMD0Neegiq/PFYkWNdBAdB4ELIXwgSNpA7hj49bJssSWdr1Xls=
=EIDN
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--

--===============3415336718896780115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3415336718896780115==--
