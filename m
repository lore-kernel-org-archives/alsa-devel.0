From: Kailang <kailang@realtek.com>
Subject: Change Dell headset mode rule
Date: Wed, 22 May 2019 08:45:35 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D766C08@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1D766C08RTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52A8DF80C20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 10:45:41 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766C08RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

In Dell headset mode, it will recheck during runtime resume when headset wa=
s plugged.
This patch will move check headset type on unplug and system resume.
Many Thanks.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766C08RTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0000-fix-check-headset-type.patch"
Content-Description: 0000-fix-check-headset-type.patch
Content-Disposition: attachment;
	filename="0000-fix-check-headset-type.patch"; size=1904;
	creation-date="Thu, 16 May 2019 08:20:13 GMT";
	modification-date="Wed, 22 May 2019 08:45:03 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNTBhMDllNDJiYmQzZTRkMzJhYmFiMjlhZmFiZmE3NGJkNzczMGI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgMTYgTWF5IDIwMTkgMTY6MTA6NDQgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIENoZWNrIGhlYWRzZXQgdHlwZSBieSB1bnBsdWcgYW5kIHJlc3VtZQoK
V2hlbiBzeXN0ZW0gZW5hYmxlIEhEQSBwb3dlciBzYXZlIG1vZGUuClRoaXMgaXNzdWUgd2lsbCBo
YXBwZW4gb24gbmV3IHBsYXRmb3JtIHdoaWNoIERNSUMgY29ubmVjdCB0byBQQ0guCkluIERlbGwg
aGVhZHNldCBtb2RlLCBpdCB3aWxsIHJlY2hlY2sgZHVyaW5nIHJ1bnRpbWUgcmVzdW1lIHdoZW4g
aGVhZHNldCB3YXMgcGx1Z2dlZC4KVGhpcyBwYXRjaCB3aWxsIG1vdmUgY2hlY2sgaGVhZHNldCB0
eXBlIG9uIHVucGx1ZyBhbmQgc3lzdGVtIHJlc3VtZS4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcg
WWFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IGY4M2Yy
MWQ2NGRkNC4uNDUwOGFiODM4YjcxIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtNDkwMSw2ICs0
OTAxLDggQEAgc3RhdGljIHZvaWQgYWxjX3VwZGF0ZV9oZWFkc2V0X21vZGUoc3RydWN0IGhkYV9j
b2RlYyAqY29kZWMpCiAJc3dpdGNoIChuZXdfaGVhZHNldF9tb2RlKSB7CiAJY2FzZSBBTENfSEVB
RFNFVF9NT0RFX1VOUExVR0dFRDoKIAkJYWxjX2hlYWRzZXRfbW9kZV91bnBsdWdnZWQoY29kZWMp
OworCQlzcGVjLT5jdXJyZW50X2hlYWRzZXRfbW9kZSA9IEFMQ19IRUFEU0VUX01PREVfVU5LTk9X
TjsKKwkJc3BlYy0+Y3VycmVudF9oZWFkc2V0X3R5cGUgPSBBTENfSEVBRFNFVF9UWVBFX1VOS05P
V047CiAJCXNwZWMtPmdlbi5ocF9qYWNrX3ByZXNlbnQgPSBmYWxzZTsKIAkJYnJlYWs7CiAJY2Fz
ZSBBTENfSEVBRFNFVF9NT0RFX0hFQURTRVQ6CkBAIC00OTQzLDggKzQ5NDUsNiBAQCBzdGF0aWMg
dm9pZCBhbGNfdXBkYXRlX2hlYWRzZXRfbW9kZV9ob29rKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVj
LAogc3RhdGljIHZvaWQgYWxjX3VwZGF0ZV9oZWFkc2V0X2phY2tfY2Ioc3RydWN0IGhkYV9jb2Rl
YyAqY29kZWMsCiAJCQkJICAgICAgIHN0cnVjdCBoZGFfamFja19jYWxsYmFjayAqamFjaykKIHsK
LQlzdHJ1Y3QgYWxjX3NwZWMgKnNwZWMgPSBjb2RlYy0+c3BlYzsKLQlzcGVjLT5jdXJyZW50X2hl
YWRzZXRfdHlwZSA9IEFMQ19IRUFEU0VUX1RZUEVfVU5LTk9XTjsKIAlzbmRfaGRhX2dlbl9ocF9h
dXRvbXV0ZShjb2RlYywgamFjayk7CiB9CiAKQEAgLTQ5ODEsNyArNDk4MSwxMSBAQCBzdGF0aWMg
dm9pZCBhbGNfZml4dXBfaGVhZHNldF9tb2RlKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLAogCQlh
bGNfcHJvYmVfaGVhZHNldF9tb2RlKGNvZGVjKTsKIAkJYnJlYWs7CiAJY2FzZSBIREFfRklYVVBf
QUNUX0lOSVQ6Ci0JCXNwZWMtPmN1cnJlbnRfaGVhZHNldF9tb2RlID0gMDsKKwkJaWYgKGNvZGVj
LT5jb3JlLmRldi5wb3dlci5wb3dlcl9zdGF0ZS5ldmVudCA9PSBQTV9FVkVOVF9SRVNVTUUgfHwK
KwkJCQljb2RlYy0+Y29yZS5kZXYucG93ZXIucG93ZXJfc3RhdGUuZXZlbnQgPT0gUE1fRVZFTlRf
UkVTVE9SRSkgeworCQkJc3BlYy0+Y3VycmVudF9oZWFkc2V0X21vZGUgPSAwOworCQkJc3BlYy0+
Y3VycmVudF9oZWFkc2V0X3R5cGUgPSAwOworCQl9CiAJCWFsY191cGRhdGVfaGVhZHNldF9tb2Rl
KGNvZGVjKTsKIAkJYnJlYWs7CiAJfQo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766C08RTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1D766C08RTITMBSVM07real_--
