From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: Re: au88x0_synth
Date: Fri, 13 May 2005 16:27:58 +0200
Message-ID: <200505131628.03297.alien999999999@users.sourceforge.net>
References: <423CCDAC.80401@netvigator.com> <200504230928.06494.alien999999999@users.sourceforge.net> <4284B43B.6040309@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2091691.R6d4ISsgjD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4284B43B.6040309@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

--nextPart2091691.R6d4ISsgjD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Op vrijdag 13 mei 2005 16:05, schreef Raymond:
> It is abnormal to get the message "vortex: reg error" on your au8810, it
> does not appear in my au8830.
>
> http://savannah.nongnu.org/support/?func=3Ddetailitem&item_id=3D102951
>
> You will need to find out the code which cause "vortex: reg error".

if i have some time, i will try it...

> You may try the following:
>
> 1) Remove code relating to SPDIF ( only SQ1500 and au8830 has SPDIF )
>
> 2) use hwwrite(vortex->mmio, VORTEX_CODEC_EN,
> hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_CODEC0);
>
> No need to use (EN_CODEC0 | EN_CODEC1 ) since your au8810 only has
> stereo codec.

you sure about that, the card told me it had stereo and 4 speaker mode? or =
are=20
we talking about different stuff?

> You can use .openalrc to configure OpenAL to use ALSA
>
> (define devices '(alsa))
> (define speaker-num 2)
> (define alsa-out-device "hw:0,0")
> (define alsa-in-device "hw:0,0")

will try

> >>Use alsamixer to find out which ac97 codec on your au8810.
> >
> > chip: Wolfson WM9701A
> >
> >>Do you have any application using gameport, mpu401 or OSS  ?
> >
> > haven't gotten any gameport to work, not on the emu10k1 nor the au8810,
> > never use MPU401 and i use OSS emulation on games like AA, ET, OpenAL...
> >
> >>>i've had this major crash below only 3 times; and the logs didn't
> >>>detect anything specific at the time. the only thing the logs
> >>>mentioned at that time was an ntpd sync going on; so the only thing i
> >>>can think of is that at a certain moment when a sync is going on, some
> >>>kind of lock is holding cause this to happen... the only thing that i
> >>>can do to fix this is reset...
> >>
> >>Do the log indicate the snd-au8810 is loaded properly ?
> >
> > yes of course: it gives
> >
> > vortex: reg error
> >
> > as always ;-)
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--nextPart2091691.R6d4ISsgjD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBChLlzuBWKXETrtdcRAjS5AJ4zYAh0MuKUqeYv8ExVF0aKKBtJigCcCRZf
DhXnfQ4uGhRX/rzqnCg7Bs0=
=VObG
-----END PGP SIGNATURE-----

--nextPart2091691.R6d4ISsgjD--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
