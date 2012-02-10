From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Regression 3.0 -> 3.1: no HDMI sound after suspend
Date: Fri, 10 Feb 2012 19:32:56 +0100
Message-ID: <20120210183256.GA28268@darkside.kls.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2167345422645697649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from piggy.rz.tu-ilmenau.de (piggy.rz.tu-ilmenau.de [141.24.4.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D17510408C
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 19:33:05 +0100 (CET)
Received: from p57B14588.dip.t-dialin.net (vpn2.rz.tu-ilmenau.de
	[141.24.172.2])
	by piggy.rz.tu-ilmenau.de (8.13.7/8.13.7/Debian-2) with ESMTP id
	q1AIX0xv008009
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 19:33:01 +0100
Received: from darkside.kls.lan (root@darkside.kls.lan
	[IPv6:2001:6f8:90c:12:21e:8cff:fecf:cfad])
	by p57B14588.dip.t-dialin.net (8.14.3/8.14.3) with ESMTP id
	q1AIX0n4019633
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 19:33:01 +0100
Received: from darkside.kls.lan (holbe@localhost [IPv6:::1])
	by darkside.kls.lan (8.14.4/8.14.4) with ESMTP id q1AIWvqQ028274
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 19:32:58 +0100
Received: (from holbe@localhost)
	by darkside.kls.lan (8.14.4/8.14.4) id q1AIWuop028272
	for alsa-devel@alsa-project.org; Fri, 10 Feb 2012 19:32:56 +0100
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


--===============2167345422645697649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

since kernel 3.1 playing sound through HDMI via pulseaudio stopped
working after suspend/resume on my Intel HDA (there is simply silence
after resume). Same for 3.2. This worked up to 3.0 and it still works
when I configure pulseaudio to play through Analog Stereo instead of
HDMI, hence I guess the issue is more connected to ALSA than to
pulseaudio.

A work-around is to induce pulseaudio to re-open the underlying audio
devices (`pasuspender true' does the trick).

Here is the alsa-info.sh output for kernels 3.0 and 3.1 (no significant
changes afaics):
http://www.alsa-project.org/db/?f=3D67e9358c83963773f69905b12d7dba06c4c010ed
http://www.alsa-project.org/db/?f=3D219dd70eee2160669f86c77c0585244b2decb5ef

Please let me know if I can provide further information.


Thanks for your work & best regards
   Mario
--=20
We know that communication is a problem, but the company is not going to
discuss it with the employees.
                       -- Switching supervisor, AT&T Long Lines Division

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEVAwUBTzVi2BS+e2HeSPbpAQK0CQf/bScwaOp9kGPKb+3O1K8b5FACBUGh7mxS
/SpeNIUB/M6BHe/ipc8ZzgxBzIy80vF80P8CsirIIavdqNtuogXxKhJfu107LrFs
u1xkuSJIf8WFop9w1ExJj63VTzOm0Im3ax3UW7MiNJccztB7hGQZiOF3E4R6iErg
Y17BMtHLxleqyOktqyy9U1zs20RpBPqqBvWG1M6KoJUPxabupxiPiIHyVhCIuFoa
HiyK6s/QLl+qkT4YmHAhTi41aLU0/69Tb5Ger9CJDeJAV3bnr0yB7a33Dp0Qz8uz
c7x9oiVgkUTZviWH/JqyVFradSjKq5cA45/7O7IHFFHB46c33B2Fcg==
=W2tJ
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============2167345422645697649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2167345422645697649==--
