From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: Fix non-DT use of I2S
 controller
Date: Fri, 12 Dec 2014 12:35:45 +0000
Message-ID: <20141212123545.GD11764@sirena.org.uk>
References: <1417809427-5126-1-git-send-email-broonie@kernel.org>
 <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
 <20141208121200.GV11764@sirena.org.uk>
 <CAAgF-BfCQ8sfT-dH8+yNUrPA=qPChv6G_8bX0qHnkj-Phb=zhw@mail.gmail.com>
 <20141210131937.GR11764@sirena.org.uk>
 <CAAgF-BcEzKMvuiP8jepsrg4k4uxhLXRfzj6jAuEaQ=kVc=5cjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7245882717376824122=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7210C265701
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 13:36:02 +0100 (CET)
In-Reply-To: <CAAgF-BcEzKMvuiP8jepsrg4k4uxhLXRfzj6jAuEaQ=kVc=5cjA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Padma Venkat <padma.kvr@gmail.com>
Cc: alsa-devel@alsa-project.org, Padmavathi Venna <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============7245882717376824122==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Is/EZc/5UaySYT1G"
Content-Disposition: inline


--Is/EZc/5UaySYT1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2014 at 08:53:50AM +0530, Padma Venkat wrote:
> On 12/10/14, Mark Brown <broonie@kernel.org> wrote:

> >> Yes. It does not have secondary dai, internal DMA, reset control. It
> >> has only 5.1ch support. Register offsets are similar to i2sv3_regs. So
> >> I think one V4 dai type with name "samsung,s3c64xx-i2s" is required.

> > OK, then can you or someone else with access to the documentation please
> > provide that?

> OK. I will post a patch next week.

Great, thanks.

--Is/EZc/5UaySYT1G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiuEgAAoJECTWi3JdVIfQ6AsH/2YCELxLW/fi0vzm6RvrwcIc
mfAeGAyOcC0NX7uQnETKKSwmuS8HVK3gtwI/uGN4xD+pIfMLnD2SSY5qieT1kUv1
mQ3+BBKzGpAJxGbJpY0MzSEC/dXz2B/K0jc9efKLsmD7nJDDQJqLwm3m5eE9xR17
3u5H9ezDuP6x2CzX2OER1ULmq6UqKiPUedB1d02sDeKcDBaNtNu3i9uiaBCAoOhN
PEMOBTq2ME3awwmBFR6DvkxKlK+gpRFdGkCY7SwCTlCmk2l/Z7fMj11yd0r3Jkw/
109N+KFBu+X1LzaUnOBp9DTR+I2pIzgpCbk50kiUM/IsiUdDJWS4R7zTrvQX9Qk=
=YKT8
-----END PGP SIGNATURE-----

--Is/EZc/5UaySYT1G--

--===============7245882717376824122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7245882717376824122==--
