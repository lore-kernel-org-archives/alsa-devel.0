From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Enable start-up and normal
 bias after reset in runtime resume
Date: Fri, 14 Jun 2013 11:51:18 +0100
Message-ID: <20130614105118.GI1403@sirena.org.uk>
References: <1371199940-29803-1-git-send-email-b42378@freescale.com>
 <20130614095917.GG1403@sirena.org.uk>
 <20130614100838.GC9206@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6363775374336699795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AE5A0261AA0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 12:51:21 +0200 (CEST)
In-Reply-To: <20130614100838.GC9206@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6363775374336699795==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R0KYKl6i9Fj1nV1E"
Content-Disposition: inline


--R0KYKl6i9Fj1nV1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2013 at 06:08:39PM +0800, Nicolin Chen wrote:

> I understand your point because I also found other wm89xx drivers do this way.
> But the truth is, originally this 8962 codec driver did put biases settings
> into set_bias_level() as the others. But after commit d23031a4d they're put
> into pm_resume().

Don't just quote commit IDs, use the subject lines as well so humans can
read your e-mails.  The commit you're referring to moves some code out
of set_bias_level() into runtime PM.

> As far as I can understand, I think these two approaches should be running
> into a same consequence, while I'm not sure which one's better.

> Sir, do you still think it's better to put them back into set_bias_level()?
> Could you please help me understand the reason?

So, if that's the case why are you changing this...  it may be that what
you need to do is to write a better commit message so it's clear why
you're making the change, your message just described what the code
change does but not why it's being done in that way.

That said the general concept is that runtime PM would be powering on
the device for digital operation (eg, for the GPIOs) and then
set_bias_level() powering up the analogue portions of the device.

--R0KYKl6i9Fj1nV1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuvWjAAoJELSic+t+oim9G4oP/jCQQRd9Joea98IWIzVqtcAP
SqilRwUvpSODcCb+3sByeoAWfJtUD3uojHMN+YvcSsYY0W8Gw1h1Hblc2DdPBU3Q
HdBkXNU1KF0+uVtZ6ROnQGjlB0lGQxIlzIWhyoRC9trfAFhJ+Y1NtWxD/af7Dk+/
XHyNFZWyg/0A4H5eUoLsEPFYYRYMS3u+532gT/b9i1MjGgUZvnTseMEDX/dnt3lj
/mu0NHvma+TeT5Jts2mSRYn0IjyRXOOMPxPOYj5J7bgcmS4Rh4XUY3Xlf26tQZYM
Weh5dVRWtSOdSKLbyov4kYk16nwl4tvlZp7Dt7+wwpYMHgX2WvRtqAtNIb/9OUzN
lPKdHraxr5kT+T9E2dRo6BhCqbAkqiMqFrDZ13JgZ9tSlgPbg0bJQF8bLJlBV/iV
TGmvZeeWD8fciuEB58LLsaLqFqhOzeWNzQItGsvaq6pHqA6VFQ3U2sY/EzpDQkuh
v8PUDD9XMB47gKAhbYr5idJfzu1zAb1t76n7m0/0wReD0PUUHY15brD1E7qTOmXw
nohhcqN06xlReyIC3HDZfk+lVi13OnbaYzQF+rkuM34FbJPnJEsMEI2YRnNFkfP+
0Ohryuc0QyxeC7FxyDT8QF1CxVt3IEvhdKoUjc5xsSyGnufDeFsLmiF31W0cOLcH
qdCk4cna6n9XcPZeyCzK
=sxz/
-----END PGP SIGNATURE-----

--R0KYKl6i9Fj1nV1E--

--===============6363775374336699795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6363775374336699795==--
