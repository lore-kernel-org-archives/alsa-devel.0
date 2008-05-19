From: Tony Vroon <tony@linx.net>
Subject: [ALC262_FUJITSU patch_realtek.c] Use jack sense for
	both headphone	outputs
Date: Mon, 19 May 2008 01:00:19 +0100
Message-ID: <1211155219.4974.10.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0411581320240121417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 362CD244DF
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 02:01:10 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============0411581320240121417==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zJo2AugS3c7Qw8bPhQmW"


--=-zJo2AugS3c7Qw8bPhQmW
Content-Type: multipart/mixed; boundary="=-zoQKyBMz7yI+F1aAswja"


--=-zoQKyBMz7yI+F1aAswja
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good morning,

Could you please consider the following patch for 2.6.27.
The driver starts up with the jacks in an inconsistent state (speakers on,=20
laptop headphone output enabled, dock headphone output enabled) and does no=
t=20
consider their state until the first unsolicited event arrives. In some cas=
es=20
it takes *headphone insert* *headphone removal* *headphone insert* to get t=
he=20
driver to mute the speakers successfully.

Also, both HP outputs are enabled together, rather then individually enable=
d based=20
on jack sense results.

This patch addresses both problems. Open to comments as usual & sign-off in=
 diff.

Regards,
Tony V.
LINX sysadmin

--=-zoQKyBMz7yI+F1aAswja
Content-Disposition: attachment; filename=alc262-fujitsu-autosense.patch
Content-Type: text/x-patch; name=alc262-fujitsu-autosense.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jLm9yaWcJMjAwOC0wNS0xNyAxNTowNzoz
NS4wMDAwMDAwMDAgKzAxMDANCisrKyBzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwkyMDA4
LTA1LTE5IDAwOjQzOjM1LjAwMDAwMDAwMCArMDEwMA0KQEAgLTg3NTcsNyArODc1Nyw3IEBADQog
CX0sDQogfTsNCiANCi0vKiBtdXRlL3VubXV0ZSBpbnRlcm5hbCBzcGVha2VyIGFjY29yZGluZyB0
byB0aGUgaHAgamFjayBhbmQgbXV0ZSBzdGF0ZSAqLw0KKy8qIG11dGUvdW5tdXRlIGludGVybmFs
IHNwZWFrZXIgYWNjb3JkaW5nIHRvIHRoZSBocCBqYWNrcyBhbmQgbXV0ZSBzdGF0ZSAqLw0KIHN0
YXRpYyB2b2lkIGFsYzI2Ml9mdWppdHN1X2F1dG9tdXRlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
LCBpbnQgZm9yY2UpDQogew0KIAlzdHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsN
CkBAIC04NzY1LDEzICs4NzY1LDI4IEBADQogDQogCWlmIChmb3JjZSB8fCAhc3BlYy0+c2Vuc2Vf
dXBkYXRlZCkgew0KIAkJdW5zaWduZWQgaW50IHByZXNlbnRfaW50X2hwLCBwcmVzZW50X2RvY2tf
aHA7DQotCQkvKiBuZWVkIHRvIGV4ZWN1dGUgYW5kIHN5bmMgYXQgZmlyc3QgKi8NCisJCS8qIHNl
bnNlIGxhcHRvcCBoZWFkcGhvbmUgamFjaywgZW5hYmxlIGFtcCBpZiByZXF1aXJlZCAqLw0KIAkJ
c25kX2hkYV9jb2RlY19yZWFkKGNvZGVjLCAweDE0LCAwLCBBQ19WRVJCX1NFVF9QSU5fU0VOU0Us
IDApOw0KIAkJcHJlc2VudF9pbnRfaHAgPSBzbmRfaGRhX2NvZGVjX3JlYWQoY29kZWMsIDB4MTQs
IDAsDQogCQkJCQlBQ19WRVJCX0dFVF9QSU5fU0VOU0UsIDApOw0KKwkJaWYgKChwcmVzZW50X2lu
dF9ocCAmIDB4ODAwMDAwMDApICE9IDApDQorCQkJc25kX2hkYV9jb2RlY19hbXBfc3RlcmVvKGNv
ZGVjLCAweDE0LCBIREFfT1VUUFVULCAwLA0KKwkJCQkJCSBIREFfQU1QX01VVEUsIDApOw0KKwkJ
ZWxzZQ0KKwkJCXNuZF9oZGFfY29kZWNfYW1wX3N0ZXJlbyhjb2RlYywgMHgxNCwgSERBX09VVFBV
VCwgMCwNCisJCQkJCQkgSERBX0FNUF9NVVRFLCBIREFfQU1QX01VVEUpOw0KKw0KKwkJLyogc2Vu
c2UgZG9jayBoZWFkcGhvbmUgamFjaywgZW5hYmxlIGFtcCBpZiByZXF1aXJlZCAqLw0KIAkJc25k
X2hkYV9jb2RlY19yZWFkKGNvZGVjLCAweDFCLCAwLCBBQ19WRVJCX1NFVF9QSU5fU0VOU0UsIDAp
Ow0KIAkJcHJlc2VudF9kb2NrX2hwID0gc25kX2hkYV9jb2RlY19yZWFkKGNvZGVjLCAweDFiLCAw
LA0KIAkJCQkJQUNfVkVSQl9HRVRfUElOX1NFTlNFLCAwKTsNCisJCWlmICgocHJlc2VudF9kb2Nr
X2hwICYgMHg4MDAwMDAwMCkgIT0gMCkNCisJCQlzbmRfaGRhX2NvZGVjX2FtcF9zdGVyZW8oY29k
ZWMsIDB4MWIsIEhEQV9PVVRQVVQsIDAsDQorCQkJCQkJIEhEQV9BTVBfTVVURSwgMCk7DQorCQll
bHNlDQorCQkJc25kX2hkYV9jb2RlY19hbXBfc3RlcmVvKGNvZGVjLCAweDFiLCBIREFfT1VUUFVU
LCAwLA0KKwkJCQkJCSBIREFfQU1QX01VVEUsIEhEQV9BTVBfTVVURSk7DQorDQogCQlzcGVjLT5q
YWNrX3ByZXNlbnQgPSAocHJlc2VudF9pbnRfaHAgJiAweDgwMDAwMDAwKSAhPSAwOw0KIAkJc3Bl
Yy0+amFja19wcmVzZW50IHw9IChwcmVzZW50X2RvY2tfaHAgJiAweDgwMDAwMDAwKSAhPSAwOw0K
IAkJc3BlYy0+c2Vuc2VfdXBkYXRlZCA9IDE7DQpAQCAtODc4MSwxMCArODc5Niw5IEBADQogCQlz
bmRfaGRhX2NvZGVjX2FtcF9zdGVyZW8oY29kZWMsIDB4MTUsIEhEQV9PVVRQVVQsIDAsDQogCQkJ
CQkgSERBX0FNUF9NVVRFLCBIREFfQU1QX01VVEUpOw0KIAl9IGVsc2Ugew0KLQkJLyogdW5tdXRl
IGludGVybmFsIHNwZWFrZXIgaWYgbmVjZXNzYXJ5ICovDQotCQltdXRlID0gc25kX2hkYV9jb2Rl
Y19hbXBfcmVhZChjb2RlYywgMHgxNCwgMCwgSERBX09VVFBVVCwgMCk7DQorCQkvKiB1bm11dGUg
aW50ZXJuYWwgc3BlYWtlciAqLw0KIAkJc25kX2hkYV9jb2RlY19hbXBfc3RlcmVvKGNvZGVjLCAw
eDE1LCBIREFfT1VUUFVULCAwLA0KLQkJCQkJIEhEQV9BTVBfTVVURSwgbXV0ZSk7DQorCQkJCQkg
SERBX0FNUF9NVVRFLCAwKTsNCiAJfQ0KIH0NCiANCkBAIC04Nzk3LDYgKzg4MTEsMTEgQEANCiAJ
YWxjMjYyX2Z1aml0c3VfYXV0b211dGUoY29kZWMsIDEpOw0KIH0NCiANCitzdGF0aWMgdm9pZCBh
bGMyNjJfZnVqaXRzdV9pbml0X2hvb2soc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpDQorew0KKwlh
bGMyNjJfZnVqaXRzdV9hdXRvbXV0ZShjb2RlYywgMSk7DQorfQ0KKw0KIC8qIGJpbmQgdm9sdW1l
cyBvZiBib3RoIE5JRCAweDBjIGFuZCAweDBkICovDQogc3RhdGljIHN0cnVjdCBoZGFfYmluZF9j
dGxzIGFsYzI2Ml9mdWppdHN1X2JpbmRfbWFzdGVyX3ZvbCA9IHsNCiAJLm9wcyA9ICZzbmRfaGRh
X2JpbmRfdm9sLA0KQEAgLTk1NzAsNiArOTU5MCw3IEBADQogCQkuY2hhbm5lbF9tb2RlID0gYWxj
MjYyX21vZGVzLA0KIAkJLmlucHV0X211eCA9ICZhbGMyNjJfZnVqaXRzdV9jYXB0dXJlX3NvdXJj
ZSwNCiAJCS51bnNvbF9ldmVudCA9IGFsYzI2Ml9mdWppdHN1X3Vuc29sX2V2ZW50LA0KKwkJLmlu
aXRfaG9vayA9IGFsYzI2Ml9mdWppdHN1X2luaXRfaG9vaywNCiAJfSwNCiAJW0FMQzI2Ml9IUF9C
UENdID0gew0KIAkJLm1peGVycyA9IHsgYWxjMjYyX0hQX0JQQ19taXhlciB9LA0KDQpTaWduZWQt
b2ZmLWJ5OiBUb255IFZyb29uIDx0b255QGxpbngubmV0Pg0K


--=-zoQKyBMz7yI+F1aAswja--

--=-zJo2AugS3c7Qw8bPhQmW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgwwxIACgkQp5vW4rUFj5q4FACgqNEB9JF7gZBnpuqvhDu4LQMV
6JYAnibnjoT8hwKaYBmZWbPFrFtkdXVN
=1uAN
-----END PGP SIGNATURE-----

--=-zJo2AugS3c7Qw8bPhQmW--


--===============0411581320240121417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0411581320240121417==--
