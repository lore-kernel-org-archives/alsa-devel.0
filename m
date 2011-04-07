From: Debarshi Ray <rishi.is@lostca.se>
Subject: Incorrect guessing of sound card on 2nd generation
	Intel Macbook
Date: Thu, 7 Apr 2011 13:05:34 +0000
Message-ID: <20110407130533.GA16141@aparichita.lostca.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8205629740381234742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aparichita.lostca.se (aparichita.lostca.se [88.198.51.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 4801B1038C3
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 15:05:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mailing list for ALSA developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8205629740381234742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a 2nd generation Intel Macbook and the elements shown by alsamixer do
not do what they are supposed to do. alsamixer shows master, speaker and
speaker1. Normally without any headphones muting speaker1 "weakens" the
output. But if a headset is attached then speaker1 has to be unmuted otherwise
there is no output from the headphones.

I am using alsa-lib-1.0.24 and the 2.6.35.11 kernel on a Fedora 14 system.

lspci:
http://rishi.fedorapeople.org/lspci

/proc/asound/Intel/codec#0:
http://rishi.fedorapeople.org/proc-asound-Intel-codec-0

Cheers,
Debarshi

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (FreeBSD)

iQIcBAEBAgAGBQJNnbadAAoJEEMnBfrN1AMlHi4QALCgzBxbAVPEGm6Ux8h6sNug
i0Hi4Xoo2mUPcVTiYt8rCxW05wfxn4EKHv4zNmFMaq/VlTyQO+l879oNLcvjRguQ
JnS7MGmSriB1PLuJ3IJfo9RKtyq0NzkCVyLtzk3xSIIb2ed7a7i1KrkAi4xejyTB
D4+7ueszSvsw53p0TOwGpTQxcE/Vfm1BXGmAowxBTRVRLT0hE6da9QkZVk9b2D+O
/POqujlhx6nAUm8XhSyyObcFP1iPX3rSXbWmaJEUK7+qqvSUoiePFfSzD0FitkGo
TCWWB74sVorp56ccWcXMIwfa0HCnh+qpv7I4pS3ebI1ugMqGYsR/3aXrYnaRM7a2
mlodwtbW0dIvu/OivwchYvzRm78CkfJdi9u7yoQi6FheBk+uDTWDRue5S6p/QtJV
v453fM5ZpeOMW2CUKaaWd7o/x8JLBgNYI/TmhmfjTJ/pms+hh5cCIbHZDM9Kj50B
47opBH+Me3rDgtfuf2eZDxEQNjttI9zjnXoEENMZke1WsNK79FGlGQwnVZ0nTXGx
SmnUL1fH55DzJvTPmZqqasefhyrXSR6YUDWubXp2NX5REHUTySCVPLb5B8yEom5k
6Ye9Z99fVa9aWMj2J39Az77hMB+G8feiby6IQEUq/xcHh+uP9iyW0lQQSS6JKPBA
6E4OTY0+Q88/PwIAK5ov
=WIIy
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============8205629740381234742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8205629740381234742==--
