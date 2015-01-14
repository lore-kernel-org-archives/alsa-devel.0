From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
	for audio
Date: Wed, 14 Jan 2015 12:50:56 +0000
Message-ID: <20150114125056.GU4160@sirena.org.uk>
References: <20150112175705.GN12302@n2100.arm.linux.org.uk>
 <1421151718.4519.24.camel@pengutronix.de>
 <20150113122715.GP12302@n2100.arm.linux.org.uk>
 <20150113165411.5469930d@armhf>
 <20150113160313.GR12302@n2100.arm.linux.org.uk>
 <20150113200252.3dbfab14@armhf>
 <20150113192648.GU12302@n2100.arm.linux.org.uk>
 <54B574CD.9020905@ti.com>
 <20150113195415.GV12302@n2100.arm.linux.org.uk>
 <1421232418.3155.31.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4847048719639612950=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05C9626156A
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 13:51:28 +0100 (CET)
In-Reply-To: <1421232418.3155.31.camel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jyri Sarha <jsarha@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4847048719639612950==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9o1Xi4ZMQ45MudWG"
Content-Disposition: inline


--9o1Xi4ZMQ45MudWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 14, 2015 at 11:46:58AM +0100, Philipp Zabel wrote:

> So the question is mostly whether four I2S data pins with a single
> shared WS/SCK input should be called "four I2S ports with shared clocks"
> or "one I2S port with up to four data lanes". I'd lean towards the
> latter.

Yes, this is what we're doing for the Samsung CPU side controllers which
implement this natively and seems to make sense here too - the different
channels can't really work as separate interfaces in any practical way.

> How audio2_i2s is forced to synchronize its clock output to audio1_i2s
> is a problem their bindings will have to handle.

Trying to hook up a controller that doesn't natively support this format
to a device that uses it is definitely tricky, as well as describing the
physical hookup we also need to worry about how things look to userspace
- it's ideally going to want a single multi-channel audio stream.

I think from a binding point of view we need a way to say "this endpoint
on the link is constructed from these DAIs on the device side" and say
if this is TDM or multi-data, and what's driving the clocks.

--9o1Xi4ZMQ45MudWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtmYvAAoJECTWi3JdVIfQt28H/1viMMw+EK2qHbR88BLH5iLi
9tbosp+jQxC+PTtsTI5YlUR3T/shxxV7+xA9D6wPezG2tyDghYicKvcDinxWGYnK
7wwtbmDBsRv69WPyeLNeZtZnTb4Oox5TYIYy1EtZluc1bYmpB3w1/MuOe4OU7ZdW
lkaOaL9pw8Bjx7ycw1rBIPbxszsOhDiQkrDkYKoKD3SlkCeSxtBAtJJG2Fas5AfS
yu8nGIGEI6f6EzXj4ry+j8/fAgftH+SMXj1/A+rOjFRWgjns9sCd8E9Sp2K7gEsl
wTgiBH1gecrvcQ3gnO492ZqfBvST+U2J0pzzDrOEKmLfck/2hoqLe884+yKdWgQ=
=pZEW
-----END PGP SIGNATURE-----

--9o1Xi4ZMQ45MudWG--

--===============4847048719639612950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4847048719639612950==--
