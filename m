From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH RESEND] ASoC: omap: Add .owner to struct
	snd_soc_card
Date: Thu, 12 Jan 2012 14:15:33 +0000
Message-ID: <CABS+qY0-AHr72rfMrEAHpD6Og=a0TSojzz-_V2p00aK8pstmQQ@mail.gmail.com>
References: <1326177866.4956.1.camel@phoenix>
	<4F0EE95E.202@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id EB81424422
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 15:15:34 +0100 (CET)
Received: by mail-vw0-f49.google.com with SMTP id l1so458563vba.8
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 06:15:33 -0800 (PST)
In-Reply-To: <4F0EE95E.202@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Axel Lin <axel.lin@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: alsa-devel@alsa-project.org

T24gMTIgSmFudWFyeSAyMDEyIDE0OjA4LCBKYXJra28gTmlrdWxhIDxqYXJra28ubmlrdWxhQGJp
dG1lci5jb20+IHdyb3RlOgo+IE9uIDEwLzAxLzEyIDA4OjQ0LCBBeGVsIExpbiB3cm90ZToKPj4K
Pj4gQWRkIG1pc3NpbmcgLm93bmVyIG9mIHN0cnVjdCBzbmRfc29jX2NhcmQuIFRoaXMgcHJldmVu
dHMgdGhlIG1vZHVsZSBmcm9tCj4+IGJlaW5nCj4+IHJlbW92ZWQgZnJvbSB1bmRlcm5lYXRoIGl0
cyB1c2Vycy4KPj4KPj4gUmVwb3J0ZWQtYnk6IExvdGhhciBXYcOfbWFubjxMV0BLQVJPLWVsZWN0
cm9uaWNzLmRlPgo+PiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbjxheGVsLmxpbkBnbWFpbC5jb20+
Cj4+IEFja2VkLWJ5OiBNYXJrIEJyb3duPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8u
Y29tPgo+PiAtLS0KPj4gwqBzb3VuZC9zb2Mvb21hcC9hbTM1MTdldm0uYyDCoCDCoCDCoCB8IMKg
IMKgMSArCj4+IMKgc291bmQvc29jL29tYXAvYW1zLWRlbHRhLmMgwqAgwqAgwqAgfCDCoCDCoDEg
Kwo+PiDCoHNvdW5kL3NvYy9vbWFwL2lnZXAwMDIwLmMgwqAgwqAgwqAgwqB8IMKgIMKgMSArCj4+
IMKgc291bmQvc29jL29tYXAvbjgxMC5jIMKgIMKgIMKgIMKgIMKgIMKgfCDCoCDCoDEgKwo+PiDC
oHNvdW5kL3NvYy9vbWFwL29tYXAzZXZtLmMgwqAgwqAgwqAgwqB8IMKgIMKgMSArCj4+IMKgc291
bmQvc29jL29tYXAvb21hcDNwYW5kb3JhLmMgwqAgwqB8IMKgIMKgMSArCj4+IMKgc291bmQvc29j
L29tYXAvb21hcDQtaGRtaS1jYXJkLmMgfCDCoCDCoDEgKwo+PiDCoHNvdW5kL3NvYy9vbWFwL29z
azU5MTIuYyDCoCDCoCDCoCDCoCB8IMKgIMKgMSArCj4+IMKgc291bmQvc29jL29tYXAvb3Zlcm8u
YyDCoCDCoCDCoCDCoCDCoCB8IMKgIMKgMSArCj4+IMKgc291bmQvc29jL29tYXAvcng1MS5jIMKg
IMKgIMKgIMKgIMKgIMKgfCDCoCDCoDEgKwo+PiDCoHNvdW5kL3NvYy9vbWFwL3NkcDM0MzAuYyDC
oCDCoCDCoCDCoCB8IMKgIMKgMSArCj4+IMKgc291bmQvc29jL29tYXAvc2RwNDQzMC5jIMKgIMKg
IMKgIMKgIHwgwqAgwqAxICsKPj4gwqBzb3VuZC9zb2Mvb21hcC96b29tMi5jIMKgIMKgIMKgIMKg
IMKgIHwgwqAgwqAxICsKPj4gwqAxMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQo+Pgo+IEFja2VkLWJ5OiBKYXJra28gTmlrdWxhIDxqYXJra28ubmlrdWxh
QGJpdG1lci5jb20+Cj4KClB1bGxlZCBhIGZldyBkYXlzIGFnbyA6KQoKVGhhbmtzCgpMaWFtCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
