From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Wed, 3 Jun 2009 22:22:17 +0800
Message-ID: <f17812d70906030722x70029dc9x4e6cb37ad4cc5d1f@mail.gmail.com>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090603131819.GQ26148@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CB3D1038BA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 16:22:19 +0200 (CEST)
Received: by qyk1 with SMTP id 1so19408qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 07:22:18 -0700 (PDT)
In-Reply-To: <20090603131819.GQ26148@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdW4gMywgMjAwOSBhdCA5OjE4IFBNLCBEYW5pZWwgTWFjayA8ZGFuaWVsQGNhaWFx
LmRlPiB3cm90ZToKPiBPbiBXZWQsIEp1biAwMywgMjAwOSBhdCAwODozMzo0MlBNICswODAwLCBF
cmljIE1pYW8gd3JvdGU6Cj4+IE1ha2UgdGhlIHB4YSBJMlMgY29uZmlndXJhdGlvbiBnZW5lcmlj
LCBhZGQgc3VwcG9ydCBmb3IgTGVmdF9KLCBhZGQKPj4gc3VwcG9ydCBmb3IgdmFyaWFibGUgZnJh
bWUgd2lkdGggbGlrZSAzMmZzLCA0OGZzLCA2NGZzIGFuZCA5NmZzCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IFBhdWwgU2hlbiA8YnNoZW45QG1hcnZlbGwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBFcmlj
IE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KPj4gQ2M6IERhbmllbCBNYWNrIDxkYW5pZWxA
Y2FpYXEuZGU+Cj4+IC0tLQo+PiDCoGFyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9yZWdz
LXNzcC5oIHwgwqAgMTQgKysrLS0tCj4+IMKgc291bmQvc29jL3B4YS9weGEtc3NwLmMgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfCDCoCA2MiArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
Cj4+IMKgc291bmQvc29jL3B4YS9weGEtc3NwLmggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fCDCoCDCoDkgKysrKwo+PiDCoDMgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMzgg
ZGVsZXRpb25zKC0pCj4KPiBPaywgSSB0cmllZCB0aGF0IGNvZGUgb24gbXkgYm9hcmQgYW5kIHRo
aXMgaXMgd2hhdCBJIGhhZCB0byBjaGFuZ2UKPiB0aGVyZToKPgo+IFRoZSB0ZG0gdGltZSBzbG90
IGNvbmZpZ3VyYXRpb24gbmVlZHMgdG8gYmUgc2V0IGFnYWluIGluIG15IGJvYXJkIHN1cHBvcnQK
PiBjb2RlIGp1c3QgbGlrZSBpbiB5b3VyIGV4YW1wbGU6IHNuZF9zb2Nfc2V0X3RkbV9zbG90KGNw
dV9kYWksIDMsIDIpLgoKTW1tLi4uLiB3aGF0IHdvdWxkIGJlIHRoZSBwcmVmZXJyZWQgd2F5LCB0
byBsZXQgYm9hcmQgc3BlY2lmaWMKY29kZSBkbyB0aGlzIG9yIHRoZSBJMlMgY29uZmlndXJhdGlv
biBjb2RlPwoKPiBBbmQKPiB0aGUgUFhBX1NTUF9ESVZfU0NSIHZhbHVlIG5lZWRlZCB0byBiZSBk
b3VibGVkIGZyb20gNCB0byA4LgoKT0ssIEknbGwgY2hlY2sgd2l0aCBTQ1IsIHNpbmNlIHdlIHVz
ZWQgdGhlIGRpdGhlcmluZyBjbG9jawpTU0FDRCBhbmQgU1NBQ0REIGZvciB0aGUgY2xvY2suCgo+
Cj4gV2l0aCB0aGF0IGNoYW5nZXMsIExSQ0xLIGlzIDQ0MTAwSHogd2hlbiBjb25maWd1cmVkIHRv
IDQ0MTAwSHouIEJ1dCB0aGUKPiBiaXRjbGsgaXMgbm90IDY0ZnMgYW55bW9yZSBidXQgMzJmcyBv
bmx5ICgxLjQxTWh6KS4gSXMgdGhlcmUgYW55Cj4gaW1wbGVtZW50YXRpb24gZGV0YWlscyBJIG1p
c3M/IFdoYXQgZG9lcyB5b3VyIGNvZGVjIGNsb2NrIGNvbmZpZyBsb29rCj4gbGlrZT8KPgo+IEFu
b3RoZXIgc21hbGwgdGhpbmc6Cj4KPiDCoENDIMKgIMKgIMKgc291bmQvc29jL3B4YS9weGEtc3Nw
Lm8KPiDCoHNvdW5kL3NvYy9weGEvcHhhLXNzcC5jOjE4Njogd2FybmluZzogJ3NzcF9nZXRfc2Ny
JyBkZWZpbmVkIGJ1dCBub3QgdXNlZAo+CgpPSywgd2lsbCBnZXQgcmlkIG9mIHRoYXQuCgo+IERh
bmllbAo+Cj4KCgoKLS0gCkNoZWVycwotIGVyaWMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
