From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: Use devm_clk_get()
Date: Tue, 11 Jun 2013 09:41:57 +0100
Message-ID: <20130611084157.GR1403@sirena.org.uk>
References: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
 <20130611004437.GA12514@S2101-09.ap.freescale.net>
 <CAOMZO5Avoamo-JPEVz4BoXvrmmbQd8C4o5DQ0For5Asueb5jQA@mail.gmail.com>
 <CAAQ0ZWSs7otvj2pO64+8b=QJc=c563SPAPK3unS_VzQA+LLO-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5090358681048226952=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F83261A3F
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 10:42:07 +0200 (CEST)
In-Reply-To: <CAAQ0ZWSs7otvj2pO64+8b=QJc=c563SPAPK3unS_VzQA+LLO-w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5090358681048226952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ZpWocbG2H/Vq+uQ"
Content-Disposition: inline


--0ZpWocbG2H/Vq+uQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 10:50:40AM +0800, Shawn Guo wrote:

> Why do you need to pass it at all?  It seems to me that the machine
> driver only needs the frequency to set up sgtl5000 sysclk.  So it ends
> up with something below.

>  - sgtl5000 driver calls clk_get_rate() to get the frequency
>  - sgtl5000 driver passes the frequency to imx-sgtl500 driver
>  - imx-sgtl500 driver sets the frequency back to sgtl5000 via
>    .set_sysclk callback

> I need some help to understand why sgtl5000 driver can not just set up
> its sysclk but having to do the above.

If it's got the clock itself it can do.  The main reason we have a
custom clock API in ASoC is that there's no generic clock API we can
rely on being available but since the driver has been modified to rely
on having a clock directly we may as well use it.

We do still want the ability to set the rate in order to allow machine
drivers to reprogram if they want to (so they can switch between 8kHz
and 44.1kHz based rates for example) but it's OK for the driver to
figure this out automatically if it has the clock provided.

--0ZpWocbG2H/Vq+uQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtuLNAAoJELSic+t+oim9t3MP/2jDAirfD5elcjhVA4dgt4PO
5VTGZlYC6qX4L+YCyrW9275CR/d902FOcIS8wzBk7uy4VGm7E3WJzVVdukr2vucW
1SWFrNpJ+OVAG0OQuHK9vP/rvzPe38J4pzMGfVRLkYq3NS8QhaLGdGfGprUrKM/8
IU0iI5U/KfKWj4cv66wdNs/1jHd1mEUvNQoB9+GG86X0dmWtIvQR9u9OekwP36mc
/TQgs4ufcsc/GYL1NoB5QjhUEqCxs+r3bodWk8WVI37iX2qcA7PfI65WIvGWJLsD
bhiUsD9Etb5AuirSnGISnlIId6jE3JdB0GBwCC+Ieyrodnz2HpjyMihkfICt4iD9
C5ke06PYTqSySzhBLKI1EkgyxklRm9X+p0BeivPvxYIE9tJPllehxUCFBtWcYaTJ
Kxw48YhFzad9XB+DFuZZLJpD+a4REgYMhV1gm1pnoEOqyzZCMdatH7uurduGl48M
z0AQhlKQu3sNkfNKtxDnPX8vKJ94gfOZVo2HvSq4KpnnjvoHlkSe/p7OHUfrulUb
pf0zKyXd/MyL0HUxVsb/RcVPGcNLKbYrevYQV1jZZOHWS/44gIvO16ZcBMCxF3n2
olvMXdPNI1hSTw7Gqo7+I6rV4nHKdDurzN8ArJTeduavmLqvYwMg1r48bipaznU/
8kClXPYTieXHY20f6d5T
=bKsU
-----END PGP SIGNATURE-----

--0ZpWocbG2H/Vq+uQ--

--===============5090358681048226952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5090358681048226952==--
