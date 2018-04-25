From: Kailang <kailang@realtek.com>
Subject: Fix ALC233 default init
Date: Wed, 25 Apr 2018 07:56:28 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184124BC@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A184124BCRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 92AF6267035
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 09:56:38 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A184124BCRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,
=20
Attach patch was for fix ALC233 for default initial.

BR,
Kailang=

--_002_6FAB7C47BCF00940BB0999A99BE3547A184124BCRTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-alc233-additional-support.patch"
Content-Description: 0000-alc233-additional-support.patch
Content-Disposition: attachment;
	filename="0000-alc233-additional-support.patch"; size=1057;
	creation-date="Wed, 25 Apr 2018 07:53:04 GMT";
	modification-date="Wed, 25 Apr 2018 07:39:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMjExMDZmODM2MTNmYmU1NWQ0NjI0MTY0MjM1MmQ4OTdiOWMxY2Y4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMjUgQXByIDIwMTggMTU6MzE6NTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEFkZCBzb21lIGZpeGVzIGZvciBBTEMyMzMKCkZpbGwgQ09FRiB0byBj
aGFuZ2UgRUFQRCB0byB2ZXJiIGNvbnRyb2wuCkFzc2lnbmVkIGNvZGVjIHR5cGUuCgpBZGRpdGlv
bmFsOiA5MmY5NzRkZjM0NjAxMzE2MDQ4MTMyNGMzOTg1MWU3ZWE5Y2U0ODJhICgiQUxTQTogaGRh
L3JlYWx0ZWsgLSBOZXcgdmVuZG9yIElEIGZvciBBTEMyMzMiKQpTaWduZWQtb2ZmLWJ5OiBLYWls
YW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwppbmRleCBj
MGM0MDQzLi4yMDg2OTQ5IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMzMxLDYgKzMzMSw3IEBA
IHN0YXRpYyB2b2lkIGFsY19maWxsX2VhcGRfY29lZihzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykK
IAkJLyogZmFsbHRocm91Z2ggKi8KIAljYXNlIDB4MTBlYzAyMTU6CiAJY2FzZSAweDEwZWMwMjMz
OgorCWNhc2UgMHgxMGVjMDIzNToKIAljYXNlIDB4MTBlYzAyMzY6CiAJY2FzZSAweDEwZWMwMjU1
OgogCWNhc2UgMHgxMGVjMDI1NjoKQEAgLTcxNjAsNiArNzE2MSw3IEBAIHN0YXRpYyBpbnQgcGF0
Y2hfYWxjMjY5KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCWNhc2UgMHgxMGVjMDI5ODoKIAkJ
c3BlYy0+Y29kZWNfdmFyaWFudCA9IEFMQzI2OV9UWVBFX0FMQzI5ODsKIAkJYnJlYWs7CisJY2Fz
ZSAweDEwZWMwMjM1OgogCWNhc2UgMHgxMGVjMDI1NToKIAkJc3BlYy0+Y29kZWNfdmFyaWFudCA9
IEFMQzI2OV9UWVBFX0FMQzI1NTsKIAkJYnJlYWs7Cg==

--_002_6FAB7C47BCF00940BB0999A99BE3547A184124BCRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A184124BCRTITMBSV02realt_--
