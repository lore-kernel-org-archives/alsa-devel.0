From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver
 with soc-of-simple
Date: Wed, 23 Jul 2008 15:30:17 +1000
Message-ID: <20080723153017.1b235313.sfr@canb.auug.org.au>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6537839849376154781=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E0A31038CE
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 07:30:26 +0200 (CEST)
In-Reply-To: <20080722235351.11648.56387.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============6537839849376154781==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN"

--Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Tue, 22 Jul 2008 19:53:51 -0400 Jon Smirl <jonsmirl@gmail.com> wrote:
>
> +static struct snd_soc_ops *machine_ops =3D NULL;
> +static char *machine_name =3D NULL;

You don't need these initialisations.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiGwekACgkQjjKRsyhoI8yRywCfeVwTrAHd2MVL1QWc/2EAm3xs
FykAn0hTPK6uXBcW3Nt9U3/+zQGBwMk4
=nIzX
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jul_2008_15_30_17_+1000_pK2cvj=ojNPkxJLN--

--===============6537839849376154781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6537839849376154781==--
