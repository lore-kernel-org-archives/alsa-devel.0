From: Tim Blechmann <tim@klingt.org>
Subject: Re: hard freezes with hdsp with cardbus/pci adapter
	card
Date: Tue, 11 Aug 2009 17:19:32 +0200
Message-ID: <4A818C04.10005@klingt.org>
References: <h5q3ur$13e$1@ger.gmane.org>	<20090811050619.GA12438@pengutronix.de>	<4A811076.6000603@klingt.org>	<4A811D1B.2020709@klingt.org>	<20090811092526.GA3163@pengutronix.de>
	<4A813E38.5030007@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3328588768417158435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 845EF24C87
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 17:19:43 +0200 (CEST)
In-Reply-To: <4A813E38.5030007@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3328588768417158435==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA4B8C10BC672270D7456D2DC"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4B8C10BC672270D7456D2DC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>>> hm, actually, i think the issue is related to the pci latency of the
>>> cardbus controller.
>>
>> Looks like it:
>>
>> http://lkml.indiana.edu/hypermail/linux/kernel/0404.1/0602.html
>>
>> Do you know if the increased latency is needed for all bridges, not ju=
st ENE?
>> (I'd assume so...)
>=20
> i remember that issue, it had different symptoms (distorted sound) ...
> the ene bridge seems to be the only cardbus bridge, that requires the
> increased latency, but maybe other controllers are just more robust and=

> don't completely freeze the system

hm, i guess, it is not that easy ... having the hdsp running at 44.1khz,
the machine ran for several hours, but when i switch the sampling rate
to 96khz, the machine freezes quickly.

also playing with the pci latency settings of cardbus bridge and hdsp
didn't change this. from my understanding the only difference between
44.1khz and 96khz in terms of the higher bandwidth ...

tim

--=20
tim@klingt.org
http://tim.klingt.org

Your mind will answer most questions if you learn to relax and wait
for the answer.
  William S. Burroughs


--------------enigA4B8C10BC672270D7456D2DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqBjAYACgkQdL+4qsZfVstyXQCfa+L/Q9VIr64A2Dn4jDjlTiq9
5y4An1ppYi21rCVjJZZ3zEjQVvTF35wJ
=TioF
-----END PGP SIGNATURE-----

--------------enigA4B8C10BC672270D7456D2DC--

--===============3328588768417158435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3328588768417158435==--
