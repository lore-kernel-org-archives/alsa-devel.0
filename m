From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Do not traverse widget hooks to snd-soc-dummy
Date: Thu, 17 Mar 2016 13:37:16 +0100
Message-ID: <56EAA4FC.5090408@metafoo.de>
References: <1458127071-14417-1-git-send-email-harry.pan@intel.com>
 <20160317095438.GD2566@sirena.org.uk> <1458211115.965.13.camel@intel.com>
 <20160317112514.GE2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Cv2biiibNwtgtOvmpmobob0PsRFPBQmNi"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160317112514.GE2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Pan, Harry" <harry.pan@intel.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gs0622@gmail.com" <gs0622@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com" <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cv2biiibNwtgtOvmpmobob0PsRFPBQmNi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/17/2016 12:25 PM, Mark Brown wrote:
> On Thu, Mar 17, 2016 at 10:38:36AM +0000, Pan, Harry wrote:
>=20
>> Allow me to explain more detail that I saw during debug; since the
>> commit 6e78108bda78 (ASoC: core: Don't probe the component which is
>> dummy), an exception has been made that dummy component won't be probe=
d,
>> thus the 'card' passed into soc_probe_component() would not be assigne=
d
>> to this component. In the other hand, the component struct is initiall=
y
>> created in snd_soc_register_platform() by kzalloc() of platform struct=
,
>> its 'card' pointer is remaining an NULL pointer even the widget node
>> being read.
>=20
>> Perhaps another option is to refine soc_probe_component(), which I hav=
e
>> not dive in.
>=20
> Another approach might be to create a separate dummy component for each=

> card rather than trying to reuse the same one for all of them (which wa=
s
> what the commit you mention was doing) - that way we don't need to worr=
y
> about it getting added to multiple cards which was the original problem=

> that was being looked at here.

I'd say as a quick fix for stable check that card is not NULL in
dapm_widget_show_component(). And as a longterm fix get rid of dapm_widge=
t
file. Nobody should hopefully use it anymore with debugfs being available=
 as
the far better alternative.

- Lars



--Cv2biiibNwtgtOvmpmobob0PsRFPBQmNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW6qUEAAoJEOj3aLScRbOZV4EQALErneQLzJ8/PkqJiHcoFSFJ
67dTkkXKgOnhHS0FEV2vwy2W9YWFj6F87DP8Ji/cuyP2neL5/O4CODDiDJndJqWz
jOMFhIeJgqVCJAeLvf0xIajKWNWyWOpEXVsNRerzgCgvAYo8acyAE2QvjUNPnviB
a84TqP0qK8dVrJYq+TA45+LsjFOmJbYNGXZqaRKJV2R8PrM/9bkU87OI7pokG75O
Yabba2Dz+aYgDg65Lv1J9tZw24Kl1dWgZ47Rt2dtckKTofV14IoTYtEHApnOW84o
5+ksDhxw2lTX6r2EKzfgQWs7w5/EuNzHUEWDC1/pyzOXsRIv9uIg9+5WRR8Zvt2I
AXCnf3wT2z9lBeL9MKdnWcdKl3g/q/dwcaqVJOGiwfYcUYufVrddq1axYVqmLUb6
LWc7AS9hoX98YmNV+tDK+F2Hh9w0c6NCxa62YrZ5Mt2ymHhSd3VLFiObJ22sURdg
0A3or3vvaFq2Y7ySeqe8gQcia+0RW2TnFGVfBhAnv1XwvoJZF5/IYFiyA+vW5UfM
Po/YF6Jd8U+gt74RZls9QNFLLQh9W+9uY8UcBsB9RrMhfc96v3BIBrhAbNraRDkT
KhK0fzN1KBi6q00BApJXXXfL2Z/EiN5DLPDsWi2nNE7TtpBXEDSi5VlKZwikWiyD
pvZuhJZGWt8h2Si3wB7c
=Kn5e
-----END PGP SIGNATURE-----

--Cv2biiibNwtgtOvmpmobob0PsRFPBQmNi--
