From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Thu, 7 Feb 2008 22:55:40 +0100
Message-ID: <200802072255.40962.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<s5hodb44r6r.wl%tiwai@suse.de> <s5hodasyapd.wl%tiwai@suse.de>
	(sfid-20080207_215131_712366_367C79A7)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0557331288687506042=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 0499824669
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 22:55:43 +0100 (CET)
In-Reply-To: <s5hodasyapd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0557331288687506042==
Content-Type: multipart/signed;
  boundary="nextPart9626555.XVd7nETxfq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9626555.XVd7nETxfq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Donnerstag, 7. Februar 2008 schrieb Takashi Iwai:
> The patch below adds the automatic mic switch for Samsung.
> Give it a try.

I gave it a try on the latest HG. You almost got the hang on it. The intern=
al=20
mic works for the first time with model=3Dlaptop-eapd. But the jack sense=20
(autmatic switch to external mic when connected) does not work. Both mics a=
re=20
recorded at the same time.

Regards,
Martin

--nextPart9626555.XVd7nETxfq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHq35cVG/GfU56d2wRAlWRAJ4vTD2EJkh50qhVYNYWyLKGVZOAYACggbq0
uJknmk9gXN8O6yGUXv2yY7U=
=sO57
-----END PGP SIGNATURE-----

--nextPart9626555.XVd7nETxfq--

--===============0557331288687506042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0557331288687506042==--
