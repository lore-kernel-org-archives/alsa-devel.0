From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ep93xx-i2s: use devm_* helpers to
	cleanup probe
Date: Wed, 28 Mar 2012 12:39:40 +0100
Message-ID: <20120328113940.GO3232@opensource.wolfsonmicro.com>
References: <201203261600.17787.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1396508036692820445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D635103F5F
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 13:40:06 +0200 (CEST)
In-Reply-To: <201203261600.17787.hartleys@visionengravers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mika.westerberg@iki.fi, Linux Kernel <linux-kernel@vger.kernel.org>, vinod.koul@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1396508036692820445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSMU0HVueUMCAvn0"
Content-Disposition: inline


--oSMU0HVueUMCAvn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2012 at 04:00:17PM -0700, H Hartley Sweeten wrote:
> Use the devm_* helpers to cleanup the probe routine. This also eliminates
> having to carry the mem value in the private data for the remove.

> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.de>
> Cc: Vinod Koul <vinod.koul@intel.com>

Applied, but again please take care of the above.

--oSMU0HVueUMCAvn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcvhIAAoJEBus8iNuMP3dvbsQAIiyUsqcuQBLLaQjKNIG/tEQ
/ETt/7Ocj2VFpY0jmlwB9r5XAhgnikC3YkA7LCfhwwTFovAAV2dezVLiRF52ho0e
7Ij0d1E3KAP7UVvUNzXy/GYe8+MqwFO5pU9jdtjIxglnnpuymq+NssY2bJMNWfGQ
8rWVJjlwCNzzibsmYgHHVswXKrUjUNWY4ErcLTtoTNS+fU301CfgXrsprvx+bKPs
nNbXXDdAnbzVsMhIRW5wKo9IWG95tyvpEmL8lnVbIRwd5TuOhRQaG1WGgR47ljad
rdYpC8Ld/xnNyziyfX2Ow3G6l7bgoamwfgu5FY4rvq13rtLM+xKuaXklqLAYKbPd
66WjOWRfvgeG3pFK0xRS+/owTjIGiMx6tUL/ItIOqCJoP0XRnzoIIEO1Sv3redcl
rmu1gzio2QT4rTcFTgHQ6yFaWVoeR9gUzFa0ribSm8mcTbb32sJcFsupZTjvV6se
QrwB73MSVVfaroX/AFWrNesXTfW06BA6vKWBewGMYRFGozznTKppwlSLGJACxtpW
WM3wHn2abW/BVQOXz91QRliiLO68cIBok/qzwwYTQ1DZdlxeVK+Zx73VEBl+g4aE
nY4RHEbYznxt0/kL3X2tmwNQlIIPFgMcl5BmRgjuLHKMccCFOs5cnG6aLEplWdku
dhe7WS0AX9Q+Lk5BTxqy
=2Ndn
-----END PGP SIGNATURE-----

--oSMU0HVueUMCAvn0--

--===============1396508036692820445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1396508036692820445==--
