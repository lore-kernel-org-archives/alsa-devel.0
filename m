From: Jo Shields <directhex@apebox.org>
Subject: ALC889A (Gigabyte EX58-UD5) pin support
Date: Fri, 06 Mar 2009 01:19:28 +0000
Message-ID: <1236302368.7568.21.camel@desire>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8415865258150101993=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from woodbine.london.02.net (woodbine.london.02.net [87.194.255.145])
	by alsa0.perex.cz (Postfix) with ESMTP id D8E261038CC
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 02:19:29 +0100 (CET)
Received: from [192.168.1.71] (78.105.105.80) by woodbine.london.02.net
	(8.5.016.1) id 4979BCBF00CDF4A2 for alsa-devel@alsa-project.org;
	Fri, 6 Mar 2009 01:19:29 +0000
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


--===============8415865258150101993==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-xV6t8JJz0YF7y2Hdo06X"


--=-xV6t8JJz0YF7y2Hdo06X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've got a pretty new Gigabyte board, using snd-hda-intel and an ALC889A
chip. Whilst the chip seems to be detected fine, I have no functional
audio out - no sound on any of the ports.

dmesg shows that ALSA has no idea about the specific model:
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...

If I'm reading the source correctly, the default pin layout is
3stack-digout. I tried 6stack-digout, but it didn't help.

Linked is output from the diagnostic script:
http://www.alsa-project.org/db/?f=3D3938bc16481f549203e373e303c4b1c1dfb303d=
d

I'm happy enough to try things out in an effort to get the onboard sound
to behave

--=-xV6t8JJz0YF7y2Hdo06X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmweiAACgkQWQvNUd/Cr8HAbgCgsvVDK4FKKoVj6M1/gFiLmPdQ
tM0An23jkIwHd61SQ/6dXF3J4NHaJWCK
=FNHZ
-----END PGP SIGNATURE-----

--=-xV6t8JJz0YF7y2Hdo06X--


--===============8415865258150101993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8415865258150101993==--
