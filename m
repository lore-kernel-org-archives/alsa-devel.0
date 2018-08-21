From: Kailang <kailang@realtek.com>
Subject: Patch for HP workstation
Date: Tue, 21 Aug 2018 08:59:06 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1841B34F@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_002_6FAB7C47BCF00940BB0999A99BE3547A1841B34FRTITMBSV02realt_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 370C9267663
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 10:59:15 +0200 (CEST)
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
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_6FAB7C47BCF00940BB0999A99BE3547A1841B34FRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

Attach patch was fixed for Headset Mic can't recording.

BR,
Kailang
=20

--_002_6FAB7C47BCF00940BB0999A99BE3547A1841B34FRTITMBSV02realt_
Content-Type: application/octet-stream; name="0002-HP-headset-mic.patch"
Content-Description: 0002-HP-headset-mic.patch
Content-Disposition: attachment; filename="0002-HP-headset-mic.patch";
	size=1690; creation-date="Tue, 21 Aug 2018 08:56:26 GMT";
	modification-date="Tue, 21 Aug 2018 08:55:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkZGUzYmI0NWM5NTY2MDkwYzA0NTZlMTk3YzQ0MTI3ODcyYzVmZWY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlsYW5nIFlhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+CkRh
dGU6IFR1ZSwgMjEgQXVnIDIwMTggMTY6NTQ6NDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBoZGEvcmVhbHRlayAtIEZpeCBIUCBIZWFkc2V0IE1pYyBjYW4ndCByZWNvcmQKClRoaXMgcGF0
Y2ggd2lsbCBmaXggSFAgd29ya3N0YXRpb24gSGVhZHNldCBNaWMgbm90IHJlY29yZGluZy4KClNp
Z25lZC1vZmYtYnk6IEthaWxhbmcgWWFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4KCmRpZmYgLS1n
aXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hf
cmVhbHRlay5jCmluZGV4IGIyMDk3NGUuLjFkMTE3ZjAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBA
IC01NDk0LDYgKzU0OTQsNyBAQCBlbnVtIHsKIAlBTEMyNTVfRklYVVBfRFVNTVlfTElORU9VVF9W
RVJCLAogCUFMQzI1NV9GSVhVUF9ERUxMX0hFQURTRVRfTUlDLAogCUFMQzI5NV9GSVhVUF9IUF9Y
MzYwLAorCUFMQzIyMV9GSVhVUF9IUF9IRUFEU0VUX01JQywKIH07CiAKIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaGRhX2ZpeHVwIGFsYzI2OV9maXh1cHNbXSA9IHsKQEAgLTYzNTEsNyArNjM1MiwxNiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBzW10gPSB7CiAJCS52
LmZ1bmMgPSBhbGMyOTVfZml4dXBfaHBfdG9wX3NwZWFrZXJzLAogCQkuY2hhaW5lZCA9IHRydWUs
CiAJCS5jaGFpbl9pZCA9IEFMQzI2OV9GSVhVUF9IUF9NVVRFX0xFRF9NSUMzCi0JfQorCX0sCisJ
W0FMQzIyMV9GSVhVUF9IUF9IRUFEU0VUX01JQ10gPSB7CisJCS50eXBlID0gSERBX0ZJWFVQX1BJ
TlMsCisJCS52LnBpbnMgPSAoY29uc3Qgc3RydWN0IGhkYV9waW50YmxbXSkgeworCQkJeyAweDE5
LCAweDAxODEzMTNmfSwKKwkJCXsgfQorCQl9LAorCQkuY2hhaW5lZCA9IHRydWUsCisJCS5jaGFp
bl9pZCA9IEFMQzI2OV9GSVhVUF9IRUFEU0VUX01JQworCX0sCiB9OwogCiBzdGF0aWMgY29uc3Qg
c3RydWN0IHNuZF9wY2lfcXVpcmsgYWxjMjY5X2ZpeHVwX3RibFtdID0gewpAQCAtNjc3Nyw2ICs2
Nzg3LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaGRhX21vZGVsX2ZpeHVwIGFsYzI2OV9maXh1
cF9tb2RlbHNbXSA9IHsKIAl7MHgyMSwgMHgwMzIxMTAyMH0KIAogc3RhdGljIGNvbnN0IHN0cnVj
dCBzbmRfaGRhX3Bpbl9xdWlyayBhbGMyNjlfcGluX2ZpeHVwX3RibFtdID0geworCVNORF9IREFf
UElOX1FVSVJLKDB4MTBlYzAyMjEsIDB4MTAzYywgIkhQIFdvcmtzdGF0aW9uIiwgQUxDMjIxX0ZJ
WFVQX0hQX0hFQURTRVRfTUlDLAorCQl7MHgxNCwgMHgwMTAxNDAyMH0sCisJCXsweDE3LCAweDkw
MTcwMTEwfSwKKwkJezB4MTgsIDB4MDJhMTEwMzB9LAorCQl7MHgxOSwgMHgwMTgxMzAzRn0sCisJ
CXsweDIxLCAweDAyMjExMDJmfSksCiAJU05EX0hEQV9QSU5fUVVJUksoMHgxMGVjMDI1NSwgMHgx
MDI1LCAiQWNlciIsIEFMQzI1NV9GSVhVUF9BQ0VSX01JQ19OT19QUkVTRU5DRSwKIAkJezB4MTIs
IDB4OTBhNjAxYzB9LAogCQl7MHgxNCwgMHg5MDE3MTEyMH0sCg==

--_002_6FAB7C47BCF00940BB0999A99BE3547A1841B34FRTITMBSV02realt_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_002_6FAB7C47BCF00940BB0999A99BE3547A1841B34FRTITMBSV02realt_--
