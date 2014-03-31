From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] ASoC: alc5632: fix uninit var in
 alc5632_probe()
Date: Mon, 31 Mar 2014 21:43:02 +0200
Message-ID: <20140331194301.GB3431@mithrandir>
References: <1396290324-6334-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2137295796999103158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 117622651EC
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 21:43:05 +0200 (CEST)
Received: by mail-bk0-f52.google.com with SMTP id my13so1223058bkb.25
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 12:43:04 -0700 (PDT)
In-Reply-To: <1396290324-6334-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2137295796999103158==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 12:25:24PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> alc5632_probe() returns ret, yet it is not initialized or set anywhere.
> This ends up causing the function to appear to fail, and audio not to
> work on the Toshiba AC100, with my compiler at least.
>=20
> This function used to set ret in all cases, but recent cleanup removed
> that.

It's also completely unused, so there's no reason to keep it:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOcVFAAoJEN0jrNd/PrOhiUQQAJuQ1drYQtmL5R7U2wYVUHM+
SWmSmCS++B2XkMsMLhGMFTb3fE+I2U0No/E/viIyMxemtjZrhuqllZQP8PnMBF0v
RmOj/BL4H2TrdhMaWnaAB/mtekMYlcDJSKUgvZk5yxRnG09BL3mTXUwZtk2y1iUP
PRJzjq7KliQs835cwIWNirDO0LrVMaRWUweDU6TvRZ9qIu3ntBhnIcw3h7VHN39+
HlFwQoMcV5zi12kf2W7NBRR5K/p9dBxMVdvIcG3JvN6CXBN1jhGnzd8leg/CS4kx
o38dftJ1qJcIOIniLcRqQygqPrkFNxHb2Z4G+oQi79BpvGJLkD1S33n8r2qOUQ0K
xaEno+3fedo+I1kr9gefxlK8ds3iPuzcZQxfiMJMZM4nRyshToWwQcK0PVIHxZ1r
sBtJaASxXQKowL7a1DIY2c33iv6tGrE7Q7clwT5N07NhEp7h0IncCoobxvbkNLnY
dPvhpux9APkWAacMh+hOIHTLCaliGid9PPb0zuHU52xQtQs79/z5zddgSausi+Ru
V2Xw+MflUcxG26dN12lxfEKqXn0j3dEYIsTn5EGE1TfZlms7vzjLVjwv5HEdGWTU
PQN5/UpYNSUaasD/RCLF9Cb8XIjSWqwStX6sXQbPXrYpYsoM2sGOOvNq2D9GoM3R
29ujWe9fJ1kMZDmwRS+E
=t242
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

--===============2137295796999103158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2137295796999103158==--
