From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Sat, 5 Apr 2014 12:22:40 +0000
Message-ID: <96BC0C99-89F0-4EA6-897E-168497E12EE5@cirrus.com>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
 <alpine.DEB.2.02.1404041646460.3451@heelrod>
 <CAFRkauCfAN+VwMEW7N-EkvrSdUi-XDe4gm=WDQJPKAttbT-aQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4445733582146553399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0088.outbound.protection.outlook.com [65.55.169.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 283832615B6
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 14:46:59 +0200 (CEST)
In-Reply-To: <CAFRkauCfAN+VwMEW7N-EkvrSdUi-XDe4gm=WDQJPKAttbT-aQg@mail.gmail.com>
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

--===============4445733582146553399==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4E70C11B-A383-44F8-8956-25F9FCAC2968";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_4E70C11B-A383-44F8-8956-25F9FCAC2968
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=iso-8859-1


On Apr 4, 2014, at 9:04 PM, Axel Lin <axel.lin@ingics.com> wrote:

> 2014-04-05 5:50 GMT+08:00 Brian Austin <brian.austin@cirrus.com>:
>> 
>>> On Fri, 4 Apr 2014, Axel Lin wrote:
>>> 
>>>> 
>>>>        dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision:
>>>> %02X\n",
>>>> -                       reg & 0xFF);
>>>> +                       reg & CS42L52_CHIP_REV_MASK);
>> 
>> 
>>>> #define CS42L52_CHIP_REV_B0                     0x02
>>>> -#define CS42L52_CHIP_REV_MASK                  0x03
>>>> +#define CS42L52_CHIP_REV_B1                    0x03
>> 
>> 
>> Correct me if I'm wrong, but it looks like you added CS42L52_CHIP_REV_MASK
>> and then replaced that define with CS42L52_CHIP_REV_B1?
> 
> The diff looks like that but...
> Actually what I did is fix CS42L52_CHIP_REV_MASK, it should be 0x07.
> and while at it, I also add CS42L52_CHIP_REV_B1 (0x03).
> 
> -#define CS42L52_CHIP_REV_MASK                  0x03
> +#define CS42L52_CHIP_REV_B1                    0x03
> +#define CS42L52_CHIP_REV_MASK                  0x07
> 
> Regards,
> Axel
I missed that last line, sorry about that.

Thanks

--Apple-Mail=_4E70C11B-A383-44F8-8956-25F9FCAC2968
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTP/WQAAoJEHdXZdGWfiO7ULsH/jDfWo6pKBf1zVEe43NSTgw8
92Qm0Ok/RoFIHVeUuqvzHNrWLs8w37ZkDoUR444HbDqoaHf4u4wAkGyCjBSjivL2
4CbjB0uD2LYrta6DrNv61oZPC8T+aVrw2Lt/pMWQnt4XCfV8tKtJ/L3waJRkUQn3
PcCw2USHebTHu5WS9DH6BbYj5tTLiSuafcXvGQYLSEY42fsh+VHj7f8s3/npWbuB
R9a5kOBZt33kRvORAKlOIagyH/x8LZ0Fx3jwDhaSLDa4yCH/W0aV911v2CXfx2rH
hoWfRgaXXMgcSnfsmRG3Gsx/bf3Gue0X/p0iInXpPb8m/aTplU3yE7WX8ZV4Z98=
=tx/Z
-----END PGP SIGNATURE-----

--Apple-Mail=_4E70C11B-A383-44F8-8956-25F9FCAC2968--

--===============4445733582146553399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4445733582146553399==--
