From: Stuffed Crust <pizza@fucktheusers.org>
Subject: Re: AC'97 compliant codec - query
Date: Tue, 7 May 2002 09:43:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020507134346.GA17561@shaftnet.org>
References: <20020507133010.20306.qmail@webmail12.rediffmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020507133010.20306.qmail@webmail12.rediffmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anandhi Dhanabalan <anandhid@rediffmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2002 at 01:30:10PM -0000, Anandhi  Dhanabalan wrote:
> I am a new to Audio driver development. I am currently developing=20
> a driver for Crystal Audio codec CS4205.

You'll never use the CS4205 directly -- it is just an AC97 codec.
You'll also need an AC97 controller, such as the one in the
ICHx/southbridge chip in most modern chipsets.

That controller handles all of the details of serializing data and
whatnot.  You need to set up the controller to pass data in the right
slots, and set up the codec's mixer and whatnot. =20

The CS4205 is specifically supported by the ac97_codec driver in=20
alsa0.9.0rc1, and more generically supported by earlier versions.  You
may want to look at the intel8x0 driver code as well, as that is little
more than a thin hardware wrapper around the ac97 codec.

 - Pizza
--=20
Solomon Peachy                                    pizzaATfucktheusers.org
I ain't broke, but I'm badly bent.                           ICQ# 1318344
Patience comes to those who wait.
    ...It's not "Beanbag Love", it's a "Transanimate Relationship"...

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE819oSPuLgii2759ARAouHAJ95EIkYQe36F9f1v8MkaTyUX/zOiACfdqQ5
7BgXEjAviNABeM3iTtRvyl0=
=JQD8
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
