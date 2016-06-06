From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt298: remove idle_bias_off = true
Date: Mon, 6 Jun 2016 19:46:27 +0100
Message-ID: <20160606184627.GK7510@sirena.org.uk>
References: <1464850312-18069-1-git-send-email-bardliao@realtek.com>
 <20160602234019.GV2282@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701163D65@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2255037372919319509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEDEE2650C0
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 20:48:46 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701163D65@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "Koul, Vinod" <vinod.koul@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, "senthilnathanx.veppur@intel.com" <senthilnathanx.veppur@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2255037372919319509==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Content-Disposition: inline


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2016 at 03:09:32AM +0000, Bard Liao wrote:

> > Could you talk through the use case in more detail - what's the widget
> > and why is it still OK for suspend to run even with widgets on?

> We need to force on "LDO1" widget when a jack is plugged in. That
> is for push button detection(not implement yet). Also, all jack related
> functions such as headphone playback, headset capture need "LDO1"
> on. However, we don't need these functions in suspend. Also, it seems
> the external power will be cut down in suspend even codec suspend
> function is not called. In that case, codec will lost its register setting.
> I.e. Codec registers will be cleaned. And we need to sync with cache.

In a situation like that I'd expect the machine driver to be disabling
jack detection over suspend - it should only be being left enabled if
the jack detection is expected to continue functioning over suspend (a
lot of Android systems do this so things like starting playback from the
button on a plugged in headset continue to work).

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVcUCAAoJECTWi3JdVIfQKMIH/jl/BUT+alnQ7o/kPYtYUm89
RktQF2oegrLBkh4g148af6opQgq5O4VO0OIuGjVeFqyxHhbY0HaUNWjiBJeIOMk2
sQD3dxFWvkCBH57z4wTST6SI2d3R0/FYuo1PRb2vkbI7PJWiMisFunzUKW3CAztA
1ozaD34iogrG0j6T83euSPC4OLUT9cFqtU0CjZVlff/65Se/3hKrN1mTqbCNGQ26
Wr/YWu09iu4rLw+dLyQ/+wGY/+6QziYUV9RgBO5FwOw1vkFH0V51czQYo02sF+Dr
XilyHDEso5afMC8TKwvSddJAUFeWYPy+6UcvDjfi87EW4wthWdovjfCovQBts24=
=m7zY
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--

--===============2255037372919319509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2255037372919319509==--
