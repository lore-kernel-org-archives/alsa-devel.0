From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: codecs: msm8916: fix invalid
	cast to bool type
Date: Mon, 15 May 2017 09:17:48 +0100
Message-ID: <20170515081748.jumvks5udstzq3oa@sirena.org.uk>
References: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
 <20170502133303.19622-3-o-takashi@sakamocchi.jp>
 <20170514095945.7oefv6767yiz5nzz@sirena.org.uk>
 <s5hy3tybkpn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1854150301521589793=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DE9F926684C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:17:58 +0200 (CEST)
In-Reply-To: <s5hy3tybkpn.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "# 4 . 10+" <stable@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


--===============1854150301521589793==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a7hulcxibgbns3ck"
Content-Disposition: inline


--a7hulcxibgbns3ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 10:14:28AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Tue, May 02, 2017 at 10:33:01PM +0900, Takashi Sakamoto wrote:

> > > This commit fixes this bug by using unsigned int type, instead of boo=
l.
> > > This bug is detected by sparse:
> >=20
> > > smsm8916-wcd-analog.c:809:43: warning: odd constant _Bool cast (40 be=
comes 1)
> > > smsm8916-wcd-analog.c:814:43: warning: odd constant _Bool cast (40 be=
comes 1)

> > This looks like a bug in sparse - the use of integers in a boolean
> > context is totally valid and especially the fact that it is claiming
> > there is a cast when clearly there is no cast is an obvious red flag, at
> > the very least the message it reports is bogus.

> Well, the function pm8916_wcd_analog_parse_dt() assigns a non-boolean
> value (BIT(6)) to a boolean field, and the value is supposed to be
> kept and passed to snd_soc_update_bits(), instead of dealing as a
> boolean.  It looks rather like a buggy code to me.

The code is buggy (which is why I applied the patch) but the error
message is talking about casts that simply aren't there which is also
buggy.

--a7hulcxibgbns3ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkZZCsACgkQJNaLcl1U
h9C1QQf/W99CzRkCwaA0mkd9RjJWNbjRUE6FXZzJi7kuqpXfg5fr4bfLT5tzP1Xo
0YS9jFdV1p3lemC0HzasNpP7H4lQEvVVAqLL5cgIQj7a50bplgt6HgbeCrW3JJyn
DHHEw9bMqmrfbZsIdiXO5+bQZSqeLdIQRUkSc0VV85IxUwutWxUrWcAXVtStL/O8
Bikohho8JBNYzuGuSA57d43DGQIU7Bb4FLpKSHR40iP5hHkoEUce2PbLmezC9Jn9
juAW97phTyPj1JiI77vtkfzWZkRyf9HgDSy+dJPTlPvtXXx8gFlaD3EQbiDNOKQz
gGVoeW96zV3IuqKEVc3qPRtezMoa6w==
=tWQ+
-----END PGP SIGNATURE-----

--a7hulcxibgbns3ck--

--===============1854150301521589793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1854150301521589793==--
