From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [Patch v2] aconnect -x: Do not update index after
 removal of connection.
Date: Thu, 25 Mar 2010 11:05:55 +0100
Message-ID: <1269511555.3692.17.camel@mattotaupa>
References: <4B9E306F.8070705@gmail.com>
	<1268663545.9635.10.camel@mattotaupa> <4B9E7123.4000207@gmail.com>
	<1268686034.16974.39.camel@mattotaupa> <4B9EB507.1060406@gmail.com>
	<4BAA308D.6020305@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1161743873911882208=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 7271D1038B8
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 11:28:00 +0100 (CET)
In-Reply-To: <4BAA308D.6020305@gmail.com>
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


--===============1161743873911882208==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-eE+A1+bC7JATEwajIQCt"


--=-eE+A1+bC7JATEwajIQCt
Content-Type: multipart/mixed; boundary="=-BE43Wrlr/CRY8gFmiWAY"


--=-BE43Wrlr/CRY8gFmiWAY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Lieven,


sorry for my late reply. I was offline.

Am Mittwoch, den 24.03.2010, 16:32 +0100 schrieb lieven moors:

[=E2=80=A6]

> Did you get my patch in the end?

yes I did. But it looks like it did not make it to the list.

Takashi, could you please review and apply the attached patch. According
to [1] you seem to be the author.


Thanks,

Paul


[1] http://alsa.opensrc.org/index.php/Aconnect

--=-BE43Wrlr/CRY8gFmiWAY
Content-Disposition: attachment;
	filename*0=0001-aconnect-x-Do-not-update-index-after-removal-of-conn.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-aconnect-x-Do-not-update-index-after-removal-of-conn.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

PkZyb20gOTk2Y2YxMjNkMjBkYzVkN2RiMmY5OGYyOWNlYmNmYjdkM2IwMTNlMCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDENCkZyb206IGxpZXZlbiBtb29ycyA8bGlldmVubW9vcnNAZ21haWwuY29t
Pg0KRGF0ZTogTW9uLCAxNSBNYXIgMjAxMCAxODoxMzoxMSArMDEwMA0KU3ViamVjdDogW1BhdGNo
IHYyXSBhY29ubmVjdCAteDogRG8gbm90IHVwZGF0ZSBpbmRleCBhZnRlciByZW1vdmFsIG9mIGNv
bm5lY3Rpb24uDQogU2lnbmVkLW9mZi1ieTogbGlldmVuIG1vb3JzIDxsaWV2ZW5tb29yc0BnbWFp
bC5jb20+DQoNCi0tLQ0KIHNlcS9hY29ubmVjdC9hY29ubmVjdC5jIHwgICA0MyArKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NlcS9hY29ubmVj
dC9hY29ubmVjdC5jIGIvc2VxL2Fjb25uZWN0L2Fjb25uZWN0LmMNCmluZGV4IDFhNTA2NjYuLjYw
OTI3NDggMTAwNjQ0DQotLS0gYS9zZXEvYWNvbm5lY3QvYWNvbm5lY3QuYw0KKysrIGIvc2VxL2Fj
b25uZWN0L2Fjb25uZWN0LmMNCkBAIC0xOTIsNTIgKzE5MiwzMyBAQCBzdGF0aWMgdm9pZCByZW1v
dmVfY29ubmVjdGlvbihzbmRfc2VxX3QgKnNlcSwgc25kX3NlcV9jbGllbnRfaW5mb190ICpjaW5m
bywNCiAJCQkgICAgICBzbmRfc2VxX3BvcnRfaW5mb190ICpwaW5mbywgaW50IGNvdW50KQ0KIHsN
CiAJc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfdCAqcXVlcnk7DQotDQogCXNuZF9zZXFfcXVlcnlf
c3Vic2NyaWJlX2FsbG9jYSgmcXVlcnkpOw0KIAlzbmRfc2VxX3F1ZXJ5X3N1YnNjcmliZV9zZXRf
cm9vdChxdWVyeSwgc25kX3NlcV9wb3J0X2luZm9fZ2V0X2FkZHIocGluZm8pKTsNCi0NCiAJc25k
X3NlcV9xdWVyeV9zdWJzY3JpYmVfc2V0X3R5cGUocXVlcnksIFNORF9TRVFfUVVFUllfU1VCU19S
RUFEKTsNCiAJc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfc2V0X2luZGV4KHF1ZXJ5LCAwKTsNCi0J
Zm9yICg7IHNuZF9zZXFfcXVlcnlfcG9ydF9zdWJzY3JpYmVycyhzZXEsIHF1ZXJ5KSA+PSAwOw0K
LQkgICAgIHNuZF9zZXFfcXVlcnlfc3Vic2NyaWJlX3NldF9pbmRleChxdWVyeSwgc25kX3NlcV9x
dWVyeV9zdWJzY3JpYmVfZ2V0X2luZGV4KHF1ZXJ5KSArIDEpKSB7DQorDQorCXdoaWxlIChzbmRf
c2VxX3F1ZXJ5X3BvcnRfc3Vic2NyaWJlcnMoc2VxLCBxdWVyeSkgPj0gMCkgDQorCXsNCiAJCXNu
ZF9zZXFfcG9ydF9pbmZvX3QgKnBvcnQ7DQogCQlzbmRfc2VxX3BvcnRfc3Vic2NyaWJlX3QgKnN1
YnM7DQogCQljb25zdCBzbmRfc2VxX2FkZHJfdCAqc2VuZGVyID0gc25kX3NlcV9xdWVyeV9zdWJz
Y3JpYmVfZ2V0X3Jvb3QocXVlcnkpOw0KIAkJY29uc3Qgc25kX3NlcV9hZGRyX3QgKmRlc3QgPSBz
bmRfc2VxX3F1ZXJ5X3N1YnNjcmliZV9nZXRfYWRkcihxdWVyeSk7DQogCQlzbmRfc2VxX3BvcnRf
aW5mb19hbGxvY2EoJnBvcnQpOw0KLQkJaWYgKHNuZF9zZXFfZ2V0X2FueV9wb3J0X2luZm8oc2Vx
LCBkZXN0LT5jbGllbnQsIGRlc3QtPnBvcnQsIHBvcnQpIDwgMCkNCi0JCQljb250aW51ZTsNCi0J
CWlmICghKHNuZF9zZXFfcG9ydF9pbmZvX2dldF9jYXBhYmlsaXR5KHBvcnQpICYgU05EX1NFUV9Q
T1JUX0NBUF9TVUJTX1dSSVRFKSkNCi0JCQljb250aW51ZTsNCi0JCWlmIChzbmRfc2VxX3BvcnRf
aW5mb19nZXRfY2FwYWJpbGl0eShwb3J0KSAmIFNORF9TRVFfUE9SVF9DQVBfTk9fRVhQT1JUKQ0K
LQkJCWNvbnRpbnVlOw0KLQkJc25kX3NlcV9wb3J0X3N1YnNjcmliZV9hbGxvY2EoJnN1YnMpOw0K
LQkJc25kX3NlcV9wb3J0X3N1YnNjcmliZV9zZXRfcXVldWUoc3Vicywgc25kX3NlcV9xdWVyeV9z
dWJzY3JpYmVfZ2V0X3F1ZXVlKHF1ZXJ5KSk7DQotCQlzbmRfc2VxX3BvcnRfc3Vic2NyaWJlX3Nl
dF9zZW5kZXIoc3Vicywgc2VuZGVyKTsNCi0JCXNuZF9zZXFfcG9ydF9zdWJzY3JpYmVfc2V0X2Rl
c3Qoc3VicywgZGVzdCk7DQotCQlzbmRfc2VxX3Vuc3Vic2NyaWJlX3BvcnQoc2VxLCBzdWJzKTsN
Ci0JfQ0KIA0KLQlzbmRfc2VxX3F1ZXJ5X3N1YnNjcmliZV9zZXRfdHlwZShxdWVyeSwgU05EX1NF
UV9RVUVSWV9TVUJTX1dSSVRFKTsNCi0Jc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfc2V0X2luZGV4
KHF1ZXJ5LCAwKTsNCi0JZm9yICg7IHNuZF9zZXFfcXVlcnlfcG9ydF9zdWJzY3JpYmVycyhzZXEs
IHF1ZXJ5KSA+PSAwOw0KLQkgICAgIHNuZF9zZXFfcXVlcnlfc3Vic2NyaWJlX3NldF9pbmRleChx
dWVyeSwgc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfZ2V0X2luZGV4KHF1ZXJ5KSArIDEpKSB7DQot
CQlzbmRfc2VxX3BvcnRfaW5mb190ICpwb3J0Ow0KLQkJc25kX3NlcV9wb3J0X3N1YnNjcmliZV90
ICpzdWJzOw0KLQkJY29uc3Qgc25kX3NlcV9hZGRyX3QgKmRlc3QgPSBzbmRfc2VxX3F1ZXJ5X3N1
YnNjcmliZV9nZXRfcm9vdChxdWVyeSk7DQotCQljb25zdCBzbmRfc2VxX2FkZHJfdCAqc2VuZGVy
ID0gc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfZ2V0X2FkZHIocXVlcnkpOw0KLQkJc25kX3NlcV9w
b3J0X2luZm9fYWxsb2NhKCZwb3J0KTsNCi0JCWlmIChzbmRfc2VxX2dldF9hbnlfcG9ydF9pbmZv
KHNlcSwgc2VuZGVyLT5jbGllbnQsIHNlbmRlci0+cG9ydCwgcG9ydCkgPCAwKQ0KLQkJCWNvbnRp
bnVlOw0KLQkJaWYgKCEoc25kX3NlcV9wb3J0X2luZm9fZ2V0X2NhcGFiaWxpdHkocG9ydCkgJiBT
TkRfU0VRX1BPUlRfQ0FQX1NVQlNfUkVBRCkpDQotCQkJY29udGludWU7DQotCQlpZiAoc25kX3Nl
cV9wb3J0X2luZm9fZ2V0X2NhcGFiaWxpdHkocG9ydCkgJiBTTkRfU0VRX1BPUlRfQ0FQX05PX0VY
UE9SVCkNCisJCWlmICgoc25kX3NlcV9nZXRfYW55X3BvcnRfaW5mbyhzZXEsIGRlc3QtPmNsaWVu
dCwgZGVzdC0+cG9ydCwgcG9ydCkgPCAwKSB8fA0KKwkJCSEoc25kX3NlcV9wb3J0X2luZm9fZ2V0
X2NhcGFiaWxpdHkocG9ydCkgJiBTTkRfU0VRX1BPUlRfQ0FQX1NVQlNfV1JJVEUpIHx8DQorCQkJ
KHNuZF9zZXFfcG9ydF9pbmZvX2dldF9jYXBhYmlsaXR5KHBvcnQpICYgU05EX1NFUV9QT1JUX0NB
UF9OT19FWFBPUlQpKQ0KKwkJew0KKwkJCXNuZF9zZXFfcXVlcnlfc3Vic2NyaWJlX3NldF9pbmRl
eChxdWVyeSwgc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfZ2V0X2luZGV4KHF1ZXJ5KSArIDEpOw0K
IAkJCWNvbnRpbnVlOw0KKwkJfQ0KIAkJc25kX3NlcV9wb3J0X3N1YnNjcmliZV9hbGxvY2EoJnN1
YnMpOw0KIAkJc25kX3NlcV9wb3J0X3N1YnNjcmliZV9zZXRfcXVldWUoc3Vicywgc25kX3NlcV9x
dWVyeV9zdWJzY3JpYmVfZ2V0X3F1ZXVlKHF1ZXJ5KSk7DQogCQlzbmRfc2VxX3BvcnRfc3Vic2Ny
aWJlX3NldF9zZW5kZXIoc3Vicywgc2VuZGVyKTsNCiAJCXNuZF9zZXFfcG9ydF9zdWJzY3JpYmVf
c2V0X2Rlc3Qoc3VicywgZGVzdCk7DQotCQlzbmRfc2VxX3Vuc3Vic2NyaWJlX3BvcnQoc2VxLCBz
dWJzKTsNCisJCWlmKHNuZF9zZXFfdW5zdWJzY3JpYmVfcG9ydChzZXEsIHN1YnMpIDwgMCl7DQor
CQkJc25kX3NlcV9xdWVyeV9zdWJzY3JpYmVfc2V0X2luZGV4KHF1ZXJ5LCBzbmRfc2VxX3F1ZXJ5
X3N1YnNjcmliZV9nZXRfaW5kZXgocXVlcnkpICsgMSk7DQorCQl9DQogCX0NCiB9DQogDQotLSAN
CjEuNi4zLjMNCg0K


--=-BE43Wrlr/CRY8gFmiWAY--

--=-eE+A1+bC7JATEwajIQCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkurNYMACgkQPX1aK2wOHVg3swCdGYzEDYfPSVKHkBp+dIOkl6zX
pvIAn1srz7bUtaU6DViSti19VybXnhQ3
=A56g
-----END PGP SIGNATURE-----

--=-eE+A1+bC7JATEwajIQCt--


--===============1161743873911882208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1161743873911882208==--
