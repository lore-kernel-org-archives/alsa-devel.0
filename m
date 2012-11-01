From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Fix channel swap for
	24-bit format
Date: Thu, 1 Nov 2012 12:11:33 +0000
Message-ID: <20121101121133.GB4413@opensource.wolfsonmicro.com>
References: <1351638429-13865-1-git-send-email-festevam@gmail.com>
 <CAP1dx+ydbcYfFrdG0sa2Ro2kfJbCS99nm4J_uFWT4JUo7NkcdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4199383609999351052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0217261793
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 13:11:35 +0100 (CET)
In-Reply-To: <CAP1dx+ydbcYfFrdG0sa2Ro2kfJbCS99nm4J_uFWT4JUo7NkcdQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, DWinner@tc-helicon.com, alsa-devel@alsa-project.org, shawn.guo@linaro.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4199383609999351052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 04:50:50PM +0800, Dong Aisheng wrote:
> On 31 October 2012 07:07, Fabio Estevam <festevam@gmail.com> wrote:

> > +                        * write data to saif data register to trigger
> > +                        * the transfer.
> > +                        * For 24-bit format the 32-bit FIFO register stores
> > +                        * only one channel, so we need to write twice.
> >                          */
> >                         __raw_writel(0, saif->base + SAIF_DATA);
> > +                       __raw_writel(0, saif->base + SAIF_DATA);

> This probably could a workaround for the customer, but i'm not sure
> Mark could accept it
> since the code is a bit confusing. (Mark, what's your suggestion on this?)

I'm not really concerned about the code, the comment is fairly clear
except that it'd be good to mention that this is safe for data sizes
other than 24 bit.  It's certainly really much more confusing than the
existing code and if it works better that's obviously good!

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkmbuAAoJELSic+t+oim9JUsP/jKQSQ+zPQrHJyB3ecQsbSBc
6oIVqS2XQ35PliGDYYWoA6sflOLSp2Ocsq47NhXBdVNu4I08GsXRfCV8t6mOgXAs
4Q7i/VUxtSHxkh9DbCtZuoYXBH1QJfC++a196gHA2ALZOsC0soxWi5pA2x9KBu9y
/iFIyH8Dznz/BqhdPRMpJgHg7JFfiiCaq7sei8nldQwX+3g3xAxBtywWXxSEQwOp
U9+RIaaiiOylS2iBwulAE0XZ3guLuAtN3rwo3YTTRG3bpdn5aXnELmKRrJkfK+oe
hSjCE0KA0J3uQ9/yAqIwvYVqq66ZNvOMN8h3rhrOnUZSSIjkryLsIvk8TYGkeml/
vY8Eo5m1PHz/CyG5YeCDuVb4Mz7nj7EV94/V0b4prR/ofiKqZuUY/AJooWxK1xP/
tfZhZ4x0Gb3pIYR66QvcexJVcmXdi4XgbdBE3zPcEfyne1h7i0xtPBaFdlwnYp8s
/LsvfwF30GoTAHko5PSc+QRSXmFtD1depFh1EXe9xUUGbebhH8B4NTI5tQmzaQ7c
4TwNI5e8Rk1G3D8XMUiOIuMBwyfHd1fHW7zaizEOQV1IScTtHI/sr5fm+rKrbds1
nJ9uxEPJxxUWHLpZgJ4qeSzvlajveac6m11G46gNEJZU/JR1x7AJHB9+vtiegWMy
uk9CvxQ4jRFQIYsgNDyu
=5AbI
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--===============4199383609999351052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4199383609999351052==--
