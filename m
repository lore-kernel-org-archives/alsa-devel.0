From: =?UTF-8?Q?Micha=c5=82_Wadowski?= <wadosm@gmail.com>
Subject: Re: [PATCH] Fix for Lenovo B50-70 inverted internal
 microphone bug.
Date: Tue, 14 May 2019 16:58:00 +0200
Message-ID: <50fba461-b791-bfa4-34f9-52cb3d839c71@gmail.com>
References: <158b63b9-ff73-7f53-de83-5a7b8a21b250@gmail.com>
 <s5h4l5xrxxm.wl-tiwai@suse.de>
 <de267744-b620-ff52-4bbc-696bc74aa789@gmail.com>
 <s5hlfz9qf9u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55479F806E5
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2019 16:58:03 +0200 (CEST)
Received: by mail-lf1-x142.google.com with SMTP id y10so12153989lfl.3
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2019 07:58:03 -0700 (PDT)
In-Reply-To: <s5hlfz9qf9u.wl-tiwai@suse.de>
Content-Language: pl-PL
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QWRkIHBhdGNoIGZvciByZWFsdGVrIGNvZGVjIGluIExlbm92byBCNTAtNzAgdGhhdCBmaXhlcyBp
bnZlcnRlZCBpbnRlcm5hbCBtaWNyb3Bob25lIGNoYW5uZWwuCkRldmljZSBJZGVhUGFkIFk0MTBQ
IGhhcyB0aGUgc2FtZSBQQ0kgU1NJRCBhcyBMZW5vdm8gQjUwLTcwLApidXQgZmlyc3Qgb25lIGlz
IGFib3V0IGZpeCB0aGUgbm9pc2UgYW5kIGl0IGRpZG4ndCBzZWVtIGhlbHAgaW4gYSBsYXRlciBr
ZXJuZWwgdmVyc2lvbi4KU28gSSByZXBsYWNlZCBJZGVhUGFkIFk0MTBQIGRldmljZSBkZXNjcmlw
dGlvbiB3aXRoIEI1MC03MCBhbmQgYXBwbHkgaW52ZXJ0ZWQgbWljcm9waG9uZSBmaXguCgpCdWd6
aWxsYTogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvYWxzYS1kcml2
ZXIvK2J1Zy8xNTI0MjE1CgpTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIFdhZG93c2tpIDx3YWRvc21A
Z21haWwuY29tPgotLS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMKaW5kZXggNDJjZDM5NDVlMGRlLi4zNGJjZDcxMWJiNTUgMTAwNjQ0Ci0tLSBhL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVh
bHRlay5jCkBAIC00OTg3LDcgKzQ5ODcsNyBAQCBzdGF0aWMgdm9pZCBhbGNfZml4dXBfaGVhZHNl
dF9tb2RlX2FsYzI1NV9ub19ocF9taWMoc3RydWN0IGhkYV9jb2RlYyAqY29kZWMsCiAJCXN0cnVj
dCBhbGNfc3BlYyAqc3BlYyA9IGNvZGVjLT5zcGVjOwogCQlzcGVjLT5wYXJzZV9mbGFncyB8PSBI
REFfUElOQ0ZHX0hFQURTRVRfTUlDOwogCQlhbGMyNTVfc2V0X2RlZmF1bHRfamFja190eXBlKGNv
ZGVjKTsKLQl9IAorCX0KIAllbHNlCiAJCWFsY19maXh1cF9oZWFkc2V0X21vZGUoY29kZWMsIGZp
eCwgYWN0aW9uKTsKIH0KQEAgLTY5NzUsNyArNjk3NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
c25kX3BjaV9xdWlyayBhbGMyNjlfZml4dXBfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDE3
YWEsIDB4MzEzYywgIlRoaW5rQ2VudHJlIFN0YXRpb24iLCBBTEMyOTRfRklYVVBfTEVOT1ZPX01J
Q19MT0NBVElPTiksCiAJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4MzkwMiwgIkxlbm92byBFNTAt
ODAiLCBBTEMyNjlfRklYVVBfRE1JQ19USElOS1BBRF9BQ1BJKSwKIAlTTkRfUENJX1FVSVJLKDB4
MTdhYSwgMHgzOTc3LCAiSWRlYVBhZCBTMjEwIiwgQUxDMjgzX0ZJWFVQX0lOVF9NSUMpLAotCVNO
RF9QQ0lfUVVJUksoMHgxN2FhLCAweDM5NzgsICJJZGVhUGFkIFk0MTBQIiwgQUxDMjY5X0ZJWFVQ
X05PX1NIVVRVUCksCisJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4Mzk3OCwgIkxlbm92byBCNTAt
NzAiLCBBTEMyNjlfRklYVVBfRE1JQ19USElOS1BBRF9BQ1BJKSwKIAlTTkRfUENJX1FVSVJLKDB4
MTdhYSwgMHg1MDEzLCAiVGhpbmtwYWQiLCBBTEMyNjlfRklYVVBfTElNSVRfSU5UX01JQ19CT09T
VCksCiAJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4NTAxYSwgIlRoaW5rcGFkIiwgQUxDMjgzX0ZJ
WFVQX0lOVF9NSUMpLAogCVNORF9QQ0lfUVVJUksoMHgxN2FhLCAweDUwMWUsICJUaGlua3BhZCBM
NDQwIiwgQUxDMjkyX0ZJWFVQX1RQVDQ0MF9ET0NLKSwKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
