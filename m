From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: ALC260 patch for Packard Bell Easy Note v7900
Date: Sat, 28 Apr 2007 10:28:43 +0200
Message-ID: <1177748923.10095.7.camel@osmosis>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0400676533159555524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aa014msr.fastwebnet.it (aa014msr.fastwebnet.it [85.18.95.74])
	by alsa0.perex.cz (Postfix) with ESMTP id E101824411
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Apr 2007 10:29:01 +0200 (CEST)
Received: from [10.0.1.10] (37.244.81.223) by aa014msr.fastwebnet.it
	(7.3.105.6) id 462DC9EA003C7648 for alsa-devel@alsa-project.org;
	Sat, 28 Apr 2007 10:29:01 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============0400676533159555524==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r9cOMW15oCf9ZzvIHJyp"


--=-r9cOMW15oCf9ZzvIHJyp
Content-Type: multipart/mixed; boundary="=-6V2G1nlm2w2i/sS0nDDW"


--=-6V2G1nlm2w2i/sS0nDDW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Please see if you can accept this patch that fixes sound/headphones/mic
on Packard Bell EN v7900 notebook (ALC260 chipset).

The code is not mine, I diff'ed using pshou's
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2189) but since
it works perfectly it would be nice to see it in the next alsa release.

Andrea

--=-6V2G1nlm2w2i/sS0nDDW
Content-Disposition: attachment; filename=packardbell7900.patch
Content-Type: text/x-patch; name=packardbell7900.patch; charset=us-ascii
Content-Transfer-Encoding: base64

LS0tIGEvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMJMjAwNy0wMy0wNiAxMzoyNjozMi4wMDAwMDAw
MDAgKzAxMDANCisrKyBiL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCTIwMDctMDQtMjggMTA6MTY6
MjIuMDAwMDAwMDAwICswMjAwDQpAQCAtNzQsNiArNzQsNyBAQA0KIAlBTEMyNjBfSFBfMzAxMywN
CiAJQUxDMjYwX0ZVSklUU1VfUzcwMlgsDQogCUFMQzI2MF9BQ0VSLA0KKwlBTEMyNjBfUEI3OTAw
LCANCiAjaWZkZWYgQ09ORklHX1NORF9ERUJVRw0KIAlBTEMyNjBfVEVTVCwNCiAjZW5kaWYNCkBA
IC0zMzQ5LDYgKzMzNTAsMjUgQEANCiAJeyB9IC8qIGVuZCAqLw0KIH07DQogDQorLyogUGFja2Fy
ZCBCZWxsIEVOIFY3OTAwIEFMQzI2MCBwaW4gdXNhZ2U6IE1pYyBqYWNrID0gMHgxMiwgDQorICog
TGluZSBJbiBqYWNrID0gMHgxNCwgQ0QgYXVkaW8gPSAgMHgxNiwgc3BlYWtlciA9IDB4MGYuDQor
ICovDQorc3RhdGljIHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IGFsYzI2MF9wYnY3OTAwX21peGVy
W10gPSB7DQorCUhEQV9DT0RFQ19WT0xVTUUoIkZyb250IFBsYXliYWNrIFZvbHVtZSIsIDB4MDgs
IDB4MCwgSERBX09VVFBVVCksDQorCUhEQV9DT0RFQ19NVVRFKCJGcm9udCBQbGF5YmFjayBTd2l0
Y2giLCAweDBmLCAweDAsIEhEQV9PVVRQVVQpLA0KKwlIREFfQ09ERUNfVk9MVU1FKCJNaWMgUGxh
eWJhY2sgVm9sdW1lIiwgMHgwNywgMHgwLCBIREFfSU5QVVQpLA0KKwlIREFfQ09ERUNfTVVURSgi
TWljIFBsYXliYWNrIFN3aXRjaCIsIDB4MDcsIDB4MCwgSERBX0lOUFVUKSwNCisJQUxDX1BJTl9N
T0RFKCJNaWMgSmFjayBNb2RlIiwgMHgxMiwgQUxDX1BJTl9ESVJfSU4pLA0KKwlIREFfQ09ERUNf
Vk9MVU1FKCJMaW5lIFBsYXliYWNrIFZvbHVtZSIsIDB4MDcsIDB4MDIsIEhEQV9JTlBVVCksDQor
CUhEQV9DT0RFQ19NVVRFKCJMaW5lIFBsYXliYWNrIFN3aXRjaCIsIDB4MDcsIDB4MDIsIEhEQV9J
TlBVVCksDQorCUFMQ19QSU5fTU9ERSgiTGluZSBKYWNrIE1vZGUiLCAweDE0LCBBTENfUElOX0RJ
Ul9JTk9VVCksDQorCUhEQV9DT0RFQ19WT0xVTUUoIkNEIFBsYXliYWNrIFZvbHVtZSIsIDB4MDcs
IDB4MDQsIEhEQV9JTlBVVCksDQorCUhEQV9DT0RFQ19NVVRFKCJDRCBQbGF5YmFjayBTd2l0Y2gi
LCAweDA3LCAweDA0LCBIREFfSU5QVVQpLA0KKwlIREFfQ09ERUNfVk9MVU1FKCJCZWVwIFBsYXli
YWNrIFZvbHVtZSIsIDB4MDcsIDB4MDUsIEhEQV9JTlBVVCksDQorCUhEQV9DT0RFQ19NVVRFKCJC
ZWVwIFBsYXliYWNrIFN3aXRjaCIsIDB4MDcsIDB4MDUsIEhEQV9JTlBVVCksDQorCXsgfSAvKiBl
bmQgKi8NCit9Ow0KKw0KIC8qIGNhcHR1cmUgbWl4ZXIgZWxlbWVudHMgKi8NCiBzdGF0aWMgc3Ry
dWN0IHNuZF9rY29udHJvbF9uZXcgYWxjMjYwX2NhcHR1cmVfbWl4ZXJbXSA9IHsNCiAJSERBX0NP
REVDX1ZPTFVNRSgiQ2FwdHVyZSBWb2x1bWUiLCAweDA0LCAweDAsIEhEQV9JTlBVVCksDQpAQCAt
MzcxOSw2ICszNzM5LDE4IEBADQogCXsgfQ0KIH07DQogDQorc3RhdGljIHN0cnVjdCBoZGFfdmVy
YiBhbGMyNjBfcGJ2NzkwMF92ZXJic1tdID0gew0KKyAgICB7MHgwOCwgQUNfVkVSQl9TRVRfQU1Q
X0dBSU5fTVVURSwgQU1QX0lOX1VOTVVURSgwKX0sDQorICAgIHsweDA4LCBBQ19WRVJCX1NFVF9B
TVBfR0FJTl9NVVRFLCBBTVBfSU5fVU5NVVRFKDEpfSwNCisgICAgezB4MGYsIEFDX1ZFUkJfU0VU
X1BJTl9XSURHRVRfQ09OVFJPTCwgUElOX0hQfSwNCisgICAgezB4MGYsIEFDX1ZFUkJfU0VUX0VB
UERfQlRMRU5BQkxFLCAweDAyfSwNCisgICAgezB4MGIsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VM
LCAweDAwfSwNCisgICAgezB4MGQsIEFDX1ZFUkJfU0VUX0NPTk5FQ1RfU0VMLCAweDAwfSwNCisg
ICAgezB4MWEsIEFDX1ZFUkJfU0VUX0NPRUZfSU5ERVgsIDB4MDd9LA0KKyAgICB7MHgxYSwgQUNf
VkVSQl9TRVRfUFJPQ19DT0VGLCAweDMwNDB9LA0KKyAgICB7IH0NCit9Ow0KKw0KIC8qIFRlc3Qg
Y29uZmlndXJhdGlvbiBmb3IgZGVidWdnaW5nLCBtb2RlbGxlZCBhZnRlciB0aGUgQUxDODgwIHRl
c3QNCiAgKiBjb25maWd1cmF0aW9uLg0KICAqLw0KQEAgLTQxNzcsNiArNDIwOSw3IEBADQogCVtB
TEMyNjBfSFBfMzAxM10JPSAiaHAtMzAxMyIsDQogCVtBTEMyNjBfRlVKSVRTVV9TNzAyWF0JPSAi
ZnVqaXRzdSIsDQogCVtBTEMyNjBfQUNFUl0JCT0gImFjZXIiLA0KKwlbQUxDMjYwX1BCVjc5MDBd
CT0gInBidjc5MDAiLA0KICNpZmRlZiBDT05GSUdfU05EX0RFQlVHDQogCVtBTEMyNjBfVEVTVF0J
CT0gInRlc3QiLA0KICNlbmRpZg0KQEAgLTQxOTgsNiArNDIzMSw3IEBADQogCVNORF9QQ0lfUVVJ
UksoMHgxMDRkLCAweDgxY2QsICJTb255IFZBSU8iLCBBTEMyNjBfQkFTSUMpLA0KIAlTTkRfUENJ
X1FVSVJLKDB4MTBjZiwgMHgxMzI2LCAiRnVqaXRzdSBTNzAyWCIsIEFMQzI2MF9GVUpJVFNVX1M3
MDJYKSwNCiAJU05EX1BDSV9RVUlSSygweDE1MmQsIDB4MDcyOSwgIkNUTCBVNTUzVyIsIEFMQzI2
MF9CQVNJQyksDQorCVNORF9QQ0lfUVVJUksoMHgxNjMxLCAweGMwMTcsICJQYWNrYXJkIEJlbGwg
RU4gVjc5MDAiLCBBTEMyNjBfUEJWNzkwMCksDQogCXt9DQogfTsNCiANCkBAIC00MjY4LDYgKzQz
MDIsMTggQEANCiAJCS5udW1fbXV4X2RlZnMgPSBBUlJBWV9TSVpFKGFsYzI2MF9hY2VyX2NhcHR1
cmVfc291cmNlcyksDQogCQkuaW5wdXRfbXV4ID0gYWxjMjYwX2FjZXJfY2FwdHVyZV9zb3VyY2Vz
LA0KIAl9LA0KKwlbQUxDMjYwX1BCVjc5MDBdID0gew0KKwkJLm1peGVycyA9IHsgYWxjMjYwX3Bi
djc5MDBfbWl4ZXIsDQorCQkJICAgIGFsYzI2MF9jYXB0dXJlX21peGVyIH0sDQorCQkuaW5pdF92
ZXJicyA9IHsgYWxjMjYwX2luaXRfdmVyYnMsIGFsYzI2MF9wYnY3OTAwX3ZlcmJzIH0sDQorCQku
bnVtX2RhY3MgPSBBUlJBWV9TSVpFKGFsYzI2MF9kYWNfbmlkcyksDQorCQkuZGFjX25pZHMgPSBh
bGMyNjBfZGFjX25pZHMsDQorCQkubnVtX2FkY19uaWRzID0gQVJSQVlfU0laRShhbGMyNjBfYWRj
X25pZHMpLA0KKwkJLmFkY19uaWRzID0gYWxjMjYwX2FkY19uaWRzLA0KKwkJLm51bV9jaGFubmVs
X21vZGUgPSBBUlJBWV9TSVpFKGFsYzI2MF9tb2RlcyksDQorCQkuY2hhbm5lbF9tb2RlID0gYWxj
MjYwX21vZGVzLA0KKwkJLmlucHV0X211eCA9ICZhbGMyNjBfY2FwdHVyZV9zb3VyY2UsDQorCX0s
DQogI2lmZGVmIENPTkZJR19TTkRfREVCVUcNCiAJW0FMQzI2MF9URVNUXSA9IHsNCiAJCS5taXhl
cnMgPSB7IGFsYzI2MF90ZXN0X21peGVyLA0K


--=-6V2G1nlm2w2i/sS0nDDW--

--=-r9cOMW15oCf9ZzvIHJyp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGMwW7j5TKYSZYpiQRAhHsAKDTKWfAWwapQUn8XsCfwlphEpXe3ACfX2gY
PKS7Aq4M6519he+iiURY0dE=
=jCF+
-----END PGP SIGNATURE-----

--=-r9cOMW15oCf9ZzvIHJyp--


--===============0400676533159555524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0400676533159555524==--
