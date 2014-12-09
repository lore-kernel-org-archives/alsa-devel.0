From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 02/11] ASoC: qcom: Add device tree binding docs
Date: Tue, 9 Dec 2014 15:37:11 +0000
Message-ID: <20141209153711.GB1934@sirena.org.uk>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
 <1418076073-12623-3-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418076073-12623-3-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 02:01:04PM -0800, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
>=20
> Add documentation to the sound directory of the
> device-tree bindings for IPQ806x audio drivers.

Please don't send multiple separate changes in a single patch.  One
change per patch.

>  .../bindings/sound/qcom,max98357a-codec.txt        | 23 ++++++++++++++++

You are reporting the vendor for this Maxim device as Qualcomm which
isn't right, please review the meaning of the vendor information in the
device tree binding strings.

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhxcmAAoJECTWi3JdVIfQE9YH/1SL/uaYFks3jdl1oDIEzVwO
w2XXV7jEGTtQN7JhVYMuW8Tv2XJAtL5fq3qUVhzdK+5p6Q0ezfvar0w+ELuDVWy9
KU5+8FjDEyJlZFqocTLO3wcSSu+netOzI6TYHwtlJ9G7HctmNCxTUZmlpU60tfoO
bncHb8B1JCrfcdQgO7uHuwUXSR1bWt464BlQ0sc+fFW7mQS1+cK/fuTV0fEWTVUA
X5pbqSKeNYVCPnchyDBYCxFIUk4fLET824QN0AemXPKVVcPL0+BebX4XET8zupwq
qHH+YuqvjtawMkz8+zCWcO+Sz+nts5YvGuHXbAWIzzLvTAh/XKpelXqZERfdwlg=
=0aqY
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
