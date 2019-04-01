From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/10] ACPI / utils: Replace leaky
 function
Date: Mon, 1 Apr 2019 14:24:35 +0700
Message-ID: <20190401072435.GE2059@sirena.org.uk>
References: <20190328171729.44002-1-andriy.shevchenko@linux.intel.com>
 <0daff2ba-3322-be9c-9afb-0d74b9d0827e@linux.intel.com>
 <20190328214019.GP9224@smile.fi.intel.com>
 <CAJZ5v0jP8bXiQzFLSFPZ7xcHfxtMv93C-ybaZjqkuj+vjLH_5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4355345247910935379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACCDDF8075C
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2019 09:24:42 +0200 (CEST)
In-Reply-To: <CAJZ5v0jP8bXiQzFLSFPZ7xcHfxtMv93C-ybaZjqkuj+vjLH_5g@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Chanwoo Choi <cw00.choi@samsung.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4355345247910935379==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2019 at 12:33:33AM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 28, 2019 at 10:40 PM Andy Shevchenko

> > > Is this going to be merged through the ACPI or ASoC tree? The changes will
> > > conflict with cleanups I started to use the 'modern' dailinks (codec_name ->
> > > codecs[0].name), so some level of coordination is needed.

> > I suppose via ACPI.

> I can expose a non-volatile branch with this material, would that work?

That would be very helpful, please - there's a lot of work going on with
the ASoC Intel drivers in order to add SoF support so there's likely to
be some kind of overlaps.

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhvLMACgkQJNaLcl1U
h9AXJgf/dJcnreH1KDJMJC6jRmug/uBOFMwF2JVJZPFwgHTT1OVud1U6kGU0fwAi
FrPwzfTHiHEZmML3O23fe85dIFxIoEtJQwR2KqqzsijSWGxjpylQgdiW87BxO4E6
BpF064ry6W4qQvdCHR3s853s4PVW0wV6huL84nm2FMjgt9QWNl9kY7Ru5JK1thdL
LcW7XpDBg8IsyErYAs4SXQu/23vX73Bb4RtJgtT60nu2ehVunIsWrNfFKD7It3j6
bqtHrMiLBmyZubchvFmf+5fVcTq29TyKPpQutwBRd3vDWatu+WW2QTMfV5RPs9qs
zbSEHWsbjy3DWWgF10x0Or12r7L8+g==
=6Gyo
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--

--===============4355345247910935379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4355345247910935379==--
