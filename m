From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re: Digital-Out (Toslink) on HDA-Intal (AD1986A)?
Date: Mon, 11 Feb 2008 19:22:19 +0100
Message-ID: <200802111922.19562.mailinglists@martin.egge.info>
References: <200801222121.05757.mailinglists@martin.egge.info>
	<200802072304.01096.mailinglists@martin.egge.info>
	<s5hfxw3ya8g.wl%tiwai@suse.de>
	(sfid-20080208_121323_322371_3FB65A08)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8549062262712766446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A6411037F1
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 19:22:21 +0100 (CET)
In-Reply-To: <s5hfxw3ya8g.wl%tiwai@suse.de>
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

--===============8549062262712766446==
Content-Type: multipart/signed;
  boundary="nextPart1440334.9Eb94ruJ8I";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1440334.9Eb94ruJ8I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Am Freitag, 8. Februar 2008 schrieb Takashi Iwai:
> At Thu, 7 Feb 2008 23:04:00 +0100,
> Martin Egge wrote:
> > Am Donnerstag, 7. Februar 2008 schrieb Takashi Iwai:
> > > If my guess is correct, you can propbably get SPDIF output via "spdif"
> > > output.  What happens with the below?
> > >
> > > 	% aplay -Dplug:spdif foo.wav
> >
> > You are right. Choosing plug:spdif plays the sound cia the SDIF-Out. Of
> > course this does not play the sound via the internal speakers when no
> > SPDIF is connected.
> >
> > But I'd prefer the old behavior from 1.0.15 where the default device was
> > playing sound via SPDIF when connected and via internal speakers when
> > SDIF is not connected.
>
> Try the patch below.  This adds the mixer switch "Analog To SPDIF".
> If this is on, the supported format is more limited so that the
> default PCM can route to SPDIF.  If this switch is off, dmix will
> choose 32bit automatically.

The patch works perfectly for me. I like this new switch. Perhaps you shoul=
d=20
rename it to "Analog to IEC958 Output". I've seen this name on some other=20
cards with ALSA.

Regards,
Martin

--nextPart1440334.9Eb94ruJ8I
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHsJJbVG/GfU56d2wRArFhAKCDd81nyjZw9ecdzMS7wvhjrsmGlgCfcrc9
Nk4T67KW1Uis2L8UE+Q4WxU=
=OHqE
-----END PGP SIGNATURE-----

--nextPart1440334.9Eb94ruJ8I--

--===============8549062262712766446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8549062262712766446==--
