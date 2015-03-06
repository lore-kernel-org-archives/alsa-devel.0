From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for NAU8824 codec to ASoC
Date: Fri, 6 Mar 2015 21:07:22 +0000
Message-ID: <20150306210722.GK21293@sirena.org.uk>
References: <1423986570-6355-1-git-send-email-Vincent.wan@amd.com>
 <20150224141314.GI6236@finisterre.sirena.org.uk>
 <54F6FC28.4030403@nuvoton.com>
 <20150304125527.GM21293@sirena.org.uk>
 <54F95721.7040103@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qNmcRovokQDZCUb0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F95721.7040103@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>
Cc: "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--qNmcRovokQDZCUb0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 03:28:33PM +0800, Chih-Chiang Chang wrote:

Please fix your mailer to word wrap within paragraphs, it makes things a
lot easier to read.

> On 2015/3/4 =E4=B8=8B=E5=8D=88 08:55, Mark Brown wrote:
> > On Wed, Mar 04, 2015 at 08:35:52PM +0800, Chih-Chiang Chang wrote:
> >> On 2015/2/24 =E4=B8=8B=E5=8D=88 10:13, Mark Brown wrote:

> > Add relevant control types if you need them, it's important to have
> > proper stereo controls available to userspace.

> We cannot find suitable macro in file "include\sound\soc.h", so we want t=
o add below two macro for our chip.
> SOC_DOUBLE_L_R_VALUE
> SOC_DOUBLE_L_R_TLV

Sounds good.

> >>> This looks like you're reimplementing regmap's register sequence
> >>> stuff...  It's also a *very* large sequence you have, are you sure it=
's
> >>> all required?  It seems like this may be doing a bunch of machine
> >>> specific configuration but since it's all magic numbers it's hard to
> >>> tell.

> >> Initial settings are arranged in order

> > This doesn't answer or address my concern.

> These large number of register setting is used to initial our codec,
> and some of other codec have the same behavior. We will remove few
> unnecessary register default setting and add some remark for
> registers.

I'd really like to have a better understanding of what this is doing -
it can be valid to do this but there are some warning signs here such as
the volume of writes being large in comparison with the set of controls
the driver exposes which mean I'd like to be sure the use matches
expectations.  Normally this sort of thing is a small number of fixes
for undocumented registers or updates to register defaults changed in
later revisions of the chip.

> > Don't include noise like this in upstream communication, if your company
> > won't fix this then please use an external mail account for upstream
> > communication.

> Our MIS report they have disabled to append message in mail. Hope you do =
not see it in this mail.

It's gone, thanks.

--qNmcRovokQDZCUb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+hcJAAoJECTWi3JdVIfQg6YH/1M5nzCRagPQG6eggs6T9+Qu
cYGDJ+4EasNBfenrOZMGuqzZrPun4btjAscXHaaxTOmrc2VIjSxMMr8ReS164Dp5
txtIcFbhkD2tFmwuk+LWUUBNCm7D8W/T1FHgiJbU6FMx9qQXZNbfV1HSPJ9UlelV
c/kYbczgNDT7GuzzPxGI9b2lLMigiCgF7gyfKLmbPl29eirWVdztpLW23SOcy/xo
XSsFAOiZylufhs6oC0bXcJK1NsmLiv2kAbr9pX9vpVO/WjhFiaofBwyrIvYe4vVY
nNQS6JH8ZeCcP8sRHxLV4cTHRgu2CuQD1xumga8YzJ62gpw61vOlQ6oFRgnPZ14=
=aHXV
-----END PGP SIGNATURE-----

--qNmcRovokQDZCUb0--
