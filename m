From: Reilly Grant <reillyeon@qotw.net>
Subject: [PATCH] plug: Move fast_ops copy after slave
	configuration.
Date: Mon, 05 Dec 2011 18:05:42 -0800
Message-ID: <4EDD7876.6060101@qotw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4794038024708057772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jane.qotw.net (jane.qotw.net [72.14.183.39])
	by alsa0.perex.cz (Postfix) with ESMTP id B5D93103A81
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 03:05:53 +0100 (CET)
Received: from [192.168.16.78] (unknown [64.125.181.70])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: reillyeon)
	by jane.qotw.net (Postfix) with ESMTPSA id 7AFA353A75
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 21:05:51 -0500 (EST)
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4794038024708057772==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig6584C98D3E90B7B6107961F2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6584C98D3E90B7B6107961F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The plug plugin copies the fast_ops structure and fast_op_arg from its
slave PCM on initialization and after inserting a new plugin. This works
unless the slave PCM is also an instance of the plug plugin because plug
can change its fast_ops structure during _snd_pcm_hw_params.

Instead of copying fast_ops in snd_pcm_plug_insert_plugins wait until
the end of snd_pcm_plug_hw_params when the slave has been fully
initialized.

This fixes a crash when two instances of plug are instantiated back to
back and the format conversion plugin inserted by the second is skipped
by the first because the fast_ops pointer is not properly updated.
---
 src/pcm/pcm_plug.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index e9d2923..72456d5 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -659,8 +659,6 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm=
,
 		}
 		if (err) {
 			plug->gen.slave =3D new;
-			pcm->fast_ops =3D new->fast_ops;
-			pcm->fast_op_arg =3D new->fast_op_arg;
 		}
 		k++;
 	}
@@ -1049,6 +1047,9 @@ static int snd_pcm_plug_hw_params(snd_pcm_t *pcm,
snd_pcm_hw_params_t *params)
 	}
 	snd_pcm_unlink_hw_ptr(pcm, plug->req_slave);
 	snd_pcm_unlink_appl_ptr(pcm, plug->req_slave);
+
+	pcm->fast_ops =3D slave->fast_ops;
+	pcm->fast_op_arg =3D slave->fast_op_arg;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	return 0;
--=20
1.7.3.4



--------------enig6584C98D3E90B7B6107961F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJO3Xh8AAoJEOXiGGAVSFKDLV8QAKj6QfxOZxtONj6rDAmfe53+
ZGuVezctpqyqwqXFdwsnUQIWa0hdOFE8RrquOXwtZd1K9szBPQOKcoL9+ZP3Vqk1
TTgzGxpeUdrPoH3It6wMMjYtmeeGsHj8A9OAF0X8ClNh6kB8ilyAAjU82mpcGfGK
h87OERaYDsCPeK7SwMKSFpBCoIkfxBlO2GW04n+gHrujH93zeqXLSlfN7mWXYvP3
n6U7InwVTavyUEk/fQvgHkaj5CF9ttE08x7d2Z6+WbvkwaO7gNXsh2Zp0TQcrJkX
1VHJChdA1+3uGCD8WPwiITiGXpa5S6sVAeSPU9ym2qGoWC859DIfPkjR4TggCuu2
aMjoRsXLHFzojWXi7pZjTC8fYrrPYoIYrgss1RvAhqLRcfhSNTbr1PXhLNRGJSq8
xMsHm0pNCqwqiga/q5AWD4J5xFA5H6DV9viHFwncXzEBj/oMHEv5r11F+wpsyp4T
jlB5tlJcMFfA/E3WfCiiuGulswRAW2pBJuAKQaqURO7rzHM4s0cX12wF9cZl3osV
LNu/MsRjKbjBmCcJE1v3s7DzvgJiauXI6nfzb4AnVFkhEZDsSzGxXB50NxqPx8GM
92B4Yl3JgzLKq5CVE8JEh7p1pSshtb67ah62i11c8J3qT3QFpU0oyTFJtZl+U6li
gabCzfwdaq9lbKynJvrp
=mDuP
-----END PGP SIGNATURE-----

--------------enig6584C98D3E90B7B6107961F2--

--===============4794038024708057772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4794038024708057772==--
