From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 33/33] ASoC: Convert to devm_ioremap_resource()
Date: Tue, 22 Jan 2013 08:55:52 +0100
Message-ID: <20130122075552.GA28158@avionic-0098.adnet.avionic-design.de>
References: <1358762966-20791-1-git-send-email-thierry.reding@avionic-design.de>
 <1358762966-20791-34-git-send-email-thierry.reding@avionic-design.de>
 <20130122074824.GE1766@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130122074824.GE1766@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2013 at 04:48:26PM +0900, Mark Brown wrote:
> On Mon, Jan 21, 2013 at 11:09:26AM +0100, Thierry Reding wrote:
> > Convert all uses of devm_request_and_ioremap() to the newly introduced
> > devm_ioremap_resource() which provides more consistent error handling.
>=20
> Applied, thanks.

It's probably too early to apply this yet since the first patch in the
series, which introduces the new function, hasn't been merged yet. I
seem to have handled this poorly, as David Miller already pointed out,
by not Cc'ing everyone involved on the first patch.

Thierry

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ/kYIAAoJEN0jrNd/PrOh2NMP/33LhnrtqB9mDGZrCLSbTcF1
f5O9xdMID/b7K9wUurFFxUTq0uAJEvPWzjMsnxrs9zx3+zAcKDp8YiziLK05Hie0
M2sfuOf/HtJoNm+OyWiuqWGJQT7hYICHDX/zrHYFHLyGI1Hj8MuD9LApBviZ5PLH
8wwjCZm7etR1oIhCBQv9Rh7V5GPLvBjL1YD1vjU5Mh1Sbn3J1Rs2Qak7wJR9DL2S
O/nS6J/XNDoXetudyHUV4pJ23l6j7LyX2JSG/qklnxlSrj0GmgPTwGdhihmXTSHk
eFgovE+FTr7x6PevHfw/3GFEfdhLoabPi8HZpTPZESKiRmNt0QhOLJss9cvzHNp6
ujcvHCL+6JfXeqQiv27XQZrg5PAOIB9h089KBK9jUEzMAXaYSIp5Ii/GKKNNGLYa
yoY/1SnzB9wkzb7K8QTuD1HhuR7BdSi6Jigbhg0TpnM/vF5GHTfJJwYlyLNRSOje
gzFPECIeIkzP4QND/anfDTKobzdqo4AcmMrIZc44bxR7WFMJ9xByoI183eBkBwBm
mxLbLE1ydTRR+Hudrb13+wOTZuJ/F3SqjguCrI4u9U57ecju3l4DZNMhi3wa+KYu
VWjOysIBKPitcXER9PdYKVHJ/y2SBu4EX6NAK/VLbKiVzsuAwDdeBkoV5XN4MZCx
JKCioRENtF+pEHqJnMgx
=/0o6
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
