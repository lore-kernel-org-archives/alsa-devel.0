From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 7 May 2014 20:49:47 +0100
Message-ID: <20140507194947.GL22111@sirena.org.uk>
References: <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
 <20140507172113.GI22111@sirena.org.uk>
 <536A7161.7090100@metafoo.de>
 <20140507180705.GJ22111@sirena.org.uk>
 <536A798E.6010408@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8430872620836004279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95175265319
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 21:50:11 +0200 (CEST)
In-Reply-To: <536A798E.6010408@metafoo.de>
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


--===============8430872620836004279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oeABDT9Upm19aBf"
Content-Disposition: inline


--2oeABDT9Upm19aBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 08:21:02PM +0200, Lars-Peter Clausen wrote:
> On 05/07/2014 08:07 PM, Mark Brown wrote:

> >What you just described is what I'd consider a virtual control - I don't
> >consider the fact that the put callbacks end up writing to the hardware
> >particularly substantial, as far as the framework is concerned some
> >driver specific thing goes off and does something but it could be
> >setting a variable just as well as writing to hardware.

> Ok, but we have controls that have virtual in their name, so I think it
> should be made clear that you are not talking about those.

My first thought would be to extend those so we have callbacks when
required, to be honest I'd forgotten they weren't there already.

> I think the drivers you are thinking of are those which had physical
> register which were backed by hardware and virtual register which were
> backed by software. For the later we introduced the virtual controls, so
> that such hacks are no longer necessary in driver. But in the case of the
> RT286 all the register all still backed by hardware except that the way they
> are accessed is not very uniform (different types of registers use a
> different message format, there is a asymmetry between reading and writing

Right, to me that's not actually a register map at all since it's
missing so many of the assumptions that back up register maps.

> the same data). In a sense this is similar to devices which have registers
> with different sizes, we also support these with custom regmap callbacks.

But those are only breaking that one assumption so they fit into the
idea of a register map much more readily - it's really only the physical
I/O code that actually notices anything, all the cache and other
operations can carry on uninterrupted.

--2oeABDT9Upm19aBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTao5XAAoJELSic+t+oim90VwP/3T93kTDNnJwS7tBZLCqpLuz
pBa+CMkqgAK5Mh30GP0Xupc2iuMXVgqOESjtkd9r8tk9xnQNX/mdnawr/arXdXGX
3ArOl0kcGFcYYXd2g7Bej1t0YHKUCQQsuwXEURiPVyekg8EVfBc1Ageq2eazp7tX
6cClV4ow6hvJZN5ll/bcNkxRtf++nhsXDg75n7Xgz0nKvqeXoJqfBURxThuOgWh2
1PlmaX+Owy6HzVJFmHol4ckP9uXRROkpK7cHBz/KeJGA1SR0TsPXo9v59s1L/Xcy
OUcN6GMs+yz3/ZTWgST9+FQxU3J/Z/BnaWIyaO6EUr9de94fTV3j1/x/tVbA4M3J
+U7bLIt7nW5AMW4gohPcvT5ks44DSlOf8me7dy7NsO9LXwo96NIyc1OY1ZQJZJxX
6pm7KnXsVm03bb+o/4Y2znkrfeW+E90Z0DqLBDrDSRwDTf0jHp3pbQlKr0mH7Dgh
9xaZyKcDgbaqQNhbFevgokoc7NAUkTFJOD2niAsmc4U7W0uTS71RbZ9EYgULGnZo
iCMVJXOQ+2KhNPMTlMWOgERdSPHb9mT9i08BA/6qzFLts1scrO5WiSiCIXQeue0R
PvRldFkMHP25CjsAkIvaRRq2SKNVMo5Kqi4IBqgxL5q7sbyChhW76azKV91olM4D
sKcnNJ45u/nsSVyxiZly
=WNMf
-----END PGP SIGNATURE-----

--2oeABDT9Upm19aBf--

--===============8430872620836004279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8430872620836004279==--
