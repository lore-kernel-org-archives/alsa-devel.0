From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] topology: Add support for included files
Date: Mon, 19 Sep 2016 10:09:06 +0100
Message-ID: <20160919090906.GF10189@sirena.org.uk>
References: <cover.1474262798.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8775239965063485029=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D199F261740
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 11:09:18 +0200 (CEST)
In-Reply-To: <cover.1474262798.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8775239965063485029==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 19, 2016 at 01:34:44PM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> There is no ABI change in this file, but only an enhancement for topology
> user space library. It will let a text configuration file include other
> files, so that some common cofigurations can be shared and we can reduce
> the total sizes of files.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX36sxAAoJECTWi3JdVIfQN6YH/2wVrhRG18pZUYKQbQ1h8KK0
haqodL85v1lkxfbfQfEDfV1lHtEHY0/WNeE/5ryLGPukgVpXHVFHdwdK81gApjuc
prn4ZO0YpGcsmCaajPfzFOVQRyw+s/1yrv4Yl3EmobCu6m1aAiJ+a6no6Oczu9UC
84LT/FiaabrR9O0iX7j4KnixaUgjmNowAWnDlwsA36NgDdhK2U4JsXEjt8BVMre/
L5aPgrsqE/c98T6k1g68f7REp7A/P+J4K2QzaPr86j70JUij/kPUgBQUfK3/c8Vf
s3sjydnuPUpH7x/sIIeIfzp2xJL2+ogDACok20H+zWNnN72EZ0nPJq0xPRj0BYY=
=q7DU
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--

--===============8775239965063485029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8775239965063485029==--
