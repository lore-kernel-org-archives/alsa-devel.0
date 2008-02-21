From: Mike Frysinger <vapier@gentoo.org>
Subject: handling of dmix and non-dmix in the same
	configuration file
Date: Thu, 21 Feb 2008 18:04:39 -0500
Message-ID: <200802211804.39684.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0345676437294845911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 6965D103896
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 00:04:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 90E3CB4009
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 23:04:41 +0000 (UTC)
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

--===============0345676437294845911==
Content-Type: multipart/signed;
  boundary="nextPart1637717.UH2KcpYuBC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1637717.UH2KcpYuBC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

on the Blackfin processor, we have an "almost-but-not-quite" AC97 interface=
=20
(called a "SPORT").  the trouble is that we can hook up AC97 codecs, but in=
=20
order to properly communicate with codecs, we need to repacketize the=20
communication between the higher alsa layers and the actual SPORT.  great .=
=2E.=20
but now we want to support dmix/dsnoop.  the overhead for dmix vs non-dmix =
is=20
such that we make it optional.  if the user does not need software mixing,=
=20
they can disable this overhead.  this leads to two (incompatible) alsa conf=
ig=20
files (in this case, for the AD1980 codec).  we're wondering if it's possib=
le=20
to have the right settings selected on the fly some how during runtime rath=
er=20
than having to select one file or the other.

the dmix config:
AD1980.pcm.default {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type asym
	playback.pcm {
		type plug
		slave.pcm {
			@func concat
			strings [ "dmix:CARD=3D" $CARD ]
		}
	}
	capture.pcm {
		type plug
		slave.pcm {
			@func concat
			strings [ "dsnoop:CARD=3D" $CARD ]
		}
	}
}

the non-dmix config:
AD1980.pcm.default {
	type plug
	slave {
		pcm {
			type mmap_emul
			slave {
				pcm {
					type hw
					card 0
					format S16_LE
					rate 48000
					channels 2
					sync_ptr_ioctl 1
				}
			}
		}
	}
}
=2Dmike

--nextPart1637717.UH2KcpYuBC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR74Dh0FjO5/oN/WBAQKgBw//c0JdMazGQuCDFuGAz8kp8wP6OqRNSy0x
G2XhdT34VkEE/fJfnVSF51EUzCmetDw5WaGSIN5f2F8QOHNQb+74sABaA5F4T02n
7CZCogD5QmPoweCw9HjOtz7ODFSlVupGEfGzsWItL4SBmjr63diunRhpEl9k0R9a
w1HFioOcjBzcXOQOenFOkkiMvDXHJp6dgLWQMfDzobddBGBlhiciQNsCZLuT0aRJ
vGuH0fPiyqGBOZYm7EVhw2p0leN+vVGp6eB+2iVoz2CqK+mHgwOBOLLl+hmIaubO
iOxSsL62JoB5OjBwtHCUYyfH6S5QQ0QjWhif4Iw2rmUew2rqYzGeLZGhskucGYmx
wKUxKafXlJhCYAEbkVjUxsz9k2kaXoEQdIvnPU73iuf+wdEomQu3uiHe8qUxLWpz
uD+RLEbLeohyhBFlQsSiaAiy1LWq1l9ACt8QPYz7OzRsmkx/uFf/2T10yxmIaD7q
+mDWIIe+vry4Y9JMBowtj6pjMCFgotogwQSC0Ax3oD1Pfnnl2o60wvbw2BPGJk5q
qPSrGRcE5aaI1LNQ0ZJBRkiiV8zn9ynghTNg0wTHGuBQYnQquF3NDJnKuaT/KDQT
+uu4gZvR99t3R/c7wYxcaCpglYRijU7cvCjuQFnJ44mvmTCaljjGyhwjtppkwLMs
NKc+H4teX7I=
=/TrJ
-----END PGP SIGNATURE-----

--nextPart1637717.UH2KcpYuBC--

--===============0345676437294845911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0345676437294845911==--
