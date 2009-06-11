From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: change set_tdm_slot api to
 allow slot_size override.
Date: Thu, 11 Jun 2009 09:37:12 -0300
Message-ID: <1244723832.21356.35.camel@brutus>
References: <1244715420.21356.29.camel@brutus>
	<20090611120738.GD26509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1601983972686673223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 500CD24651
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 14:37:20 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2012332qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 05:37:18 -0700 (PDT)
In-Reply-To: <20090611120738.GD26509@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============1601983972686673223==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-n4xOzjEyCb6ifJzUVL4l"


--=-n4xOzjEyCb6ifJzUVL4l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qui, 2009-06-11 =C3=A0s 13:07 +0100, Mark Brown escreveu:
> On Thu, Jun 11, 2009 at 07:17:00AM -0300, Daniel Ribeiro wrote:
> > Extend set_tdm_slot to allow the user to arbitrarily set the frame widt=
h
> > and active TX/RX slots.
>=20
> Looks good - I'll apply this unless someone else spots any issues.
> Unfortunately I'm not able to test the PXA changes right now.

Thanks!
Please note that this patch is useless without the next one (2/2), as
ssp_hw_params will not respect the slot_width set by set_tdm_slot().

> > Updates magician.c and wm9081.c for the new set_tdm_slot(). wm9081.c
> > still doesn't handle the slot_width override, I will submit this as a
> > separate patch after I figure how to handle the I2S case.
>=20
> There's no need for you to spend time looking at this, I'll take care of
> it.

Ok, thanks!

--=20
Daniel Ribeiro

--=-n4xOzjEyCb6ifJzUVL4l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkow+ngACgkQw3OYl0G0liSSJQCgkfagDEWTT32cN4REXPVsKIl+
s8kAn1Mnic3+1VLOuhLAa2eQVLmvvywI
=bgeo
-----END PGP SIGNATURE-----

--=-n4xOzjEyCb6ifJzUVL4l--


--===============1601983972686673223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1601983972686673223==--
