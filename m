From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: Intel: remove conflicts when
 load/unload multiple firmware images
Date: Fri, 6 Mar 2015 21:08:24 +0000
Message-ID: <20150306210824.GL21293@sirena.org.uk>
References: <1424823981-14133-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6482863078305492685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7280266085
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 22:08:29 +0100 (CET)
In-Reply-To: <1424823981-14133-1-git-send-email-han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6482863078305492685==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2otm9oCO281xmWKR"
Content-Disposition: inline


--2otm9oCO281xmWKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 08:26:21AM +0800, han.lu@intel.com wrote:
> From: "Lu, Han" <han.lu@intel.com>
>=20
> Details:
>   1. Unload all modules on fw_list of dsp when suspend, and reload all
> modules on fw_list when resume.
>   2. A DSP expects only one scratch, but hsw_parse_fw_image() allocates
> scratch blocks for each firmware image it parses. Move the allocate funct=
ion
> sst_block_alloc_scratch() out of hsw_parse_fw_image() to make sure a scra=
tch
> be allocated only after all firmware images be parsed.

Applied, thanks.

--2otm9oCO281xmWKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+hdHAAoJECTWi3JdVIfQAOUIAIJms2FNBYofI6+ZDEkDklw9
e5+pf2Drs8gBsd2XmAekYLff9e2dYnzonXKkFTWZ4sW9a0na9blIM3t2/o5cQiVG
eAUbaODhs2dIob0syV1wWH2awVjJktVE7/ExHrZCi0h8te9fYK+RkVwX+tcglrzd
4VeQubeX27gsh5YuW7BmsNjVxuXmtzUqAP3C3+iqkFbYFKni6wAsIehdVVdK2f2e
ASAGTvktt3TggNG+YE7EvY06i3mYWHBkCNe4UiBAHafOhmDxnXD/cTe3vHzjyh20
JK+CW8nFH1ubVJ74abvLZ4Q8+g7UXr9JVnMXrYuCK1m2ZA8N1uGbQyUgsIg5feE=
=Q/n9
-----END PGP SIGNATURE-----

--2otm9oCO281xmWKR--

--===============6482863078305492685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6482863078305492685==--
