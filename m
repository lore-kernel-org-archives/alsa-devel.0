From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [RFC PATCH] ASoC: Modify check condition of multiple
 bindings of components
Date: Thu, 15 Oct 2015 15:26:17 +0200
Message-ID: <561FA979.6030407@metafoo.de>
References: <1444743477-48819-1-git-send-email-koro.chen@mediatek.com> <561D0AA9.5080702@metafoo.de> <1444745902.26493.2.camel@mtksdaap41> <561D1843.1020007@metafoo.de> <1444785549.26493.12.camel@mtksdaap41> <561E1991.1050705@metafoo.de> <20151015121035.GE14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JPKCCjUqCRPjWFBVK5mJN5uJ8IiahrslM"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151015121035.GE14956@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Koro Chen <koro.chen@mediatek.com>, alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JPKCCjUqCRPjWFBVK5mJN5uJ8IiahrslM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/15/2015 02:10 PM, Mark Brown wrote:
> On Wed, Oct 14, 2015 at 11:00:01AM +0200, Lars-Peter Clausen wrote:
>=20
>> It was never intended that it is possible to bind a component to multi=
ple
>> cards. That it was possible was a bug that was overlooked and some peo=
ple
>> tried to do it which caused apparently random crashes later on, caused=
 by
>> the data structure corruption. This is why we added the check to catch=
 this
>> kind of mistake early and to avoid the crashes.
>=20
> This is true, but I do think it's something that we should have some
> story on supporting for some of this hardware that has a bunch of
> channels in one IP block that can't really interact with each other.
> It's going to make it a lot easier for people to think about the
> hardware and how to describe it.

I'm not saying we shouldn't support it, just that we can't support it wit=
h
the current code. And adding support for it will require a fair bit of
restructuring.

If a hardware block as multiple independent channels the best approach in=
 my
opinion is to register multiple components (Which we can't do at the mome=
nt,
because there can only be one component per device). From a framework poi=
nt
of view there is no difference between a single device with multiple
independent channels and multiple independent devices with one channel ea=
ch.
Both have the same logical topology.

- Lars



--JPKCCjUqCRPjWFBVK5mJN5uJ8IiahrslM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH6l5AAoJEOj3aLScRbOZ0DYP+wQ0qvOkYDWiFoPX3OZY+/Gi
ykBQ5X9iOpalWxVsCh0k++4YvisZyGqlPu65mUFtvFLcdAnluv4bADw7wALADV4H
BeDtwr0GN2xNab+uYsqae4F2cwqwMM9c7Jn9Tok7k9Hz8pRLNdi628xQOPjrDk5+
SmI231WT8L6RlOOxsESiEMjLpzDLMZDSDNn7KpjkxI6Hlw0kA4UEtjqoSit5rj0n
7X1pI87eWDquceSr/xpXEa7o/Q+qU6DrUnd07cRXrJOoWbVPNeiXJhPyNrALzb3P
vM8Dg6VE3ZoXE5aAd7HADIy2d9QxY2VfntbFh6Ttzky353a9boKEbacehHGWHuLp
j7UCgM+XJp+kQxD+3QCM/bHEUdzgmljf9LFW7MqDnPO/WT5o6wXjDoH7K6Mg+AKg
cou7RnploYjBMon91ZRWTslLRP8U35HzJM95j+BI/aokNfEX6iucQ2+bwr4jHzbm
A50eMjaFjQbKhx7pY89A7KutPP6iVOqwcskO8IQl52KQftdnwaxpNM0Uywpzov4m
QIdSBt2NtQvJmmDcwi6EhlWnRE8SxqsPt47Ar8mL1CaLI58xtsphxOAVy1pZy8Tj
s5brEiNZGRJz0FFT1xWBHZ6FNwJWa9EgQllKyKn4xMxIUPZCCbEgbkMzqy9m/sqJ
de27BWIHDp1aD+uiNV34
=o2qz
-----END PGP SIGNATURE-----

--JPKCCjUqCRPjWFBVK5mJN5uJ8IiahrslM--
