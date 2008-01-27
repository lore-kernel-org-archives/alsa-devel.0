From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Sun, 27 Jan 2008 23:03:20 +0100
Message-ID: <200801272303.20917.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<s5hr6g87qfu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5250121052221992385=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C2088103829
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 23:03:34 +0100 (CET)
In-Reply-To: <s5hr6g87qfu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5250121052221992385==
Content-Type: multipart/signed;
  boundary="nextPart5674093.9VYP8IGoFu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5674093.9VYP8IGoFu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Takashi,

Am Mittwoch, 23. Januar 2008 schrieb Takashi Iwai:
> The SPDIF is disabled intentionally for your model because no one
> could test it.  Does the patch below work?

As I already have written: this patch does not work with the code from hg. =
But=20
I've applied it successfully on 1.0.15. The digital output is working and c=
an=20
be disabled with the IEC958 switch.

Using the code from hg the digital output is not working as well when I set=
=20
model=3D3stack. This has has been working with the original code from 1.0.1=
5=20
and 1.0.14. So there must be a general problem with IEC958 in the hg code.

I've another question regarding the digital output. Is there a way to contr=
ol=20
the volume of the digital output? Neither the Master nor the PCM control ha=
ve=20
any effect on the volume of the digital output. In addition the output can'=
t=20
be switched off by muting PCM or Master.

Regards,
Martin

--nextPart5674093.9VYP8IGoFu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHnP+oVG/GfU56d2wRAk3nAJ9xtuz6p7h/bPJjA2g0ZxlOot9E8QCfVrDC
8vduNi2yd6PuggZr1XSZ9kc=
=H4gR
-----END PGP SIGNATURE-----

--nextPart5674093.9VYP8IGoFu--

--===============5250121052221992385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5250121052221992385==--
