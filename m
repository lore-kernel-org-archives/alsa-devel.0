From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 3/7] S3C64XX PCM: Define PCM Controller
	base registers
Date: Mon, 16 Nov 2009 20:40:27 +0900
Message-ID: <1b68c6790911160340t6436b7dem816ef152c7ad4905@mail.gmail.com>
References: <1257914709-4447-1-git-send-email-jassi.brar@samsung.com>
	<20091116104746.GU23772@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B1051038A4
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 12:40:29 +0100 (CET)
Received: by pwj11 with SMTP id 11so7311833pwj.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 03:40:28 -0800 (PST)
In-Reply-To: <20091116104746.GU23772@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBOb3YgMTYsIDIwMDkgYXQgNzo0NyBQTSwgQmVuIERvb2tzIDxiZW4tbGludXhAZmx1
ZmYub3JnPiB3cm90ZToKPiBPbiBXZWQsIE5vdiAxMSwgMjAwOSBhdCAwMTo0NTowOVBNICswOTAw
LCBKYXNzaSBCcmFyIHdyb3RlOgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNzaSBCcmFyIDxqYXNzaS5i
cmFyQHNhbXN1bmcuY29tPgo+Cj4gU2hvdWxkIGhhdmUgZ29uZSB0byB0aGUgbGludXgtYXJtLWtl
cm5lbCBsaXN0LgpJIGRpZCBzdWJtaXQgdGhlcmUgdG9vLgpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9waXBlcm1haWwvbGludXgtYXJtLWtlcm5lbC8yMDA5LU5vdmVtYmVyLzAwMzcyNy5odG1s
Cgo+IFdpbGwgbWVyZ2UgdGhpcyB0byBteSB0cmVlLgo+Cj4+IC0tLQo+PiDCoGFyY2gvYXJtL21h
Y2gtczNjNjQwMC9pbmNsdWRlL21hY2gvbWFwLmggfCDCoCDCoDIgKysKPj4gwqAxIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtczNjNjQwMC9pbmNsdWRlL21hY2gvbWFwLmggYi9hcmNoL2FybS9tYWNo
LXMzYzY0MDAvaW5jbHVkZS9tYWNoL21hcC5oCj4+IGluZGV4IGZjOGIyMjMuLjg2NmJlMzEgMTAw
NjQ0Cj4+IC0tLSBhL2FyY2gvYXJtL21hY2gtczNjNjQwMC9pbmNsdWRlL21hY2gvbWFwLmgKPj4g
KysrIGIvYXJjaC9hcm0vbWFjaC1zM2M2NDAwL2luY2x1ZGUvbWFjaC9tYXAuaAo+PiBAQCAtNDgs
NiArNDgsOCBAQAo+PiDCoCNkZWZpbmUgUzNDNjRYWF9QQV9JSVMxIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKDB4N0YwMDMwMDApCj4+IMKgI2RlZmluZSBTM0M2NFhYX1BBX1RJTUVSIMKgIMKgICgweDdG
MDA2MDAwKQo+PiDCoCNkZWZpbmUgUzNDNjRYWF9QQV9JSUMwIMKgIMKgIMKgIMKgIMKgIMKgIMKg
KDB4N0YwMDQwMDApCj4+ICsjZGVmaW5lIFMzQzY0WFhfUEFfUENNMCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCgweDdGMDA5MDAwKQo+PiArI2RlZmluZSBTM0M2NFhYX1BBX1BDTTEgwqAgwqAgwqAgwqAg
wqAgwqAgwqAoMHg3RjAwQTAwMCkKPj4gwqAjZGVmaW5lIFMzQzY0WFhfUEFfSUlTVjQgwqAgwqAg
KDB4N0YwMEQwMDApCj4+IMKgI2RlZmluZSBTM0M2NFhYX1BBX0lJQzEgwqAgwqAgwqAgwqAgwqAg
wqAgwqAoMHg3RjAwRjAwMCkKPj4KPj4gLS0KPj4gMS42LjIuNQo+Pgo+Cj4gLS0KPiAtLQo+IEJl
bgo+Cj4gUTogwqAgwqAgwqBXaGF0J3MgYSBsaWdodC15ZWFyPwo+IEE6IMKgIMKgIMKgT25lLXRo
aXJkIGxlc3MgY2Fsb3JpZXMgdGhhbiBhIHJlZ3VsYXIgeWVhci4KPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiBodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
