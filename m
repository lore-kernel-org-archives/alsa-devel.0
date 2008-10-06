From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: size of snd_hda_intel
Date: Sun, 05 Oct 2008 20:04:36 -0500
Message-ID: <1223255076.20200.1976.camel@petrie.sacredspiral.co.uk>
References: <9e4733910810051519k427dce6aobca50815bfac30e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8260420447474691592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [67.202.90.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BEDE2436B
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 03:05:04 +0200 (CEST)
In-Reply-To: <9e4733910810051519k427dce6aobca50815bfac30e2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8260420447474691592==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1qcgBpFFtcmStSyc1ETO"


--=-1qcgBpFFtcmStSyc1ETO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 2008-10-05 at 18:19 -0400, Jon Smirl wrote:
> >ismod
> snd_hda_intel         435,772
>=20
> 435,772 bytes seems awfully large for an audio driver. The large size
> seems to be due to having support for multiple codecs in the driver.
> Could a generic  hda driver load the correct codec dynamically instead
> of building them all in statically?
>=20
> I have a Realtek codec.
>=20

snd_hda_intel should probably be rearchitected to be similar to the way
that snd-aoa works... e.g. multiple modules for codecs, etc.

But, that's a lot of effort, and I don't personally have the hardware to
test (only one box of mine has HDA audio that I know of, and I use a
better card there), or I would start working on making that happen.

William

--=-1qcgBpFFtcmStSyc1ETO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI6WQkoB+26npOQg4RAnhzAJ9l/kCzPCTmhM/N+AIo89X8hzeTMQCfVJyf
+q4qreYcapk4S7xUJI6E/lI=
=ciDg
-----END PGP SIGNATURE-----

--=-1qcgBpFFtcmStSyc1ETO--


--===============8260420447474691592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8260420447474691592==--
