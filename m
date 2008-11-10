From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Mon, 10 Nov 2008 21:22:33 +0100
Message-ID: <20081110212233.3d3bcc7c.kristoffer.ericson@gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<20081110185800.42b6c198.kristoffer.ericson@gmail.com>
	<cabda6420811101108od6fe848qc291135a2ba9d819@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1279077486228997697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 9788A243A5
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 20:22:27 +0100 (CET)
Received: by ik-out-1112.google.com with SMTP id c28so2036613ika.0
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 11:22:24 -0800 (PST)
In-Reply-To: <cabda6420811101108od6fe848qc291135a2ba9d819@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chri <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, zdevai@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--===============1279077486228997697==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__10_Nov_2008_21_22_33_+0100_rhC3lRYNRQ5DuDjz"

--Signature=_Mon__10_Nov_2008_21_22_33_+0100_rhC3lRYNRQ5DuDjz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2008 20:08:00 +0100
chri <chripell@gmail.com> wrote:

> On Mon, Nov 10, 2008 at 6:58 PM, Kristoffer Ericson
> <kristoffer.ericson@gmail.com> wrote:
> > On Mon, 10 Nov 2008 13:34:52 +0000
>=20
> > I'm equally interested in this patch, seeing as I
> > got an hp jornada 7xx with uda1344 waiting.
> >
> > Have you any plans on creating an 134x seeing as there
> > is very little difference between chipsets?
> >
>=20
> Hi,
>=20
> I had a quick look at the UDA1344 data sheet. When operated in L3-mode
> it's basically a subset of the UDA1341 so I can do the changes. Anyway
> I'm not able to test them so could you give me a hand testing? Anyway
> if you won't use special mixer settings the patch I sent should work
> since the important configuration registers and the volume are the
> same for both chips.

It would be good if the driver could be used for both 1341/1344.
Some minor ifdef's should sort it out.=20
Please drop me a mail with the patches (missed the old one) and I'll start
testing them them out.

>=20
> --=20
> Christian Pellegrin, see http://www.evolware.org/chri/
> "Real Programmers don't play tennis, or any other sport which requires
> you to change clothes. Mountain climbing is OK, and Real Programmers
> wear their climbing boots to work in case a mountain should suddenly
> spring up in the middle of the computer room."


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Mon__10_Nov_2008_21_22_33_+0100_rhC3lRYNRQ5DuDjz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkYmAkACgkQPQls10ERAGfFDgCbBC678QlJqKM0OhaeXhlsQDO5
yAEAoIn/imrWW9Ag93w+pX+fWX9SBX1U
=m/M9
-----END PGP SIGNATURE-----

--Signature=_Mon__10_Nov_2008_21_22_33_+0100_rhC3lRYNRQ5DuDjz--

--===============1279077486228997697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1279077486228997697==--
