From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 5/7] S3C AUDIO: Add header to pass platform
	data to device drivers
Date: Mon, 16 Nov 2009 20:46:51 +0900
Message-ID: <1b68c6790911160346l4d9cf1en3e0ba42b4dacb7d5@mail.gmail.com>
References: <1257914722-4507-1-git-send-email-jassi.brar@samsung.com>
	<20091116104941.GW23772@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f183.google.com (mail-px0-f183.google.com
	[209.85.216.183])
	by alsa0.perex.cz (Postfix) with ESMTP id CD44F1038C9
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 12:46:51 +0100 (CET)
Received: by mail-px0-f183.google.com with SMTP id 13so1280190pxi.24
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 03:46:51 -0800 (PST)
In-Reply-To: <20091116104941.GW23772@trinity.fluff.org>
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

T24gTW9uLCBOb3YgMTYsIDIwMDkgYXQgNzo0OSBQTSwgQmVuIERvb2tzIDxiZW4tbGludXhAZmx1
ZmYub3JnPiB3cm90ZToKPiBPbiBXZWQsIE5vdiAxMSwgMjAwOSBhdCAwMTo0NToyMlBNICswOTAw
LCBKYXNzaSBCcmFyIHdyb3RlOgo+Cj4gUGxlYXNlIHB1dCBzb21ldGhpbmcgaGVyZSEgRXZlbiBp
ZiBpdCBqdXN0IGEgc2xpZ2h0bHkgZXhwYW5kZWQgdmVyc2lvbgo+IG9mIHRoZSBwYXRjaCB0aXRs
ZS4Kd2lsbCBkby4gdGhhbmtzCgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNzaSBCcmFyIDxqYXNzaS5i
cmFyQHNhbXN1bmcuY29tPgo+Cj4gVGhpcyBjb3VsZCBiZSBtZXJnZWQgdG8gdGhlIGFsc2EgdHJl
ZSwgd2UgY2FuIG1vdmUgaXQgb25jZSB0aGUgb3RoZXIKPiBjaGFuZ2VzIGFyZSBtYWRlLgo+Cj4+
IC0tLQo+PiDCoGFyY2gvYXJtL3BsYXQtczNjL2luY2x1ZGUvcGxhdC9hdWRpby5oIHwgwqAgMTcg
KysrKysrKysrKysrKysrKysKPj4gwqAxIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDAgZGVsZXRpb25zKC0pCj4+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL3BsYXQtczNj
L2luY2x1ZGUvcGxhdC9hdWRpby5oCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LXMz
Yy9pbmNsdWRlL3BsYXQvYXVkaW8uaCBiL2FyY2gvYXJtL3BsYXQtczNjL2luY2x1ZGUvcGxhdC9h
dWRpby5oCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAuLmYyMmQyM2IK
Pj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9hcmNoL2FybS9wbGF0LXMzYy9pbmNsdWRlL3BsYXQv
YXVkaW8uaAo+PiBAQCAtMCwwICsxLDE3IEBACj4+ICsvKiBhcmNoL2FybS9wbGF0LXMzYy9pbmNs
dWRlL3BsYXQvYXVkaW8uaAo+PiArICoKPj4gKyAqIENvcHlyaWdodCAoYykgMjAwOSBTYW1zdW5n
IEVsZWN0cm9uaWNzIENvLiBMdGQKPj4gKyAqIEF1dGhvcjogSmFzd2luZGVyIFNpbmdoIDxqYXNz
aS5icmFyQHNhbXN1bmcuY29tPgo+PiArICoKPj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Cj4+ICsgKiBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24g
MiBhcwo+PiArICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCj4+
ICsgKi8KPj4gKwo+PiArLyoqCj4+ICsgKiBzdHJ1Y3QgczNjX2F1ZGlvX3BkYXRhIC0gY29tbW9u
IHBsYXRmb3JtIGRhdGEgZm9yIGF1ZGlvIGRldmljZSBkcml2ZXJzCj4+ICsgKiBAY2ZnX2dwaW86
IENhbGxiYWNrIGZ1bmN0aW9uIHRvIHNldHVwIG11eCdlZCBwaW5zIGluIEkyUy9QQ00vQUM5NyBt
b2RlCj4+ICsgKi8KPj4gK3N0cnVjdCBzM2NfYXVkaW9fcGRhdGEgewo+PiArIMKgIMKgIGludCAo
KmNmZ19ncGlvKShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICopOwo+PiArfTsKPj4gLS0KPj4gMS42
LjIuNQo+Pgo+Cj4gLS0KPiAtLQo+IEJlbgo+Cj4gUTogwqAgwqAgwqBXaGF0J3MgYSBsaWdodC15
ZWFyPwo+IEE6IMKgIMKgIMKgT25lLXRoaXJkIGxlc3MgY2Fsb3JpZXMgdGhhbiBhIHJlZ3VsYXIg
eWVhci4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
PiBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
