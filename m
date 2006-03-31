From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: pcm parameters, digital output ...
Date: Fri, 31 Mar 2006 13:45:56 +0200
Message-ID: <1143805556.23254.0.camel@localhost>
References: <1143632082.9481.6.camel@localhost>
	 <Pine.LNX.4.61.0603301642170.11712@tm8103.perex-int.cz>
	 <1143731165.4617.0.camel@localhost>
	 <Pine.LNX.4.61.0603311204150.9303@tm8103.perex-int.cz>
	 <1143802530.22691.29.camel@localhost>
	 <Pine.LNX.4.61.0603311303340.9303@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m88vDBr7lBv/AogrmYuS"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A9BDAC1
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 13:46:05 +0200 (MEST)
Received: from sipsolutions.net (unknown [213.151.39.204])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 64CFC9927A
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 13:46:05 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0603311303340.9303@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-m88vDBr7lBv/AogrmYuS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-31 at 13:38 +0200, Jaroslav Kysela wrote:
> > I don't see what more information the app could get from having a pro
> > mask and a con mask. Or is there hardware that changes the allowed mask
> > with the setting of pro/con mode??
>=20
> Yes, it's exactly what I'm talking about.

Ok. Then it makes sense. Sorry for not getting it.

> > That makes sense. Essentially, I'm happy if I can use the same stream
> > and tell during prepare() if compressed audio is going to be sent or
> > not. That's pretty much all that matters to me.
>=20
> Ok, I will try to add this feature. If someone else have objections=20
> against this implementation, please, speak now.

Cool, thanks, let me know if you want me to take a look at anything.

johannes

--=-m88vDBr7lBv/AogrmYuS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARC0Wc6Vg1VMiehFYAQIJLg/+NEzWle1QncKx5URRWvvZAlnmKCluOD0o
z6kTHFIoD6IxXbBE1v6LL5lcSE2US+QLll9Q5nk4zYpqiYrGXTsHh8ljCe3od0YP
t+WbjE1OdICYnYXO3+S/y6BWZwswR8a9txjhaN7THT92rCf7EBu0zcYCwd5Xwmdr
yl0g4ph91cyBW/YZXN+weHow4WYr6WPZczxhSBZQqwsR9O7p5EztjlKwI+2STGpv
aoAJCC70UUvi1Jxgc2hs5CoylT2Z6Qp5VkoqKP3c7To8lBCKoKDCmuE2FdnmmdvS
DhXFDMfGenPkTOMJCk4xsdfBOaNnLGxR86ZG2gG/2NGdk22EWNclXVIvRZzZrwat
RUuDKCeyeu0+hRgFMGI3dMvwvRc6VAwmLXbx4wJV6fcqPtsdvE5ZatUbXkQRxOpx
VrNyppyuMmObI5Fy2Bqkg9Fey+Hlkbql2Gc63QiA4h6qGw6qRtUxdaOnZ3dlY1B5
cDWYPaYDMWWzyhKP2g34RrnqxC2rutjIy04HY1GzB6pRRv4xMfu30VgNauDTyfaS
7j1/PG0EdPMWERnpHWlBPZH1BPszIUJ28cJZCDV5ayQjtcZVnZoieih/L5uzSrgu
O/3R3lJndVidi5NgUsK/fnRVAm33ELFLoYVUes9JL0LUqh6W9Io9/6e/rJ2Trmm5
GbPDUGApKlY=
=tinD
-----END PGP SIGNATURE-----

--=-m88vDBr7lBv/AogrmYuS--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
