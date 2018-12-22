From: Thorsten Glaser <tg@debian.org>
Subject: Bug#870396: [Pkg-alsa-devel] Bug#870396: alsa-lib: fix SIGSEGV on x32 (and a minor typo in the testsuite)
Date: Sat, 22 Dec 2018 19:56:22 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1812221945540.22404@herc.mirbsd.org>
References: <150160433965.21991.1657492243954025255.reportbug@tglase.lan.tarent.de> <20181216120541.fjzy3cvnomlxraqj@toy.home.lxtec.de> <150160433965.21991.1657492243954025255.reportbug@tglase.lan.tarent.de>
Reply-To: Thorsten Glaser <tg@debian.org>, 870396@bugs.debian.org
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-860927789-1545508609=:22404"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.870396.B870396.154550894619514@bugs.debian.org>
In-Reply-To: <20181216120541.fjzy3cvnomlxraqj@toy.home.lxtec.de>
Content-Language: de-DE-1901, en-GB
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: 870396@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-860927789-1545508609=:22404
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

(For alsa-devel@alsa-project.org I=E2=80=99ve attached the diffs this
eMail thread has been about, with hope you will apply them in
the next upstream release.)


Elimar Riesebieter dixit:

>it seems that you are an exclusive user of the x32 port ;-) Please

If you actually read that thread you=E2=80=99d know I=E2=80=99m not. (I wro=
te some
eMails to it, too.)

>Does it really make sense to maintain code for a handful of users?

It=E2=80=99s nothing architecture-specific if I recall, so it will reduce
the chance of problems for all users.

Lemme dissect the patch=E2=80=A6

0009-fix-format-strings.patch: fixes, basically, this=E2=80=A6

=09printf("%ld", some_long_long_value);

=E2=80=A6 which is always an error, on platforms where time_t is larger
than long (which is currently all *64ilp32 platforms (there=E2=80=99s
x32, amd64ilp32, and a third one I forgot, already in existence),
but *will* encompass all ILP32 architectures as we get closer to
the year 2038).

0010-fix-testcase-typo.patch: not actually x32-related, but
noticed during porting.

0011-distinguish-x32-from-amd64.patch: this is the most important
one, and it=E2=80=99s a frigging oneliner:

-#elif defined(__x86_64__)
+#elif defined(__x86_64__) && !defined(__ILP32__)

This one literally only affects x32, indeed (so what I said above
was proven misremembered) but it=E2=80=99s obviously non-harmful to anythin=
g
else and easy to carry and forward.

So I=E2=80=99d wish you=E2=80=99d do that as it=E2=80=99s your duty as main=
tainer of a Debian
package, but alas=E2=80=A6 I=E2=80=99ll Cc the eMail address you told me an=
d hope
that someone picks it up.

Blessed yuletide,
//mirabilos
--=20
=E2=80=9CIt is inappropriate to require that a time represented as
 seconds since the Epoch precisely represent the number of
 seconds between the referenced time and the Epoch.=E2=80=9D
=09-- IEEE Std 1003.1b-1993 (POSIX) Section B.2.2.2
--0-860927789-1545508609=:22404
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=0009-fix-format-strings.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSM.4.64L.1812221956220.22404@herc.mirbsd.org>
Content-Description: 
Content-Disposition: attachment; filename=0009-fix-format-strings.patch

IyBEUDogZml4IGxvbmcgdnMuIGxvbmcgbG9uZyBjb25mdXNpb24gd2hlbiB0
aGVyZSBpcyBhIDY0LWJpdCB0aW1lX3QNCiMgRFA6IG9uIGEgMzItYml0IGxv
bmcgc3lzdGVtLCBzdWNoIGFzIGFsbCBuZXdlciAzMi1iaXQgYXJjaGl0ZWN0
dXJlcw0KDQotLS0gYS9zcmMvcGNtL3BjbS5jDQorKysgYi9zcmMvcGNtL3Bj
bS5jDQpAQCAtMjI1NywxMSArMjI1NywxMSBAQCBpbnQgc25kX3BjbV9zdGF0
dXNfZHVtcChzbmRfcGNtX3N0YXR1c190DQogew0KIAlhc3NlcnQoc3RhdHVz
KTsNCiAJc25kX291dHB1dF9wcmludGYob3V0LCAiICBzdGF0ZSAgICAgICA6
ICVzXG4iLCBzbmRfcGNtX3N0YXRlX25hbWUoKHNuZF9wY21fc3RhdGVfdCkg
c3RhdHVzLT5zdGF0ZSkpOw0KLQlzbmRfb3V0cHV0X3ByaW50ZihvdXQsICIg
IHRyaWdnZXJfdGltZTogJWxkLiUwNmxkXG4iLA0KLQkJCSAgc3RhdHVzLT50
cmlnZ2VyX3RzdGFtcC50dl9zZWMsDQotCQkJICBzdGF0dXMtPnRyaWdnZXJf
dHN0YW1wLnR2X25zZWMgLyAxMDAwKTsNCi0Jc25kX291dHB1dF9wcmludGYo
b3V0LCAiICB0c3RhbXAgICAgICA6ICVsZC4lMDZsZFxuIiwNCi0JCXN0YXR1
cy0+dHN0YW1wLnR2X3NlYywgc3RhdHVzLT50c3RhbXAudHZfbnNlYyAvIDEw
MDApOw0KKwlzbmRfb3V0cHV0X3ByaW50ZihvdXQsICIgIHRyaWdnZXJfdGlt
ZTogJWxsZC4lMDZsZFxuIiwNCisJCQkgIChsb25nIGxvbmcpc3RhdHVzLT50
cmlnZ2VyX3RzdGFtcC50dl9zZWMsDQorCQkJICAobG9uZylzdGF0dXMtPnRy
aWdnZXJfdHN0YW1wLnR2X25zZWMgLyAxMDAwTCk7DQorCXNuZF9vdXRwdXRf
cHJpbnRmKG91dCwgIiAgdHN0YW1wICAgICAgOiAlbGxkLiUwNmxkXG4iLA0K
KwkJKGxvbmcgbG9uZylzdGF0dXMtPnRzdGFtcC50dl9zZWMsIChsb25nKXN0
YXR1cy0+dHN0YW1wLnR2X25zZWMgLyAxMDAwTCk7DQogCXNuZF9vdXRwdXRf
cHJpbnRmKG91dCwgIiAgZGVsYXkgICAgICAgOiAlbGRcbiIsIChsb25nKXN0
YXR1cy0+ZGVsYXkpOw0KIAlzbmRfb3V0cHV0X3ByaW50ZihvdXQsICIgIGF2
YWlsICAgICAgIDogJWxkXG4iLCAobG9uZylzdGF0dXMtPmF2YWlsKTsNCiAJ
c25kX291dHB1dF9wcmludGYob3V0LCAiICBhdmFpbF9tYXggICA6ICVsZFxu
IiwgKGxvbmcpc3RhdHVzLT5hdmFpbF9tYXgpOw0KLS0tIGEvdGVzdC9sYXRl
bmN5LmMNCisrKyBiL3Rlc3QvbGF0ZW5jeS5jDQpAQCAtMzI1LDEyICszMjUs
MTIgQEAgdm9pZCBzZXRzY2hlZHVsZXIodm9pZCkNCiAJcHJpbnRmKCIhISFT
Y2hlZHVsZXIgc2V0IHRvIFJvdW5kIFJvYmluIHdpdGggcHJpb3JpdHkgJWkg
RkFJTEVEISEhXG4iLCBzY2hlZF9wYXJhbS5zY2hlZF9wcmlvcml0eSk7DQog
fQ0KIA0KLWxvbmcgdGltZWRpZmYoc25kX3RpbWVzdGFtcF90IHQxLCBzbmRf
dGltZXN0YW1wX3QgdDIpDQorbG9uZyBsb25nIHRpbWVkaWZmKHNuZF90aW1l
c3RhbXBfdCB0MSwgc25kX3RpbWVzdGFtcF90IHQyKQ0KIHsNCi0Jc2lnbmVk
IGxvbmcgbDsNCisJc2lnbmVkIGxvbmcgbG9uZyBsOw0KIA0KIAl0MS50dl9z
ZWMgLT0gdDIudHZfc2VjOw0KLQlsID0gKHNpZ25lZCBsb25nKSB0MS50dl91
c2VjIC0gKHNpZ25lZCBsb25nKSB0Mi50dl91c2VjOw0KKwlsID0gKHNpZ25l
ZCBsb25nIGxvbmcpIHQxLnR2X3VzZWMgLSAoc2lnbmVkIGxvbmcgbG9uZykg
dDIudHZfdXNlYzsNCiAJaWYgKGwgPCAwKSB7DQogCQl0MS50dl9zZWMtLTsN
CiAJCWwgPSAxMDAwMDAwICsgbDsNCkBAIC02ODIsMTAgKzY4MiwxMCBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0KIAkJc25kX3BjbV9u
b25ibG9jayhwaGFuZGxlLCAhYmxvY2sgPyAxIDogMCk7DQogCQlpZiAob2sp
IHsNCiAjaWYgMQ0KLQkJCXByaW50ZigiUGxheWJhY2sgdGltZSA9ICVsaS4l
aSwgUmVjb3JkIHRpbWUgPSAlbGkuJWksIGRpZmYgPSAlbGlcbiIsDQotCQkJ
ICAgICAgIHBfdHN0YW1wLnR2X3NlYywNCisJCQlwcmludGYoIlBsYXliYWNr
IHRpbWUgPSAlbGxpLiVpLCBSZWNvcmQgdGltZSA9ICVsbGkuJWksIGRpZmYg
PSAlbGxpXG4iLA0KKwkJCSAgICAgICAobG9uZyBsb25nKXBfdHN0YW1wLnR2
X3NlYywNCiAJCQkgICAgICAgKGludClwX3RzdGFtcC50dl91c2VjLA0KLQkJ
CSAgICAgICBjX3RzdGFtcC50dl9zZWMsDQorCQkJICAgICAgIChsb25nIGxv
bmcpY190c3RhbXAudHZfc2VjLA0KIAkJCSAgICAgICAoaW50KWNfdHN0YW1w
LnR2X3VzZWMsDQogCQkJICAgICAgIHRpbWVkaWZmKHBfdHN0YW1wLCBjX3Rz
dGFtcCkpOw0KICNlbmRpZg0KLS0tIGEvdGVzdC9xdWV1ZV90aW1lci5jDQor
KysgYi90ZXN0L3F1ZXVlX3RpbWVyLmMNCkBAIC05OSwxMSArOTksMTEgQEAg
bWFpbihpbnQgYXJnYyBBVFRSSUJVVEVfVU5VU0VELCBjaGFyICoqYQ0KIAlu
b3JtYWxpemUoJmRpZmZkaWZmKTsNCiAJcHJldmRpZmYgPSBkaWZmOw0KIA0K
LQlmcHJpbnRmKHN0ZGVyciwgIiByZWFsIHRpbWU6ICUxMmxkIHNlYyAlOGxk
IHVzZWNcbnF1ZXVlIHRpbWU6ICUxMmxkIHNlYyAlOGxkIHVzZWNcbiAgICAg
IGRpZmY6ICUxMmxkIHNlYyAlOGxkIHVzZWNcbiAgZGlmZmRpZmY6ICUxMmxk
IHNlYyAlOGxkIHVzZWNcbiIsDQotCQl0di50dl9zZWMsIHR2LnR2X3VzZWMs
DQotCQkobG9uZylydGltZS0+dHZfc2VjLCAobG9uZylydGltZS0+dHZfbnNl
YyAvIDEwMDAsDQotCQlkaWZmLnR2X3NlYywgZGlmZi50dl91c2VjLA0KLQkJ
KGxvbmcpZGlmZmRpZmYudHZfc2VjLCAobG9uZylkaWZmZGlmZi50dl91c2Vj
KTsNCisJZnByaW50ZihzdGRlcnIsICIgcmVhbCB0aW1lOiAlMTJsbGQgc2Vj
ICU4bGQgdXNlY1xucXVldWUgdGltZTogJTEybGxkIHNlYyAlOGxkIHVzZWNc
biAgICAgIGRpZmY6ICUxMmxsZCBzZWMgJThsZCB1c2VjXG4gIGRpZmZkaWZm
OiAlMTJsbGQgc2VjICU4bGQgdXNlY1xuIiwNCisJCShsb25nIGxvbmcpdHYu
dHZfc2VjLCAobG9uZyl0di50dl91c2VjLA0KKwkJKGxvbmcgbG9uZylydGlt
ZS0+dHZfc2VjLCAobG9uZylydGltZS0+dHZfbnNlYyAvIDEwMDAsDQorCQko
bG9uZyBsb25nKWRpZmYudHZfc2VjLCAobG9uZylkaWZmLnR2X3VzZWMsDQor
CQkobG9uZyBsb25nKWRpZmZkaWZmLnR2X3NlYywgKGxvbmcpZGlmZmRpZmYu
dHZfdXNlYyk7DQogDQogCWlmIChkaWZmZGlmZi50dl91c2VjID4gIDUwMDAg
fHwNCiAJICAgIGRpZmZkaWZmLnR2X3VzZWMgPCAtNTAwMCkgew0K

--0-860927789-1545508609=:22404
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=0010-fix-testcase-typo.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSM.4.64L.1812221956221.22404@herc.mirbsd.org>
Content-Description: 
Content-Disposition: attachment; filename=0010-fix-testcase-typo.patch

IyBEUDogZml4IGFuIG9idmlvdXMgdHlwbw0KDQotLS0gYS90ZXN0L2xhdGVu
Y3kuYw0KKysrIGIvdGVzdC9sYXRlbmN5LmMNCkBAIC02NzMsNyArNjczLDcg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCiAJCXByaW50
ZigiQ2FwdHVyZTpcbiIpOw0KIAkJc2hvd3N0YXQoY2hhbmRsZSwgZnJhbWVz
X2luKTsNCiAJCXNob3dpbm1heChpbl9tYXgpOw0KLQkJaWYgKHBfdHN0YW1w
LnR2X3NlYyA9PSBwX3RzdGFtcC50dl9zZWMgJiYNCisJCWlmIChwX3RzdGFt
cC50dl9zZWMgPT0gY190c3RhbXAudHZfc2VjICYmDQogCQkgICAgcF90c3Rh
bXAudHZfdXNlYyA9PSBjX3RzdGFtcC50dl91c2VjKQ0KIAkJCXByaW50Zigi
SGFyZHdhcmUgc3luY1xuIik7DQogCQlzbmRfcGNtX2Ryb3AoY2hhbmRsZSk7
DQo=

--0-860927789-1545508609=:22404
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=0011-distinguish-x32-from-amd64.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSM.4.64L.1812221956222.22404@herc.mirbsd.org>
Content-Description: 
Content-Disposition: attachment; filename=0011-distinguish-x32-from-amd64.patch

IyBEUDogZml4IHNlZ21lbnRhdGlvbiBmYXVsdCBjb21pbmcgZnJvbSB0aGlz
IHVzaW5nIGFtZDY0IGFzc2VtYmx5IGNvZGUNCiMgRFA6IG9uIHgzMiBzeXN0
ZW1zDQoNCi0tLSBhL3NyYy9wY20vcGNtX2RtaXguYw0KKysrIGIvc3JjL3Bj
bS9wY21fZG1peC5jDQpAQCAtMTQyLDcgKzE0Miw3IEBAIHN0YXRpYyB2b2lk
IGRtaXhfc2VydmVyX2ZyZWUoc25kX3BjbV9kaXINCiAjaW5jbHVkZSAicGNt
X2RtaXhfZ2VuZXJpYy5jIg0KICNpZiBkZWZpbmVkKF9faTM4Nl9fKQ0KICNp
bmNsdWRlICJwY21fZG1peF9pMzg2LmMiDQotI2VsaWYgZGVmaW5lZChfX3g4
Nl82NF9fKQ0KKyNlbGlmIGRlZmluZWQoX194ODZfNjRfXykgJiYgIWRlZmlu
ZWQoX19JTFAzMl9fKQ0KICNpbmNsdWRlICJwY21fZG1peF94ODZfNjQuYyIN
CiAjZWxzZQ0KICNpZm5kZWYgRE9DX0hJRERFTg0K

--0-860927789-1545508609=:22404--
