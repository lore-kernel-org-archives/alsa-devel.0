From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Add API to set supported jack
 type
Date: Mon, 11 Aug 2014 13:24:15 +0100
Message-ID: <20140811122415.GZ17528@sirena.org.uk>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
 <20140807173136.GN17528@sirena.org.uk>
 <1407751185.2487.150.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2683628162576172842=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD5F7265196
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 14:24:31 +0200 (CEST)
In-Reply-To: <1407751185.2487.150.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Graeme.Gregory@linaro.org, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2683628162576172842==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9HywjR4dOKKj5Bzg"
Content-Disposition: inline


--9HywjR4dOKKj5Bzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2014 at 10:59:45AM +0100, Liam Girdwood wrote:
> On Thu, 2014-08-07 at 18:31 +0100, Mark Brown wrote:

> > I've CCed in Graeme Gregory who's been writing some guidelines for this
> > sort of thing in the context of ARMv8 serviers - the most recent patch
> > is:

> >    http://thread.gmane.org/gmane.linux.acpi.devel/69757

> > The advice there looks good to me - see the "Device Enumeration"
> > section.

> This is indeed good, just too late for the initial Broadwell BIOSes that
> wont have this _DSD field for the codec (it will be hard coded for
> Windows anyway).

Sounds like DMI is going to be needed then - whatever ends up being done
I'd expect it should just be a case of putting the checks done to work
out the machine configuration into the CODEC driver instead of the
machine driver.  If it looks ugly this can be used to explain to people
why we need something more sensible!

--9HywjR4dOKKj5Bzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6LXsAAoJELSic+t+oim9iiMP/0cUX73IYytEfRC/gHmG06gR
YKoSstJEgrlpcqW82HCnEUDnvl7z1r2dc1b72F2aC3WuU2VViBMG9suGduWJzkRs
X2q0GXpOI0J7NmgqLyQvGP/pEqur3eIhMmK3fMFhescTwiwd2W3pGYt+Uf/y/e/+
vRNXGqgLBOJs1l5f39/dh9VZIGEkf491EfLNpiSG8p01iy2GeNKjwuxrD9roJVln
icY4DlrZG6aX9HmIZz5A/m1rOMUV6ZyNvTeXEvr4cQtUSF15B5B5XsI+/uxv7wYZ
RN2ONgzmQgUwZhN2/CcRpCzn/QPOYC8kj610ct6itGggCsskXwPNaF9dGkivWeIL
iuFRGGY8qaqjfKxu2Xihrgw3sQuXG4YpBWL7jt1SSnd2PWKkiUhoSjiJBzE726tS
31vQzgyvrW2atzoBr/S9fDuNOVM5Ft4Mgbv5roXgMiiyJntp7Rt+WBeTxCGwGJLc
aH5s6wRY4CCTpCffpvPLP24xM+C+jITv7Sd+KNa+Hz2slizGDnw/L8CCD1F+O72E
R4ptuMeWLuN/ezM+NAG7Oarw1KKHjpmfB/VzYTvmleOykJ9Py20GhUb24iiFw7u3
DpcJQUMTUBAxzTdMOv0TgKL04ApAeWqgc6iairQ85Sm0iMllj+r/M+eMLbmt4Mgg
g06a8TUWBHsgN7h4QDau
=K7q2
-----END PGP SIGNATURE-----

--9HywjR4dOKKj5Bzg--

--===============2683628162576172842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2683628162576172842==--
