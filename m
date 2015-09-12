From: Andreas Hartmann <mail@andreashartmann.eu>
Subject: Bug: LADSPA implementation - no up/downmix handling
Date: Sat, 12 Sep 2015 22:10:40 +0200
Message-ID: <2541800.vBPmoIL6Xo@deep-thought>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3156358036627519353=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from stcim.de (stcim.de [78.46.73.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B202605C7
 for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2015 22:10:45 +0200 (CEST)
Received: from ip9234f783.dynamic.kabel-deutschland.de ([146.52.247.131]
 helo=deep-thought.localnet)
 by stcim.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.84) (envelope-from <mail@andreashartmann.eu>)
 id 1Zar8F-0005BT-LO
 for alsa-devel@alsa-project.org; Sat, 12 Sep 2015 22:10:43 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3156358036627519353==
Content-Type: multipart/signed; boundary="nextPart5324272.G1J0i3PnF0"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart5324272.G1J0i3PnF0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Using the surround_encoder of the swh-plugins I noticed, that the alsa 
implementation only assumes an equal number of in- and output channels for 
ladspa plugins. This occurs from Line 752 onwards in pcm_ladspa.c and leads to 
a Segfault shortly after.
There needs to be a check and correct handling for up/downmix scenarios.

Andreas
--nextPart5324272.G1J0i3PnF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJV9IbDAAoJEFdgwA+zsF1UQSQQAJaqi2Ih6khOWX8WB+QJFxpA
A3VkgWWTdJ2GZLV5VrWhmwE1Lhu5acNiaV6d924/IqmdIKrXjt3/chbhiaA1mirU
LdeRGrzlP9ZWOVkMKTAl5c/LYjNVN7/deFQ47IIxLsV+o3Oy/A0tq1PJe81HHFF+
tJYzZTPbNTD1y1LDVF6oBTOWWjsO6681EDp+fUbAz9PDQdVOhRA9E07uKBrm+tgp
L/ESlECJUZ4Q5ZquoPa9U/c0wqiQZ6hg+e/eC70S5SpTBMd0rCBwf6v2dDCq+Shm
HCL0pf+tccWFjTgBvLr+hYVivte70N8DBMRhs96i+BRpnmqMZLpqLmpwqdtvUZmZ
XhXSEEly+3OHFPz+nI4icD4VO4OkUiXTve9xr8qErBm/mgoTMGgSSUoW9ZZYRMSH
Yy4x3w+ppqK9UixjBHyKEitLcMwmK2hA4+khnjli5fbuYWeIqEszRC51nJuuga8e
wO1XZ9/IZMQh17mmLDerGr/bz210P/ayHXbjCw9R26P5R35HgLPYp9NCkZtyyFpQ
EEHLL6f2VU9O7S2aQ+qYTnJZ+Ac3DnKzM8P8RXkPh5KkJeyIhteqhsaLDabonRxG
g6afNofYLhdUvb47j2z5k0+41BTDGaunCAy5XRKq8MH5TH5fF4xoHd+caUMRDk/d
SkTePzjtSR6XdQYuRhyc
=pRuD
-----END PGP SIGNATURE-----

--nextPart5324272.G1J0i3PnF0--


--===============3156358036627519353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3156358036627519353==--
