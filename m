From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: Merging alsa-kernel-1.0.7 into kernel 2.6.9
Date: Fri, 19 Nov 2004 12:52:34 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AD5D7@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4CE79.B2D1DC2F"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4CE79.B2D1DC2F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> On Fri, 2004-11-19 at 08:25 -0800, Stephen Warren wrote:
> > Unfortunately, this probably isn't an option for us. Whilst
> > we're targetting an embedded style userspace, we don't
> > control the hardware, and it can end up being basically any
> > arbitrary PC right now. Thus, we need good support for
> > everything ALSA can give us!
>=20
> OK that was just a suggestion for a quick fix.  It really should work
> the way you said.  This is an area of frequent breakage because the
> kernel changes so fast.  But 2.6.9 + 1.0.7 does works fine for me as
> modules, so this should be easy to fix...

OK. So I've done the merge and it seems to work. I've split this into
two patches.

The first patch is simply the copy of the relevant files into the kernel
tree. The second patch is the back-port to the 2.6.9 kernel API.

I was going to post both patches, but the first patch is 113K
compressed! So, I'll provide just the instructions to re-create the
first patch, plus the second patch...

rm -rf linux-kernel.org-2
cp -rp linux-kernel.org linux-kernel.org-2
chmod -R +w linux-kernel.org-2
rm -rf alsa-driver-1.0.7
tar jxvf patches-src/alsa-driver-1.0.7.tar.bz2
cd alsa-driver-1.0.7/alsa-kernel/
rm -rf oss
cp -a * ../../linux-kernel.org-2/sound
rm -rf ../../linux-kernel.org-2/sound/Documentation
rm -rf ../../linux-kernel.org-2/sound/include
rm -rf ../../linux-kernel.org-2/sound/kbuild
rm -rf ../../linux-kernel.org-2/sound/scripts
cd include
cp -a * ../../../linux-kernel.org-2/include/sound
cd ../Documentation
cp -a * ../../../linux-kernel.org-2/Documentation/sound/alsa
cd ../../..
diff -urN linux-kernel.org linux-kernel.org-2 >
patches-src/nvidia-2.6.9-alsa-1.0.7-1.diff

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html

------_=_NextPart_001_01C4CE79.B2D1DC2F
Content-Type: application/octet-stream;
	name="nvidia-2.6.9-alsa-1.0.7-2.diff"
Content-Transfer-Encoding: base64
Content-Description: nvidia-2.6.9-alsa-1.0.7-2.diff
Content-Disposition: attachment;
	filename="nvidia-2.6.9-alsa-1.0.7-2.diff"

ZGlmZiAtdXJOIGxpbnV4LWtlcm5lbC5vcmctMi9zb3VuZC9jb3JlL2luaXQuYyBsaW51eC1rZXJu
ZWwub3JnLTMvc291bmQvY29yZS9pbml0LmMKLS0tIGxpbnV4LWtlcm5lbC5vcmctMi9zb3VuZC9j
b3JlL2luaXQuYwkyMDA0LTEwLTI3IDAxOjUyOjU5LjAwMDAwMDAwMCAtMDYwMAorKysgbGludXgt
a2VybmVsLm9yZy0zL3NvdW5kL2NvcmUvaW5pdC5jCTIwMDQtMTEtMTkgMTM6Mzk6MTEuNjc3MzU1
MTEyIC0wNzAwCkBAIC03OTgsNyArNzk4LDcgQEAKIAlpZiAoY2FyZC0+cG93ZXJfc3RhdGUgPT0g
U05EUlZfQ1RMX1BPV0VSX0QwKQogCQlyZXR1cm4gMDsKIAkvKiByZXN0b3JlIHRoZSBQQ0kgY29u
ZmlnIHNwYWNlICovCi0JcGNpX3Jlc3RvcmVfc3RhdGUoZGV2KTsKKwlwY2lfcmVzdG9yZV9zdGF0
ZShkZXYsIGRldi0+c2F2ZWRfY29uZmlnX3NwYWNlKTsKIAkvKiBGSVhNRTogY29ycmVjdCBzdGF0
ZSB2YWx1ZT8gKi8KIAlyZXR1cm4gY2FyZC0+cG1fcmVzdW1lKGNhcmQsIDApOwogfQpkaWZmIC11
ck4gbGludXgta2VybmVsLm9yZy0yL3NvdW5kL2NvcmUvbWVtYWxsb2MuYyBsaW51eC1rZXJuZWwu
b3JnLTMvc291bmQvY29yZS9tZW1hbGxvYy5jCi0tLSBsaW51eC1rZXJuZWwub3JnLTIvc291bmQv
Y29yZS9tZW1hbGxvYy5jCTIwMDQtMTAtMjMgMTA6MTA6MjQuMDAwMDAwMDAwIC0wNjAwCisrKyBs
aW51eC1rZXJuZWwub3JnLTMvc291bmQvY29yZS9tZW1hbGxvYy5jCTIwMDQtMTEtMTkgMTM6MjM6
MDMuNDQyNTQ5MTc2IC0wNzAwCkBAIC0zNiw2ICszNiwxMSBAQAogI2luY2x1ZGUgPGFzbS9zYnVz
Lmg+CiAjZW5kaWYKIAorI3VuZGVmIG1vZHVsZV9wYXJhbV9hcnJheQorI2RlZmluZSBtb2R1bGVf
cGFyYW1fYXJyYXkobmFtZSwgdHlwZSwgbnVtcCwgcGVybSkgXAorICAgICAgICBzdGF0aWMgaW50
IGJvb3RfZGV2c18jI25hbWU7IFwKKyAgICAgICAgbW9kdWxlX3BhcmFtX2FycmF5X25hbWVkKG5h
bWUsIG5hbWUsIHR5cGUsIGJvb3RfZGV2c18jI25hbWUsIHBlcm0pCisKIAogTU9EVUxFX0FVVEhP
UigiVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiwgSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBz
dXNlLmN6PiIpOwogTU9EVUxFX0RFU0NSSVBUSU9OKCJNZW1vcnkgYWxsb2NhdG9yIGZvciBBTFNB
IHN5c3RlbS4iKTsKZGlmZiAtdXJOIGxpbnV4LWtlcm5lbC5vcmctMi9zb3VuZC9jb3JlL29zcy9w
Y21fb3NzLmMgbGludXgta2VybmVsLm9yZy0zL3NvdW5kL2NvcmUvb3NzL3BjbV9vc3MuYwotLS0g
bGludXgta2VybmVsLm9yZy0yL3NvdW5kL2NvcmUvb3NzL3BjbV9vc3MuYwkyMDA0LTExLTEwIDIz
OjQxOjA1LjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgta2VybmVsLm9yZy0zL3NvdW5kL2NvcmUv
b3NzL3BjbV9vc3MuYwkyMDA0LTExLTE5IDEzOjIzOjIxLjkzNDczNzkzNiAtMDcwMApAQCAtNDIs
NiArNDIsMTEgQEAKICNpbmNsdWRlIDxsaW51eC9zb3VuZGNhcmQuaD4KICNpbmNsdWRlIDxzb3Vu
ZC9pbml0dmFsLmg+CiAKKyN1bmRlZiBtb2R1bGVfcGFyYW1fYXJyYXkKKyNkZWZpbmUgbW9kdWxl
X3BhcmFtX2FycmF5KG5hbWUsIHR5cGUsIG51bXAsIHBlcm0pIFwKKyAgICAgICAgc3RhdGljIGlu
dCBib290X2RldnNfIyNuYW1lOyBcCisgICAgICAgIG1vZHVsZV9wYXJhbV9hcnJheV9uYW1lZChu
YW1lLCBuYW1lLCB0eXBlLCBib290X2RldnNfIyNuYW1lLCBwZXJtKQorCiAjZGVmaW5lIE9TU19B
TFNBRU1VTFZFUgkJX1NJT1IgKCdNJywgMjQ5LCBpbnQpCiAKIHN0YXRpYyBpbnQgZHNwX21hcFtT
TkRSVl9DQVJEU10gPSB7WzAgLi4uIChTTkRSVl9DQVJEUy0xKV0gPSAwfTsKZGlmZiAtdXJOIGxp
bnV4LWtlcm5lbC5vcmctMi9zb3VuZC9jb3JlL3Jhd21pZGkuYyBsaW51eC1rZXJuZWwub3JnLTMv
c291bmQvY29yZS9yYXdtaWRpLmMKLS0tIGxpbnV4LWtlcm5lbC5vcmctMi9zb3VuZC9jb3JlL3Jh
d21pZGkuYwkyMDA0LTEwLTIzIDEwOjEwOjI0LjAwMDAwMDAwMCAtMDYwMAorKysgbGludXgta2Vy
bmVsLm9yZy0zL3NvdW5kL2NvcmUvcmF3bWlkaS5jCTIwMDQtMTEtMTkgMTM6MjM6MTIuNDYzMTc3
ODMyIC0wNzAwCkBAIC0zNSw2ICszNSwxMSBAQAogI2luY2x1ZGUgPHNvdW5kL21pbm9ycy5oPgog
I2luY2x1ZGUgPHNvdW5kL2luaXR2YWwuaD4KIAorI3VuZGVmIG1vZHVsZV9wYXJhbV9hcnJheQor
I2RlZmluZSBtb2R1bGVfcGFyYW1fYXJyYXkobmFtZSwgdHlwZSwgbnVtcCwgcGVybSkgXAorICAg
ICAgICBzdGF0aWMgaW50IGJvb3RfZGV2c18jI25hbWU7IFwKKyAgICAgICAgbW9kdWxlX3BhcmFt
X2FycmF5X25hbWVkKG5hbWUsIG5hbWUsIHR5cGUsIGJvb3RfZGV2c18jI25hbWUsIHBlcm0pCisK
IE1PRFVMRV9BVVRIT1IoIkphcm9zbGF2IEt5c2VsYSA8cGVyZXhAc3VzZS5jej4iKTsKIE1PRFVM
RV9ERVNDUklQVElPTigiTWlkbGV2ZWwgUmF3TWlkaSBjb2RlIGZvciBBTFNBLiIpOwogTU9EVUxF
X0xJQ0VOU0UoIkdQTCIpOwpkaWZmIC11ck4gbGludXgta2VybmVsLm9yZy0yL3NvdW5kL3BjaS9j
bWlwY2kuYyBsaW51eC1rZXJuZWwub3JnLTMvc291bmQvcGNpL2NtaXBjaS5jCi0tLSBsaW51eC1r
ZXJuZWwub3JnLTIvc291bmQvcGNpL2NtaXBjaS5jCTIwMDQtMTAtMjMgMTA6MTA6MjYuMDAwMDAw
MDAwIC0wNjAwCisrKyBsaW51eC1rZXJuZWwub3JnLTMvc291bmQvcGNpL2NtaXBjaS5jCTIwMDQt
MTEtMTkgMTM6MjM6MzEuMzM4MzA4Mzc2IC0wNzAwCkBAIC00MCw2ICs0MCwxMSBAQAogI2luY2x1
ZGUgPHNvdW5kL2Fzb3VuZGVmLmg+CiAjaW5jbHVkZSA8c291bmQvaW5pdHZhbC5oPgogCisjdW5k
ZWYgbW9kdWxlX3BhcmFtX2FycmF5CisjZGVmaW5lIG1vZHVsZV9wYXJhbV9hcnJheShuYW1lLCB0
eXBlLCBudW1wLCBwZXJtKSBcCisgICAgICAgIHN0YXRpYyBpbnQgYm9vdF9kZXZzXyMjbmFtZTsg
XAorICAgICAgICBtb2R1bGVfcGFyYW1fYXJyYXlfbmFtZWQobmFtZSwgbmFtZSwgdHlwZSwgYm9v
dF9kZXZzXyMjbmFtZSwgcGVybSkKKwogTU9EVUxFX0FVVEhPUigiVGFrYXNoaSBJd2FpIDx0aXdh
aUBzdXNlLmRlPiIpOwogTU9EVUxFX0RFU0NSSVBUSU9OKCJDLU1lZGlhIENNSTh4MzggUENJIik7
CiBNT0RVTEVfTElDRU5TRSgiR1BMIik7CmRpZmYgLXVyTiBsaW51eC1rZXJuZWwub3JnLTIvc291
bmQvcGNpL2VuczEzNzAuYyBsaW51eC1rZXJuZWwub3JnLTMvc291bmQvcGNpL2VuczEzNzAuYwot
LS0gbGludXgta2VybmVsLm9yZy0yL3NvdW5kL3BjaS9lbnMxMzcwLmMJMjAwNC0xMC0yMyAxMDox
MDoyNy4wMDAwMDAwMDAgLTA2MDAKKysrIGxpbnV4LWtlcm5lbC5vcmctMy9zb3VuZC9wY2kvZW5z
MTM3MC5jCTIwMDQtMTEtMTkgMTM6MjM6NDEuMTM5ODE4MzIwIC0wNzAwCkBAIC01MSw2ICs1MSwx
MSBAQAogI2RlZmluZSBEUklWRVJfTkFNRSAiRU5TMTM3MSIKICNlbmRpZgogCisjdW5kZWYgbW9k
dWxlX3BhcmFtX2FycmF5CisjZGVmaW5lIG1vZHVsZV9wYXJhbV9hcnJheShuYW1lLCB0eXBlLCBu
dW1wLCBwZXJtKSBcCisgICAgICAgIHN0YXRpYyBpbnQgYm9vdF9kZXZzXyMjbmFtZTsgXAorICAg
ICAgICBtb2R1bGVfcGFyYW1fYXJyYXlfbmFtZWQobmFtZSwgbmFtZSwgdHlwZSwgYm9vdF9kZXZz
XyMjbmFtZSwgcGVybSkKKwogCiBNT0RVTEVfQVVUSE9SKCJKYXJvc2xhdiBLeXNlbGEgPHBlcmV4
QHN1c2UuY3o+LCBUaG9tYXMgU2FpbGVyIDxzYWlsZXJAaWZlLmVlLmV0aHouY2g+Iik7CiBNT0RV
TEVfTElDRU5TRSgiR1BMIik7CmRpZmYgLXVyTiBsaW51eC1rZXJuZWwub3JnLTIvc291bmQvcGNp
L2ludGVsOHgwLmMgbGludXgta2VybmVsLm9yZy0zL3NvdW5kL3BjaS9pbnRlbDh4MC5jCi0tLSBs
aW51eC1rZXJuZWwub3JnLTIvc291bmQvcGNpL2ludGVsOHgwLmMJMjAwNC0xMC0yNiAwMDoyMDox
My4wMDAwMDAwMDAgLTA2MDAKKysrIGxpbnV4LWtlcm5lbC5vcmctMy9zb3VuZC9wY2kvaW50ZWw4
eDAuYwkyMDA0LTExLTE5IDEzOjIzOjQ5LjAxMDYyMTc3NiAtMDcwMApAQCAtNDMsNiArNDMsMTEg
QEAKICNpbmNsdWRlIDxhc20vcGd0YWJsZS5oPgogI2luY2x1ZGUgPGFzbS9jYWNoZWZsdXNoLmg+
CiAKKyN1bmRlZiBtb2R1bGVfcGFyYW1fYXJyYXkKKyNkZWZpbmUgbW9kdWxlX3BhcmFtX2FycmF5
KG5hbWUsIHR5cGUsIG51bXAsIHBlcm0pIFwKKyAgICAgICAgc3RhdGljIGludCBib290X2RldnNf
IyNuYW1lOyBcCisgICAgICAgIG1vZHVsZV9wYXJhbV9hcnJheV9uYW1lZChuYW1lLCBuYW1lLCB0
eXBlLCBib290X2RldnNfIyNuYW1lLCBwZXJtKQorCiBNT0RVTEVfQVVUSE9SKCJKYXJvc2xhdiBL
eXNlbGEgPHBlcmV4QHN1c2UuY3o+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIkludGVsIDgyODAx
QUEsODI5MDFBQixpODEwLGk4MjAsaTgzMCxpODQwLGk4NDUsTVg0NDA7IFNpUyA3MDEyOyBBbGkg
NTQ1NSIpOwogTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwpkaWZmIC11ck4gbGludXgta2VybmVsLm9y
Zy0yL3NvdW5kL3BjaS92aWE4Mnh4LmMgbGludXgta2VybmVsLm9yZy0zL3NvdW5kL3BjaS92aWE4
Mnh4LmMKLS0tIGxpbnV4LWtlcm5lbC5vcmctMi9zb3VuZC9wY2kvdmlhODJ4eC5jCTIwMDQtMTEt
MDkgMTA6NDM6MzYuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC1rZXJuZWwub3JnLTMvc291bmQv
cGNpL3ZpYTgyeHguYwkyMDA0LTExLTE5IDEzOjIzOjU3LjYxMzMxMzk2OCAtMDcwMApAQCAtNjQs
NiArNjQsMTEgQEAKICNkZWZpbmUgUE9JTlRFUl9ERUJVRwogI2VuZGlmCiAKKyN1bmRlZiBtb2R1
bGVfcGFyYW1fYXJyYXkKKyNkZWZpbmUgbW9kdWxlX3BhcmFtX2FycmF5KG5hbWUsIHR5cGUsIG51
bXAsIHBlcm0pIFwKKyAgICAgICAgc3RhdGljIGludCBib290X2RldnNfIyNuYW1lOyBcCisgICAg
ICAgIG1vZHVsZV9wYXJhbV9hcnJheV9uYW1lZChuYW1lLCBuYW1lLCB0eXBlLCBib290X2RldnNf
IyNuYW1lLCBwZXJtKQorCiBNT0RVTEVfQVVUSE9SKCJKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHN1
c2UuY3o+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIlZJQSBWVDgyeHggYXVkaW8iKTsKIE1PRFVM
RV9MSUNFTlNFKCJHUEwiKTsK

------_=_NextPart_001_01C4CE79.B2D1DC2F--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
