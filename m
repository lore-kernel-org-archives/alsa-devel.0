From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#436502: alsa-tools
	->	usx2yloader
Date: Thu, 13 Sep 2007 11:32:53 +0200
Message-ID: <20070913093252.GA7645@aragorn.home.lxtec.de>
References: <20070911152102.GA17585@frodo.home.lxtec.de>
	<20070912205256.GR4125@frodo.home.lxtec.de>
	<8e4fc8270709130123x39b33a1fkd4dae9d018bb4c65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3659077962316354602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id CE69E244C3
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 11:32:59 +0200 (CEST)
In-Reply-To: <8e4fc8270709130123x39b33a1fkd4dae9d018bb4c65@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Bourgeous <sts.nitrogen@gmail.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, pkg-alsa-devel@lists.alioth.debian.org, alsa-devel <alsa-devel@alsa-project.org>, 436502@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--===============3659077962316354602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Sep 2007 the mental interface of
Michael Bourgeous told:

> On 9/12/07, Elimar Riesebieter <riesebie@lxtec.de> wrote:
> >
> > Attached is a patch for the Makefiles and an udev rule which should
> > work anyway. I don't have TASCAM US-122 usb hardware handy, so
> > I would be very pleased if someone could test it.
> >
> > Thanks
> >
> > Elimar
> >
>=20
> I can't remember for sure, but the included rules file might have
> problems loading the us428control program.  I think there might have
> been problems I encountered with using the tascam_fpga script directly
> from udev, since us428control doesn't self-daemonize.  I'll attach the
> .rules file that I use, which might be useful as an example to fix the
> .rules file provided already if it's found that there are problems
> with udev and the existing tascam_fpga script.  As I recall, since
> us428control was still holding on to its stdout, udev would hang and
> not load any devices after the US-428.
>=20
> A better option might be a patch to us428control to add a daemonize
> switch (which, of course, could be as simple as fclose()-ing stdin,
> stdout, and stderr, and dealing with any I/O functions accordingly).

Hmm, from my patch tascam_fw and tascam_fpga are installed to
/lib/udev. The udev rules are calling these scripts which are almost
doing what your udev rule is doing manualy, isn't it?
There is one user [0], who came along with an rule similar to the
attached which still works. My intention is not do rewrite
usx2yloaders, but optimize it for distribution.

I don't know whether upstream is active to help? A statement from
Karsten Wiese would be helpfull at that point ;)

But if your rule works for sure, I can distribute it with your
allowness. There are still ugly sh -c calls I don't understand yet.

[0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D361558

Thanks for your competent input ;)

Elimar


--=20
  The path to source is always uphill!
                                -unknown-

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6QPE3Ig8bsVPf7ARAk7TAJ40tHd8n8tYMgzs5P3Mko0Ope3FFQCfW5+/
8PdkfOXHY8Hl2hu8WtgyYac=
=VnT6
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============3659077962316354602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3659077962316354602==--
