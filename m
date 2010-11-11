From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: alsa jack plugin
Date: Thu, 11 Nov 2010 23:11:57 +0100
Message-ID: <1289513517.16615.10.camel@mattotaupa>
References: <20101108092647.GS4410@siel.b>  <20101110101846.GD4238@siel.b>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7804022725806990128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id F291D103815
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 23:11:59 +0100 (CET)
Received: from f053038093.adsl.alicedsl.de ([78.53.38.93]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1PGfN8-0001pq-Fg
	for alsa-devel@alsa-project.org; Thu, 11 Nov 2010 22:11:58 +0000
In-Reply-To: <20101110101846.GD4238@siel.b>
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


--===============7804022725806990128==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-/8Kg53LtjfNe2++Xz3H+"


--=-/8Kg53LtjfNe2++Xz3H+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 10.11.2010, 11:18 +0100 schrieb torbenh:
> On Mon, Nov 08, 2010 at 10:26:47AM +0100, torbenh wrote:
> >=20
> > the alsa jack plugin has quite some problems:
> > a) does not work correctly with mplayers alsa output. (and quite a few
> >    others)
> > b) it includes the pid in its clientname.
> > c) it requires port connections.
> > d) jack client is deactivated when alsa stream is not active.
> > e) no way to set the jack clientname
> >=20
> > the master branch on git://hochstrom.endofinternet.org/alsa-plugins
> > carries fixes for a, b and e.
> >=20
> > c and d have their own branches.
> >=20
> > i have seen a few problems with making the write end of the fd
> > non-blocking. would it be possible to use eventfd(2) for this ?
>=20
> did anybody see this mail ?
> do you prefer patches in a different form ?

Please follow `Documentation/SubmittingPatches` [1]. I was told to
always CC the maintainers (item 7). You should also tag your message in
the subject with `[PATCH]` (item 11). Item 16 talks about sending a pull
request.

> looks like you want git send-email

I guess this way people will be able to review your patches more easily
and give feedback.

> or is there another ML for the plugins ?

I do not think so.


Thank you for your contribution. I hope the developers will be able to
take a look. I also believe that Takashi is on vacation right now and is
going to be for another week [2].


Thanks,

Paul


[1] http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dblo=
b;f=3DDocumentation/SubmittingPatches;h=3D689e2371095cc5dfea9927120009341f3=
69159aa;hb=3DHEAD
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/0333=
66.html

--=-/8Kg53LtjfNe2++Xz3H+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzcaiEACgkQPX1aK2wOHVj+zgCeNziB6IIuf0I/tw2hyuuksyb6
ZZUAni4UduAWqoUn7/cpyWJTJM0F/ffD
=DTZp
-----END PGP SIGNATURE-----

--=-/8Kg53LtjfNe2++Xz3H+--


--===============7804022725806990128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7804022725806990128==--
