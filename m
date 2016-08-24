From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 0/7] AC97 device/driver model revamp
Date: Wed, 24 Aug 2016 12:39:53 +0100
Message-ID: <20160824113953.GF22076@sirena.org.uk>
References: <1464380819-19075-1-git-send-email-robert.jarzmik@free.fr>
 <87twebphh4.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1851927226293660026=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87twebphh4.fsf@belgarion.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1851927226293660026==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7cXxibKNEnJOqEg4"
Content-Disposition: inline


--7cXxibKNEnJOqEg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2016 at 06:39:35PM +0200, Robert Jarzmik wrote:

> In the old ac97 bus, the match function was always returning "true", and the
> driver did probe. With this new implementation, the ac97 is discovered and
> sound/soc/codecs/wm9713.c#wm9713_ac97_probe() is called. I don't export
> ac97_bus_type (nor want to do it), and only _one_ device is created upon
> discovery, while the wm97xx-core.c would benefic a second ac97 device.

> I'm wondering how to work around this :
>  - either I add a wm97xx-ts ac97 device in wm9713_ac97_probe()
>  - or I add a platform device in wm9713_ac97_probe() and add a new
>    platform_driver in wm97xx-core ...
>  - or something smarter

That device really should be a MFD.

> What's behind this question is : should I keep to my initial solution of 1 ac97
> device discovered is bound on the ac97 to _at most_ 1 ac97 driver, or is there a
> know smart way to have several drivers for one device (that sounds a bit heretic
> regarding my understanding of the device/driver model but who knows ...) ?

MFDs are how we do multiple drivers per device.

--7cXxibKNEnJOqEg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvYd+AAoJECTWi3JdVIfQ6pcH/2FcK/Wk0D9FljAA6xkCu8GU
glQTTLjFoVOGVoZF3fgxu7ZmA9/vedCuJwad/lJM8J1NQEsMj1jdebk2+I2YyjE/
zzeYj3vrqTanhCkRb179R90mML9tYK53gYs1sG9ib4KX+abtFAjhYyXpdKTfACTL
D7fanKYh1TF4aXhdA813j+/xQ3IPEcJukMQyLGn9wfEuSgl6mc5Vx6FEPOEmoZjV
91MlRDcgyQa7k4ZwZWo8E+x/an5Mc4F5GuK4Bil4xmhIpGe5DPiivDR5OV061E5G
ltYAAmzZJCsAHuAs3c9psmSorcvHDV9aT/JHze67RURTSz2SaDpVpr8ugAcxtcE=
=oTIK
-----END PGP SIGNATURE-----

--7cXxibKNEnJOqEg4--


--===============1851927226293660026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1851927226293660026==--
