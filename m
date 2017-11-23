From: Jens Verwiebe <info@jensverwiebe.de>
Subject: Re: Focusrite Scarlett 6i6 gen1 - input handling fix
Date: Thu, 23 Nov 2017 16:04:59 +0100
Message-ID: <5a1a63fe-10dd-3022-5932-dc933130125e@jensverwiebe.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------9B1F167BE70A78E170601497"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C8B3266B02
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 16:05:01 +0100 (CET)
Received: from [192.168.178.21] ([85.179.205.209]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0M7PiZ-1f2ikN37zD-00xJRg for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017
 16:05:00 +0100
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------9B1F167BE70A78E170601497
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Dammit, sorry, i better add the patch as textfile (?) Formatting looks 
good here, but ml shows spaces where i expect tabs.

New try:



The Scarlett 6i6 has no padding on rear inputs 3/4 but a gainstage 
(Low/Hi). Adding this functionality

Signed-off-by: Jens Verwiebe <info at jensverwiebe.de>

1 file changed, 21 insertions(+), 2 deletions(-)

-- 

Jens Verwiebe
Allerskehre 44 - 22309 Hamburg

Tel.: +49 40 68 78 50
mobile: +49 172 400 49 07
mailto: info@jensverwiebe.de
web: http://www.jensverwiebe.de


--------------9B1F167BE70A78E170601497
Content-Type: text/plain; charset=UTF-8;
 name="scarlett6i6rev1_gain.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="scarlett6i6rev1_gain.txt"

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlcl9zY2FybGV0dC5jIGIvc291bmQvdXNiL21p
eGVyX3NjYXJsZXR0LmMKaW5kZXggNzQzOGU3Yy4uMmM4NmQ1OTUgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3VzYi9taXhlcl9zY2FybGV0dC5jCisrKyBiL3NvdW5kL3VzYi9taXhlcl9zY2FybGV0
dC5jCkBAIC0xNTIsNiArMTUyLDcgQEAgZW51bSB7CiAJU0NBUkxFVFRfT1VUUFVUUywKIAlT
Q0FSTEVUVF9TV0lUQ0hfSU1QRURBTkNFLAogCVNDQVJMRVRUX1NXSVRDSF9QQUQsCisJU0NB
UkxFVFRfU1dJVENIX0dBSU4sCiB9OwogCiBlbnVtIHsKQEAgLTIwMiw2ICsyMDMsMTUgQEAg
c3RydWN0IHNjYXJsZXR0X2RldmljZV9pbmZvIHsKIAl9CiB9OwogCitzdGF0aWMgY29uc3Qg
c3RydWN0IHNjYXJsZXR0X21peGVyX2VsZW1fZW51bV9pbmZvIG9wdF9nYWluID0geworCS5z
dGFydCA9IDAsCisJLmxlbiA9IDIsCisJLm9mZnNldHMgPSB7fSwKKwkubmFtZXMgPSAoY2hh
ciBjb25zdCAqIGNvbnN0IFtdKXsKKwkJIkxvIiwgIkhpIgorCX0KK307CisKIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc2NhcmxldHRfbWl4ZXJfZWxlbV9lbnVtX2luZm8gb3B0X2ltcGVkYW5j
ZSA9IHsKIAkuc3RhcnQgPSAwLAogCS5sZW4gPSAyLApAQCAtNjY0LDggKzY3NCw4IEBAIHN0
YXRpYyBpbnQgYWRkX291dHB1dF9jdGxzKHN0cnVjdCB1c2JfbWl4ZXJfaW50ZXJmYWNlICpt
aXhlciwKIAkJeyAubnVtID0gMSwgLnR5cGUgPSBTQ0FSTEVUVF9TV0lUQ0hfUEFELCAubmFt
ZSA9IE5VTEx9LAogCQl7IC5udW0gPSAyLCAudHlwZSA9IFNDQVJMRVRUX1NXSVRDSF9JTVBF
REFOQ0UsIC5uYW1lID0gTlVMTH0sCiAJCXsgLm51bSA9IDIsIC50eXBlID0gU0NBUkxFVFRf
U1dJVENIX1BBRCwgLm5hbWUgPSBOVUxMfSwKLQkJeyAubnVtID0gMywgLnR5cGUgPSBTQ0FS
TEVUVF9TV0lUQ0hfUEFELCAubmFtZSA9IE5VTEx9LAotCQl7IC5udW0gPSA0LCAudHlwZSA9
IFNDQVJMRVRUX1NXSVRDSF9QQUQsIC5uYW1lID0gTlVMTH0sCisJCXsgLm51bSA9IDMsIC50
eXBlID0gU0NBUkxFVFRfU1dJVENIX0dBSU4sIC5uYW1lID0gTlVMTH0sCisJCXsgLm51bSA9
IDQsIC50eXBlID0gU0NBUkxFVFRfU1dJVENIX0dBSU4sIC5uYW1lID0gTlVMTH0sCiAJfSwK
IAogCS5tYXRyaXhfbXV4X2luaXQgPSB7CkBAIC04OTUsNiArOTA1LDE1IEBAIHN0YXRpYyBp
bnQgc2NhcmxldHRfY29udHJvbHNfY3JlYXRlX2dlbmVyaWMoc3RydWN0IHVzYl9taXhlcl9p
bnRlcmZhY2UgKm1peGVyLAogCQkJaWYgKGVyciA8IDApCiAJCQkJcmV0dXJuIGVycjsKIAkJ
CWJyZWFrOworCQljYXNlIFNDQVJMRVRUX1NXSVRDSF9HQUlOOgorCQkJc3ByaW50ZihteCwg
IklucHV0ICVkIEdhaW4gU3dpdGNoIiwgY3RsLT5udW0pOworCQkJZXJyID0gYWRkX25ld19j
dGwobWl4ZXIsICZ1c2Jfc2NhcmxldHRfY3RsX2VudW0sCisJCQkJCSAgc2NhcmxldHRfY3Rs
X2VudW1fcmVzdW1lLCAweDAxLAorCQkJCQkgIDB4MDgsIGN0bC0+bnVtLCBVU0JfTUlYRVJf
UzE2LCAxLCBteCwKKwkJCQkJICAmb3B0X2dhaW4sICZlbGVtKTsKKwkJCWlmIChlcnIgPCAw
KQorCQkJCXJldHVybiBlcnI7CisJCQlicmVhazsKIAkJfQogCX0KIAo=
--------------9B1F167BE70A78E170601497
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------9B1F167BE70A78E170601497--
