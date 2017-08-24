From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Thu, 24 Aug 2017 07:15:47 -0400
Message-ID: <20170824111547.GA17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503498573.25945.69.camel@linux.intel.com>
 <20170823173912.GN17193@bill-the-cat>
 <20170824000525.GY17193@bill-the-cat>
 <1503560349.25945.72.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7936456307187341520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com
 [209.85.161.172])
 by alsa0.perex.cz (Postfix) with ESMTP id AA14B26763F
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 13:15:38 +0200 (CEST)
Received: by mail-yw0-f172.google.com with SMTP id z3so1601817ywz.1
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 04:15:38 -0700 (PDT)
In-Reply-To: <1503560349.25945.72.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============7936456307187341520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0JXx0QNa4/JeB8y"
Content-Disposition: inline


--z0JXx0QNa4/JeB8y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 10:39:09AM +0300, Andy Shevchenko wrote:
> On Wed, 2017-08-23 at 20:05 -0400, Tom Rini wrote:
> > On Wed, Aug 23, 2017 at 01:39:12PM -0400, Tom Rini wrote:
> > > On Wed, Aug 23, 2017 at 05:29:33PM +0300, Andy Shevchenko wrote:
> > >=20
> > > > On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> > > > > Not all devices with ACPI and this combination of sound devices
> > > > > will
> > > > > have the required information provided via ACPI.=A0=A0Reintroduce
> > > > > the I2C
> > > > > device ID to restore sound functionality on on the Chromebook
> > > > > 'Samus'
> > > > > model.
> > > > > This is a regression from v4.12 on my laptop (a Chromebook
> > > > > 'Samus'
> > > > > that's not running ChromeOS).=A0=A0My fault for getting out of the
> > > > > habit
> > > > > of
> > > > > trying -rc1 when it comes out and not spotting this sooner.=A0=A0=
I'm
> > > > > not
> > > > > 100% sure if this fix is correct for all cases as I'm only able
> > > > > to
> > > > > test
> > > > > my hardware here, and this does fix my laptop.
> > > >=20
> > > > Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide platform
> > > > data
> > > > in the module sources") does not fix your issue?
> > >=20
> > > As that's not in master yet I can't tell.=A0=A0Can you give me a poin=
ter
> > > to
> > > somewhere?
>=20
> It's in ASoC next at least.
>=20
> > > =A0=A0Thanks!
> >=20
> > OK, my bad, it has a different hash upstream, but no, that change
> > doesn't fix things as I see the problem on top of Linus'
> > tree.=A0=A0Thanks!
>=20
> Interesting...
>=20
> The only bug so far I saw is the following one
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D196397
>=20
> ...and above commit fixes it.
>=20
> Can you place somewhere the bundle of the following:
>=20
> 1. Output file (tables.dat) of
> 	% acpidump -o tables.dat

https://gist.github.com/trini/b9a9a547e37cb812506a22e18cd2aff5

> 2. Output of
> 	% cat /proc/interrupts

https://gist.github.com/trini/39a5d88a5ecb9b71336ff5fe9da7c720

> 3. Output of
> 	% lspci -vv -xx

https://gist.github.com/trini/e81ab21909eeaa05ea50dc0596d23c14

> 4. Output of
> 	% grep -H 15 /sys/bus/acpi/devices/*/status

https://gist.github.com/trini/698dc284634ad9e1cfbafad8e705de5f

--=20
Tom

--z0JXx0QNa4/JeB8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZnrVjAAoJEIf59jXTHXZSTY8P/R1G6pKO7lF2GUtefPZAGHvb
kJDDDZGzpRu1E/eMTROJoahoVRgTu6Fgz1KkB+CqbcwCQ/kTWM/SJZXpoQ7wuKNJ
D0NgFP1nk52MQJ/bjrKeclo0t1c4GyOM/47SLiJh3BCa8vQr7pKBsVqM0ZvVUZAt
Oi7fqRd5hEABNYWTmpURqXTq3CH1jMsIZUXjirrwt4lXqYF2e2VlmQWg5RwXJ0kS
rQj56XJnXzhHGUE+PMF9Y5wjJxwJ6nLLg2UhCZImO6Y2AgqIdAWgEY0m881T8IZf
uF5qHQ0T9vt2UB7SkiTG0u+0zSyzSSKLjXZIvb0zVebHFl5qUnqby+Sy61Oz42kz
O8OSd9e+m5kOv0poMMVl07tqX3+Fp4q1gW62GCtSMRhBtgmOWONry+jPkTmpmR2v
I70zmmk6FATbdEvwI2maGg1Q0CRic0ccKUsLIBtc5diylTwpsW2EwrWJ0nJLrmzf
vrMHHnM5QD3EUNH4amWI2VNzqyjTEKUbX4S9735tNnWXRQ34nIBavYOHV4xHTxsO
f0tQHw4twJ71+lT+c2k9tzCcZFUyS1HbBoLT3JsPLDr7htX+atSTf/sHqP8xf/nc
fDpbopiFUcp+2wHEIveUv6OW15trWml61WKYzYPNhvxkfKuQGPneyZ6dDXKCsqMV
Zw0iy0Ssu/bKFD83niMd
=F3Mn
-----END PGP SIGNATURE-----

--z0JXx0QNa4/JeB8y--

--===============7936456307187341520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7936456307187341520==--
