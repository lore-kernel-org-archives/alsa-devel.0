From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Best representation for TDM devices
Date: Thu, 25 Jul 2019 15:01:12 +0200
Message-ID: <20190725130112.3j2vi4dyngyr6yh3@flea>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5392625376563764073=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5392625376563764073==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rddslzkshiyxhiyb"
Content-Disposition: inline


--rddslzkshiyxhiyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm currently working on a device that has two Analog's ADAU7002
connected to an I2S/TDM Controller (sound/soc/sunxi/sun4i-i2s.c, with
some modifications), over the slots 1/2 and 3/4.

The capture itself is working fine, however I'm not quite sure about
the way to expose those streams to the userspace.

Since I have two codecs, I have two links (described through
simple-card) and thus two subdevices. However, the microphones
connected are really separate streams, so ideally (I guess?) we should
have 1 subdevice per microphone.

An alternative would be that we capture the whole 4 channels and use
dsnoop to demux them, but trying to use the device directly (using
arecord -D hw:0) results in the ioctl to change the number of channels
being rejected, I'm assuming because each codec only has 2 channels?

So I'm a bit lost at this point about how I should go and expose
this. I couldn't really find any similar setup either in the
kernel. Any preferred way of doing this?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rddslzkshiyxhiyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTmoGAAKCRDj7w1vZxhR
xTKUAPwPcJzEqkkoUcUYtmz9PUBumusjyVSRBmCPSBM/U/pQ2AD/UQWf6Jlc3JJN
BX8LFvZSo3fF7enhh05KgQsqvLuhIQo=
=hz2z
-----END PGP SIGNATURE-----

--rddslzkshiyxhiyb--


--===============5392625376563764073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5392625376563764073==--
