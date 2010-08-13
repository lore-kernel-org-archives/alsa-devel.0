From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: Fix indentiation in S3C DMA
	driver
Date: Fri, 13 Aug 2010 14:38:38 +0900
Message-ID: <AANLkTik=zq9ZL1bN=YcMivTNS8Lu88M9GnaQfC=39DQX@mail.gmail.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1281607342-13127-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5EDCA2447B
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 07:38:38 +0200 (CEST)
Received: by fxm11 with SMTP id 11so1369941fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 22:38:38 -0700 (PDT)
In-Reply-To: <1281607342-13127-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Seungwhan Youn <sw.youn@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBdWcgMTIsIDIwMTAgYXQgNzowMiBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJv
d24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+IMKgc291bmQv
c29jL3MzYzI0eHgvczNjLWRtYS5jIHwgwqAgwqA0ICsrLS0KPiDCoDEgZmlsZXMgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9zM2MyNHh4L3MzYy1kbWEuYyBiL3NvdW5kL3NvYy9zM2MyNHh4L3MzYy1kbWEuYwo+IGluZGV4
IGJiOGJhMDcuLjU0YmZmODMgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL3MzYzI0eHgvczNjLWRt
YS5jCj4gKysrIGIvc291bmQvc29jL3MzYzI0eHgvczNjLWRtYS5jCj4gQEAgLTQ3Nyw4ICs0Nzcs
OCBAQCBzdGF0aWMgaW50IF9fZGV2ZXhpdCBzM2MyNHh4X3NvY19wbGF0Zm9ybV9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPgo+IMKgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9k
cml2ZXIgczNjMjR4eF9wY21fZHJpdmVyID0gewo+IMKgIMKgIMKgIMKgLmRyaXZlciA9IHsKPiAt
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5uYW1lID0gInMzYzI0eHgtcGNtLWF1
ZGlvIiwKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5vd25lciA9IFRISVNf
TU9EVUxFLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLm5hbWUgPSAiczNjMjR4eC1wY20tYXVk
aW8iLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLm93bmVyID0gVEhJU19NT0RVTEUsCj4gwqAg
wqAgwqAgwqB9LAo+Cj4gwqAgwqAgwqAgwqAucHJvYmUgPSBzM2MyNHh4X3NvY19wbGF0Zm9ybV9w
cm9iZSwKT2sgYnV0IEkgdGhpbmsgd2UgbmVlZCB0byBpbnZvbHZlIEJlbiB0b28sIGZvciBJIGhh
dmUgdGhlIGltcHJlc3Npb24KdGhhdCBoZSBpcyBub3QgdmVyeSBpbnRlcmVzdGVkIGluIHN1Y2gg
dmFsaWQgYnV0IGluY29uc2VxdWVudGlhbApjaGFuZ2VzLgpJZiBoZSBhZ3JlZXMsIG1heWJlIHdl
IGNhbiBwcmVwYXJlIGEgcGF0Y2hzZXQgZm9yIGNvbXBsZXRlIHBvbGlzaAphbmQgb3ZlcmhhdWxp
bmcgdGhlIGRyaXZlcnMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9y
ZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo=
