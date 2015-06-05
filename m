From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Avoid recursive locking in
 the DEADLOCK detector
Date: Fri, 5 Jun 2015 18:13:51 +0100
Message-ID: <20150605171351.GZ14071@sirena.org.uk>
References: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
 <20150603164453.GP14071@sirena.org.uk>
 <CANMq1KCFwFppzAx5NiotP_0uy93Ga436PYEbhhA6iM0JCXWtaA@mail.gmail.com>
 <20150605103144.GS14071@sirena.org.uk>
 <55717FA7.8030005@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5506877884071900081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB4832668BC
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 19:14:02 +0200 (CEST)
In-Reply-To: <55717FA7.8030005@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Nicolas Boichat <drinkcat@chromium.org>, lgirdwood@gmail.com, john.lin@realtek.com, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5506877884071900081==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sao9idefCFjK9Dt3"
Content-Disposition: inline


--Sao9idefCFjK9Dt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 12:53:27PM +0200, Lars-Peter Clausen wrote:

> Now the issue here is that we have nested regmap instances, meaning one
> regmap instances uses another instance in its read/write implementation.

Ah, that sounds more familiar than unlocking in different orders.

> I think Antti submitted some patches to attend to fix this, but there were
> still issues with the patches and they never got merged.

IIRC his patch was adding the ability for drivers to override the lock
class which wasn't exactly fixing the problem but rather providing a
different way to try to work around it in drivers.

--Sao9idefCFjK9Dt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcdjOAAoJECTWi3JdVIfQw04H/0P9xRvOperSpzM87fV4nt82
Reulj6TLM2k7KrxJB+eHCIHY5TITmBQuqWkIKFv8Zd8KeHYgSqcDabaAEnu0eyk3
Jjb9lf4+tqhp0JngdfuWj+ftkPFmNMi8nyHcB5siFDnJy4sCNtgyQLChk1aeYw+x
mwTNiZu0f3SGpdXfFXA6FLi322QmJUb6iaii06qKgTdMTGCOCEGQuLUEJ6ZLhBZd
lcYHKG7I2prXuFbGGyqHcGubf8CU42P7Z96Gh6vsGTsD5F0/xC1Eu1MDpvUFvv0L
/r5C85mV33/RXs5X3G7VnH0YO0NgzIMPm2hUPVmhiZUGLj9y4TaFGdaSdsJCGI4=
=4uwg
-----END PGP SIGNATURE-----

--Sao9idefCFjK9Dt3--

--===============5506877884071900081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5506877884071900081==--
