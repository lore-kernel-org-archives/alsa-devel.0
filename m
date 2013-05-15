From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: spear: spdif_in: Staticize non
 exported struct
Date: Wed, 15 May 2013 08:48:48 +0400
Message-ID: <20130515044848.GD24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8759859895340853624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A35D4265148
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:48:53 +0200 (CEST)
In-Reply-To: <1368562797-10440-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8759859895340853624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:49PM +0200, Lars-Peter Clausen wrote:
> The spdif_in_dai struct is not used outside of spdif_in.c, so make it static.

Applied, thanks.

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxOtAAoJELSic+t+oim9aNsQAIfnAwuhTi0myhhMUQncC2CK
Sa4ic7HbvWjX9NavV9MNpvx/brBeSFsXwHN/Wcb60hJe/2vi9a4hw67lAppLuiJI
dFPiEuF9yJT6b9DR7BaqmF3D9ZA3SMQE1qFUH+THbr1mEnMLx8yoBharBHyLYiQx
BfrOIDPzYj+tgJMEMehwhbwc2/q31FnoTGGKIxbAkvYFTTBXupK0WAykVD6IYH63
aMtAdpu/qpnSTIEnWB3Z5SYKOUg80dTILDhsdQB/9IGLxFl91TodrJYXXYzcHd7O
j85B85JUR5SG76LgjChF2vK89c0x3RFD2vJbdgSPagHmrhlCp3DNJNd8SG6hokVd
ZCP/Jyr8YXYkhlFFVy7nMMvWNwsTDu/KS95TX46MRTi2T/TC+scDgeYB1QU0BBSF
gxyx/u14eOMr0RLaxBzpBr6tjyCroMIiOQwPab1wljQCtuQTrMDI8vj37j4VZgLY
va3VR3PnZsiwinmvXQvv0/4dsOOSFJ09T+Ai12YOzmUq72WmnYkn/BRdPuJ+HwPG
0cl/sRY+crHXCivzVn+GnwHYUlo9Cerwzou/NURGnNwwuLxTdyRNWny/UxnvE9pD
RRjp0GUsHtcLO1k8lE9RpuVx+pwmDnagc4GgLNDBgd2vHHZSxl6Jm0OGuZkAOHtc
A3SuT9NweqKmLIhnp+HF
=DUO9
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--

--===============8759859895340853624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8759859895340853624==--
