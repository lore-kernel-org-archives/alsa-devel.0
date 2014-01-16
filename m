From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: DPCM: make some DPCM API calls
 non static for compressed usage
Date: Thu, 16 Jan 2014 12:31:53 +0000
Message-ID: <20140116123153.GP15567@sirena.org.uk>
References: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4363450441596359395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C30A261616
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 13:32:00 +0100 (CET)
In-Reply-To: <1389804717-5985-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4363450441596359395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gS/sOEqITpbrYRmu"
Content-Disposition: inline


--gS/sOEqITpbrYRmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 04:51:56PM +0000, Liam Girdwood wrote:
> The ASoC compressed code needs to call the internal DPCM APIs in order to
> dynamically route compressed data to different DAIs.

Applied, thanks.  I'm holding off on the second patch for a little so
Vinod has a chance to say something since it's compressed stuff.

--gS/sOEqITpbrYRmu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS19E1AAoJELSic+t+oim9tkQQAImyg+qzUT+uGz4gpbfTpQQy
ymEaoZ9SqBlI1IJsQ34TDHPzQikABR3gCTQC35KosPH0J5XJ+51FMls6nzj0IDpB
hapRzgEBAMVVVrnKcNvvU5QhBFrNvcVsLVugBrRHv88KbxXZ1BYTF+LDueQByJwe
7LWd01WcswCY3xAhJgV6QX84f6aEdVSvi9wAyqjd3+PpwO95k/tlwFYOAmBvkMOu
FSXASLWozypUUsNTbhtmysGrJnOJrXkDLiSfb75sqzJoDS2mbmfztMRx1lMi27DF
IlP7SFXmprUm2maLmK78zCIdA2QRspNTxebqPZH/JNEg0U5ro85cLhsAEXgWzLzQ
kgau+2oT2+khjOMUosPEfzr/22RZ8xKzPQDuPwxQvgFmKPvibc8n65UbYbthCiB2
n5dDTrLCYJW6QU7+HE/RDWc293ZBnHCZWMp5J6RDbu0Kwcm/iSXX0WXqrbNR/jXL
RKDG7ljVYjVZnmf8zMBdne21AaCS/mDJWEo0j98lk/xc6XucuEcoiUbO0Xj+HIvZ
lYUZCNVsttQv9TcDDagnLXw4LgXC2zsZ3jzd5NpZw+xvekYzEKo4IzpPSDpIufAR
xv+xjvgzdy1d/t+iBB4p/DM0POFIQgNE4VzaCTv625rCiRUYKvvxycbP8tqBeNHp
5VwNL07DffwLqlXnEcuu
=oxSM
-----END PGP SIGNATURE-----

--gS/sOEqITpbrYRmu--

--===============4363450441596359395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4363450441596359395==--
