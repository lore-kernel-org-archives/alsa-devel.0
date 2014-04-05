From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Sat, 5 Apr 2014 12:48:11 +0000
Message-ID: <2009B58E-4C0C-456B-B7D3-5ADC68931CE5@cirrus.com>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
 <CAFRkauBYAZDrrbGkZH3jGKzMJHYMEN00yXgLWtk+9m_dwDqB_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3710237089062095586=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 79E2F264F40
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 14:48:17 +0200 (CEST)
In-Reply-To: <CAFRkauBYAZDrrbGkZH3jGKzMJHYMEN00yXgLWtk+9m_dwDqB_w@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

--===============3710237089062095586==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_B3067451-2E01-4CDF-A636-37BBF3EF926D";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_B3067451-2E01-4CDF-A636-37BBF3EF926D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On Apr 4, 2014, at 8:59 PM, Axel Lin <axel.lin@ingics.com> wrote:

> 2014-04-05 1:00 GMT+08:00 Brian Austin <brian.austin@cirrus.com>:
>> On Fri, 4 Apr 2014, Axel Lin wrote:
>>=20
>>>=20
>>>        ret =3D regmap_read(cs42l52->regmap, CS42L52_CHIP, &reg);
>>> -       devid =3D reg & CS42L52_CHIP_ID_MASK;
>>> +       devid =3D (reg & CS42L52_CHIP_ID_MASK) >> 3;
>>=20
>>=20
>> What you added does the same thing as what was already there.
>> The CHIP_ID is E0.
>=20
> Use CS42L52_CHIP_REV_A1 as example:
> 11100001 -> CS42L52_CHIP_REV_A1
> BIT[0:2] REVID
> BIT[3:7] CHIPID (CS42L52: 11100)
>=20
> Current code displays:
> 0xE1 for REVID (because it uses 0xFF as mask)
> 0xE0 for CHIPID
>=20
> I would expect the driver displays:
> 01 for REVID
> 11100 (0x1C) for CHIPID.
>=20
Which it does not, but your addition of the  correct mask for REV_ID =
does.
But this block of code only checks devid to make sure we are this =
device. Nothing more.

> I think current code mixes REVID & CHIPID.

Only for the print statement. Not the DEVICE ID check.

> That is why I change the define of CS42L52_CHIP_ID to 0x1C
> and change CS42L52_CHIP_ID_MASK  to (0x1F << 3).
> In my point of view, the chip id is 0x1C rather than 0xE0,

CHIP_ID is E0

> we got the chip id by reading BIT[3:7] of register 01h.
>=20
>=20
>>=20
>>=20
>>>        if (devid !=3D CS42L52_CHIP_ID) {
>>>                ret =3D -ENODEV;
>>>                dev_err(&i2c_client->dev,
>>> @@ -1259,7 +1259,7 @@ static int cs42l52_i2c_probe(struct i2c_client
>>> *i2c_client,
>>>        }
>>>=20
>>>        dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision:
>>> %02X\n",
>>> -                       reg & 0xFF);
>>> +                       reg & CS42L52_CHIP_REV_MASK);
>>=20
>>=20
>> This works
>>>=20
>>>=20
>>>        /* Set Platform Data */
>>>        if (cs42l52->pdata.mica_diff_cfg)
>>> -#define CS42L52_CHIP_ID                                0xE0
>>> -#define CS42L52_CHIP_ID_MASK                   0xF8
>>> +#define CS42L52_CHIP_ID                                0x1C
>>> +#define CS42L52_CHIP_ID_MASK                   (0x1F << 3)
>>> #define CS42L52_CHIP_REV_A0                     0x00
>>> #define CS42L52_CHIP_REV_A1                     0x01
>>> #define CS42L52_CHIP_REV_B0                     0x02
>>> -#define CS42L52_CHIP_REV_MASK                  0x03
>>> +#define CS42L52_CHIP_REV_B1                    0x03
>>=20
>>=20
>> If you used this it would be cool, but your not so I don't see the =
need for
>> it.
>>=20
>> So if you want to add the code to actually display the REV_ID I would =
ack
>> that, but I dont see anything that this patch actually fixes.
>=20
> I think to actually display the REV_ID or not is another topic.
> This patch does is to fix the display value.
> (see above example, both chipid and revid are different from original =
code).

Then just fix the display value. which is the 1 line that fixes the =
REV_MASK. That=92s a bug
the rest of the current code works just fine.

Thanks


--Apple-Mail=_B3067451-2E01-4CDF-A636-37BBF3EF926D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTP/uLAAoJEHdXZdGWfiO7IwAIAME57u0JCsKUaG5NxovMtM7u
bSbdTIQzICcvd1TBaO+nxsnS0a/z3jVN/YhadZPfvnHF/t1rw9dW5M957sg5slqc
hdnypXC+AuGoZcHVV3OEOoNEHTRr/9cK3sFoLwb0PqyouSPUo0+ugqcYIBWQX9JI
EQN6t+/D89KzL3T0EyXLdHTHZ1+ZOAToRUlkqT9NSaVvobZwZ2DgeFCPTwvEShu9
ko0IOcr4j6clp2ez7K1QErxIOO4Fj8A8N0LhM6TpbyAmcJIsTr+Nt8c0V8crPZF0
yA7KW4WeNyYiFUVWPMyo35dfPP1+5Zxibrfg90GL6WY2qjIezL3PmdJf4uoxeAI=
=ASGu
-----END PGP SIGNATURE-----

--Apple-Mail=_B3067451-2E01-4CDF-A636-37BBF3EF926D--

--===============3710237089062095586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3710237089062095586==--
