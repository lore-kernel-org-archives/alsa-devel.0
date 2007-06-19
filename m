From: Ed Schouten <ed@fxq.nl>
Subject: Re: Changing the sample rate/channels of an
	already	opened PCM stream
Date: Tue, 19 Jun 2007 10:06:02 +0200
Message-ID: <20070619080602.GO27942@hoeg.nl>
References: <20070618184758.GL27942@hoeg.nl>
	<1182232782.12152.1195873653@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0665217350474310183=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from palm.hoeg.nl (mx0.hoeg.nl [83.98.131.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D1B124349
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 10:06:03 +0200 (CEST)
In-Reply-To: <1182232782.12152.1195873653@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0665217350474310183==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIlomvtVtXAVxSKT"
Content-Disposition: inline


--oIlomvtVtXAVxSKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

* Clemens Ladisch <cladisch@fastmail.net> wrote:
> Ed Schouten wrote:
> > I have been trying to get the device to reset so I can change the sample
> > rate, but for some reason, it just gets ignored. Can someone explain me
> > how it's possible to reset the sample rate after preparing the handle?
>=20
> The various snd_pcm_hw_params_set_xxx() functions choose some value for
> a parameter that has not yet been set, but they do not change a
> parameter once it has been set.  To reset all parameters in a hw_params
> container, call snd_pcm_hw_params_any() again.

Calling snd_pcm_hw_params_any() before changing the sample rate did the
trick. Thanks a lot! :-)

Yours,
--=20
 Ed Schouten <ed@fxq.nl>
 WWW: http://g-rave.nl/

--oIlomvtVtXAVxSKT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (FreeBSD)

iD8DBQFGd45q52SDGA2eCwURAtSIAJ9xw4H7rxdZ9RyoRSFgUhf9Q/ZPUwCeIl5j
K/Ykfo8AOzl+e+rOzfpKS+A=
=3yRZ
-----END PGP SIGNATURE-----

--oIlomvtVtXAVxSKT--

--===============0665217350474310183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0665217350474310183==--
