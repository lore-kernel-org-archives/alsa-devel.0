From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Fri, 1 Feb 2008 22:02:51 +0100
Message-ID: <200802012202.59047.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<200801291105.43407.mailinglists@martin.egge.info>
	<s5hmyqo4qde.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3422179656256637137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 181EC245F4
	for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2008 22:03:02 +0100 (CET)
In-Reply-To: <s5hmyqo4qde.wl%tiwai@suse.de>
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

--===============3422179656256637137==
Content-Type: multipart/signed;
  boundary="nextPart2485571.7lKnkvU7IG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2485571.7lKnkvU7IG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Dienstag, 29. Januar 2008 schrieb Takashi Iwai:
> Could you try HG bisect?  It'd be greatly helpful.

I've tried HG bisect this evening. It took me some time to discover that th=
e=20
problem is not within alsa-driver or alsa-kernel but within alsa-lib. This =
is=20
the result of HG bisect:

The first bad revision is:
changeset:   2397:d1e9a2f92e7b
user:        tiwai
date:        Fri Jan 18 13:42:51 2008 +0100
summary:     dmix - Enable auto format detection as default


Regards,
Martin

--nextPart2485571.7lKnkvU7IG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHo4kCVG/GfU56d2wRAqhVAJ4wiScFhp4vawyfI0CHupxuLd6klwCgidVS
qK3IvIAhecSc5TjtW1jWTY8=
=1S2h
-----END PGP SIGNATURE-----

--nextPart2485571.7lKnkvU7IG--

--===============3422179656256637137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3422179656256637137==--
