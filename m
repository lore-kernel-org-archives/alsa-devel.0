From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
Subject: Re: davinci-mcasp: extension to use AHCLKX pin as external clock
 source
Date: Tue, 10 Feb 2015 15:17:30 +0100
Message-ID: <54DA12FA.4090402@bytesatwork.ch>
References: <54D487BE.2060209@bytesatwork.ch> <54D4AA7D.6050108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4flpexOQ4n32evrqXVm0cGUQmr29khS4B"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D4AA7D.6050108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, perex@perex.cz, tiwai@suse.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, jsarha@ti.com, misael.lopez@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4flpexOQ4n32evrqXVm0cGUQmr29khS4B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.02.2015 12:50, Peter Ujfalusi wrote:
> On 02/06/2015 11:22 AM, Urs F=C3=A4ssler wrote:
>> The AHCLKX pin seems not to be supported as external source. The first=

>> patch is a general fix to allow external clock. The second allows you =
to
>> select the AHCLKX pin as clock source.
>>
>> Patch built against v3.19-rc7
>>
>=20
> I don't think this series is correct. You can just issue:
> snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_IN);
>=20
> from the machine driver to select AHCLKX as input.
>=20
I checked everything and the source of the problem is, that on our
hardware the bit clock of the codec is connected to AHCLKX. According to
the datasheet, AHCLKX is for the master clock only. On the other hand,
it is possible to route a bitclock from AHCLKX to the subsystem (what I
did with my patches).

Now my question is, if it is even worth trying to bring such an option
for the driver (use AHCLKX as bit clock in) upstream?

Thanks
Urs



--4flpexOQ4n32evrqXVm0cGUQmr29khS4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2hL7AAoJEKKADLnESIBjzjgQAIntiJUbuemKQDeMI1TOgsEO
RyFOh6kyNNkcEVqToo6CJ6v+mEpAsbSFdpiNtH602H9jlJ+mIqWXZlRYaLeM3gAm
PxLQBdB9AWEVG2KrLiRJShVuZ3ha/evtHBkQWDQOM5EJBcX5FNIrFppXt2xAD2py
ldohwBp9Pv9ZudcJ5uXZ1vGSj1p/ZCoKskqUrMzkPeaBGfaPhR6/x2+BGWeiuq9D
5cde2u+b23Bcs2fD0Y9OwZ8LoH7aZmhGMcuzcmTcPzNQxroYaCWyty8ZLa3LfTJK
OKPabYmUxz3TB9U2Ue+qpRMDx9J/s/uG8xYRkukemh8y0RgxN7zStBOsJhCovBxb
9TsWmBsbrkS7xIizz5WJTgHtyMfGYDsg2E06QEf8EI37a68ffaT0BV9LJ3O3hQbx
IMLL0VixbFW5yDWc+gaJTPe9yvjFJQHj7CylkBFBE9OhvwKTOLrf61+nfYyC91NG
aUpIkKp9mL/P5S/xUmMyrVgUvXDKswr1pp02cSU8E71UDz2q55pagI/yiOGRUneb
aVNBWaJgBgMOtzb17GR9EWBW5msihqDb91BqX1jRkgDQb7TLWnjLqbZP+FlhDSeo
GHR/ShgL3Ae5QBxOFvHhyzpHmw6EOOdxzAKjtwNPMEPbRPmyYtnNjx1cIxiAT9DV
JV3GcsHlZRScuwwe5djE
=OWsd
-----END PGP SIGNATURE-----

--4flpexOQ4n32evrqXVm0cGUQmr29khS4B--
