From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/12] dw-hdmi development
Date: Mon, 10 Aug 2015 14:21:36 +0200
Message-ID: <20150810122135.GZ1262@ulmo.nvidia.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0320246987=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0320246987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NSDslKtQVY7LeFYu"
Content-Disposition: inline


--NSDslKtQVY7LeFYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 05:02:51PM +0100, Russell King - ARM Linux wrote:
> This sub-series is a mixture of development:
>=20
> * Removing the incorrect pixel repetition configuration code
> * Preventing pixel-doubled modes from being used
> * Adding interlaced video support
> * Implementing the sink_is_hdmi/sink_has_audio flags I suggested a few
>   months ago
> * Only enabling audio support if the sink indicates it has audio
> * Avoiding double-enabling the HDMI interface
> * Fixing the mis-leading name of "dw_hdmi_phy_enable_power"
> * Adding connector mode forcing (important if your monitor bounces
>   RXSENSE and HPD signals while in low-power mode.)
> * Improving the HDMI enable/disabling on sink status
>=20
> For review (and testing if people feel like it).  Acks/tested-bys etc
> welcome.  It applies on top of my drm-dwhdmi-devel branch, which is
> waiting for David Airlie to pull (see pull request on dri-devel, 15th
> July.)

Hi Russell,

I have in the past merged patches for the bridge subdirectory via the
drm/panel tree, though lately much of the dw-hdmi patches have gone in
via Philipp or you directly. This seems to have worked fine so far, but
this time around I carry a patch to clean up Kconfig and Makefile a
little and bring more consistency to the subdirectory and I think it's
going to conflict with your series here (and potentially any ongoing
work you have).

Would you be open to me picking up these patches into the drm/panel
tree? It feeds into linux-next, so the code would get some exposure
before Dave's return.

Thierry

--NSDslKtQVY7LeFYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVyJdMAAoJEN0jrNd/PrOhvxQQALRJHKzmuvaznRXE/GFte8Pu
f8cfn1OBU5Lc/Y5X660R4XoXAQKAEmibN/rqRp/5Bm8Mb5UO2bPb1KNGsiTpqUtW
xvQDVy32mK8+m/oTiAQpCzTtLCiHC0U7MriB5Lafkw1XskMuGzrD9M6xypZPqyj7
rBpZNTak6omu1ipLLOAu5P8sz38hn77bvKnq+w2KN5f3e9XlQB7AXF7z1WhcqWr/
zvf+rBvusQtZDdU1iFJa9auIQMVwC7RicB81bEL3bYDRVkkikp9eIkH4BToQgeI5
eFtwlaBsb7PWI5chKtzLppS3EoEl+yv2X/+YwxduCk9AqBOpnrUIOvH+FStycZ/D
ZGOF7Dy2ewF4g++ujpnPNDeNecXpvGTe7bYS5Taf56ouKYBSpo3tRLlCdOM3I+Nf
6XxblbSWdLV+bheUYpjE0GIBp8iBKzl+pLtLMSYyXnEZOhxo8SztJypjKbvnQVmB
xCo/AZxJ9W9Ua2fZCWhXo1KjvFfsKBSsYqxh7YwAFUqBw46PYMTo9hi1bVnROwUB
jpgflIcH+xhhrG0l7ZBuXGefl8BktlmgeS3VmbKnOdovyzNQBLSkgFX+va/yWhm8
SheaI7ZK3U/1lniMxXrI14dYUuw3MKQ6JMpkyo7sp19mKiwn9hvTrewqMFCWlxFp
KCesNkZ+jgUkSWsY0N06
=mEX3
-----END PGP SIGNATURE-----

--NSDslKtQVY7LeFYu--

--===============0320246987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0320246987==--
