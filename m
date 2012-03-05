From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Mon, 5 Mar 2012 14:35:04 +0000
Message-ID: <20120305143504.GP3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<20120305142009.GO3224@opensource.wolfsonmicro.com>
	<20120305144400.GH16232@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0727981778874776687=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF5941042D6
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:35:06 +0100 (CET)
In-Reply-To: <20120305144400.GH16232@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============0727981778874776687==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1MCZUn4MZNv/LeVo"
Content-Disposition: inline


--1MCZUn4MZNv/LeVo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 10:44:03PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2012 at 02:20:10PM +0000, Mark Brown wrote:

> > I see you've ignored my comments about reordering the patches so they
> > can be applied more easily :(

> Sorry, if it makes your life hard.  But I hope I can win ack from Sascha
> and Timur soon, so that the series can be applied as a whole anyway.

If you resend again please do pull out those two commits, in general
smaller serieses doing one thing are much better.

--1MCZUn4MZNv/LeVo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVM8RAAoJEBus8iNuMP3dzYEP/04hw6hLTQ2TX4xb7j6RqkGl
daqxEzC9gHbdMmMZkHqWCpoDQUg95VlYtLDTQgPuSnwQjTrEkdFiz1M0zVYsVNql
t8KffsmcgIxr14pg0at05YbSdzpNDe8f0QTh5mV3sK9iSa0IdsYKfADX9swLqG1r
f0nX6gUT7E9MHJRA5b640xO12RBreq4w5fDrWM/28a8BP1r1uhhmT2D4amr1f/uR
jv2VHfdr+DnaA06xb9LgSzjXyqt0ltXzWx5/mnf5uDTDIS1+JRtHnRdIOjwhtqON
eWv4FXJRlnGKUcfARpU48oDPA0gcHBeAt9iuS6zWc6M9gBzVZCLghr9EcoqKcCq4
7LJ60ddOnfWI0WEXfPhAwdCStPBpGGzVRM4H+LmTPfimJVayirGIbHt2ROpGEKvo
y5H19gn0KooArXvoJtq6BQIOlhLUeAyhjPOJnEPm3WvaC8MO6mCJrE1eXoesHM1k
Eos+z0Z3WdvihiVDejMoeGCHBCgLKMxN3RmTtJgpcB+2XJEgogheaQZ2EM+LQJ29
6AYbygz6m0pzB4yFKJPqSdDxsrHOEvp20QbdmF+j9/xpBrfGhs384Awj4NBWNnyQ
rCW36J/cc/l2al3Dk8xmXGSOMsjMjmEzv25BU/ne3+XFeww7GFW7RMgeutUHb0Mh
F+d0Bpn6tWMthgAOrSDD
=9c1b
-----END PGP SIGNATURE-----

--1MCZUn4MZNv/LeVo--

--===============0727981778874776687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0727981778874776687==--
