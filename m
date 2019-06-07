From: Vinod Koul <vkoul@kernel.org>
Subject: [GIT PULL]: soundwire fixes for v5.2-rc4
Date: Fri, 7 Jun 2019 15:26:33 +0530
Message-ID: <20190607095633.GD9160@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2124165675361225435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B262F80709
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 11:59:44 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2124165675361225435==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

Please consider pull to receive fixes for soundwire for 5.2. We have 3
fixes done by Srini and all are in linux-next

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-5.2-rc4

for you to fetch changes up to 39194128701bf2af9bbc420ffe6e3cb5d2c16061:

  soundwire: intel: set dai min and max channels correctly (2019-06-06 22:4=
8:41 +0530)

----------------------------------------------------------------
soundwire fixes for v5.2-rc4

Srinivas Kandagatla fixed by bunch of issues, two in core for locking
and out of bound access and one in intel driver copy-paste

----------------------------------------------------------------
Srinivas Kandagatla (3):
      soundwire: stream: fix out of boundary access on port properties
      soundwire: stream: fix bad unlock balance
      soundwire: intel: set dai min and max channels correctly

 drivers/soundwire/intel.c  | 4 ++--
 drivers/soundwire/stream.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

Thanks
--=20
~Vinod

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc+jTRAAoJEHwUBw8lI4NHiP0P/0ioLKYuP0ZZHXsXXxztXkH4
LIlxpYk4GXX8F/VDaDlqdbDfZJvtrmc1uUIA77BquFxCLRMk5W7uEvFZBzlMVWbm
HMZcSNN+6Gz4VkvA8oIRs0iNB7ix2NNLKW5GinZ7ipXbqdwdAutcBarlfO/bGWQA
WryHbzRcUjYqkTmN2nFEM7tU8ynITbaMDJgl1++xv3MJ86gUor4AJD5C4qyvJSC3
YGLNJdGBh4F8ZP7rlBn+s7JFotz8kth6SirCCsxpQBPbYKBn0SxHV233H8thzqqP
rETBWzeELKdABzsxtJgM9wZXmXIoKeTyr6FjfiEn3TleUKUlEooMuXLO4lIKJGS8
iBHVSmpFyEI69CfkXprVezU6eEipr5d7F9mz1HgLxTtUQXZkw8C4gl+gqpfrT1j9
nbzt9C+pgAqYxLT+QyvkffjTumi6/Re4AReRUqAHfPgELrHS4R9pppVQCJi4olVM
R+JoQUEzMJd7fpPELfY1juybShTRneZLmWzPHv5bL4MxrMmx6jvXAK0k4yVpYyzk
209u36b/dJdsHFLCU91E3wldrOXazt/vPoKnKXEdXmLPYv92z8UY+SnDGPhqjGNf
0KPPdXQW2LZW69+RieBDvuCGkmTNU8+dgjwcCrMXh972cc6drp+jxhvPuzT0B4Y/
Fdb4J2UijDZLy5H4Alxm
=/nxH
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--===============2124165675361225435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2124165675361225435==--
