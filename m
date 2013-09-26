From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] sound/soc/fsl/fsl_ssi.c: let check zero instead of
 check NO_IRQ
Date: Thu, 26 Sep 2013 11:29:14 +0100
Message-ID: <20130926102914.GG19304@sirena.org.uk>
References: <523FB47C.8010800@asianux.com> <523FB6F4.60803@asianux.com>
 <523FB735.2060906@asianux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5237033855241398914=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <523FB735.2060906@asianux.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, lgirdwood@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============5237033855241398914==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2013 at 11:36:21AM +0800, Chen Gang wrote:
> NO_IRQ may be defined as '(unsigned int) -1' in some architectures
> (arm, sh ...), and either may not be defined in some architectures
> which can enable SND_SOC_FSL_SSI (e.g. allmodconfig for arc).

Applied, thanks.

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRAx3AAoJELSic+t+oim9r3kP/Ax6TVOp8elPTn8GKNefAis2
tJboRw92DQZSoqvXHiALYnb2iii2WBtXCnklDoUNXBDyar+KkpBBkIwD6Xy9F9US
kWJ6NxfKlyq8X1GBoqSBzTZNjvoyE41hHToR9468Mz376f4HXDc2oloKauVu7hLH
04Xm7K/G/1Cwyu7fQDRwgzV5cMm3njrqoruLtuzqpX14eF46B4YYl8ZMrfbKhR06
ASLNsn5SkoDsQXQzBKuGHmr6wVzBWWC6eYTXLaoDF3+AiB3K5rycCkSV6Y7PMH4i
n2G0zgW8FRchbbqxSYCkb+EwG0DTFdnZZTCQIhjKjqOz/GYCeWMeqor5xMKD6jt/
bSA2SB7uJllUiBriUlwunbXzBRRzfHCNncK+W/y0W3auZD8F4t9S5BxOM1UZlVRj
5i0qjIJct5n+caqjHzslb3vI8sgN6rWx9kGq1vPoCGjNfqgLWO8Lis+r5zDm46Js
8G7Vk9mRTQETbzdjNmfPGzDdIBNx+7HOlEym7P4bSmHXLo4cwoImjQ8gq9wV4Upn
gWTru2Q0Gr3GME92IOQgxJP6ycTW1HqNTZj4iYcEP5pbY3PrD5XRiNjk1fYZDQDf
H16+w4tg+2hYWbuq0DNe33UpZiwaMXIFPkSUyZVCY+Pfmt8aC9t6kxQnbJSjp/Ac
cSTS7bV6vxKX8eRgknY2
=u0E3
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--

--===============5237033855241398914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============5237033855241398914==--
