From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: alsamixer and short slider
Date: Tue, 16 May 2006 01:43:58 +0200
Message-ID: <1147736638.29795.77.camel@johannes>
References: <1147358935.4692.2.camel@johannes>
	 <s5hvesc1u3j.wl%tiwai@suse.de> <1147360673.4692.17.camel@johannes>
	 <s5hlkt81t50.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J1fNb1zZFZN5LAK2C5md"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkt81t50.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-J1fNb1zZFZN5LAK2C5md
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-11 at 17:24 +0200, Takashi Iwai wrote:
> > Well, it tries to, but like I said, I cannot select anything but 0, 4,
> > 7, 11 and 14, but for a range of 3..28 it should be selecting
> > approximately every 4 items from 0 to 100.
>=20
> Sounds like the minimum value 3 isn't handled properly but assumed the
> range 0-28.

Not sure, but if I actually translate the range from 3..28 to 0..25 in
the kernel module, it works well. But that's not how it should be.

> Does amixer work as expected?

As I said before, yes, it does indeed.

Side note: most programs I've tried don't handle ranges where the start
or both start and end are negatiive ... I feel like I'm going to have to
educate dozens of alsa software writers or just cave in and translate
the ranges in the kernel...

johannes

--=-J1fNb1zZFZN5LAK2C5md
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGkSPKVg1VMiehFYAQJgRA//cbsuM4K9rb1Ov1rdrxRXTRFrjWkBihi/
YeR8rVuX5TF0BHVENlSonCHlScv17XPx/0vCCSRIckwiHTAc6vUUqRF/pW5YzJYS
viPwQWjd0Ysbv5HLuT5t4ma+1yB/ZMkb37FZDzI/PDt9Zg7stV9cSILZvKu7+gjz
KWS8t3/wu2ntDP03bk0nCLYniI27/k2/BHLZW/MNjnVtsiranYVjORibA/sC/ypb
XWRjfw5bLu+jf1GLeIOJmlrEPiP8LWaKAKhfdJYJAMXEsHTnhrqNbw80y8Wo94p9
5V16erqRxn62BHscw97IeBLp4vgaWj6DqOW7CpS7taVvmrHaB5L9ISxjDkNWWK8Q
o8I80n1H9FCqz7u4CqBPFseXEssDEV2Zas6IG6iDdX49/Ai+KUhluGBwO/qw0RiF
Oxo3O31VIaJ+1kwJokLUkD7lXDMgNClKdEkZrII2XMREmV9GV6ArxryilCrmoquL
OivYCYfFQYMEtAB6iyVtwhpdnFMSFvx8oCQJTCNyAJWQCAZU50EednRyw5cqr8o7
Za1+iWmu8dkMxHplUx9CRb8+tnm3c057cWVpGMXXPeDWLDmCNe1RluPavAbMpYjG
jqfFkfSYqfo45Gi+fGpmbLWkfLHtqTcOaq331h4mlIUczNmNcz+xpyADaO/JrpAO
bDWyyGpiD9o=
=c6Xf
-----END PGP SIGNATURE-----

--=-J1fNb1zZFZN5LAK2C5md--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
