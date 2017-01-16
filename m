From: Kailang <kailang@realtek.com>
Subject: Add support for ALC1220 codec
Date: Mon, 16 Jan 2017 09:04:16 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A4BBBB@RTITMBSV09.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_6FAB7C47BCF00940BB0999A99BE3547A17A4BBBBRTITMBSV09realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B675266539
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 10:04:22 +0100 (CET)
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

--_004_6FAB7C47BCF00940BB0999A99BE3547A17A4BBBBRTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch is support new codec of ALC1220.

Many Thanks,
Kailang

--_004_6FAB7C47BCF00940BB0999A99BE3547A17A4BBBBRTITMBSV09realt_
Content-Type: application/octet-stream;
	name="0000-add-support-for-ALC1220.patch"
Content-Description: 0000-add-support-for-ALC1220.patch
Content-Disposition: attachment;
	filename="0000-add-support-for-ALC1220.patch"; size=1253;
	creation-date="Mon, 16 Jan 2017 09:02:06 GMT";
	modification-date="Mon, 16 Jan 2017 09:01:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3YWJmMTU1NDdmMGJmMzNiM2EwNTg3MTNjMTAyNjIxNTY2NTJkMmEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IE1vbiwgMTYgSmFuIDIwMTcgMTY6NTk6MjYgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIE5ldyBjb2RlYyBzdXBwb3J0IG9mIEFMQzEyMjAKCkFkZCBzdXBwb3J0
IGZvciBuZXcgY29kZWMgb2YgQUxDMTIyMC4KClNpZ25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8
a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmluZGV4IDdjMzVkZjcuLjVm
NDZhZDIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIC0zODAsNiArMzgwLDcgQEAgc3RhdGljIHZv
aWQgYWxjX2ZpbGxfZWFwZF9jb2VmKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogCQlicmVhazsK
IAljYXNlIDB4MTBlYzA4OTk6CiAJY2FzZSAweDEwZWMwOTAwOgorCWNhc2UgMHgxMGVjMTIyMDoK
IAkJYWxjX3VwZGF0ZV9jb2VmX2lkeChjb2RlYywgMHg3LCAxPDwxLCAwKTsKIAkJYnJlYWs7CiAJ
fQpAQCAtMjMxMSw2ICsyMzEyLDcgQEAgc3RhdGljIGludCBwYXRjaF9hbGM4ODIoc3RydWN0IGhk
YV9jb2RlYyAqY29kZWMpCiAJY2FzZSAweDEwZWMwODgyOgogCWNhc2UgMHgxMGVjMDg4NToKIAlj
YXNlIDB4MTBlYzA5MDA6CisJY2FzZSAweDEwZWMxMjIwOgogCQlicmVhazsKIAlkZWZhdWx0Ogog
CQkvKiBBTEM4ODMgYW5kIHZhcmlhbnRzICovCkBAIC03Mjk5LDYgKzczMDEsNyBAQCBzdGF0aWMg
aW50IHBhdGNoX2FsYzY4MChzdHJ1Y3QgaGRhX2NvZGVjICpjb2RlYykKIAlIREFfQ09ERUNfRU5U
UlkoMHgxMGVjMDg5MiwgIkFMQzg5MiIsIHBhdGNoX2FsYzY2MiksCiAJSERBX0NPREVDX0VOVFJZ
KDB4MTBlYzA4OTksICJBTEM4OTgiLCBwYXRjaF9hbGM4ODIpLAogCUhEQV9DT0RFQ19FTlRSWSgw
eDEwZWMwOTAwLCAiQUxDMTE1MCIsIHBhdGNoX2FsYzg4MiksCisJSERBX0NPREVDX0VOVFJZKDB4
MTBlYzEyMjAsICJBTEMxMjIwIiwgcGF0Y2hfYWxjODgyKSwKIAl7fSAvKiB0ZXJtaW5hdG9yICov
CiB9OwogTU9EVUxFX0RFVklDRV9UQUJMRShoZGF1ZGlvLCBzbmRfaGRhX2lkX3JlYWx0ZWspOwo=

--_004_6FAB7C47BCF00940BB0999A99BE3547A17A4BBBBRTITMBSV09realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_004_6FAB7C47BCF00940BB0999A99BE3547A17A4BBBBRTITMBSV09realt_--
