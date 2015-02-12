From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
Subject: Re: davinci-mcasp: extension to use AHCLKX pin as external clock
 source
Date: Thu, 12 Feb 2015 15:24:05 +0100
Message-ID: <54DCB785.8020802@bytesatwork.ch>
References: <54D487BE.2060209@bytesatwork.ch> <54D4AA7D.6050108@ti.com> <54DA12FA.4090402@bytesatwork.ch> <54DC5FCD.1070501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DpjqtUp9XDJfDRGOFtCr6dVnpIBxRpDqP"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54DC5FCD.1070501@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, perex@perex.cz, tiwai@suse.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, jsarha@ti.com, misael.lopez@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DpjqtUp9XDJfDRGOFtCr6dVnpIBxRpDqP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.02.2015 09:09, Peter Ujfalusi wrote:
> On 02/10/2015 04:17 PM, Urs F=C3=A4ssler wrote:
>> On 06.02.2015 12:50, Peter Ujfalusi wrote:
>>> On 02/06/2015 11:22 AM, Urs F=C3=A4ssler wrote:
>>>> The AHCLKX pin seems not to be supported as external source. The fir=
st
>>>> patch is a general fix to allow external clock. The second allows yo=
u to
>>>> select the AHCLKX pin as clock source.
>>>>
>>>> Patch built against v3.19-rc7
>>>>
>>>
>>> I don't think this series is correct. You can just issue:
>>> snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_IN);
>>>
>>> from the machine driver to select AHCLKX as input.
>>>
>> I checked everything and the source of the problem is, that on our
>> hardware the bit clock of the codec is connected to AHCLKX.
>=20
> Why would any HW designer do this???

It was not intended that way.

> Just to clarify this: the bitclock from codec is only connected to AHCL=
KX pin,
> or is it also connected to the ACLKX pin?
> The use of AHCLKX/R pin is _optional_ in McASP and it serves the purpos=
e of
> providing a way to have synchronized master clock for the codec and McA=
SP.
> ACLKX, AFSX and data pins are mandatory to be connected.
>
>> According to the datasheet, AHCLKX is for the master clock only.
>=20
> Yes, it is for the master clock to be used by both codec and McASP to a=
void
> clock drifting.
>=20
>> On the other hand, it is possible to route a bitclock from AHCLKX to
>  >the subsystem (what I did with my patches).
>=20
> Yes, it is possible, when McASP is master it can use the signal on AHCL=
KX pin
> to generate the BCLK/FS.
>=20
>> Now my question is, if it is even worth trying to bring such an option=

>> for the driver (use AHCLKX as bit clock in) upstream?
>=20
> I don't want HW designers to get ideas from code - but if they did what=
 I
> think they did with your HW they certainly not going to bother checking=
 TRM or
> code...
>=20
> But I think you can still get the setup working, if it is really like t=
his:
>=20
> McASP
> AHCLKX <-- bitclock <-- codec
> ACLKX  (not connected while it should have been)
> FSX    <-- framsync <-- codec
>=20
> In this case you want to configure the codec to be CBM_CFM and McASP as=

> CBS_CFM (we don't have this supported in the driver, but not a big deal=
 to add).
>=20
> And you call:
> snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_IN);
> snd_soc_dai_set_clkdiv(cpu_dai, 1, 1);
>=20
> You will have the codec providing the FS and driving the bitclock (conn=
ected
> to wrong McASP pin). McASP will drive the bitclock using the AHCLKX as =
source
> using divide by 1. McASP will not try to drive FS.

Thanks, that looks better than my patches. We will fix the hardware and
use your solution for the already produced boards.

Urs



--DpjqtUp9XDJfDRGOFtCr6dVnpIBxRpDqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU3LeFAAoJEKKADLnESIBjE2AP/iFonf3gKibonX62dT5n96c1
qvkDbhXnhU+Gn4T2rYDI6KD6G5l/U7Tx1rlJXZHNxiDHR1NASWHP1u2hhaKO5FHq
jwlPAD6lPeCAP2t6KGMftHwn8xUHeB/EszkFVdvbtcV5NAFIR5zKIOlVbiLw+9wO
zAEA8P7jouOGNDGc3LusSxYTijKxY3TfkWCy3Jb/XREAxKZkrqp8X4gxIwtwtKQR
cM3ae2Z6+jdtcDuj0bL1G+ABRNtOgM3YWj5c6hSkPzsenMrXpaVSgu041sHFtloX
a+nYEgFvz4rm0kUD2W6kPi/8cd5bw3yTwmq3Nfz9T4Zl+qtHsouIGiJwYlzyyu8q
FzHrphHwcy+Mr89UulkYqstqRZlBKsWHn0dutn+oANi4Xyi1ynaNsQgUI9OmJ/C0
PdmEXDQHmTnkKOH5cJ6Z2hHBw8g2Fi+fmxUwp4uDRyeucSzrtCdLRBtyHifkLo9i
A/RskbIXY/+LNgF9Z1cf/btzBuYKAHS+leC8YtSU5GW+K0lfa/ga7c3i+cTVyxJO
d+D9BHrXlgXDlN1Gf0iGHFI0EU64hGDH9Q7sRn0NaGY75y3CDtpxg3tXbBmCEpBO
Lya3GcjTBqSZP1CAJglVFbz+wgZjqHQ1nbZj/OSZw/MhBZkbe0irzQKaxbWUsfef
pAEQTSyP26634u2LJfe1
=6nm1
-----END PGP SIGNATURE-----

--DpjqtUp9XDJfDRGOFtCr6dVnpIBxRpDqP--
