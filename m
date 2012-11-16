From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v6 1/4] ARM: at91: atmel-ssc: add pinctrl support
Date: Fri, 16 Nov 2012 10:03:11 +0900
Message-ID: <20121116010310.GG4387@opensource.wolfsonmicro.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352887751-21848-2-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2012 at 06:09:08PM +0800, Bo Shen wrote:
> Add pinctrl support for atmel ssc peripheral
>=20
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

This generates lots of conflicts in the pinctrl stuff in the DTS - looks
like it was generated against -next.  Can you please regenerate against
my atmel branch with just the changes to add the pinmux information on
the SSC nodes?  Or possbily this can just be applied direct to the
pinctrl branch (we'll get an add/add conflict with the SSC nodes though
that should be simple to resolve, a cross merge might be helpful).

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpZC3AAoJELSic+t+oim9LVIP+wfSXHZBOMfHDlLea+R7HxJp
gBOmulLYK7kVEuRWFQimv8EruQRwUurQCXeXxbV8QGbrxV+BlUqFSJ5mPZLp6l9S
No6VRIc7uqpZKLVUVtcuI78HeilV3Ffb9mgcPIPULx5XRhaiHK5ipT7459YIb4PA
4t2OLjEiLNY1IEXR49Zk/oDBehSSCz8lGHVShSqpKbCkinWbb6vZGU6v4qVFscva
CEkVQscW7R4/iUQz/BEo/kVwrm+DlvpfUDmOUFC/4C/N67RtbTaHmuk5VQ+thnMG
Sd3XznyDlur2jJHBfG8YfodRr/l+rhLRQAg+OnMw62rh57ZAv5XngX9vVI595QwO
GlZYmenvKur/OcA+Uco6sFYqBTGigI4p4EM91IoA31fM4J6pG0CXVLYsVeCos6p4
n4VnhkZHPKDsfSjiQdPevBL0sUYWCZnRZ1LVGFRMaQBB5VHo4a+/NmFFTOUO5OXb
nPAejNdgnW6G93tZyxT4PGO+ZpS4zFw59KfMpiBbJzmf2G22uXua1azR6iGREDGC
VZuAeVPK3YVLeXH9rrUaylP+3o6NucOho9MO/aTciKLwHZYRFOK1uPfZyBUDWHIR
o7FVbSkqyL+qSPQs/WMWeNBNQcp16pUYMwd4atx5nvppkbKKyiapgxT7GJwaWC6N
S5N1Rm3PlLZ3u+ZaqZdE
=/FNn
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
