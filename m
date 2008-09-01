From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Using GDB for ALSA How to?
Date: Mon, 1 Sep 2008 22:24:07 +0200
Message-ID: <20080901202407.GL15719@lug-owl.de>
References: <48BC4E6A.1070508@popdial.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0417594438320434066=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CA1451037FA
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 22:24:07 +0200 (CEST)
In-Reply-To: <48BC4E6A.1070508@popdial.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Estrada <MrUmunhum@popdial.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0417594438320434066==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-09-01 13:19:54 -0700, William Estrada <MrUmunhum@popdial.com> =
wrote:
>   I am trying to use GDB with my ALSA program. I wish to display (print)=
=20
> a handle for
> an snd_pcm_t pointer. I am getting the following error:
> > (gdb) p Device
> > $9 =3D (snd_pcm_t *) 0x92be458
> > (gdb) p *Device
> > $10 =3D <incomplete type>
>   How do I display the snd_pcm_t structure?

My guess is that this pointer is simply uninitialized. Did you check
that it was properly prepared?

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:              What we do for ourselves dies with us. What we d=
o for
the second  :         others and the world remains and is immortal. (Albert=
 Pine)

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIvE9nHb1edYOZ4bsRAinUAJ4/W3OSj/Gsz9wJevaYHYkRJl1tsACfay6j
xMjdkawmOSOy3ZhOaDr6bag=
=e3m3
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--

--===============0417594438320434066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0417594438320434066==--
