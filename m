From: Mark Brown <broonie@kernel.org>
Subject: Re: Best representation for TDM devices
Date: Thu, 25 Jul 2019 18:44:09 +0100
Message-ID: <20190725174409.GF4213@sirena.org.uk>
References: <20190725130112.3j2vi4dyngyr6yh3@flea>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1518461609711075358=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190725130112.3j2vi4dyngyr6yh3@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1518461609711075358==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2019 at 03:01:12PM +0200, Maxime Ripard wrote:

> Since I have two codecs, I have two links (described through
> simple-card) and thus two subdevices. However, the microphones
> connected are really separate streams, so ideally (I guess?) we should
> have 1 subdevice per microphone.

> An alternative would be that we capture the whole 4 channels and use
> dsnoop to demux them, but trying to use the device directly (using
> arecord -D hw:0) results in the ioctl to change the number of channels
> being rejected, I'm assuming because each codec only has 2 channels?

> So I'm a bit lost at this point about how I should go and expose
> this. I couldn't really find any similar setup either in the
> kernel. Any preferred way of doing this?

What is the actual hardware - what do the microphones physically look
like in the system, what functional role do they play?  My initial guess
would be to combine them into a single PCM for userspace, there's some
support for that but it's not surprising if that's broken somewhere
along the line as it's very infrequently tested.

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl056mgACgkQJNaLcl1U
h9C4xgf/ecGx+yNE7q7BDjXryu/S2MaP2MoLVGeNAfqFdg6Q37hZnvDBkvS1FclU
ZhvpOy6AmwKHeMEsjIi6nloIBgwAy4xuuTC196fRfZPF6vm8anCEkNgy50L+1LHL
aMumVuDGg+lhdwpw9nNs+7Igf5aPYQ9GtNMRqO7Fzzlc016IzfwZfVuGTGLtmKYb
UPuDnCjbAfZ2y3bd4R2N6upPwykZQEobYTKg6bKecYw/m16OMlayRyXw7Cl/jjQ1
Qc/zIcgcAlPjJGdDmhmU0q9ekigKN9h2oXcyEOFXnHH3ofxa/Pv1NCnlIdjV29+L
VuBX4FLparLISadUL8FIIwxuvGUaZA==
=XGrz
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--


--===============1518461609711075358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1518461609711075358==--
