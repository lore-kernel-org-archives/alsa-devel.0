From: Sebastian Benoit <benoit-lists@fb12.de>
Subject: Re: Juli@-Card and hanging process snd-ak4114/0
Date: Tue, 15 Mar 2005 17:47:55 +0059
Message-ID: <20050315164817.GA86246@mail.webmonster.de>
References: <20050310170354.GH78387@mail.webmonster.de> <Pine.LNX.4.58.0503101812250.1733@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Received: from mail.webmonster.de (datasink.webmonster.de [194.162.162.209])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 6CA9C1B1
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2005 17:47:57 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503101812250.1733@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Jaroslav Kysela(perex@suse.cz) on 2005.03.10 18:14:12 +0000:
> > The main problem is, that a process "snd-ak4114/0" is using 60% of my C=
PU
> > time. I would like to solve this problem, and have started reading trou=
gh
> > the code. But it seems I need some pointers where to look ;-)
>=20
> You may try to change queue_delayed_work(chip->workqueue, &chip->work, 1);
> to queue_delayed_work(chip->workqueue, &chip->work, 2); (or highter value)
> in alsa-kernel/i2c/other/ak4114.c .

A value of two gives me 40% CPU time, with 100 the process uses ~2%.
=20
> It seems that i2c takes too much time. Or it might be, that the scheduler=
=20
> code for task statistics is somewhat broken.

My other process behave like they dont get enough time, so i think the
scheduler stats are right ;-)

With the value in ak4114.c set to 100 everything is working. I don't know
about spdif, i haven't tried that, am i right that the ak4114.c code manages
digital i/o?

My application is recording and playing (something differen) at the same
time via this card, and that works fine now, except for the output volume.

I am willing to test more. Is someone working on the mixer code?

Thanks for your help.
/B.
--=20
Sebastian Benoit <benoit-lists@fb12.de>
My mail is GnuPG signed -- Unsigned ones are bogus -- http://www.gnupg.org/
GnuPG 0xD777DBA7 2003-09-10 D02B D0E0 3790 1AA1 DA3A  B508 BF48 87BF D777 D=
BA7

That's so plausible I can't believe it -- Leiyla, Futurama

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (FreeBSD)

iD8DBQFCNxHRv0iHv9d326cRAiZ2AKCgRDQGpXsaYnTiVNouOWxf+dPEVgCgq0J2
ZUbjB3vqkq8skg6/xjsHsww=
=BHyh
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
