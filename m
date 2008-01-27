From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Sun, 27 Jan 2008 23:15:03 +0100
Message-ID: <200801272315.03890.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<s5hwspxj2ir.wl%tiwai@suse.de>
	<200801252005.42391.mailinglists@martin.egge.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8381325655465585881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B8D710382D
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 23:15:16 +0100 (CET)
In-Reply-To: <200801252005.42391.mailinglists@martin.egge.info>
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

--===============8381325655465585881==
Content-Type: multipart/signed;
  boundary="nextPart48065660.4xbr7h41se";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart48065660.4xbr7h41se
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Freitag, 25. Januar 2008 schrieb Martin Egge:
> Am Freitag, 25. Januar 2008 schrieb Takashi Iwai:
> > Anyay, the patch below is to change the mic input behavior.
> > With the patch, the mic input is toggled automatically via jack plug.
>
> The external mic input is toggled via jack plug now. But the internal mic
> still is not working.

I've got some information that might help you. If I set model=3D3stack the=
=20
internal and external mic are working in parallel. There is no jack-sense=20
which disables the internal mic when an external mic is connected.


HTH
Martin

--nextPart48065660.4xbr7h41se
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHnQJnVG/GfU56d2wRAtbdAJ99BkS1o9H24LC9j7FMlEWZt+53yQCfQbAR
GvsvierBXqZU39WuQn6MnvU=
=Tbng
-----END PGP SIGNATURE-----

--nextPart48065660.4xbr7h41se--

--===============8381325655465585881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8381325655465585881==--
