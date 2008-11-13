From: flameeyes@gmail.com (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: Git branches with Gentoo fixes
Date: Thu, 13 Nov 2008 14:21:12 +0100
Message-ID: <m2abc34v93.fsf@gmail.com>
References: <m263ms5vno.fsf@gmail.com> <m2wsf84ggp.fsf@gmail.com>
	<s5hmyg4qad6.wl%tiwai@suse.de> <m2iqqr4xvc.fsf@gmail.com>
	<s5htzabhioi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5928012696256744146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A58F24553
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 14:21:29 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L0c8Q-0005xO-FF
	for alsa-devel@alsa-project.org; Thu, 13 Nov 2008 13:21:22 +0000
Received: from ppp-13-236.21-151.libero.it ([151.21.236.13])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 13:21:22 +0000
Received: from flameeyes by ppp-13-236.21-151.libero.it with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 13:21:22 +0000
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

--===============5928012696256744146==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai <tiwai@suse.de> writes:

> Thanks for fixing.  If finished, please post again with summaries.

git://git.flameeyes.eu/others/alsa/alsa-utils.git master

=2D Fix building speaker-test when NLS is enabled, locale.h was not being
  included;
=2D Fix alsaconf use of dialog by redirecting to a new descriptor, or
  "snd-***" was tried for loading in case of errors;
=2D Replace modules-update with update-modules in alsaconf, since Gentoo
  also use the same command name as Debian.

git://git.flameeyes.eu/others/alsa/alsa-tools.git master

=2D Fix building with --as-needed ld option, by not passing library names
  on LDFLAGS variables;

git://git.flameeyes.eu/others/alsa/alsa-plugins.git master

=2D Add --disable options for jack, pulseaudio, libsamplerate and
  libavcodec based plugins, so that they can be disabled even if the
  software is found in the system;

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkcKcgACgkQe2h1+2mHVWOrngCfS15qEf0Xjn+UHSa4KdbHzm+h
lQYAn0f3wZwcntuSIk5Rg+m1ZpnzxN/m
=Zav5
-----END PGP SIGNATURE-----
--=-=-=--


--===============5928012696256744146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5928012696256744146==--
