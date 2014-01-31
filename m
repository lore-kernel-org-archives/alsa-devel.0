From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: wm8962: Hold a runtime PM
 reference	while handling interrupts
Date: Fri, 31 Jan 2014 17:40:38 +0000
Message-ID: <20140131174038.GT22609@sirena.org.uk>
References: <1391182201-29439-1-git-send-email-broonie@kernel.org>
 <s5hvbx0oy01.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3598632001227824926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4541264FE3
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 18:40:50 +0100 (CET)
In-Reply-To: <s5hvbx0oy01.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linaro-kernel@lists.linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3598632001227824926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ti9qQdT93fLKTkp"
Content-Disposition: inline


--6ti9qQdT93fLKTkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 06:35:26PM +0100, Takashi Iwai wrote:

> > +	ret = pm_runtime_get_sync(dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to resume: %d\n", ret);
> > +		return ret;

> Shouldn't here return IRQ_XXX?

Yeah, it should.

--6ti9qQdT93fLKTkp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6+ATAAoJELSic+t+oim9Of0P+wUe45GpMltw++TGz3Mai5go
mareLvx+LjyZ281U7Ke8jjPlwLA4yfr0BseJx/61R+tmls116YzHcXL/dteus5UA
JhBF+EMreK4FPs8F1QUKB2MAsXrZjrepSkzPTH3q/5Y5RV296vTfSwOwCSr3dLK5
7Neu1ilV/okNX97i8/7vkHwk1TSr+y13rgGYVf8XSi7nD0DtLOpXz2nzXFuB/hq+
bmeIEg+CTUzCLHdAQUYKeMi1gSYadsWgJev5SboIiP3x2EKM6F0GwR92X7kkaPjD
6iwB0qYZHnZBRUazRSUBI8f1BWvVfKsT6TgYUs9yChWBoFpEEuE+WxGhX3SzIR+0
6U/KI1cDdZ9KXbYrKyEUgI8sfPIxqSKkChNl9WRlv5ERIankZWhfH6hCAuy42oxv
crWvdpJ2rHbGrAIJGwdxUddXLVUN94qbU2SBd131lwMAckAmWus+OwHWcETXgJ97
Y6FQF8eJZakHdAmCDR5ePZxUqRNGKDXNI15mVCtIafDQ/UOZ5mQCK2Zd7dvYNDoy
LNZDhXAeietMJpnQ4mnXWe5b4ITn/rmJvbGn1lsdUP8ApbcIzDdiE5Z8L8t5rXT2
WI1j3dUCD1SuAFcBT9Kk1PCAFT85SV9SYylQs31FXMXJ+13s4VuWzMvFIAbo9LkV
0xOokeYtcQspmjrb4OGs
=hqgI
-----END PGP SIGNATURE-----

--6ti9qQdT93fLKTkp--

--===============3598632001227824926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3598632001227824926==--
