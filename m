From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Mon, 3 Mar 2014 13:07:45 +0800
Message-ID: <20140303050745.GP2411@sirena.org.uk>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1833680676849974963=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B6302654D5
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 06:08:02 +0100 (CET)
In-Reply-To: <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rongjun Ying <Rongjun.Ying@csr.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Liam Girdwood <lgirdwood@gmail.com>, RongJun Ying <rjying@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1833680676849974963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZXg5XZblsOcYBG3r"
Content-Disposition: inline


--ZXg5XZblsOcYBG3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2014 at 02:15:17AM +0000, Rongjun Ying wrote:

> The codec clock is only used by this driver. And this clock is not manage=
d by
> clock controller. The Audio controller codec is always enable. So I think=
=20
> it is not need abstract to general clock API.

No, you're still missing the point.  You are requesting external clocks,
why are you not managing those here?

--ZXg5XZblsOcYBG3r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFA4eAAoJELSic+t+oim9uLcP/Rd6sCuRlqqOgbdGTOI8IVp8
Rg4i25cOKwKmEhJDVOSpEsW+S3AOaSQBSXd0h8JippVyRzHeLs35gVsfuTwPSVqG
Ms5yvAZL3EHi4An277mX3qnATmPrFcSHQkkuMobIY30z51tUPBCPdHLD0cpVTUnB
BxpfwdWjRxs9pR25biW4l/N3xX9dSDQiVPdmRN9O+3bTT1pdb4Oj5qQSvC3BZnH9
rWdyZGVHoq8XFrQ3m5LWP0bH8E3S6MMZ2S7PiYSAfm+Catq7zvZEY0xoSAio96T8
4i2j7+AjQBhZeg+dyIAhx0KauXoXCUI1Os+TAmwhm5GIEt1Ro/vO+70Uxfl684rx
MSbruqFmruXfeEjAkik9zG0sQloE2VBNLBTOJ3HSHR16jh7Z4EqSe7gzpZ9Vogsd
zDPpQvh2y1gPNKl8+UGthZGLElfCPnh1iZn7yXbckwC0BnE61W7mLeFtWEx7Fa0Z
mJeRR44x+YgfleXGO2KE+vMuyII67/mHn+xLR3ecFYcAPB1iOuLTq3zzltLztitV
C5sRiqP9GY+9OjwbPAxUKzrhqmMcK4a9IBciDoEiai5rl5FOgTqCAGYOZ1cIZ8/L
C5fd36WgReowExgTeDSzUBYj0fLt6Z6l7HOdaimxIUtIPLgJwqgT5TO+sVJ+7TY7
lvb/5x6MHZ7QEGCHHYMr
=2Vwi
-----END PGP SIGNATURE-----

--ZXg5XZblsOcYBG3r--

--===============1833680676849974963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1833680676849974963==--
