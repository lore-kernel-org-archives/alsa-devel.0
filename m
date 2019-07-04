From: Kailang <kailang@realtek.com>
Subject: Dell Headphone Mic can't record after S3
Date: Thu, 4 Jul 2019 08:49:18 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D76878B@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1D76878BRTITMBSVM07real_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D21D9F800E7
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2019 10:49:24 +0200 (CEST)
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

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76878BRTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Headphone Mic can't record after S3 on Dell headset mode platform.
The S3 mode was deep. S2idle didn't have this issue.

BR,
Kailang

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76878BRTITMBSVM07real_
Content-Type: application/octet-stream;
	name="0000-fix-hp-mic-recording-fail.patch"
Content-Description: 0000-fix-hp-mic-recording-fail.patch
Content-Disposition: attachment;
	filename="0000-fix-hp-mic-recording-fail.patch"; size=1544;
	creation-date="Thu, 04 Jul 2019 08:09:23 GMT";
	modification-date="Thu, 04 Jul 2019 08:11:36 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhODIwY2YzN2U0ZjBiNDhmYjZhMzRjYjJmZjFhNWY2YTRhN2MzOTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFRodSwgNCBKdWwgMjAxOSAxNjowMjoxMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGhkYS9yZWFsdGVrIC0gSGVhZHBob25lIE1pYyBjYW4ndCByZWNvcmQgYWZ0ZXIgUzMKCkRlbGwg
aGVhZHNldCBtb2RlIHBsYXRmb3JtIHdpdGggQUxDMjM2LgpJdCBkb2Vzbid0IHJlY29yZGluZyBh
ZnRlciBzeXN0ZW0gcmVzdW1lIGZyb20gUzMuClMzIG1vZGUgd2FzIGRlZXAuIHMyaWRsZSB3YXMg
bm90IGhhcyB0aGlzIGlzc3VlLgpTMyBkZWVwIHdpbGwgY3V0IG9mIGNvZGVjIHBvd2VyLiBTbywg
dGhlIHJlZ2lzdGVyIHdpbGwgYmFjayB0byBkZWZhdWx0IGFmdGVyIHJlc3VtZSBiYWNrLgpUaGlz
IHBhdGNoIHdpbGwgc29sdmUgdGhpcyBpc3N1ZS4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFu
ZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNo
X3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDQ4ZjNjNWI4
ZDZlOS4uMGY3NzY0NDRhYjg2IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0
ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAtMzI2OCw2ICszMjY4
LDcgQEAgc3RhdGljIHZvaWQgYWxjMjU2X2luaXQoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMpCiAJ
YWxjX3VwZGF0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDU3LCAweDA0LCAweDAwMDcsIDB4NCk7IC8q
IEhpZ2h0IHBvd2VyICovCiAJYWxjX3VwZGF0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDUzLCAweDAy
LCAweDgwMDAsIDEgPDwgMTUpOyAvKiBDbGVhciBiaXQgKi8KIAlhbGNfdXBkYXRlX2NvZWZleF9p
ZHgoY29kZWMsIDB4NTMsIDB4MDIsIDB4ODAwMCwgMCA8PCAxNSk7CisJYWxjX3VwZGF0ZV9jb2Vm
X2lkeChjb2RlYywgMHgzNiwgMSA8PCAxMywgMSA8PCA1KTsgLyogU3dpdGNoIHBjYmVlcCBwYXRo
IHRvIExpbmUgaW4gcGF0aCovCiB9CiAKIHN0YXRpYyB2b2lkIGFsYzI1Nl9zaHV0dXAoc3RydWN0
IGhkYV9jb2RlYyAqY29kZWMpCkBAIC03ODM4LDcgKzc4MzksNiBAQCBzdGF0aWMgaW50IHBhdGNo
X2FsYzI2OShzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAkJc3BlYy0+c2h1dHVwID0gYWxjMjU2
X3NodXR1cDsKIAkJc3BlYy0+aW5pdF9ob29rID0gYWxjMjU2X2luaXQ7CiAJCXNwZWMtPmdlbi5t
aXhlcl9uaWQgPSAwOyAvKiBBTEMyNTYgZG9lcyBub3QgaGF2ZSBhbnkgbG9vcGJhY2sgbWl4ZXIg
cGF0aCAqLwotCQlhbGNfdXBkYXRlX2NvZWZfaWR4KGNvZGVjLCAweDM2LCAxIDw8IDEzLCAxIDw8
IDUpOyAvKiBTd2l0Y2ggcGNiZWVwIHBhdGggdG8gTGluZSBpbiBwYXRoKi8KIAkJYnJlYWs7CiAJ
Y2FzZSAweDEwZWMwMjU3OgogCQlzcGVjLT5jb2RlY192YXJpYW50ID0gQUxDMjY5X1RZUEVfQUxD
MjU3Owo=

--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76878BRTITMBSVM07real_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1D76878BRTITMBSVM07real_--
