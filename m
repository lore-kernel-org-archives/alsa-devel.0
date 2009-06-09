From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Tue, 09 Jun 2009 07:10:00 -0300
Message-ID: <1244542200.1315.29.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<1244276805.15998.102.camel@brutus>
	<1719ee7f0906090239m578d1ab3j80a7ebc15f9cc51e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0341295932160745128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id AD92A1037E3
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 12:11:19 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4823498qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 03:11:19 -0700 (PDT)
In-Reply-To: <1719ee7f0906090239m578d1ab3j80a7ebc15f9cc51e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Shen <boshen9@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============0341295932160745128==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-nyz8YDYE0HgteIJifiuV"


--=-nyz8YDYE0HgteIJifiuV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Ter, 2009-06-09 =C3=A0s 17:39 +0800, Paul Shen escreveu:
> Hi Daniel,
>=20
> Would you please give some informations about your platform ?
> Thus I can test the patches with your method.
...
> Would you please give me code extract about your SSP, codec
> configurations and clock setting?

Hi Paul! :)

Im working to get Motorola EZX Phones[1] supported by mainline linux.

Our audio codec is a proprietary PMIC, manufactured by TI for Motorola,
named PCAP2(PTWL93017).

The audio codec is connected to PXA SSP2, PXA SSP3, Baseband Processor
and BCM20x5(bluetooth) in network mode.

PXA is always the _slave_ of bitclock and frame, so I don't have to care
about clock settings on PXA side, the codec always provides me the
correct clock for the selected rate.

You can find our code on git://git.openezx.org/openezx.git, ezx/current
branch. (sound/soc/pxa/ezx.c and sound/soc/codecs/pcap2.c).

Most of our work is based on the 2.4 kernel source releases by
motorola[2], and on the atlas(MC13783) PMIC documentation[3] from
Freescale (used by Motorola on newer(MAGX) phones), as we don't have
documentation for PCAP2.

[1]http://wiki.openezx.org/Project_devices
[2]https://opensource.motorola.com/
[3]http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMC13783=
&webpageId=3D1098824671538699514881&nodeId=3D01435974404881

--=20
Daniel Ribeiro

--=-nyz8YDYE0HgteIJifiuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkouNPEACgkQw3OYl0G0liQuzgCeP/F2EtO4xo9og9rQBHy4Ltgn
OCcAn19/JT192JBQHnQ7Og5lXV2UV6JR
=WKH0
-----END PGP SIGNATURE-----

--=-nyz8YDYE0HgteIJifiuV--


--===============0341295932160745128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0341295932160745128==--
