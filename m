From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Thu, 26 Sep 2013 21:58:07 +0100
Message-ID: <20130926205807.GV19304@sirena.org.uk>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6734809453278825793=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 972B1264E9D
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 22:58:09 +0200 (CEST)
In-Reply-To: <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6734809453278825793==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pkBzO0lo80FoaZii"
Content-Disposition: inline


--pkBzO0lo80FoaZii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2013 at 12:58:27PM -0700, Andrey Smirnov wrote:
> On Thu, Sep 26, 2013 at 12:43 PM, Mark Brown <broonie@kernel.org> wrote:

> > What exactly is the locking you're talking about here?

> I am talking about locking specific for si476x MFD device that is
> hadled by si476x_core_lock / si476x_core_unlock. The code before the
> patch has both externally exposed functions via V4L2 driver and SoC
> driver obtain said lock for the duration of their interaction with the
> device. The patch appears to remove lock acquisition for SoC
> functions.

But what exactly are these locks supposed to be protecting?

> > The way the code is written it looks like the lock is being held to
> > ensure there's no race due to a power state change.

> That lock is being held to prevent device access contention between
> all of the code that can be triggered to be executed via V4L2 ioctl
> API and SoC API. As an example, I can open the radio device and start
> tuning it using corresponding ioctl, meanwhile, parallel to that
> process my other code is trying to change the sample rate of the
> codec. To prevent those two from clashes both of them try to acquire
> "core lock" with si476x_core_lock before the start doing anything with
> chip/MFD.

In what way might these things conflict?  What are the clashes you are
concerned about?

--pkBzO0lo80FoaZii
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRJ/bAAoJELSic+t+oim9PvoP/jGw9WsU8Scz56m1xLgsvR/h
dEuuLo4MYf+P8we7AKZ1qVn9by0VfCEseI2mLqtzTXfhUUJ55NKuxop7736TyD9L
b7IKcKxk3p1pePWDuDUiGr5KVyz5T5JxPIq7O2kc+OyabJc02PvUoxhCs6BgSkXY
dqT2TnT+qFqsRLMoFsDY9AhQiEnMHfKaiC+zToU9Mv62PdoHarOxITERVOu8wO00
waFsqqgkikiAgYHGDWLaTZw+1EaUsHR2gCQXnisU7Sc0n+19gDr21pfT9rAvehIX
9WJiMQ28UPOjmEdbXJPCvltmCZe2oHiD6u4kV/cdVvy9tdjMu2+qWPsTFnv5NQfM
zsIikqdfZpswLxUdgrSOuulp0keCPNTuEUi83c9Oe9EQdn+UCNoozypSlNEnCncL
utoGE5xegU8yMTJUZJwsZaOTOnCOkg5B6KcFkTtcVYDR26vTDXjHTa8fBYyM40Xd
0RuuI2eWf0KP5/Mmmecfaxh5JCMeiOSBiLHcpFSk6ThtwWWn0laQdqI5g41TlQ9R
e3vcFv/s5ePmTI6fLQ5+yvtH96oBgD+4yLthtUWPV9K7qCmos4WLG4of7wTx+FTY
uiytJ9AqOCc+VRnwmFO6Kcqv0Z2DxYQOZ2UjJrfmjPgl5rBToFAmXbcQtFdqo1Hj
SglRrgElTChMTjOAyw4b
=5pgo
-----END PGP SIGNATURE-----

--pkBzO0lo80FoaZii--

--===============6734809453278825793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6734809453278825793==--
