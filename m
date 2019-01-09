From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
Date: Wed, 9 Jan 2019 18:49:31 +0000
Message-ID: <20190109184931.GK10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
 <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
 <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8372601090061564251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5104226742C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 19:49:32 +0100 (CET)
In-Reply-To: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, Jonas Karlman <jonas@kwiboo.se>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Code Kipper <codekipper@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8372601090061564251==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2018 at 11:16:31AM +0800, Chen-Yu Tsai wrote:

> This sounds like the flush is happening after DMA transfers and/or I2S
> operations have started, disrupting the order of the audio samples. I
> think that might be the case since the regcache is synced sequentially,
> and the FIFO control register is after the enable bits. That would imply
> that the device is taken out of runtime suspend after the .start_capture
> or .start_playback callbacks. Not sure if that's the case, but that would
> mean the bus clocks are still off at this point, and bypassing the cache
> and updating the bits is basically moot.

I would expect that the device needs to be resumed from suspend before
we start actually trying to transfer audio - there is stuff in the ASoC
core which is supposed to have appropriate gets but it's possible
something is going wrong there.

> I think there's something else happening here, but we need to figure it
> out instead of papering over it with something that "just works" but
> we don't know why it works.

I agree.

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QjoACgkQJNaLcl1U
h9CYkQf+LxpY1u9lPMC6ld9Jxf0JNyammIoqScIdns2JZ8ZH4M6rpKWUsUyETdVg
14bCT1yi7D5ZH9Ekcw/6yXB0FBQX0rqP2W9X7PODZTgWEVBwF6wrp9jIe5YlYsM5
47wuQFzRquRKmhaBwvuwdOM0+l2T8cRd7ZnOVmVNDJxb3oD8/0fR3LKCd8e8sQ9v
vqJTljjBtGlvwwWbWLeMLkXbvlesGpc7heRgrdHFXgxf46BMpN0rZuUWZU/5XwF6
zqSDZaXBPAgm1CFJ06FQdo8VeAmXT+mD0X0tJgZKG2FxJBAKEp5Ss9+sgSCMsbVr
Qo/rQCkOQYPKtuPsNLeHCFJEaBNy0g==
=m/5F
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--

--===============8372601090061564251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8372601090061564251==--
