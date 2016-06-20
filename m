From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Mon, 20 Jun 2016 17:17:42 +0530
Message-ID: <20160620114742.GQ16910@localhost>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <20160617111407.GE26099@sirena.org.uk>
 <20160617121359.GH16910@localhost>
 <20160617123523.GP26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4149239087806730595=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 23873266613
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 13:40:52 +0200 (CEST)
In-Reply-To: <20160617123523.GP26099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4149239087806730595==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Content-Disposition: inline


--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 01:35:23PM +0100, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 05:44:00PM +0530, Vinod Koul wrote:
> > On Fri, Jun 17, 2016 at 12:14:07PM +0100, Mark Brown wrote:
>=20
> > > Just use snd_soc_resume() directly.
>=20
> > Nope, that leads to warnings.
>=20
> > .complete is the only callback that expects void return whereas
> > snd_soc_resume like other returns int.
>=20
> This is possibly an indication that you're abusing things then - this is
> a very unusual interface to use as well...  the patch just looks very
> fishy as is, and as we were talking about in the other thread Lars
> started it seems like this is bodging around something rather than
> solving the right problem.

In the hindsight, I do agree that instead of this, we should move platform
to do suspend_late and resume_early. That way the dependency between card
and platform is taken care in a much bteer fashion.

The problem is two components racing and need of the resume being in serial
fashion.

Thanks
--=20
~Vinod

--80Ds8Z/hZmemMosa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZ9feAAoJEHwUBw8lI4NH0w4P/2SNFqLzFwwYrf3MWPBmq0mY
q2xk8yt76Lmxv8u2mLLaltFhpRw5Fi7AzNih+ICppslVZIzaVO9M/TxHgyKBTAzu
pBydlwJlOx6qRb5/57bCwqLhNxCvxR6Wmqv4LM3kq0zIhqaGp24tSvAUIYmsE21t
f83Gss1PuhCzgbjFJsOuy/WhegM50mxryNjrPFLyViVvUgAeSjJQgH+P44fXIR4I
XFxeXthnpSnA696NqLyQAG7VaZGq0bvmNaBqe98F4nXW8wDPksRxeFDr29A0hxmU
dMkpfyvLUGiaS5SnFV4lbFOwRcDYMn/Rn0FcJs28T9m0VuahTCKQ8ejdSMRIWIVb
olAPKm1JeacA7I/FMPw/NomUh58liyebDnSGbC1YbSzgv42sdX0ZUgFQgN3WXPmq
LZzowKYg2OShTrS3UDR015M91t6Wj382wiHeoiaubxe1m6UQR/zabDgBwf1TJlm6
4HjcUJp4Pam2aPc3j5selpxi9FrUpfI6D26tfQk9l3u/zPnrAaCn4W1K3zVU6ntO
DUVy1BFFOENP+VBW/guFQAWYA/lAY/s2Yo0mHB5rOqyDj3hIykUQYKM7iS3jiWhh
+TNrA+YEIVbumNvOCer+pkrRuWeWMUNktTWbyq4ld+ma7gWctKBHp50+v+vcbbj5
Oe6sG+Zu+T6Scerh83Bi
=3W5h
-----END PGP SIGNATURE-----

--80Ds8Z/hZmemMosa--

--===============4149239087806730595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4149239087806730595==--
