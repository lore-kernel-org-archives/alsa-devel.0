From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 21:53:17 +0100
Message-ID: <20081111215317.091d870d.kristoffer.ericson@gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<20081110185800.42b6c198.kristoffer.ericson@gmail.com>
	<cabda6420811101108od6fe848qc291135a2ba9d819@mail.gmail.com>
	<20081110212233.3d3bcc7c.kristoffer.ericson@gmail.com>
	<20081110221044.GI22835@trinity.fluff.org>
	<cabda6420811110615tdb3b294yd4de2ad5239af654@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5781742035691310474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by alsa0.perex.cz (Postfix) with ESMTP id E1D191037F7
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 20:52:51 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so37499nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 11:52:51 -0800 (PST)
In-Reply-To: <cabda6420811110615tdb3b294yd4de2ad5239af654@mail.gmail.com>
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
Cc: zdevai@gmail.com, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--===============5781742035691310474==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__11_Nov_2008_21_53_17_+0100_tpeisfeOJ3r0ReVT"

--Signature=_Tue__11_Nov_2008_21_53_17_+0100_tpeisfeOJ3r0ReVT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2008 15:15:11 +0100
chri <chripell@gmail.com> wrote:

> On Mon, Nov 10, 2008 at 11:10 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>=20
> >>
> >> It would be good if the driver could be used for both 1341/1344.
> >> Some minor ifdef's should sort it out.
> >> Please drop me a mail with the patches (missed the old one) and I'll s=
tart
> >> testing them them out.
> >
> > eww, ifdefs...
> >

Oh, just wanted to ask, is the L3 code platform specific
or universally crunchable?

>=20
> I'll try to put the common code in a uda_common.c and the do 2 small driv=
ers.
>=20
> --=20
> Christian Pellegrin, see http://www.evolware.org/chri/
> "Real Programmers don't play tennis, or any other sport which requires
> you to change clothes. Mountain climbing is OK, and Real Programmers
> wear their climbing boots to work in case a mountain should suddenly
> spring up in the middle of the computer room."


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__11_Nov_2008_21_53_17_+0100_tpeisfeOJ3r0ReVT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZ8L0ACgkQPQls10ERAGdvHwCgg1uYnHlqGrwVs1ATulpmYVSM
wzEAn2vMWt1KyEFvf6tVilxxOtavitto
=VE5U
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Nov_2008_21_53_17_+0100_tpeisfeOJ3r0ReVT--

--===============5781742035691310474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5781742035691310474==--
