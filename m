From: Johannes Berg <johannes@sipsolutions.net>
Subject: driver submission procedure?
Date: Wed, 31 May 2006 18:06:53 +0200
Message-ID: <1149091613.8877.31.camel@johannes>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1181984987=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D68AF140
	for <alsa-devel@alsa-project.org>;
	Wed, 31 May 2006 18:41:12 +0200 (MEST)
Received: from [131.234.78.216] (helo=dhcp-78-216.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.62) (envelope-from <johannes@sipsolutions.net>)
	id 1FlTDi-0000Bg-Ne
	for alsa-devel@alsa-project.org; Wed, 31 May 2006 17:06:54 +0100
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1181984987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Dl3rksTCq11YXQ4W2O42"


--=-Dl3rksTCq11YXQ4W2O42
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

I'll post a new round of patches that add snd-aoa (and this time adding
also the critical part in two split patches), I held off because I had
been working on headphone detection.

But the question I have now is: What's the procedure for submitting
this? If it goes through alsa mercurial, in what form do I submit
patches? Is it fine to submit patches that would apply against the linux
kernel?

Another thing is that I'll have a round of patches that change both
snd-aoa and the kernel at the same time, so how should I submit those?
Working with the alsa hg repository will be mostly impossible since
those patches need to be applied in both spots at the same time...

Thoughts?

johannes

--=-Dl3rksTCq11YXQ4W2O42
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARH2/GqVg1VMiehFYAQLw4g/9Fecku6vso1ROCEDbLMnAAnSGFYDn8YJv
yNDoxfkzA0udS9EIfQrJM6sF3uh3AYh/7FRCBuqxoUd/wGxkRJOeownEFjIcziSJ
Ylfhj9JG7l21NBmlxr24oF3YQhw86IykCbxNEnmM9JKvIzhVrVDgfhJRQHlrR8r2
UuNtaxFcQTx2WJg6RRhkdlngr7+IonKrnR9U7vRuynae8mQcggwns2IlF/fRainC
ak4moRBaLGarC6BmApf2EFZFhr7PS370ct6/T1+TMw7AGehJmEiaTJHCovCjST8Q
lPi/QJdQ+XEAiju0h+E8BnOoCOXIYWIgE1ooJQmOWcuPGjemttsoZXaj/cupeqcr
/QdRIB1s4kotNQajrU+Zh+4EX3kAJ85PbrQguH76gPJHqgRuWqP71Ddq/z3OzGYf
c+2ggNJug5XpIz+Fx5Fpi9Ku033TF9Wknh6FOArCZ8plbVKo6gho311mP4lgA8fL
KcujUk9rpSm68fSSh86+ktVKmNdKYPxn7mv6KN7emELzaP0FIW+FA94KSFapGtju
3mETWAZXHE9ZAqS1VXmwPwb3xopBOYdCPQL5d67nFzmJFT3AUabaGL0BCe3ro/KR
iV4TQlXoFjc6A53j4EXsiccH5/1mc1IshcHLSusOnqRXvSVD03YzRyTkJPb0x/JN
ICpofa4aR1A=
=tH1h
-----END PGP SIGNATURE-----

--=-Dl3rksTCq11YXQ4W2O42--



--===============1181984987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1181984987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1181984987==--
