From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: bcm283x: Fix register ranges of bcm2835-i2s
Date: Wed, 17 Jan 2018 11:37:03 -0800
Message-ID: <87a7xcmg4g.fsf@anholt.net>
References: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com> <1512818795-1441-2-git-send-email-stefan.wahren@i2se.com> <47138b75-1d6a-1692-636b-e37a87d68842@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <47138b75-1d6a-1692-636b-e37a87d68842-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:

> Am 09.12.2017 um 12:26 schrieb Stefan Wahren:
>> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
>> the bcm2835-i2s requires a clock as DT property. Unfortunately
>> the necessary DT change has never been applied. While we are at it
>> also fix the first PCM register range to cover the PCM_GRAY register.
>>
>> This patch only fixes the affected dt-bindings.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>> Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>> ---
>>   Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
>>   Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-=
----
>>   2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt =
b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> index baf9b34..b6a8cc0 100644
>> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> @@ -74,8 +74,8 @@ Example:
>>=20=20=20
>>   bcm2835_i2s: i2s@7e203000 {
>>   	compatible =3D "brcm,bcm2835-i2s";
>> -	reg =3D <	0x7e203000 0x20>,
>> -	      < 0x7e101098 0x02>;
>> +	reg =3D <	0x7e203000 0x24>;
>> +	clocks =3D <&clocks BCM2835_CLOCK_PCM>;
>>=20=20=20
>>   	dmas =3D <&dma 2>,
>>   	       <&dma 3>;
>> diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.tx=
t b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
>> index 65783de..7bb0362 100644
>> --- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
>> +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
>> @@ -2,9 +2,8 @@
>>=20=20=20
>>   Required properties:
>>   - compatible: "brcm,bcm2835-i2s"
>> -- reg: A list of base address and size entries:
>> -	* The first entry should cover the PCM registers
>> -	* The second entry should cover the PCM clock registers
>> +- reg: Should contain PCM registers location and length.
>> +- clocks: the (PCM) clock to use
>>   - dmas: List of DMA controller phandle and DMA request line ordered pa=
irs.
>>   - dma-names: Identifier string for each DMA request line in the dmas p=
roperty.
>>     These strings correspond 1:1 with the ordered pairs in dmas.
>> @@ -16,8 +15,8 @@ Example:
>>=20=20=20
>>   bcm2835_i2s: i2s@7e203000 {
>>   	compatible =3D "brcm,bcm2835-i2s";
>> -	reg =3D <0x7e203000 0x20>,
>> -	      <0x7e101098 0x02>;
>> +	reg =3D <0x7e203000 0x24>;
>> +	clocks =3D <&clocks BCM2835_CLOCK_PCM>;
>>=20=20=20
>>   	dmas =3D <&dma 2>,
>>   	       <&dma 3>;
>
> gentle ping ...

Still looking for a DT ack, here.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlpfpeAACgkQtdYpNtH8
nugr2w//fvHDUrGTYOKrxPgEtkmEpIYI5Rj3FyGJ8+Ryict7Yr15Kfy/SUCAfb5X
bA5grq9DfMH9K0BrZk88EocF3Slr4sMMfO0+efWFPrkEJEJHdKi3td+4vEJVeaKL
oEtTwSscMtp+TGZRUaUxufnNTnvqq17aTUaxVGkXC6cDCNxWleEuQ4kQdP6ZmWWQ
fXrX1F+l2ieLtiWIh1XJYBCUE/2fqA5EbNNa8Vq1WYn/2ieiYZlfFpfOiDPBBTLX
ZggdrawhsO0eJyzoVFGzOgfzo/r8xuXhZcWI+fvKp681qVFC8WKCY7Bhoyxsn/5I
J2p4PBjReYoaqPM3/5fNcnyp+fdrbPhNlBb8gcJOAJLB/I0xzrY0nmFFfZnA+JHY
qkO3ymKFWtU63/eqAt7H6zKqX2uhrt1WwnChbjoanJboig5YYrSY51GKjHLL0ZJf
wHuswTlT1fuZZzvZgqQ/f1S+c7dB8r1Jl72ZD8dVqSQG7IPX958mUQamPZkP2dz7
IbQbzXJtJBD6Ijn49ICxWddzQO7dNvMfDB8eAHfUAEPhumpBN0/LF+qdfpOzsoQi
UM2v7/v7ng2qf7jgMa/g7gssW7wYlRmnJXK9SuZY1YcPy4Vh0YS3chRWle48ijmo
iw0bNFz94TQsQXbjYqU7E3Xf+xvLDm3ffTZELH2sad09QoMxhsY=
=j7T8
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
