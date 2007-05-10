From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] snd-aoa-i2sbus: use MODULE_DEVICE_TABLE
	instead of	plain	MODULE_ALIAS
Date: Thu, 10 May 2007 17:51:16 +0200
Message-ID: <1178812276.3806.25.camel@johannes.berg>
References: <1175080700.5151.56.camel@johannes.berg>
	<s5hr6r9shrq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8459198157183840339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 7896A243AA
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 17:48:51 +0200 (CEST)
In-Reply-To: <s5hr6r9shrq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, ALSA development <alsa-devel@alsa-project.org>, Sylvain Munaut <tnt@246tNt.com>
List-Id: alsa-devel@alsa-project.org


--===============8459198157183840339==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uP8p1DseXFouaMM16++p"


--=-uP8p1DseXFouaMM16++p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 2007-03-28 at 13:56 +0200, Takashi Iwai wrote:
> At Wed, 28 Mar 2007 13:18:20 +0200,
> Johannes Berg wrote:
> >=20
> > This patch changes snd-aoa-i2sbus to use MODULE_DEVICE_TABLE instead of
> > a hardcoded MODULE_ALIAS. Thanks to Sylvain Munaut for pointing this
> > out.
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> >=20
>=20
> Applied to ALSA tree now.  Thanks.

What happened to this patch? It seems it hasn't shown up in Linus's tree
yet, but IIRC it's required with some modalias changes from Sylvain.

johannes

--=-uP8p1DseXFouaMM16++p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGQz90/ETPhpq3jKURAnFwAKCFlCXDlEuzjSHudF0Oi1BennCheACfbr1e
mliImBxjNZdNJRMXdA6yjXw=
=ZH0/
-----END PGP SIGNATURE-----

--=-uP8p1DseXFouaMM16++p--


--===============8459198157183840339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8459198157183840339==--
