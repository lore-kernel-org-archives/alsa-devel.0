From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/4] USB: Gadget: Rename audio function to
	uac1
Date: Wed, 15 Feb 2012 10:12:14 +0200
Message-ID: <20120215081212.GI15346@legolas.emea.dhcp.ti.com>
References: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA@mail.gmail.com>
	<1328200193-31939-1-git-send-email-jaswinder.singh@linaro.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7576142640658765743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E3D5103D8F
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 09:12:21 +0100 (CET)
Received: by mail-lpp01m010-f47.google.com with SMTP id c1so757811lah.6
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 00:12:18 -0800 (PST)
In-Reply-To: <1328200193-31939-1-git-send-email-jaswinder.singh@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: alsa-devel@alsa-project.org, greg@kroah.com, linux-usb@vger.kernel.org, jaredwiltshire@gmail.com, balbi@ti.com, zonque@gmail.com, yadi.brar01@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7576142640658765743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="STPqjqpCrtky8aYs"
Content-Disposition: inline


--STPqjqpCrtky8aYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2012 at 09:59:53PM +0530, Jassi Brar wrote:
> The extant USB-Audio function driver complies to UAC_1 spec.
> So name the files accordingly, paving way for inclusion of
> a new UAC_2 specified driver.
>=20
> Signed-off-by: Yadi Brar <yadi.brar01@gmail.com>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

nobody complains in 2 weeks so I'm applying this entire series, thanks

--=20
balbi

--STPqjqpCrtky8aYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO2jcAAoJEIaOsuA1yqREDHEP/ieCkqCmj35CCMZocew6BkrN
kgCI/fGciOaPM+2xtP7sUBHFIsbQoT6wSoZhtD2ZTcj7fMoD9MOws+l4ptpL39wE
dvzW7Lvs08cKTdFFY/EGXzkpfgErbglMzGU6UT4HlWdsxOWEN571rk19Is2ow66v
qoh/4X37k4J47EAywJI/1SbOpwx/xNC/B+7JOy2Lc5IsRFK9nMa4/UaOdFxTjNux
UUJouR2ztGA+19cWgClEngRc/q7Ymkw0F/CJi9ze++IgwhHGn5EhHDIFr6+yhc47
iRK3ksdSEds6D+vrN1g2+QCXmlIF31sU+StMMKqK8X+jbA6c+Y7P3JZkGknJM4bM
EaiKRUlDyi7F9RpmVBt+39YyZ4CDFaDucrNu2HSRCBUTHHS1l65u1JgY8Qhj1Acr
rPqSdG6g98Z0BN7kgm6xGxmKMRAa19nYA7ANUMV4SYRwa1RUWLj+JliLZ88jB6tH
fJtjrSl/SEd275yCc9324k5BXiANVszHzE5dnmCUYH4VWoVNwfeFveDiJd4ZRzgB
5Z7Ittjd/oFMvQHtwJalKr+9eEWug/mcwqbjtKnmCiWJo3Voc9I7yEk9Ug+taBzN
1SXeYrn2SESQlPhpPmSDozPg1gr68cONLzBFMPl8sI8yRPOAHWUAVqm8TeivzKmu
SyM4W6h7FIgXg5gbFCa+
=ypt4
-----END PGP SIGNATURE-----

--STPqjqpCrtky8aYs--

--===============7576142640658765743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7576142640658765743==--
