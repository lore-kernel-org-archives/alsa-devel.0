From: Josh Green <josh@resonance.org>
Subject: Modem support for ICH6 based laptop?
Date: Wed, 23 Nov 2005 16:13:22 -0800
Message-ID: <1132791202.32481.22.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vNowBlCizDE0nQ+S+Jwu"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-vNowBlCizDE0nQ+S+Jwu
Content-Type: multipart/mixed; boundary="=-eHziQ1AYqts3pvOWGcJo"


--=-eHziQ1AYqts3pvOWGcJo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have an ASUS Z71V based laptop which has an Intel HDA sound system
(uses snd-hda-intel).  This laptop also has a modem, which I have heard
referred to as an ICH intel modem, but I'm not sure of the details.
I've tried loading the snd-intel8x0m module, but it doesn't seem to do
anything (no additional sound cards, output, etc).  I didn't find any
matches when looking through the list of PCI IDs in the intel8x0m.c
file.  Any ideas if this driver supports this modem, or could be made to
support it?  Attached is my lspci output (first as "lspci" then as
"lspci -n").  Best regards,
	Josh Green


--=-eHziQ1AYqts3pvOWGcJo
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=ISO-8859-1
Content-Transfer-Encoding: base64

JCBsc3BjaQ0KDQowMDAwOjAwOjAwLjAgSG9zdCBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9uIE1v
YmlsZSA5MTVHTS9QTS9HTVMvOTEwR01MIEV4cHJlc3MgUHJvY2Vzc29yIHRvIERSQU0gQ29udHJv
bGxlciAocmV2IDAzKQ0KMDAwMDowMDowMS4wIFBDSSBicmlkZ2U6IEludGVsIENvcnBvcmF0aW9u
IE1vYmlsZSA5MTVHTS9QTSBFeHByZXNzIFBDSSBFeHByZXNzIFJvb3QgUG9ydCAocmV2IDAzKQ0K
MDAwMDowMDoxYi4wIENsYXNzIDA0MDM6IEludGVsIENvcnBvcmF0aW9uIDgyODAxRkIvRkJNL0ZS
L0ZXL0ZSVyAoSUNINiBGYW1pbHkpIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBDb250cm9sbGVyIChy
ZXYgMDQpDQowMDAwOjAwOjFjLjAgUENJIGJyaWRnZTogSW50ZWwgQ29ycG9yYXRpb24gODI4MDFG
Qi9GQk0vRlIvRlcvRlJXIChJQ0g2IEZhbWlseSkgUENJIEV4cHJlc3MgUG9ydCAxIChyZXYgMDQp
DQowMDAwOjAwOjFkLjAgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxRkIv
RkJNL0ZSL0ZXL0ZSVyAoSUNINiBGYW1pbHkpIFVTQiBVSENJICMxIChyZXYgMDQpDQowMDAwOjAw
OjFkLjEgVVNCIENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxRkIvRkJNL0ZSL0ZX
L0ZSVyAoSUNINiBGYW1pbHkpIFVTQiBVSENJICMyIChyZXYgMDQpDQowMDAwOjAwOjFkLjIgVVNC
IENvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxRkIvRkJNL0ZSL0ZXL0ZSVyAoSUNI
NiBGYW1pbHkpIFVTQiBVSENJICMzIChyZXYgMDQpDQowMDAwOjAwOjFkLjMgVVNCIENvbnRyb2xs
ZXI6IEludGVsIENvcnBvcmF0aW9uIDgyODAxRkIvRkJNL0ZSL0ZXL0ZSVyAoSUNINiBGYW1pbHkp
IFVTQiBVSENJICM0IChyZXYgMDQpDQowMDAwOjAwOjFkLjcgVVNCIENvbnRyb2xsZXI6IEludGVs
IENvcnBvcmF0aW9uIDgyODAxRkIvRkJNL0ZSL0ZXL0ZSVyAoSUNINiBGYW1pbHkpIFVTQjIgRUhD
SSBDb250cm9sbGVyIChyZXYgMDQpDQowMDAwOjAwOjFlLjAgUENJIGJyaWRnZTogSW50ZWwgQ29y
cG9yYXRpb24gODI4MDEgTW9iaWxlIFBDSSBCcmlkZ2UgKHJldiBkNCkNCjAwMDA6MDA6MWYuMCBJ
U0EgYnJpZGdlOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUZCTSAoSUNINk0pIExQQyBJbnRlcmZh
Y2UgQnJpZGdlIChyZXYgMDQpDQowMDAwOjAwOjFmLjEgSURFIGludGVyZmFjZTogSW50ZWwgQ29y
cG9yYXRpb24gODI4MDFGQi9GQk0vRlIvRlcvRlJXIChJQ0g2IEZhbWlseSkgSURFIENvbnRyb2xs
ZXIgKHJldiAwNCkNCjAwMDA6MDE6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBuVmlk
aWEgQ29ycG9yYXRpb246IFVua25vd24gZGV2aWNlIDAxNDQgKHJldiBhMikNCjAwMDA6MDM6MDAu
MCBFdGhlcm5ldCBjb250cm9sbGVyOiBNYXJ2ZWxsIFRlY2hub2xvZ3kgR3JvdXAgTHRkLiBHaWdh
Yml0IEV0aGVybmV0IENvbnRyb2xsZXIgKHJldiAxMykNCjAwMDA6MDM6MDEuMCBDYXJkQnVzIGJy
aWRnZTogUmljb2ggQ28gTHRkIFJMNWM0NzYgSUkgKHJldiBhYykNCjAwMDA6MDM6MDEuMSBDYXJk
QnVzIGJyaWRnZTogUmljb2ggQ28gTHRkIFJMNWM0NzYgSUkgKHJldiBhYykNCjAwMDA6MDM6MDEu
MiBGaXJlV2lyZSAoSUVFRSAxMzk0KTogUmljb2ggQ28gTHRkIFI1QzU1MiBJRUVFIDEzOTQgQ29u
dHJvbGxlciAocmV2IDA0KQ0KMDAwMDowMzowMy4wIE5ldHdvcmsgY29udHJvbGxlcjogSW50ZWwg
Q29ycG9yYXRpb24gUFJPL1dpcmVsZXNzIDIyMDBCRyAocmV2IDA1KQ0KDQoNCiQgbHNwY2kgLW4N
Cg0KMDAwMDowMDowMC4wIENsYXNzIDA2MDA6IDgwODY6MjU5MCAocmV2IDAzKQ0KMDAwMDowMDow
MS4wIENsYXNzIDA2MDQ6IDgwODY6MjU5MSAocmV2IDAzKQ0KMDAwMDowMDoxYi4wIENsYXNzIDA0
MDM6IDgwODY6MjY2OCAocmV2IDA0KQ0KMDAwMDowMDoxYy4wIENsYXNzIDA2MDQ6IDgwODY6MjY2
MCAocmV2IDA0KQ0KMDAwMDowMDoxZC4wIENsYXNzIDBjMDM6IDgwODY6MjY1OCAocmV2IDA0KQ0K
MDAwMDowMDoxZC4xIENsYXNzIDBjMDM6IDgwODY6MjY1OSAocmV2IDA0KQ0KMDAwMDowMDoxZC4y
IENsYXNzIDBjMDM6IDgwODY6MjY1YSAocmV2IDA0KQ0KMDAwMDowMDoxZC4zIENsYXNzIDBjMDM6
IDgwODY6MjY1YiAocmV2IDA0KQ0KMDAwMDowMDoxZC43IENsYXNzIDBjMDM6IDgwODY6MjY1YyAo
cmV2IDA0KQ0KMDAwMDowMDoxZS4wIENsYXNzIDA2MDQ6IDgwODY6MjQ0OCAocmV2IGQ0KQ0KMDAw
MDowMDoxZi4wIENsYXNzIDA2MDE6IDgwODY6MjY0MSAocmV2IDA0KQ0KMDAwMDowMDoxZi4xIENs
YXNzIDAxMDE6IDgwODY6MjY2ZiAocmV2IDA0KQ0KMDAwMDowMTowMC4wIENsYXNzIDAzMDA6IDEw
ZGU6MDE0NCAocmV2IGEyKQ0KMDAwMDowMzowMC4wIENsYXNzIDAyMDA6IDExYWI6NDMyMCAocmV2
IDEzKQ0KMDAwMDowMzowMS4wIENsYXNzIDA2MDc6IDExODA6MDQ3NiAocmV2IGFjKQ0KMDAwMDow
MzowMS4xIENsYXNzIDA2MDc6IDExODA6MDQ3NiAocmV2IGFjKQ0KMDAwMDowMzowMS4yIENsYXNz
IDBjMDA6IDExODA6MDU1MiAocmV2IDA0KQ0KMDAwMDowMzowMy4wIENsYXNzIDAyODA6IDgwODY6
NDIyMCAocmV2IDA1KQ0K


--=-eHziQ1AYqts3pvOWGcJo--

--=-vNowBlCizDE0nQ+S+Jwu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBDhQWiRoMuWKCcbgQRAiGYAJ9S1+hCG2nsYjY5HU9ECpWz5jsG2ACeJQ+2
sXEQB2yqRrNAxr7hOxLNC/s=
=IA0y
-----END PGP SIGNATURE-----

--=-vNowBlCizDE0nQ+S+Jwu--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
