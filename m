From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: [PATCH 1/6] Alsa support for Maemo SDK (n770): Build
	configuration
Date: Wed, 1 Nov 2006 13:06:40 -0400
Message-ID: <a0580c510611010906p75ffbf7fg552ce795aa762e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_27771_19423160.1162400800107"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, mikko.a.leppanen@nokia.com
List-Id: alsa-devel@alsa-project.org

------=_Part_27771_19423160.1162400800107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch file changes the build configuration files to add alsa-dsp
plugin to communicate
with n770 system.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

diffstat:
 Makefile.am       |    2 +-
 configure.in      |   10 ++++++++++
 maemo/Makefile.am |   15 +++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)


-- 
Eduardo Bezerra Valentin

------=_Part_27771_19423160.1162400800107
Content-Type: text/x-patch; name=maemo-build.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_etzxpu71
Content-Disposition: attachment; filename="maemo-build.patch"

ZGlmZiAtcHJ1TiBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0KLS0tIGEvTWFrZWZpbGUuYW0J
MjAwNi0wOS0xMiAwOTo1MjoyNS4wMDAwMDAwMDAgLTA0MDAKKysrIGIvTWFrZWZpbGUuYW0JMjAw
Ni0xMS0wMSAxMjowMzoxNC4wMDAwMDAwMDAgLTA0MDAKQEAgLTExLDcgKzExLDcgQEAgaWYgSEFW
RV9BVkNPREVDCiBBNTJESVIgPSBhNTIKIGVuZGlmCiAKLVNVQkRJUlMgPSBvc3MgbWl4ICQoSkFD
S0RJUikgJChQVUxTRURJUikgJChTQU1QTEVSQVRFRElSKSAkKEE1MkRJUikgZG9jCitTVUJESVJT
ID0gb3NzIG1peCAkKEpBQ0tESVIpICQoUFVMU0VESVIpICQoU0FNUExFUkFURURJUikgJChBNTJE
SVIpIG1hZW1vIGRvYwogRVhUUkFfRElTVCA9IGhnY29tcGlsZSB2ZXJzaW9uIENPUFlJTkcuR1BM
CiBBVVRPTUFLRV9PUFRJT05TID0gZm9yZWlnbgogCmRpZmYgLXBydU4gYS9jb25maWd1cmUuaW4g
Yi9jb25maWd1cmUuaW4KLS0tIGEvY29uZmlndXJlLmluCTIwMDYtMDktMTIgMDk6NTI6MjUuMDAw
MDAwMDAwIC0wNDAwCisrKyBiL2NvbmZpZ3VyZS5pbgkyMDA2LTExLTAxIDEyOjAzOjIzLjAwMDAw
MDAwMCAtMDQwMApAQCAtMyw2ICszLDggQEAgQUNfSU5JVChvc3MvcGNtX29zcy5jKQogQU1fSU5J
VF9BVVRPTUFLRShhbHNhLXBsdWdpbnMsIDEuMC4xM3JjMikKIEFDX1BSRUZJWF9ERUZBVUxUKC91
c3IpCiAKK0FDX0NPTkZJR19IRUFERVJTKGNvbmZpZy5oKQorCiBBQ19QUk9HX0NDCiBBQ19QUk9H
X0lOU1RBTEwKIEFDX0RJU0FCTEVfU1RBVElDCkBAIC0yMiw2ICsyNCwxMyBAQCBBTV9DT05ESVRJ
T05BTChIQVZFX1BVTFNFLCB0ZXN0IHgkSEFWRV9QCiBQS0dfQ0hFQ0tfTU9EVUxFUyhzYW1wbGVy
YXRlLCBbc2FtcGxlcmF0ZV0sIFtIQVZFX1NBTVBMRVJBVEU9eWVzXSwgW0hBVkVfU0FNUExFUkFU
RT1ub10pCiBBTV9DT05ESVRJT05BTChIQVZFX1NBTVBMRVJBVEUsIHRlc3QgeCRIQVZFX1NBTVBM
RVJBVEUgPSB4eWVzKQogCitQS0dfQ0hFQ0tfTU9EVUxFUyhEQlVTLCBbZGJ1cy0xXSwgW0hBVkVf
REJVUz15ZXNdLCBbSEFWRV9EQlVTPW5vXSkKK0FNX0NPTkRJVElPTkFMKEhBVkVfREJVUywgdGVz
dCB4JEhBVkVfREJVUyA9IHh5ZXMpCisKK2lmIHRlc3QgIiRIQVZFX0RCVVMiID0gInllcyI7IHRo
ZW4KKyAgICAgICAgQUNfREVGSU5FKFVTRV9SRVNPVVJDRV9NQU5BR0VSLCAxLCJVc2UgZGJ1cyBz
ZXJ2ZXIgYXMgYSByZXNvdWNlIG1hbmFnZXIiKQorZmkKKwogQUNfQVJHX1dJVEgoW2F2Y29kZWMt
aW5jbHVkZWRpcl0sCiAJWy0td2l0aC1hdmNvZGVjLWluY2x1ZGVkaXI9ZGlyICAgIEFWY29kZWMg
aW5jbHVkZSBkaXJlY3RvcnldLAogCVtBVkNPREVDX0NGTEFHUz0iLUkkd2l0aHZhbCJdLCBbQVZD
T0RFQ19DRkxBR1M9IiJdKQpAQCAtNTMsNSArNjIsNiBAQCBBQ19PVVRQVVQoWwogCW1peC9NYWtl
ZmlsZQogCXJhdGUvTWFrZWZpbGUKIAlhNTIvTWFrZWZpbGUKKwltYWVtby9NYWtlZmlsZQogCWRv
Yy9NYWtlZmlsZQogXSkKZGlmZiAtcHJ1TiBhL21hZW1vL01ha2VmaWxlLmFtIGIvbWFlbW8vTWFr
ZWZpbGUuYW0KLS0tIGEvbWFlbW8vTWFrZWZpbGUuYW0JMTk2OS0xMi0zMSAyMDowMDowMC4wMDAw
MDAwMDAgLTA0MDAKKysrIGIvbWFlbW8vTWFrZWZpbGUuYW0JMjAwNi0xMS0wMSAxMjowMzoxNC4w
MDAwMDAwMDAgLTA0MDAKQEAgLTAsMCArMSwxNSBAQAorYXNvdW5kX21vZHVsZV9wY21fYWxzYV9k
c3BfTFRMSUJSQVJJRVMgPSBsaWJhc291bmRfbW9kdWxlX3BjbV9hbHNhX2RzcC5sYQorYXNvdW5k
X21vZHVsZV9jdGxfZHNwX2N0bF9MVExJQlJBUklFUyA9IGxpYmFzb3VuZF9tb2R1bGVfY3RsX2Rz
cF9jdGwubGEKKworYXNvdW5kX21vZHVsZV9wY21fYWxzYV9kc3BkaXIgPSAkKGxpYmRpcikvYWxz
YS1saWIKK2Fzb3VuZF9tb2R1bGVfY3RsX2RzcF9jdGxkaXIgPSAkKGxpYmRpcikvYWxzYS1saWIK
KworQU1fQ0ZMQUdTID0gLVdhbGwgLWZQSUMgLURQSUMgLU8yIEBBTFNBX0NGTEFHU0AgJChEQlVT
X0NGTEFHUykKK0FNX0xERkxBR1MgPSAtc2hhcmVkIC1sbSAtbGRsIC1scHRocmVhZCAtbW9kdWxl
IC1hdm9pZC12ZXJzaW9uIC1leHBvcnQtZHluYW1pYyAkKERCVVNfTElCUykKKworbGliYXNvdW5k
X21vZHVsZV9wY21fYWxzYV9kc3BfbGFfU09VUkNFUyA9IGRzcC1wcm90b2NvbC5jIGFsc2EtZHNw
LmMKK2xpYmFzb3VuZF9tb2R1bGVfcGNtX2Fsc2FfZHNwX2xhX0xJQkFERCA9IEBBTFNBX0xJQlNA
CisKK2xpYmFzb3VuZF9tb2R1bGVfY3RsX2RzcF9jdGxfbGFfU09VUkNFUyA9IGRzcC1wcm90b2Nv
bC5jIGRzcC1jdGwuYworbGliYXNvdW5kX21vZHVsZV9jdGxfZHNwX2N0bF9sYV9MSUJBREQgPSBA
QUxTQV9MSUJTQAorCg==
------=_Part_27771_19423160.1162400800107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------=_Part_27771_19423160.1162400800107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_27771_19423160.1162400800107--
