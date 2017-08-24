From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 10:41:52 -0400
Message-ID: <20170824144152.GC17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <s5hk21tjb02.wl-tiwai@suse.de> <s5hinhdjav6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8874611028191579389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B729266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 16:41:42 +0200 (CEST)
Received: by mail-yw0-f179.google.com with SMTP id f185so4813183ywh.0
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 07:41:42 -0700 (PDT)
In-Reply-To: <s5hinhdjav6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8874611028191579389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i1dAbsF9+zgeqzLb"
Content-Disposition: inline


--i1dAbsF9+zgeqzLb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 04:31:25PM +0200, Takashi Iwai wrote:
> On Thu, 24 Aug 2017 16:28:29 +0200,
> Takashi Iwai wrote:
> >=20
> > On Thu, 24 Aug 2017 02:05:25 +0200,
> > Tom Rini wrote:
> > >=20
> > > On Wed, Aug 23, 2017 at 01:39:12PM -0400, Tom Rini wrote:
> > > > On Wed, Aug 23, 2017 at 05:29:33PM +0300, Andy Shevchenko wrote:
> > > >=20
> > > > > On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> > > > > > Not all devices with ACPI and this combination of sound devices=
 will
> > > > > > have the required information provided via ACPI.=A0=A0Reintrodu=
ce the I2C
> > > > > > device ID to restore sound functionality on on the Chromebook '=
Samus'
> > > > > > model.
> > > > >=20
> > > > > > This is a regression from v4.12 on my laptop (a Chromebook 'Sam=
us'
> > > > > > that's not running ChromeOS).=A0=A0My fault for getting out of =
the habit
> > > > > > of
> > > > > > trying -rc1 when it comes out and not spotting this sooner.=A0=
=A0I'm not
> > > > > > 100% sure if this fix is correct for all cases as I'm only able=
 to
> > > > > > test
> > > > > > my hardware here, and this does fix my laptop.
> > > > >=20
> > > > > Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide platfor=
m data
> > > > > in the module sources") does not fix your issue?
> > > >=20
> > > > As that's not in master yet I can't tell.  Can you give me a pointe=
r to
> > > > somewhere?  Thanks!
> > >=20
> > > OK, my bad, it has a different hash upstream,
>=20
> BTW, the hash above is correct.  It's in Mark's asoc tree (and in
> linux-next).  You might have cherry-picked a wrong one, I suppose?

Alright, I read-things to quickly, and to be clear:
(a) "ASoC: rt5677: Hide platform data in the module sources" is _not_ in
Linus' tree (I confused this with a different commit) and _is_ in Mark's
ASoC for-next branch currently.
(b) Applying just that patch on top of Linus' tree _does_ fix my
regression (an Oops and non-functional audio) with audio and now sound
works well, as expected.

Can we please get that as a fix for this release?  Thanks!

--=20
Tom

--i1dAbsF9+zgeqzLb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnuWwAAoJEIf59jXTHXZSN8IP/RFjnNc9Xq4YB1QjtKQhPdTR
dnvr3AtdG/uqOUX6I+5URYv6oG0EKGuuFl4WSzJpj1n2Rt13K+2IDr5jbDfgXDiz
Po0/VoD59USP33SXEwwHK8O84S3MNmEw+NV//69sGMemJ7MoecjghUdy4S4SZjVJ
nquhs4h+FrF8PpII0VaUVSVRVtOvwRLNwwbcn2hRBHujOAPT0huuVvN0imyyRZAS
/Gtz9uUse7msdvuTjYPcIQ3bWOVociLSpm3+AgWraJWGHILfqf4Sae3MD7+78gbW
LYqnFOTMbO7n8mxm8KFdV9Q7cpWqQ1n9jDRzqwqS6Wrtkdt8l6y97kuWlfklP194
JNoIVQ/H1UnXLPocdXV8lYu6ZkpLoHik7MTXUWFzW2za89wuWxQNH8offLAUbbdy
GvYCX6alG4s+u/HDXRlQISbHn0FTX52MI0FPU9NcQdUM3WzrKzC2MSJCVV38AMzP
Nx2ZnmSl4ewaWjrzXIhdTSv6J/aEQ0aGo2ZxA04Ya03zFS4RtbOCye6X2hjXiMvN
17LzKumZtQu1/c4+h+QRpkOUGsr1+q1brITid6uZvjfqgCOzAvZbeCwKPVItur9+
rmMbV4oc6pyAjwaVxWJuGfi1syTL4xPAyDb/uvAYmt0Xen0eDksrYchDFAM4BrK2
Gj3aqiudP2hkIBPI3qCC
=FMGm
-----END PGP SIGNATURE-----

--i1dAbsF9+zgeqzLb--

--===============8874611028191579389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8874611028191579389==--
