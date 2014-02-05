From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Wed, 5 Feb 2014 14:35:05 +0000
Message-ID: <2AA67204-1A61-4E3E-959A-F50D1E0A2B53@cirrus.com>
References: <1391543731-9085-1-git-send-email-lars@metafoo.de>
 <A40422ED-1EEB-4A09-A550-0AAAAA89464D@cirrus.com>
 <52F15519.7090109@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4967654483978303373=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E93D264F47
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 15:35:18 +0100 (CET)
In-Reply-To: <52F15519.7090109@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============4967654483978303373==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_941854C6-E9C8-4377-8447-97DC740A2F46";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_941854C6-E9C8-4377-8447-97DC740A2F46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252


On Feb 4, 2014, at 3:01 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 02/04/2014 09:30 PM, Austin, Brian wrote:
>>> On Feb 4, 2014, at 13:55, "Lars-Peter Clausen" <lars@metafoo.de> =
wrote:
>>>=20
>>> SNDRV_PCM_RATE_KNOT means that the device can support rates that can =
not be
>>> expressed using the rate bits. The driver will provide a list of =
those rates
>>> specified through constraints. Any rate bits that are set in the =
rates mask will
>>> be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT =
wont have any
>>> effect, but might be confusing to the casual reader, so remove them.
>>>=20
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >
>> I don't see how this makes it any less confusing to the casual =
reader. I think the
> > define works well in the descriptive sense. maybe a comment about =
what KNOT really
> > means instead of just using a non-rate define?
>=20
> The thing is SNDRV_PCM_RATE_8000_48000 does something if =
SNDRV_PCM_RATE_{KNOT,CONTINUOUS} is not set, but does nothing at all if =
either of them is set.


> While when reading the code it will, in my opinion, give the =
impression that the rates that are
> specified by SNDRV_PCM_RATE_8000_48000 are definitely among the =
supported rates and somewhere else additional rates are specified as =
well. But this is not the case all the supported rates need to be =
specified somewhere else, e.g. by a rate list constraint. I find this =
confusing when casually reading the code. And this is the only driver =
that does it.
But that is the case is it not? The device supports the rates within =
8000 and 48000. There are additional rates that need to be specified. If =
anything I see the issue with having to specify ALL the rates supported =
in the constraint list. The KNOT is an addition to the .rates member. =
The KNOT list is added to the .rates member in the dai driver.

>=20
> Also there was a bug, which is now fixed, where additionally =
specifying rates in the rate bitmap when KNOT or CONTINUOUS was set did =
something, but did the wrong thing and caused additional rates which =
where outside of the range of the rates set in the bitmap to be ignored. =
Better avoid that by not mixing KNOT or CONTINUOUS with other rate bits.
>=20
Shouldn=92t the rates outside of the range of the rates bitmap be =
ignored?  Maybe this is a wrong interpretation of how this is supposed =
to work, but I thought you specify the rates that are available and add =
a constraint list to add rates that are not defined in ALSA. Not that =
the KNOT value would mean that you also have rates outside of the values =
you specified.

example: SNDRV_PCM_RATE_8000_48000 | | SNDRV_PCM_RATE_KNOT means that I =
support all rates defined between 8 and 48 PLUS addition rates INSIDE of =
8 and 48.  Is this correct?

Sorry Lars, I just want to have a clear understanding of what the bug is =
and how this fixes it.

Thanks,
Brian

--Apple-Mail=_941854C6-E9C8-4377-8447-97DC740A2F46
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJS8kwYAAoJEHdXZdGWfiO7Yo0H/1e9Moa4GGDgwod8YC5FaQIH
/cd8QWhl2+PMIx7AJu1Mtv2eJaognvvw+0KO1C/fpHq8FJt41X62k/7NE1NLbbQq
A2jinyLzb3IXW+89bDgupXkijSv9JQdev5VU9zpXLahg0ZPrKOCDVOE9UEo8vy1S
LvPc4KVCPnkCT1h9ysU95mLGStiiqG5SLH86G3omBl02mZcTKa2SrU3L7vIBSxRi
/3QklDYJZgnsdlXFLNBYew6GATaPz2wl/NVfH6uQFo7sQPT2YRhz2Cy8dMVxqZgt
YUoskRGYpoLvLjeSj0c+tNZi4UzviT3MzgQE1vzOveH9UGX/ZNm4y5qw7uFZtEw=
=8rqD
-----END PGP SIGNATURE-----

--Apple-Mail=_941854C6-E9C8-4377-8447-97DC740A2F46--

--===============4967654483978303373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4967654483978303373==--
