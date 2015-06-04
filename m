From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: zx: fix platform_no_drv_owner.cocci
	warnings
Date: Thu, 4 Jun 2015 18:53:00 +0100
Message-ID: <20150604175300.GP14071@sirena.org.uk>
References: <201506050116.40gO5c34%fengguang.wu@intel.com>
 <20150604171126.GA226227@ivytown2>
 <20150604171659.GO14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6179192846595984754=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05910260601
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 19:53:12 +0200 (CEST)
In-Reply-To: <20150604171659.GO14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, kbuild-all@01.org, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6179192846595984754==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8RzCspYsRAU9V6Ra"
Content-Disposition: inline


--8RzCspYsRAU9V6Ra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2015 at 06:16:59PM +0100, Mark Brown wrote:
> On Fri, Jun 05, 2015 at 01:11:27AM +0800, kbuild test robot wrote:
> > sound/soc/zte/zx296702-i2s.c:428:3-8: No need to set .owner here. The c=
ore will do it.
> >=20
> >  Remove .owner field if calls are used which set it automatically
>=20
> Applied, thanks.

These mails are CCed to kbuild-all@01.org which is generating
backscatter since it's subscribers only (not even moderated for
non-subscribers) - you can you please disable the mails to
non-subscribers or open the list up?

--8RzCspYsRAU9V6Ra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcJB7AAoJECTWi3JdVIfQkeEH/1w1xzDm6LB4sC/XK6jL+deQ
Py7BoRkVCQzJuyyWaRBFLApky60UichVRyqizDAzYMDbYvndTx4jbihSkSG9UAkY
oRdrn4wQIpl5QxQm1mw+8QIxqyfYWc838QK/Tmkzq5bpjKi/ofIBXGkB9SWYWPni
Br4MClpqKJCi9Zg0rNU/nf0GG5NQq971PrjSg7vK9cF5kbRISgWW9SUxWh+3Vhno
F556UXzY2Ddq2cZE49yZE43E0BQ0b54SUExZu87IJbOCN1LXn4GSsXC36Kow19Hm
9VlIkVvbetJOiqtaWm19/xsE0II3ZoN1Uxw1awt07WhUq5alNKbgNlNBRP3W+nM=
=yXCc
-----END PGP SIGNATURE-----

--8RzCspYsRAU9V6Ra--

--===============6179192846595984754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179192846595984754==--
