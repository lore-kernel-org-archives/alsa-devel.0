From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Subject: Since kernel-2.6.32 alsactl thinks my sound card is
	"Unknown"
Date: Wed, 01 Sep 2010 18:15:23 +0200
Message-ID: <1283357723.8159.4.camel@localhost.localdomain>
Reply-To: pacho@condmat1.ciencias.uniovi.es
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1390292778461111623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp02.jazztel.es (smtp02.jazztel.es [62.14.3.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F2AD24387
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 18:15:32 +0200 (CEST)
Received: from [87.222.151.169] (helo=[192.168.1.201])
	by smtp02.jazztel.es with esmtpa (Exim 4.69)
	(envelope-from <pacho@condmat1.ciencias.uniovi.es>)
	id 1OqpyD-0007iQ-1L
	for alsa-devel@alsa-project.org; Wed, 01 Sep 2010 18:15:29 +0200
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


--===============1390292778461111623==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-L7isDXQAshTc4tyzeZrx"


--=-L7isDXQAshTc4tyzeZrx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is an old problem I am suffering since kernel-2.6.32 and that is
still unresolved even with 2.6.35 and alsa-utils-1.0.23:
http://www.spinics.net/lists/alsa-devel/msg31422.html

If you follow the thread, it got stalled in:
http://www.spinics.net/lists/alsa-devel/msg31433.html

In summary, I get the following:
# alsactl -f /etc/asound.state restore /dev/snd/controlC0=20
Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
"0x1415"
Hardware is initialized using a guess method
# echo $?
99

As you can see, the exit code was solved, but I don't know why my
hardware is still shown as "Unknown" even if=20
via82xx.c clearly has some lines for my device:
        SND_PCI_QUIRK(0x147b, 0x1415, "ABIT AV8", VIA_DXS_NO_VRA),


Thanks a lot for your help

--=-L7isDXQAshTc4tyzeZrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkx+fBsACgkQCaWpQKGI+9QqiQCfbXf5NE0BfLmnyns52AKfBc2S
MkcAnR/8ekxrEGPUz+h6cVNxM1TW3mIj
=UmyV
-----END PGP SIGNATURE-----

--=-L7isDXQAshTc4tyzeZrx--


--===============1390292778461111623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1390292778461111623==--
