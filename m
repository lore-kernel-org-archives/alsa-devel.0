From: Tony Vroon <tony@linx.net>
Subject: Re: power save of snd_hda_intel
Date: Wed, 28 May 2008 14:50:27 +0100
Message-ID: <1211982627.4166.3.camel@localhost>
References: <827ad74d0805280609p8420727gcf08dd557a52ae5a@mail.gmail.com>
	<s5hk5hepnv9.wl%tiwai@suse.de>
	<827ad74d0805280627h4aee4631sea6634d5be77a4d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2928545971555302001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4893E2464E
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 15:51:27 +0200 (CEST)
In-Reply-To: <827ad74d0805280627h4aee4631sea6634d5be77a4d9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha priya gupta <harshapriya@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2928545971555302001==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rmxKUeo9JIV96yusYozl"


--=-rmxKUeo9JIV96yusYozl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-05-28 at 18:57 +0530, Harsha priya gupta wrote:
> 3. From ALSA .15 version, if am not wrong, power_save is enabled by defau=
lt.

The functionality is enabled, but the default timeout is 0 seconds
(never power down). You may have to specify a timeout. 10 seconds works
well for me, but you can try something more aggressive like 3 seconds if
you want to see quick response on your measurements.
Generally you can hear the power up as an audible pop as you start
playback.

Regards,
Tony V.

--=-rmxKUeo9JIV96yusYozl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkg9YyMACgkQp5vW4rUFj5pQRQCglvw3m6K7L8gnXezGx+BFOo6v
KLgAoKCzRyXruKy4hbT81hXoiWvtLmuq
=PCW+
-----END PGP SIGNATURE-----

--=-rmxKUeo9JIV96yusYozl--


--===============2928545971555302001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2928545971555302001==--
