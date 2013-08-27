From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/9] ALSA: compress offfload fixes
Date: Tue, 27 Aug 2013 18:48:16 +0530
Message-ID: <20130827131816.GB2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <s5heh9fjtrn.wl%tiwai@suse.de> <20130827100955.GX2748@intel.com>
 <s5h7gf7jov7.wl%tiwai@suse.de>
 <20130827132808.GH10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3804923270300649828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C3068260840
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:03:12 +0200 (CEST)
In-Reply-To: <20130827132808.GH10783@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3804923270300649828==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2013 at 02:28:08PM +0100, Mark Brown wrote:
> On Tue, Aug 27, 2013 at 02:32:28PM +0200, Takashi Iwai wrote:
> > Vinod Koul wrote:
>=20
> > > Since lot of embedded folks will be on 3.10 then would have been nice=
r if it
> > > went to stable.
>=20
> > "It'd be nice" doesn't satisfy the condition for stable kernels,
> > unfortunately.
>=20
> On the other hand if there's an issue which essentially every user is
> most likely going to end up backporting a fix for it seems reasonable to
> consider getting that resolved.  Personally I'd be a lot more
> conservative than Vinod with this one and only consider the fix for
> blocking during drain.  The current series seems rather invasive though.
Not all are marked for stable. Only thecouple to fix locking problem and
defination of sampling_rate. Rest will go thru usual cycle, though I suspect
with folks in embedded will take complete series.

~Vinod
--=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJSHKcXAAoJEHwUBw8lI4NHfvYQAJGAIlGpNQy8/Hjp7oO53K1L
YlLMGBuR8veK8mNqxT4IN4S8WZYPZhjR5sbuwSAKooMEQEl6r2VwTyGijOydAVtK
fd7El/Ssf34+2VgCHFdBll4ry9iQFdHgRqxgYkcnje8RNg8FcWWn+V1zPxNcK6Bp
rAQCECEh5mwJD89kIuvortefOA4ZjKni7nXaJ82Rg3rIMnINJiX9RV8kQswv+moW
dUhMOUzNggN0yVbVl83PKn6LzVvZUnVLbI+a1osmJYDJNOK310plLULx0hE4h8lE
dZIltnObiJOx6EhQt48RjzeiwDzYbm2byrrJRSISGFb2pI2N8wsDYe6fZ/KpSVsk
s8fxpytVnAN5+xEOHjfKAU24ibknoEW3qTJ3Bc+hSe37UXuxFwc3QFkiB0wWF6FB
Go8FNoDAmOboVxcNSxC664Vanl73t/Lhb/buG4lYpS4KeiXQRYB7j10p9+xpKSB9
HE3eJnOy0yyhfEqML8bQBulRF7AVrz5cajuA9WHxzSTCb6LSy7fc8J1AoxWebtoG
LoR2BQrP4hoSgGVzonDHX3u71TcPrTVq+3IQt+yyeFJ4BZEOQE1VjJ27HKulrJ4W
7ArBXBwc0EBzgVtxCZvEIleuerac5OKAggUlT08Q/hJBqpCmGATdf4wOdnwWqPWx
vS3kOyuO+a8P1fsd1hJS
=W7Ou
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

--===============3804923270300649828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3804923270300649828==--
