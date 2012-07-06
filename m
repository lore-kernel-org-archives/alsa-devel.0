From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dpcm: Allow FE to be opened without
 valid BE routes.
Date: Fri, 6 Jul 2012 19:07:05 +0100
Message-ID: <20120706180705.GE5437@opensource.wolfsonmicro.com>
References: <1341590820-21040-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8129283812878768711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B2B51045DA
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 20:07:08 +0200 (CEST)
In-Reply-To: <1341590820-21040-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8129283812878768711==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 05:07:00PM +0100, Liam Girdwood wrote:
> Some userspace will open a PCM device and then configure mixers
> for routing before triggering. This patch allows userspace to do
> this sequence.

Applied, thanks.

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9ykwAAoJEBus8iNuMP3d96MP/ApGKb2rWuuB69Sl/JOUpbUw
MhmLR6NbnHiSv2JqAJYh2tCZQCd4DHI+tGSu6AekBHjam2EkQ2nJzUDOvAFMX7ta
pxts60gozVYFYIYPgHkU/olYSQZe/Y7D7ap9B+8aedjCppkwXkcHILx8Q3dEJCMm
i5lAhnfU7BpkZxnW6ygr+zH2e5YVwah6M5hiYq6EnOUGOXim7RkZDEq/45AGbvna
EnpXGT2fypv0cFm6IcUmSZJlnrURCEti1b3tHV5Ev2QHDAkXzIjV5mVafev6lSzV
IFU1h8r9Ztnx17HNiCrlhsXny8MWB2irsrIKRPYj40lBHUjaV3qZL7mWjp0th+Gi
NbHuOJBWiXYrxDaJncVJTfV0DRN9TcV51iNl5AOyEDKE7NIsSGj8WFK9g/jDKRSa
6s2jJ7AGBAEodsBqVs2/8O8WsiW5oa2SuZqghCqRYjGZ4EgfELscaAvUJbC5MT3f
/N0IMHWpi0qAfj9D58TP8B5gJo7hlvDE2ReUo3KbNzfnQ0lI8GnOsQdIWqT+bqEv
SXRmfXEgG6ybFPZX5ZX1ZcYG32s5XwC8uX1VzhBAgthT1RUfpAca/Z3Nl5h19kH8
v79vF6E2l3Ftmh/o9oS9oHh+efR/Qh1eEDzzuh1qa5YkeTYuDjhULSYqvc9Syc4L
iQfYhi/GnWDaRzcbTbPf
=7vMa
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--

--===============8129283812878768711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8129283812878768711==--
