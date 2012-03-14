From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Wed, 14 Mar 2012 12:27:23 +0000
Message-ID: <20120314122723.GC3133@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5270888464335217568=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38C151041DD
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 13:27:26 +0100 (CET)
In-Reply-To: <4F6008FA.3040805@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5270888464335217568==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2012 at 02:57:00AM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > With this card those would just be separate CODECs.  This is a binding
> > for a simple card.

> But that is insufficient for the SSI driver, which is expected to handle=
=20
> multiple SSIs.  If you're going to document a binding for the SSI driver,=
=20
> then you need to document how to handle multiple SSIs.

For almost all SoC audio ports this works in exactly the same way it
works for multiple instances of any other device - you do a binding that
covers a single device and then you bind multiple instances of that
device in the system each of which need know nothing about any other
instances of the IP. =20

If your SoC has IP which provides more than one port in a single IP
block then the driver for that IP would need to register multiple DAIs
=66rom a single binding which is again exactly the same thing as you'd do
with any other IP block that behaved similarly.

All of which is exactly the same as for any other device and essentially
irrelevant to how we define the bindings for the cards.

> > The biggest improvement is that the SoC binding knows nothing about the
> > card binding at all, cards are completely separate and are free to
> > define any binding they choose using any number of on-SoC and off-SoC
> > devices.

> Ok, I don't understand that at all.

Do you have some questions about the above?  What is it that you find
unclear?  =20

> I also don't understand why you insist on perverting my driver to support=
=20
> two incompatible bindings, especially since I still haven't heard an=20
> explanation as to what's wrong with the binding that I defined.

We've been through this *repeatedly*, including in the message you're
replying to, and we're still going back to square one every time you
decide to start talking about device tree again.  This is frustrating
in the extreme.

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYI6jAAoJEBus8iNuMP3da3QP/1k70BJRCTStJ4dXBaQ0Jw9/
ymQFS7koLIREUIb6e5XpbN0ubUBNA2cHY5Nlk7EJ0IemVQY3jNEtOdgz0i5xTthv
Y1jXFvG9KqyK9WTGbaF8l77Tz0DiC/QlBac54gGQAIbTqzvIToLpDi3wA2Dd2UMc
o5H2C/qlnx+Z4wEqkQzAW7Qi02c3qIzpgt1Ma05cOZrKVt7kST3kHCUBG91x1Lus
OVMvvusNUGsFPsWAt+sFH1pl80HMUnVRd1fqUTKBNAA52HJqhHQT6WnJwL9r9fdt
KTZXDnc8Fj0W+1wzMRN27DwTFnI32wMzgaTGzAGDrVtsAg/JQVErVnbGPeIj1tka
WXzs6dZfixj9O+XRST0WCZSB8GxhGhEj6cEfSr6fFZ6UUVzvAFwSAMyN3ZLqOAGr
CeFjIAhTgUeIJtrj7OFyRzeht4klNW3zlHO4OgKTc7VK+/2GDaxt/sUrHflsGjoo
/Mj0Dxqovk+f92sU3zMRvR6KM15Kb7EWYkosUU/BW5VyKqj2NVHYWsvKLBJ7QhIE
Ma+o4SkWgYFhIO8FA1QOL+YicpRAlnRA5ZNH6a3ro9t/2bA0ZeOBv/XWmVdaqnRl
K7QLf6kqJmlbfoVh0ioN4c8LMqH1Xjn59zL/+onAYOhBUCBYKgo0vQBzbM2ynOXE
c4fns4zfBvgrN5T7OTyB
=O0JB
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

--===============5270888464335217568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5270888464335217568==--
