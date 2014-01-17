From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Fri, 17 Jan 2014 17:20:25 +0000
Message-ID: <20140117172025.GW17314@sirena.org.uk>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
 <20140113211858.GK29039@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
 <20140114195159.GW15567@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CD24A@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1549966207882812770=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 315262610D4
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 18:20:35 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7CD24A@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============1549966207882812770==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1d8mk/W7pQzMfc7"
Content-Disposition: inline


--+1d8mk/W7pQzMfc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2014 at 02:11:03AM +0000, Opensource [Adam Thomson] wrote:
> On Tue, 14 Jan 2014 19:52:19 +0000, Mark Brown wrote:

> > That's not what's been coming over.

> The drivers follow common patterns. The only thing slightly different is that
> both the Codec and PMIC are initialised separately, but this reflects the
> nature of the chip. I don't believe wanting to add a simple solution which
> fits with that as being awkward or against common methods and am not overly
> happy you're trying to suggest otherwise, especially when previous kernel
> submissions I've been involved with have very much followed common kernel
> practices. I just want the correct solution for our drivers here.

Sure, like I say this is about the impression that is created rather
than your actual intention.  One particular thing I'd highlight is that
it's really common for device vendors to say that their device or code
is special in some way and can't do the standard things but this rarely
turns out to be true.  It is therefore really important to do things
like highlight specific technical things that mean new approaches are
needed (like the fact that the addresses are independently controllable
for the functions on this device) otherwise it is very easy for it to
look like a common pattern is being repeated.

> Yes I'm sure, and there are OTP settings for the PMIC as well. For the PMIC
> address configurability, there isn't really an issue anyway as you need to
> provide the address for this I2C device at board initialisation in the kernel.
> The point of note here is that the Codec I2C address is OTP configurable and
> therefore not fixed.

OK, that's fine - I was just really surprised since the normal thing
would be that if only one function was going to have the address
configured via OTP it'd be the PMIC.

What I would suggest doing is writing a binding document for the device
(which seems to be missing anyway) and sending that along with patches
changing both the MFD and CODEC compatible strings and IDs and adding
comments saying that this is intentional to ensure that nobody cleans
this up again.

--+1d8mk/W7pQzMfc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2WZWAAoJELSic+t+oim9G+IP/ivzRE3iWJba9c+VlA0Y4KkX
RjTULIgjIGS/tOmepob7L2CPN8kTwZO6+inpEMqHLKneyeZtIklWgJgnM5xraxq3
UOW+xG2Euksf9Hms0GGepdbO5Dx+3l0VenX+eB9Z76KDonmjOIxthG2O6Lchy025
1TE4yLxVJK6c1bFlcLzrjzejWfCMpFxW1YqXB364aKV0JLrbD52SQK/vgbYNW+wB
IRwFPlfmFUUACmw+2INV5OHHlaxVI6riqA57rF3C0RvzjhwKKqPc53UWnDeixWFN
pfQCuuJ3hc5ika8nt41fu1jHyz0FB8L3VVvpYrLhkFZWLXnJBuj6Dvvf/hno+MyB
E8kOGG+T/eVIHdH9arasF65505JHX2RXUaSohX8oTLC6YSeFGElxYtSTFfh6TP5n
pjUbht7y4b/TkNmTR/RBOM+oQ49YVuVvsI3TcPLJUdyGW9FtkUYHdxI201HVn+pQ
C3bukEozr1Yj6SWr6JTs4wFu7LjWbr5BOe/ivk42DxcK50O3AMydv+uIzpC3ZgJ9
APBLsdt6nW921PbTznYIwesaxHaOS7jM4DXvNHcfQ2oupnJrYik5jcM9u9KwxJ/Y
ahBt2DJK2ilu6bWCp3Y/ygWwLsMwD01L9KUSS40N2TFETx9bnNczrMK325c6HHZS
5IHILQwBIv24vtIS0lop
=vx7a
-----END PGP SIGNATURE-----

--+1d8mk/W7pQzMfc7--

--===============1549966207882812770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1549966207882812770==--
