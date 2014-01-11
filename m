From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: dpcm: don't do hw_param when BE has
 done	hw_param
Date: Sat, 11 Jan 2014 12:08:26 +0000
Message-ID: <20140111120826.GS29039@sirena.org.uk>
References: <1389332195-15900-1-git-send-email-nhcao@marvell.com>
 <s5htxdcxg0q.wl%tiwai@suse.de>
 <52CFD7BE.5030907@marvell.com>
 <1389354435.2293.32.camel@loki>
 <52CFE0AE.1030606@marvell.com>
 <s5hk3e8xcz2.wl%tiwai@suse.de>
 <1389356948.2293.55.camel@loki>
 <s5hd2k0x833.wl%tiwai@suse.de>
 <1389379389.2293.114.camel@loki>
 <s5hzjn2n9ne.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xe2geHXJg22At20M"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hzjn2n9ne.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nenghua Cao <nhcao@marvell.com>
List-Id: alsa-devel@alsa-project.org


--xe2geHXJg22At20M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 11, 2014 at 10:35:33AM +0100, Takashi Iwai wrote:

> But, the point is that basically we already know that something is
> wrong at the point BE2 setting up an incompatible hw_params; then it
> should be notified properly to FE1, or the incompatible change must be
> handled as an error.  This is the missing piece in the current
> implementation.  The skip of redundant BE hw_params call can be
> implemented as an optimization in this compatibility check, too.

Only in the case where they actually are incompatible though - if
there's DSP in place which can do suitable mixing it's not an issue.
At the minute the core is relying on the drivers handling any limits
just like with the CODECs.

--xe2geHXJg22At20M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS0TQ3AAoJELSic+t+oim97tkQAIryE4RhnX93Wmo2GJrx8BSi
SGQwoTP8hoAc6nbbb07hYqQDrpVX7Z8vVBMa0diS67l0CS2iauKaLGNtK/I+wBgY
ct45/bFNt8sxdLS53KbN37taz0XiEEZkpVgY/Z6hszwmZ04+xLz5tqLNm3dCsWus
UMWFOVu2nAEETypJDCFBtKzRWAVjKmaG4C1x4cnBg4K19q/ydZkaVzh8ytKoMIM2
fPTxBlhh548ISpX+0aPkzdmpswek1bZnJ8uBBij7qGnvn7ccjyIvU5PTTf94mlPu
GAkRkX/NILejCt658JCUT+f3jDWDMQQwf5y2v7iU7ycNHlMvmwFRXiE/QDnX+LdF
biR9RGttPKGlQYb5VU+S8eHPLSGu+vKV9UawTyEpvGXK/AlIKPqxuPoVdbuxL9E+
+JkoLt84ao08FSCtTpQ3AAFHFdM6jcCoc1iufMmb0dPqboPpF+oIuLyJvRmIDCqZ
ZYwljOJUwV+SCR3DCJ3I/JyznnOIuVQLpzOvj5aR9+t1z1pX2j6JooRYHzIqw11F
zGC7PF3I8rS6q/kpuh4WzVWz+498fzgCqLbRhETAK5aK8adUd+q2oYC+2ggpe4zM
JKJeicMh5yF+9LV2Wj1YL6XbH6l0WUgbftQ7ryrINr3vxn5ndHKFrrJasmpDIryw
/8GOJrwk7gak8z4XNn6h
=aetL
-----END PGP SIGNATURE-----

--xe2geHXJg22At20M--
