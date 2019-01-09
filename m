From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/9] ASoC: sun4i-i2s: Fix offset mask
Date: Wed, 9 Jan 2019 18:50:58 +0000
Message-ID: <20190109185058.GL10405@sirena.org.uk>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-5-codekipper@gmail.com>
 <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1310635964929640369=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A99126742C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 19:50:59 +0100 (CET)
In-Reply-To: <CAGb2v649OVnaYNbZKPtBYkPHkFP13y201RZPTRauNsjiGQKwjw@mail.gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1310635964929640369==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 22, 2018 at 12:54:48AM +0800, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:

> > Also add offset to RX channel select

> Commit log seems a bit lacking. You could probably explain how you
> found this, either when comparing datasheet macros, or some actual
> error manifested and you "heard" it. You could also state what the
> fixed outcome should be.

> Also please add a fixes tag.

Plus send this at the start of the series so it can be applied as a fix
and sent to Linus during the development cycle.

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2QpEACgkQJNaLcl1U
h9A/2Qf+MpKvC1sDIcOBBmk7hZNPdkcZE5wlhCQAmahqcAdv8UeXEo+DGX8UwwtV
4DI7HFayI95aRYebTz5VK/W1noETZaQMciZ8eeqELS95MInDMhauwlioR0QlN90L
re/xxB9i+h/rGYomJenLE4UblW9FQ9D92bIudL7aSW+ysnEJFvptf3e6IVYwWGBH
Oh3H2N35iCCVsO45ex6Ra2k4h5/zDqz8jqM3MrlDN0AAb5OmT76HHWfiCNPTNZyU
hty4A7sssYji0nqfs3gB6UqJwK4eAxjGak6tmh5yHu02WXh+4HQjMMpnQfvYVdX3
RUFMDvm2f2KaEaljyksXH4Wml+pKAw==
=REGU
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--

--===============1310635964929640369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1310635964929640369==--
