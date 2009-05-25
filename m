From: Werner Van Belle <werner@yellowcouch.org>
Subject: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 17:30:19 +0200
Message-ID: <4A1AB98B.9010604@yellowcouch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8298115638994947839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id BFC1E2435E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:28:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8298115638994947839==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2F848627FA3C12DA5936338"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2F848627FA3C12DA5936338
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

This is the third time I tried to get information on the same topic but
there has been no response. Since it is crucial for me to get this to
work, I really would appreciate your input. If necssary I can provide
further documentation. The problem is as follows: if a process which
opened a DSP device forks of a new process, then this child will have
the same handle towards the DSP. What I now want to do is to release the
handle in the child without closing the device for the parent as well.
So essentially the sequence below illustrates the problem if one is
unable to 'unlink' a dsp device.

a- parent process creates and open dsp device
b- parent process forks of a child 1. Child 1 has access to the same dsp
device
c- parent process closes the DSP device
d- client process can no longer write to the DSP device (these are
already odd semantics, but okay, can live with it)
e- parent process forks of a second child. Child 2 has no dsp device
f- Child 2 tries to open the DSP device. This fails because the device,
although closed, is not released yet by Child 1.

Is this normal behavior ?
Is there some rigid documentation on the closing and sharing semantics
of pcm devices ?
Is there a way to unlink a device without closing it ?

If this is the wrong mailinglist, then who should I contact regarding
these erratic semantics ?

Wkr,

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/



--------------enigE2F848627FA3C12DA5936338
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoauYwACgkQYJM5sO5rAR36EQCg19CEGQ24Jz8J1Epaknapr557
K50An3W8oDsutd1fuMRKS4BX1jB2gbmk
=oOK2
-----END PGP SIGNATURE-----

--------------enigE2F848627FA3C12DA5936338--

--===============8298115638994947839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8298115638994947839==--
