From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Mon, 11 Feb 2008 19:13:06 +0100
Message-ID: <200802111913.13404.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<200802091301.25360.mailinglists@martin.egge.info>
	<s5hwspbv74j.wl%tiwai@suse.de>
	(sfid-20080211_180331_856671_47C53BF4)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8910422467436319390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 73928244A5
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 19:13:23 +0100 (CET)
In-Reply-To: <s5hwspbv74j.wl%tiwai@suse.de>
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

--===============8910422467436319390==
Content-Type: multipart/signed;
  boundary="nextPart2884178.7Ju7ES1MDx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2884178.7Ju7ES1MDx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Montag, 11. Februar 2008 schrieb Takashi Iwai:
> How about the patch below?  If it still doesn't work, please show the
> whole codec#* proc file again.

Hey, after some hard work you've solved the problem: Internal, external mic=
=20
and jack sensing are working perfectly.

Thanks a lot!
Martin

--nextPart2884178.7Ju7ES1MDx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHsJA4VG/GfU56d2wRAiHQAJ9/AJbH8HGa9Z+q/EqR53oGzPEg8wCfcS94
dUEfhreuGRBsGq+z5S5zw7Q=
=kiPM
-----END PGP SIGNATURE-----

--nextPart2884178.7Ju7ES1MDx--

--===============8910422467436319390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8910422467436319390==--
