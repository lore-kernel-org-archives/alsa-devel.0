From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] drm/amdgpu: add amd_gnb_bus support
Date: Fri, 7 Aug 2015 19:24:01 +0100
Message-ID: <20150807182401.GK10301@sirena.org.uk>
References: <1438871112-25946-1-git-send-email-alexander.deucher@amd.com>
 <1438871112-25946-2-git-send-email-alexander.deucher@amd.com>
 <20150807102508.GL20873@sirena.org.uk>
 <CADnq5_NihZCFEaL150Kt0LWCUBp6eQzne-O0JcCFE0-vHj7ZBQ@mail.gmail.com>
 <55C4D9C3.1070504@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1118201805682077923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACCFF2652C3
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 20:24:14 +0200 (CEST)
In-Reply-To: <55C4D9C3.1070504@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Chunming Zhou <david1.zhou@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, maruthi.bayyavarapu@amd.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1118201805682077923==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 12:16:03PM -0400, Felix Kuehling wrote:
> Hi,
>=20
> To elaborate more on Alex's explanation ...

Please don't top post, reply in line deleting any unneeded context so
people have context for what's being discussed.

> Therefore we created this "virtual" GNB bus that allows us to create
> devices in a sensible place in the device hierarchy, as child devices of
> the GNB. The enum amd_gnb_bus_ip serves as device ID on this bus. The

Like I say this just sounds like exactly the sort of thing we handle
with an MFD, it's a very common pattern.

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxPe+AAoJECTWi3JdVIfQoYYH/0z74J1LuAD87Cxl6r50gzR9
5gSCmkWnxaIdnyG1wkyrh7as4cnH6X9x3QzdDkUy5+tZobj+VHv9Iuc3AWxl4gkB
z2pquaeWmJHbvVlxzeKxebDColmBVjGVf0UQIse3tNDx0lza2YEvc0qgURrvBNxk
mcgvMmpyNy0SL2v6Hhl6dHsUlgdDJxMDfeU3/2Vi1h6WLUrl3iQDTEkquN9HKHZ2
Iq7chh9dwBLofZO83qeGF9eEGi0+8c3MVpkSPVW2VLHqBX/ear4AMnhN0e9V28Gy
2K1WliMT+s0qqPNukU3h6UBqBGFvVt/nGJOZ0mqbtEy+AgdcunWhrrPwD/fPSBA=
=zgNJ
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--

--===============1118201805682077923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1118201805682077923==--
