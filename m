From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 7 May 2014 19:07:05 +0100
Message-ID: <20140507180705.GJ22111@sirena.org.uk>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
 <20140507172113.GI22111@sirena.org.uk>
 <536A7161.7090100@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7461746659336701940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85C2F265253
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 20:07:32 +0200 (CEST)
In-Reply-To: <536A7161.7090100@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7461746659336701940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wluVThW9QgEmL6s2"
Content-Disposition: inline


--wluVThW9QgEmL6s2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 07:46:09PM +0200, Lars-Peter Clausen wrote:

> I don't think virtual controls are the right approach here. Virtual controls
> are for controls where the state is completely in software, but here the
> state is still in hardware. It's just that there is no uniform hardware map.
> But there is still some structure. So you'd have controls with custom put
> and get handlers and for DAPM widgets use the event handler.

What you just described is what I'd consider a virtual control - I don't
consider the fact that the put callbacks end up writing to the hardware
particularly substantial, as far as the framework is concerned some
driver specific thing goes off and does something but it could be
setting a variable just as well as writing to hardware.

> But I still think that the best and easiest solution is to have custom
> regmap read/write function that do the translation of logical registers to
> physical read/write operations.

That's the first time this idea has been mentioned that I recall.  I
have to say I'm really not keen on pushing non-physical registers
through regmap, all the drivers that have done that previously have
ended up causing problems though if the registers were *all* fake then
there would be less issue (most of the issues have been due to having
extra registers that don't really exist).  It does still feel like it's
a layering problem though.

--wluVThW9QgEmL6s2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTanZGAAoJELSic+t+oim9U7gP/0zF1Dq0xLhi0UuSYTkE2E2R
8E1uXnsV0DHc/7MIK5wsE65KItD0D6BYqcVQF6p7V5JSUtc13kyOsfF3T84NSW71
4nN/M6+xIuviZLPXTaL3m3fjPfMlTacmTqnlMxB3QZEYvEGbZoG2+yp+5jJlCj6k
KOZiPXGHpYHVqBLJGt5TtAJB3LA79+qduri4z+jt1ueHI+Fw/LLTlTGtt5P1nQxW
PfqggxXLVO6nc5tpuyAB4Wb24vW9+uxS19jOWXR8y76z6BJFalW8gjKUpG9BxtHj
mveLOQftFHZDBojpanf4ZSVFwpk3gGAlNtg20GzAelKQuxO2Ma04Q271EiLQmynE
kqEhz3c8Y3zcy9OENTD6S/rxU38XY4ku2WcMxWXPRef8jlEPioo7Gy1vTHSzbDIk
MD/a+23cUhoO3Hhn+7/fQG8lRd0DRNArmcPE7aoHQTbljKEfyV58w4uRL9qZleYW
Jdwut+R7HMk4c7Jm/PrQDTiBseQ/ol2RUUSAUZH8f0n4U9tG88oAjx4iEXzqHb48
mHpuaPBqydV6F//9ZpnckqwlLkgRmGhkqS3tLD0KrbW01aiIJoVhXE8Mk0kkpNCh
5350KzhuDX2N76HGwyu+rSkUySARent9+sFzQx2H5anjrqyS4Jin59w/fvFcr0J7
PHrebbV0oVVkIqNPukns
=dLlJ
-----END PGP SIGNATURE-----

--wluVThW9QgEmL6s2--

--===============7461746659336701940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7461746659336701940==--
