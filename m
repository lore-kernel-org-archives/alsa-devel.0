From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: merge conflict between drm-misc and sound trees
Date: Wed, 14 Mar 2018 19:05:18 +1100
Message-ID: <20180314190518.6e139bdf@canb.auug.org.au>
References: <20180314063801.GA26553@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0882282320=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180314063801.GA26553@wunner.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

--===============0882282320==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T8FhFnZrDbFWFu/adlSMTHu"; protocol="application/pgp-signature"

--Sig_/T8FhFnZrDbFWFu/adlSMTHu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

On Wed, 14 Mar 2018 07:38:01 +0100 Lukas Wunner <lukas@wunner.de> wrote:
>
> when rebuilding linux-next you're going to see a merge conflict in:
>=20
>   sound/pci/hda/hda_intel.c
>=20
> betwen commit:
>=20
>   1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")
>=20
> from the sound tree and commit:
>=20
>   07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")
>=20
> from the drm-misc tree.
>=20
> I recommend fixing it up like below.

Thanks very much for the heads up and resolution.  I'll still report
this when I get to it just to make sure I gate it right.

--=20
Cheers,
Stephen Rothwell

--Sig_/T8FhFnZrDbFWFu/adlSMTHu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqo174ACgkQAVBC80lX
0GxzPQf/UTL5y/+nnI6VKIFmvU4qt57v4YqbzBVuezr7moWR5rgPFJQQhcU90AXl
9SsyoP0ckDLpZmkoUHFCU2EGK4+GD7pbsTrZbhzdPwXLWSPHVKOsvq+qJBW1bPOH
+OSoYkeWd1gzucRhvWB6CtAXav0FwbEjuQ0AhTM3Z2DejD9m6RRbDnYf8pNoMdlb
aSOqFb3Tx3xKrcJLHNuiFgxsJEjrmQmwsFbhoSGEAquQsRP+ttVAOaGW4JNnEbeD
kwIcC2v03z2HRqibS4mfz0AD1ySbKQ01+t2DnTmMvSFHftcqP0nMSiynChbyz67l
uPHdbKSnnJ3Id1H9k8W8TrEq508waw==
=uLZG
-----END PGP SIGNATURE-----

--Sig_/T8FhFnZrDbFWFu/adlSMTHu--

--===============0882282320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0882282320==--
