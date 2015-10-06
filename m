From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Tue, 06 Oct 2015 18:35:28 +0200
Message-ID: <5613F850.1040605@metafoo.de>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk> <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
 <20151006103403.GH12635@sirena.org.uk> <1444144590.25504.27.camel@intel.com>
 <20151006162520.GB30592@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3830581318462051494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-060.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 56EE426574A
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 19:21:07 +0200 (CEST)
In-Reply-To: <20151006162520.GB30592@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3830581318462051494==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="D7QA0aTD0v6qubd5WLhHwHvO2lmuxAL6R"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D7QA0aTD0v6qubd5WLhHwHvO2lmuxAL6R
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/06/2015 06:25 PM, Mark Brown wrote:
> On Tue, Oct 06, 2015 at 03:16:30PM +0000, Koul, Vinod wrote:
>> On Tue, 2015-10-06 at 11:34 +0100, Mark Brown wrote:
>=20
>>> No, I mean that if someone changes a name it'll invalidate topology
>>> files that reference that name.
>=20
>> Shouldn't this sort be checked in the alsa-lib while building the topo=
logy. It should
>> validate the names, graph and complete only when stuff is right.
>=20
> The problem isn't detecting the error, the point is that if someone
> upgrades their kernel and someone changed the DAI link name then their
> existing userspace will break.  We don't want that error to be there to=

> be detected in the first place.

Another thing to consider is that the topology firmware might be develope=
d
against a non-upstream driver. And in order for the driver to go upstream=
 it
needs changes that breaks the ABI interface to the firmware which is alre=
ady
shipped and the vendor might not provide support for updating the firmwar=
e
file. Having these kind of tightly coupled interdependencies between driv=
er
and firmware is quite risky business.



--D7QA0aTD0v6qubd5WLhHwHvO2lmuxAL6R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWE/haAAoJEOj3aLScRbOZj44P/Auqtoa2iKIjHDLz/TEWCJae
LsykFjEMeKDHP73buPoSP6BBRSMRSA/Sy32M9Mpx5cdAZzqftHy+z+coCJ8MeDoM
8DN8ocQtxaP8Q5UjWrSuLkKqCP2cYfqrUONZgWz1yU15zZOygnRIe8zMNctxr0DN
QsBQldUHzJ/jbLiHnp5Tw+4PSkI3WBxfMDqOUh97Ri+7mW5UKOFHttbhgNNYLUOP
k4IYnwEF7hSA6QDdTlP+AziLbhcHRGh+PWpYJKSt4mP4TW5SMah1EIXJU5E8otqx
P6lPsTHXVp6ywRT2NhP94ySbdv8N/2IutnIQCJANkHOHXnAkE/uJjCJTnoA7Q1tG
K98d1qpyx3RpZzJ4DxNRJFm1IG6aQWeK1XM7AiVR7A8DaNisHsFShYn6Mt2X1uiT
hDhFqqN2lC4XIlf4SiUAXt637omE/9oICq2g996q107vhEXES2jWpaB4PjmruEwC
TwbpJOBW80BM4Nk5YAVb5yl0HintiW4+gsW2LFiVuIVr2b2UltL3CCLyfQFdArlx
6J2tY4jLZjEnaPw5694qOkia3ykkULY/ntGkQ8WMl8LH3mKgXtchGXJi2XPo2TwE
0n9HR4nHOTQSITcM+yroQEe088peCa8fEvHALgXsUqwxcpIxiLu+uX2mhTPJ+dKe
cKqq/Vg5unZAncMH8znW
=gDj2
-----END PGP SIGNATURE-----

--D7QA0aTD0v6qubd5WLhHwHvO2lmuxAL6R--

--===============3830581318462051494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3830581318462051494==--
