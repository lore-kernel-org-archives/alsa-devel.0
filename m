From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6 v3] ASoC: rsnd: Add Volume Ramp support
Date: Fri, 7 Nov 2014 10:45:10 +0000
Message-ID: <20141107104510.GG8509@sirena.org.uk>
References: <87egtp2g05.wl%kuninori.morimoto.gx@gmail.com>
 <87egti46j7.wl%kuninori.morimoto.gx@gmail.com>
 <8761eu46cz.wl%kuninori.morimoto.gx@gmail.com>
 <20141106165829.GQ8509@sirena.org.uk>
 <87389v98eo.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2257155192106038796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F61A2655F7
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 11:45:22 +0100 (CET)
In-Reply-To: <87389v98eo.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2257155192106038796==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fTMItigZdw4hn5Z7"
Content-Disposition: inline


--fTMItigZdw4hn5Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 04:11:12PM -0800, Kuninori Morimoto wrote:

> > Correct me if I'm wrong but I think what's confusing me here is that
> > what I'd expect to happen is that setting the ramp rate would cause any
> > volume change done by the user to ramp to the target volume (or mute)
> > but it looks like what's actually happening is that the ramp control is
> > providing an additional layer of volume control on top of the normal
> > volume control.

> Sorry for my poor explanation.
> Yes, you are correct.
> Volume Ramp chenges [ramp layer] (0% - 100%)
> [ramp layer] is always 100% if you don't use Volume Ramp.

>          [Normal Volume] x [ramp layer] = output

> Please let me better/understandable naming.

OK, right.  In that case what I'd expect is that the only control the
user gets is of the ramp rate and then if that's configured any time the
volume is changed the driver will ensure that the change is implemented
with a ramp - that'd correspond to the normal implementation of this in
other devices (usually the hardware just does this so we don't have to
do anything special in software).

--fTMItigZdw4hn5Z7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXKK1AAoJECTWi3JdVIfQtScH+QFMzOtjAzcJg19vnrJf4hil
SVuWCQFinRTQxNjUgRmysbr+G9iLXizgERkT4r9HtNiZlt7gbAe/TfEi6U42zw2a
F4puPS6uEyCnkZ5OTsLDXmOAnv54gvrmD7VBH5GaFG4UhSgdA7Ej+oqwiSM7DJx2
tRRi/u1bTBrEeLjVGVEBH7WQCqToQUHq4KKdZH32BkdrrA8oV8cFq1ReaQEeV5sK
VfdjyhTM6GAvYOBqiJdT1TR8RXwEFzWJ2zaLy5lv9qJd2bCgxpF4eq0jWjqr+t3R
UU1K7IcK3qrQ/BTqhIX0swK9t7uZHfWeib6PuyfOGy49wAyDY7VtaimlsLAkODU=
=SDxp
-----END PGP SIGNATURE-----

--fTMItigZdw4hn5Z7--

--===============2257155192106038796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2257155192106038796==--
