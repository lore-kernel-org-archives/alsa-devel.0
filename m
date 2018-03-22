From: Kailang <kailang@realtek.com>
Subject: [ThinkPad] speaker no sound after system resume
Date: Thu, 22 Mar 2018 08:25:07 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18410669@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A18410669RTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E32C267396
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 09:25:14 +0100 (CET)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A18410669RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,
=20
Attach patch will fix ThinkPad T580 family for resume issue.
=20
It will have a chance speaker no sound after system resume.
To toggle NID 0x53 index 0x2 bit 15 will solve this issue.
This usage will also suitable with ALC256.
=20
This patch also tested by Ubuntu QA.
Many Thanks.
=20
BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A18410669RTITMBSV02realt_
Content-Type: application/octet-stream;
	name="0000-lenovo-spk-no-sound.patch"
Content-Description: 0000-lenovo-spk-no-sound.patch
Content-Disposition: attachment; filename="0000-lenovo-spk-no-sound.patch";
	size=1280; creation-date="Wed, 14 Mar 2018 08:15:56 GMT";
	modification-date="Thu, 22 Mar 2018 08:14:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwNjg5ZDc5ZDk2NjkwYmMzNDc1YWYzNGNmYjI1MTJmNjcxNTZlY2IzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFdlZCwgMTQgTWFyIDIwMTggMTY6MDg6NTcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeCBzcGVha2VyIG5vIHNvdW5kIGFmdGVyIHN5c3RlbSByZXN1bWUK
Ckl0IHdpbGwgaGF2ZSBhIGNoYW5jZSBzcGVha2VyIG5vIHNvdW5kIGFmdGVyIHN5c3RlbSByZXN1
bWUuClRvIHRvZ2dsZSBOSUQgMHg1MyBpbmRleCAweDIgYml0IDE1IHdpbGwgc29sdmUgdGhpcyBp
c3N1ZS4KVGhpcyB1c2FnZSB3aWxsIGFsc28gc3VpdGFibGUgd2l0aCBBTEMyNTYuCgpTaWduZWQt
b2ZmLWJ5OiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CgpkaWZmIC0tZ2l0IGEv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYwppbmRleCA5YWYzMDFjLi5lOWI1MTczIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMzEz
MCw2ICszMTMwLDggQEAgc3RhdGljIHZvaWQgYWxjMjU2X2luaXQoc3RydWN0IGhkYV9jb2RlYyAq
Y29kZWMpCiAKIAlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDQ2LCAzIDw8IDEyLCAwKTsK
IAlhbGNfdXBkYXRlX2NvZWZleF9pZHgoY29kZWMsIDB4NTcsIDB4MDQsIDB4MDAwNywgMHg0KTsg
LyogSGlnaHQgcG93ZXIgKi8KKwlhbGNfdXBkYXRlX2NvZWZleF9pZHgoY29kZWMsIDB4NTMsIDB4
MDIsIDB4ODAwMCwgMSA8PCAxNSk7IC8qIENsZWFyIGJpdCAqLworCWFsY191cGRhdGVfY29lZmV4
X2lkeChjb2RlYywgMHg1MywgMHgwMiwgMHg4MDAwLCAwIDw8IDE1KTsKIH0KIAogc3RhdGljIHZv
aWQgYWxjMjU2X3NodXR1cChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKQEAgLTcxNTQsNiArNzE1
Niw4IEBAIHN0YXRpYyBpbnQgcGF0Y2hfYWxjMjY5KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQog
CQlicmVhazsKIAljYXNlIDB4MTBlYzAyNTc6CiAJCXNwZWMtPmNvZGVjX3ZhcmlhbnQgPSBBTEMy
NjlfVFlQRV9BTEMyNTc7CisJCXNwZWMtPnNodXR1cCA9IGFsYzI1Nl9zaHV0dXA7CisJCXNwZWMt
PmluaXRfaG9vayA9IGFsYzI1Nl9pbml0OwogCQlzcGVjLT5nZW4ubWl4ZXJfbmlkID0gMDsKIAkJ
YnJlYWs7CiAJY2FzZSAweDEwZWMwMjE1Ogo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A18410669RTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A18410669RTITMBSV02realt_--
