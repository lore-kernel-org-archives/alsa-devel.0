From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: 1.0.16 snd-aoa driver
Date: Mon, 11 Feb 2008 00:27:28 +0100
Message-ID: <20080210232728.GA10710@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6020088137603999333=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CC8610387A
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 00:27:35 +0100 (CET)
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 0DCA42000066
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 00:27:35 +0100 (CET)
Received: from mail.home.lxtec.de (p5B146B9B.dip.t-dialin.net [91.20.107.155])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id BC1CB180F19A1
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 00:27:34 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.69 1 (LXTEC))
	id 1JOLa9-00050w-UN
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 00:27:33 +0100
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0c0oVBPCIW8z for <alsa-devel@alsa-project.org>;
	Mon, 11 Feb 2008 00:27:31 +0100 (CET)
Received: from aragorn.home.lxtec.de ([192.168.200.203] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.69 1 (LXTEC))
	id 1JOLa7-00050l-D0
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 00:27:31 +0100
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


--===============6020088137603999333==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

have build 1.0.16 drivers. Running aplay musi.mp3 gives:

ALSA lib pcm_direct.c:866:(snd1_pcm_direct_initialize_slave) snd_pcm_hw_par=
ams_any failed
ALSA lib pcm_dmix.c:1008:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:564: audio open error: Invalid argument

$ lsmod | grep snd
snd_aoa_codec_tas      13088  2=20
snd_aoa_fabric_layout    12296  3=20
snd_aoa                17408  2 snd_aoa_codec_tas,snd_aoa_fabric_layout
snd_aoa_i2sbus         21476  1=20
snd_pcm_oss            48000  0=20
snd_mixer_oss          19040  1 snd_pcm_oss
snd_pcm                83428  2 snd_aoa_i2sbus,snd_pcm_oss
snd_timer              23108  1 snd_pcm
snd_page_alloc          9320  1 snd_pcm
snd                    62804  14 snd_aoa_codec_tas,snd_aoa_fabric_layout,sn=
d_aoa,snd_aoa_i2sbus,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               6916  1 snd
snd_aoa_soundbus        5828  2 snd_aoa_fabric_layout,snd_aoa_i2sbus

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.16.
Compiled on Feb 10 2008 for kernel 2.6.24.1-aragorn.

Any hints?

Thanks
Elimar
--=20
  >what IMHO then?
  IMHO - Inhalation of a Multi-leafed Herbal Opiate ;)
              --posting from alex in debian-user--

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHr4hg3Ig8bsVPf7ARAha3AJ9F+ut+790AwFKQVwYjsupWODsWKwCgrDlO
KWkfHFO1zOZ+pR4WmquvzZk=
=qgmb
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============6020088137603999333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6020088137603999333==--
