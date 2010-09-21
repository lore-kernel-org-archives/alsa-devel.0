From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] ASoC: Select DMA driver for Samsung DAIs
Date: Tue, 21 Sep 2010 09:38:04 +0900
Message-ID: <AANLkTikQeNoKCHnizQ74H5q4bacfmYBCVvJVbznNrZOx@mail.gmail.com>
References: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 87505103844
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 02:38:04 +0200 (CEST)
Received: by bwz4 with SMTP id 4so5512521bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 17:38:04 -0700 (PDT)
In-Reply-To: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBTZXAgMjEsIDIwMTAgYXQgNDozOCBBTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IEtjb25maWcgZ290IHNtYXJ0IGVub3Vn
aCB0byBkbyBkZXBlbmRlbmNpZXMgdGhyb3VnaCBzZWxlY3RzIHNvIGxldCdzIG1ha2UKPiB1c2Ug
b2YgdGhhdC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJj
ZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+IMKgc291bmQvc29jL3MzYzI0eHgvS2NvbmZpZyB8
IMKgIMKgNCArKysrCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvczNjMjR4eC9LY29uZmlnIGIvc291
bmQvc29jL3MzYzI0eHgvS2NvbmZpZwo+IGluZGV4IDdkODIzNWQuLjExNDJkM2UgMTAwNjQ0Cj4g
LS0tIGEvc291bmQvc29jL3MzYzI0eHgvS2NvbmZpZwo+ICsrKyBiL3NvdW5kL3NvYy9zM2MyNHh4
L0tjb25maWcKPiBAQCAtMTAsNiArMTAsNyBAQCBjb25maWcgU05EX1MzQzI0WFhfU09DCj4gwqBj
b25maWcgU05EX1MzQzI0WFhfU09DX0kyUwo+IMKgIMKgIMKgIMKgdHJpc3RhdGUKPiDCoCDCoCDC
oCDCoHNlbGVjdCBTM0MyNDEwX0RNQQo+ICsgwqAgwqAgwqAgc2VsZWN0IFNORF9TM0NfU09DX1BD
TQo+Cj4gwqBjb25maWcgU05EX1MzQ19JMlNWMl9TT0MKPiDCoCDCoCDCoCDCoHRyaXN0YXRlCj4g
QEAgLTE4LDE2ICsxOSwxOSBAQCBjb25maWcgU05EX1MzQzI0MTJfU09DX0kyUwo+IMKgIMKgIMKg
IMKgdHJpc3RhdGUKPiDCoCDCoCDCoCDCoHNlbGVjdCBTTkRfUzNDX0kyU1YyX1NPQwo+IMKgIMKg
IMKgIMKgc2VsZWN0IFMzQzI0MTBfRE1BCj4gKyDCoCDCoCDCoCBzZWxlY3QgU05EX1MzQ19TT0Nf
UENNCj4KPiDCoGNvbmZpZyBTTkRfUzNDNjRYWF9TT0NfSTJTCj4gwqAgwqAgwqAgwqB0cmlzdGF0
ZQo+IMKgIMKgIMKgIMKgc2VsZWN0IFNORF9TM0NfSTJTVjJfU09DCj4gwqAgwqAgwqAgwqBzZWxl
Y3QgUzNDNjRYWF9ETUEKPiArIMKgIMKgIMKgIHNlbGVjdCBTTkRfUzNDX1NPQ19QQ00KPgo+IMKg
Y29uZmlnIFNORF9TM0M2NFhYX1NPQ19JMlNfVjQKPiDCoCDCoCDCoCDCoHRyaXN0YXRlCj4gwqAg
wqAgwqAgwqBzZWxlY3QgU05EX1MzQ19JMlNWMl9TT0MKPiDCoCDCoCDCoCDCoHNlbGVjdCBTM0M2
NFhYX0RNQQo+ICsgwqAgwqAgwqAgc2VsZWN0IFNORF9TM0NfU09DX1BDTQo+Cj4gwqBjb25maWcg
U05EX1MzQ19TT0NfUENNCj4gwqAgwqAgwqAgwqB0cmlzdGF0ZQo+IC0tCgpTTkRfUzNDX1NPQ19Q
Q00gYnVpbGRzIHMzYy1wY20uYywgd2hpY2ggaXMgdGhlIFBDTSBjb250cm9sbGVyJ3MgQ1BVIGRy
aXZlci4KCnMzYy1kbWEuYyBpcyB0aGUgRE1BIGRyaXZlciBmb3IgU2Ftc3VuZyBTb0NzLCB3aGlj
aCBpcyBhbHJlYWR5IGJ1aWx0CmFzIHRoZSBmaXJzdAp0aGluZyBmb3IgU2Ftc3VuZyBBU29DLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
