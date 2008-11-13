From: flameeyes@gmail.com (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: Git branches with Gentoo fixes
Date: Thu, 13 Nov 2008 13:24:39 +0100
Message-ID: <m2iqqr4xvc.fsf@gmail.com>
References: <m263ms5vno.fsf@gmail.com> <m2wsf84ggp.fsf@gmail.com>
	<s5hmyg4qad6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1344715004491076637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0061F24527
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 13:24:52 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L0bFh-0003q2-Ey
	for alsa-devel@alsa-project.org; Thu, 13 Nov 2008 12:24:49 +0000
Received: from ppp-13-236.21-151.libero.it ([151.21.236.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 12:24:49 +0000
Received: from flameeyes by ppp-13-236.21-151.libero.it with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 12:24:49 +0000
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

--===============1344715004491076637==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai <tiwai@suse.de> writes:

> Use rather AC_ENABLE() instead of AC_WITH().
> It's more intuitive.

Okay, I actually had ENABLE in the original patch I made about two years
ago, but switched to WITH since speex was using that.

> BTW, we'd like also a sign-off in each commit by the committer for
> non-kernel repos (although not strictly needed).
> Don't forget to add --sign option at each time.

Done now, I've rewritten history for the repositories and now they all
should be fine.

I also further fixed the hdspmixer issue in the proper way, I was tired
for sure for not noticing the hack I've been using.

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkcHIcACgkQe2h1+2mHVWP0kgCcCzUWrlWpOc+Ip2WYLKsQ8FAO
lAYAoLp8oRcILVFkZvmNWJUdh8vBWnXw
=8mxS
-----END PGP SIGNATURE-----
--=-=-=--


--===============1344715004491076637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1344715004491076637==--
