From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Export functions for
 threshold configuration
Date: Mon, 12 Mar 2012 11:59:54 +0000
Message-ID: <20120312115954.GF3110@opensource.wolfsonmicro.com>
References: <1331550064-28349-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1873756546923215220=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D521A103F95
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 12:59:59 +0100 (CET)
In-Reply-To: <1331550064-28349-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1873756546923215220==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2012 at 01:01:04PM +0200, Peter Ujfalusi wrote:
> ABE has certain requirements towards the FIFO configuration in McBSP.
> Make it posssible to configure the McBSP FIFO threshold from outside of
> the McBSP driver stack.

You should always submit things like this along with the changes which
use them, it's much easier to see if they're sensible when the users are
there.  Without seeing how this is used it's hard to tell if this is
sensible or if it should be abstracted in some way and we don't want to
have half of the bodges sitting around if we end up doing things a
different way.

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXeUqAAoJEBus8iNuMP3drFoP/i9UekBOO11gVzgyJNcsji32
mVknOw1XvTSs0FKRP9iHrUU8XtOMmXT0emR+/z3msYvqhS0UdFj0tXd3TzoLohf9
h1pAXB8TYhJWrtFkk6g+i60Y5K6c353VfTA1vTYtIpoNIwcqu7GiKnN3xEoVC6fA
kJarVSs5OdfIrZh0N2QLwpi5oiZi8s4ZBHyfF6ehF3YiUOVDC6VThlbvHIaBMaQx
oVU0rjgDMHAfs5eJ4D+T5jMDMIntvsR+JYqA6DdyNXYEhQoqH1O6cQJDwRTl++nS
rdClGSDUNXo20z6zPISZMLxX22fAvDiM0CMdbIhdKosqPkog6/9sSzPdbhDYqTHi
nAhbzZAkVDYx7pWUUnhWHPfVsTM1Wy7fI2Y1VNv3GzdpPDSKS6jnqJuf9qkgGZM5
ert41xojg8psa1n9RK65tkBY3RADu5YdV9kB2ta2D/4/hybBsWrOr0n4h/5Zez4f
QjXqUgkStsaJWnjV6iXnz/C/XWSWyuShRNsZ+Rl9V/CeBa3eHXKhCJwgWiSt8ZWR
bkjJqofLa/d6hN/NmIvxgLr5agjzJe4aI2uky6KUzEiA3Q8MMVFV/xMr+VENLGmx
mcah6BDtrOrcYjaN7Jy+ZftAXk+cmBLAIU/Z6r0USmrilI3fand/y0Db7kb34FbM
yUlATksIqExGnyfX09nZ
=XuUl
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--

--===============1873756546923215220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1873756546923215220==--
