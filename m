From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/6] sound: lx_core: Remove unused defines
Date: Fri, 18 Apr 2014 11:45:15 +0200
Message-ID: <20140418094515.GF4132@lukather>
References: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
 <s5hd2gfukvh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0821170385433177166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 4010026166B
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 11:50:03 +0200 (CEST)
In-Reply-To: <s5hd2gfukvh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0821170385433177166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 18, 2014 at 10:01:22AM +0200, Takashi Iwai wrote:
> At Thu, 17 Apr 2014 11:51:16 +0200,
> Maxime Ripard wrote:
> >=20
> > Commit f9367f3fbe3c ("ALSA: lx6464es: Remove unused
> > function in pci/lx6464es/lx_core.c") removed the
> > lx_dsp_es_check_pipeline function that was the only user
> > of these defines.
> >=20
> > Since they're useless now, simply remove them.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Thanks, applied all patches now.
> But, at the next time, please put my correct address to Cc.

Hmmm, yes, look like it was a typo on my side.. Sorry.

> Also, for ALSA stuff (except for ASoC), we usually use "ALSA:"
> prefix.

Ok, I will.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTUPQrAAoJEBx+YmzsjxAgX9YP/jZ7xhUk9GaBuGSe/nBylDTS
oDIUnoV+o0SIRwrC1KCgIZ97naaN4+ODnyd4/sfcbHJnKLJsQUnW69IINetwyPxY
EMLfzPMTWdE7RcNyWcUG0kVcIvblWnKF3EYKiDZFmDct1kH2i6hWltRUfKt5ft6R
2AO6u1PLICBXlpi9F13f1ZCZgTEJU/eIjBF4rv0YSvJhM0IW9WJekHHglYtQ8Mn/
pPp0ge6y3rB9EIC8S71It1eBk3irlU+yPbmlU9A1szDaJnmipWlBxqgHgfzEJETJ
ne22GTXUOW9ihltA68TekmGz9OU9x9FRW+7GxKU9KXwBZxM5YsIp1DZKS2ccKPWL
anqIjZOA+SKgFnf2T1n6XSNgsyUW4PLMREjQWUZQJng6hWTESfErKkcxFG20QRD4
+qk67M+Zt0nNa339mfrb04eDoba9GVJdtzbWTgMayadlqzjVMRXgvH0AKl79H55b
3gR7A61zEQHpHjv2AXnP3H1TC2m7lEIA9CY0Cfh7Li+swXl4b0GJ4PwvQL+LqeGf
xW4gf2JQFJ6grAdscleiS8hSLuXWM4ekjnpt2EHDYpKKNeEAQ8pf6G4sNeg89DDM
LhbmVj7OnwIE3ZJ27cJ6CPpdpwHkWcoB4wXGi9H6jE3BRRLRcOEZw+qheQ2PZKpj
nhxVyMO4LNbj5W2XMbYY
=Nlyv
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============0821170385433177166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0821170385433177166==--
