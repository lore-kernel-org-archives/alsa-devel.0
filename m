From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v2 2/5] ASoC: ad193x: fix dac word len
	setting
Date: Mon, 15 Aug 2011 10:42:26 +0800
Message-ID: <CAGsJ_4yfcHKh-opqdDM1+8pcKnRZDyK-nxeV9xkiH15PLp+k-w@mail.gmail.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
	<1313186654-22520-2-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3B5402440F
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 04:42:50 +0200 (CEST)
Received: by bkar19 with SMTP id r19so2760033bka.38
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2011 19:42:46 -0700 (PDT)
In-Reply-To: <1313186654-22520-2-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

MjAxMS84LzEzIFNjb3R0IEppYW5nIDxzY290dC5qaWFuZy5saW51eEBnbWFpbC5jb20+Ogo+IGRh
YyB3b3JkIGxlbiB2YWx1ZSBzaG91bGQgbGVmdCBzaGlmdCBiZWZvcmUgc2V0dGluZwo+Cj4gU2ln
bmVkLW9mZi1ieTogU2NvdHQgSmlhbmcgPHNjb3R0LmppYW5nLmxpbnV4QGdtYWlsLmNvbT4KCkFj
a2VkLWJ5OiBCYXJyeSBTb25nIDwyMWNuYmFvQGdtYWlsLmNvbT4KCmlmIHlvdSBjYW4gbW92ZSBB
RDE5M1hfREFDX1dPUkRfTEVOX01BU0sgZnJvbSB5b3VyIGFub3RoZXIgcGF0Y2ggdG8KdGhpcywg
aXQgaXMgYmV0dGVyLgoKPiAtLS0KPiDCoHNvdW5kL3NvYy9jb2RlY3MvYWQxOTN4LmMgfCDCoCDC
oDMgKystCj4gwqBzb3VuZC9zb2MvY29kZWNzL2FkMTkzeC5oIHwgwqAgwqAxICsKPiDCoDIgZmls
ZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL3NvdW5kL3NvYy9jb2RlY3MvYWQxOTN4LmMgYi9zb3VuZC9zb2MvY29kZWNzL2FkMTkzeC5j
Cj4gaW5kZXggMjM3NGNhNS4uZjFhOGJlNSAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNz
L2FkMTkzeC5jCj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9hZDE5M3guYwo+IEBAIC0zMDcsNyAr
MzA3LDggQEAgc3RhdGljIGludCBhZDE5M3hfaHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLAo+IMKgIMKgIMKgIMKgc25kX3NvY193cml0ZShjb2RlYywgQUQxOTNY
X1BMTF9DTEtfQ1RSTDAsIHJlZyk7Cj4KPiDCoCDCoCDCoCDCoHJlZyA9IHNuZF9zb2NfcmVhZChj
b2RlYywgQUQxOTNYX0RBQ19DVFJMMik7Cj4gLSDCoCDCoCDCoCByZWcgPSAocmVnICYgKH5BRDE5
M1hfREFDX1dPUkRfTEVOX01BU0spKSB8IHdvcmRfbGVuOwo+ICsgwqAgwqAgwqAgcmVnID0gKHJl
ZyAmICh+QUQxOTNYX0RBQ19XT1JEX0xFTl9NQVNLKSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHwgKHdvcmRfbGVuIDw8IEFEMTkzWF9EQUNfV09SRF9MRU5fU0hGVCk7Cj4gwqAgwqAgwqAgwqBz
bmRfc29jX3dyaXRlKGNvZGVjLCBBRDE5M1hfREFDX0NUUkwyLCByZWcpOwo+Cj4gwqAgwqAgwqAg
wqByZWcgPSBzbmRfc29jX3JlYWQoY29kZWMsIEFEMTkzWF9BRENfQ1RSTDEpOwo+IGRpZmYgLS1n
aXQgYS9zb3VuZC9zb2MvY29kZWNzL2FkMTkzeC5oIGIvc291bmQvc29jL2NvZGVjcy9hZDE5M3gu
aAo+IGluZGV4IGMxMDI5ZDIuLmNjY2MyZTggMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL2NvZGVj
cy9hZDE5M3guaAo+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3MvYWQxOTN4LmgKPiBAQCAtMzQsNiAr
MzQsNyBAQAo+IMKgI2RlZmluZSBBRDE5M1hfREFDX0xFRlRfSElHSCDCoCDCoCgxIDw8IDMpCj4g
wqAjZGVmaW5lIEFEMTkzWF9EQUNfQkNMS19JTlYgwqAgwqAgKDEgPDwgNykKPiDCoCNkZWZpbmUg
QUQxOTNYX0RBQ19DVFJMMiDCoCDCoCDCoCDCoDB4ODA0Cj4gKyNkZWZpbmUgQUQxOTNYX0RBQ19X
T1JEX0xFTl9TSEZUIMKgIMKgIMKgIMKgMwo+IMKgI2RlZmluZSBBRDE5M1hfREFDX1dPUkRfTEVO
X01BU0sgwqAgwqAgwqAgwqAweDE4Cj4gwqAjZGVmaW5lIEFEMTkzWF9EQUNfTUFTVEVSX01VVEUg
wqAxCj4gwqAjZGVmaW5lIEFEMTkzWF9EQUNfQ0hOTF9NVVRFIMKgIMKgMHg4MDUKPiAtLQo+IDEu
Ny4wLjQKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
