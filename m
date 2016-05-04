From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
Date: Wed, 4 May 2016 17:22:00 +0100
Message-ID: <20160504162200.GX6292@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <20160503162938.GT6292@sirena.org.uk>
 <87twiforl3.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AAkN98o3X3ouhQaz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87twiforl3.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--AAkN98o3X3ouhQaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2016 at 09:43:20PM +0200, Robert Jarzmik wrote:

> You probably mean the BITCLK clock.

> What is a bit pesky about this clock is that it can either be mastered by
> digital controller and the codec is a slave, or the other way around.

That's a bit surprising - I've never encountered a system that
impelemnts this, it may be permitted by the spec but it's always the
CODEC.  The master clock from the CODEC is often provided by the SoC but
I've not seen systems where anything other than the CODEC drives the
actual AC'97 bus.

> >> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
> >> +				     struct device *dev);
> >> +int ac97_digital_controller_unregister(const struct device *dev);

> > Why "digital"?

> I copy-pasted this from Audio Codec '97 Revision 2.3, where in several places
> they call the controller a "digital controller".

It's not really adding anything though, it's just clumsy wording on
their part - it's not like we need to distinguish this from analogue
or any other type of AC'97 controllers.

> Now if you prefer "ac97_controller" or something like that, that's as you wish,
> the name does not matter that much to me ;)

Yes.

--AAkN98o3X3ouhQaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKiGlAAoJECTWi3JdVIfQbD0IAIPYGLrmc7omWG2b8GSc8+4y
BGrqqBcZr3Y3jlJtfo2IHi4NNZfXcTCDg4/CFdU2PHVlJ98Lo0bejVLY5kKlWN0o
6/Lj+zSxvNKyCdQVL4yclK2UdD/9Ga9EgdRuTH6lmfukEvmBfVNH4H7aArAEN8uy
igmQdsv9SL6CuCffJcRzsQalSwQNRqvi5m7pVK63kAntvkl4in0TrhPgLskjixRB
Oq7RBePdny2F7TPxJSyKntoL4PTBHBCeziyVc1uARAl98574+9Z+n4sroChM3jPX
aXu1HhpLX9F05wqoMp/3425/rctjZ7cZUvDVzKAiaAQ3xbuvUXNUd9v8sBskv9o=
=Bi9D
-----END PGP SIGNATURE-----

--AAkN98o3X3ouhQaz--
