From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [PATCH] alsa-lib/tlv: fix handling of raw value
	ranges
Date: Sat, 2 Jun 2012 09:09:56 +0100
Message-ID: <CAAMvbhGA=JUMH97V3OD_M2GZ=AqJfhUQMA6e8QXU2WLavzrvgg@mail.gmail.com>
References: <4F7570D1.2060809@ladisch.de>
	<3f0367dc-8bd2-4342-99b5-9397ea4189b7@zose-store-12>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C70C2454E
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jun 2012 10:09:57 +0200 (CEST)
Received: by qcha6 with SMTP id a6so1618040qch.38
	for <alsa-devel@alsa-project.org>; Sat, 02 Jun 2012 01:09:56 -0700 (PDT)
In-Reply-To: <3f0367dc-8bd2-4342-99b5-9397ea4189b7@zose-store-12>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

T24gMzAgTWFyY2ggMjAxMiAxMTo0MSwgQmVub8OudCBUaMOpYmF1ZGVhdQo8YmVub2l0LnRoZWJh
dWRlYXVAYWR2YW5zZWUuY29tPiB3cm90ZToKPiBDbGVtZW5zIExhZGlzY2ggd3JvdGU6Cj4+IEJl
bm/DrnQgVGjDqWJhdWRlYXUgd3JvdGU6Cj4+ID4gSW4gY2FzZSBvZiBhIFRMViBkQiByYW5nZSB3
aXRoIGFsbCBpdGVtcyBoYXZpbmcgcmF3IHZhbHVlIHJhbmdlcwo+PiA+IHN0cmljdGx5IHdpdGhp
bgo+PiA+IHRoZSBtYWluIHJhdyB2YWx1ZSByYW5nZSByZXBvcnRlZCBieSB0aGUgZHJpdmVyLAo+
PiA+IHNuZF90bHZfY29udmVydF9mcm9tX2RCKCkKPj4gPiByZXR1cm5lZCBvbmUgb2YgdGhlIG1h
aW4gcmF3IHJhbmdlIGJvdW5kYXJpZXMsIHdoaWNoIHdhcyBvdXRzaWRlCj4+ID4gYWxsIGRCIHJh
bmdlCj4+ID4gaXRlbXMuCj4+Cj4+IEJ1dCB0aGUgbWFpbiByYXcgcmFuZ2UgYm91bmRhcmllcyBf
YXJlXyB2YWxpZCB2YWx1ZXMuCj4KPiBOb3QgYWx3YXlzLiBGb3IgaW5zdGFuY2UsIGlmIGEgY29k
ZWMgcmVnaXN0ZXIgaGFzIHRoZSBmb2xsb3dpbmcgdm9sdW1lIHZhbHVlczoKPiAweDAwIHRvIDB4
MjA6IHByb2hpYml0ZWQKPiAweDIxIHRvIDB4NDA6IHNvbWUgZEIgdmFsdWVzCj4gMHg0MSB0byAw
eDYwOiBwcm9oaWJpdGVkCj4gMHg2MSB0byAweGZmOiBzb21lIGRCIHZhbHVlcwo+CgpJbiB0aGUg
dXNlcnNwYWNlIHRvIGtlcm5lbCBpbnRlcmZhY2UuIEEgbWl4ZXIgY29udHJvbCBtdXN0IGhhdmUg
bWluL21heCB2YWx1ZXMuCldoZW4gd3JpdGluZyB0aGUgdmFsdWUsIGFsbCB2YWx1ZXMgd2l0aGlu
IHRoZSByYW5nZSBvZiBtaW4gdG8gbWF4IG11c3QKYmUgdmFsaWQgdmFsdWVzLgpUaGVyZSBhcmUg
anVzdCB0b28gbWFueSB1c2VyIGxhbmQgdG9vbHMgdGhhdCByZWx5IG9uIHRoaXMgZmFjdC4KVGhp
bmsgb2YgdGhlIHVzZSBjYXNlIG9yICJOZXh0IHN0ZXAgbG91ZGVyIHBsZWFzZSIuIElmIHRoZSBj
dXJyZW50bHkKd3JpdHRlbiB2YWx1ZSBpcyAweDQwLCB0aGUgY3VycmVudCB1c2VyIGxhbmQgbWl4
ZXIgYXBwcyB3b3VsZCB0cnkgdG8Kd3JpdGUgMHg0MSwgd2l0aG91dCBldmVuIGJvdGhlcmluZyB0
byBsb29rIGF0IHRoZSBkQiB0YWJsZXMuCklmIHlvdSBpbnN0ZWFkIGNoYW5nZSB0aGUgZHJpdmVy
IHRvIG1hcDoKMHgyMSB0byAweDQwIC0+IDB4MDAgdG8gMHgxZgoweDYxIHRvIDB4ZmYgLT4gMHgy
MCB0byAweEJFCmFuZCBzZXQgbWluIHRvIDAsIGFuZCBtYXggdG8gMHhiZQpUaGUgdXNlciBzcGFj
ZSB0b29scyB3aWxsIHRoZW4gd29yayBmaW5lLgoKVGhlIGRCIGNvbnZlcnNpb24gdGFibGVzIGFy
ZSBqdXN0IGEgZnJpZW5kbHkgd2F5IG9mIGRpc3BsYXlpbmcgYQpzbGlnaHRseSBtb3JlIHVzZWZ1
bCBmaWd1cmUgdG8gdGhlIHVzZXIgdGhhbiBhIHBlcmNlbnRhZ2UuCklmIHlvdSBoYXZlIGhhcmR3
YXJlIHdpdGggZ2FwcyBsaWtlIHRoZSBhYm92ZSwgdGhlIGtlcm5lbCBkcml2ZXIgd2lsbApoYXZl
IHRvIGJlIGZpeGVkIHRvIHJlbW92ZSB0aGUgcHJvaGliaXRlZCByYW5nZXMgaW4gdGhlIGtlcm5l
bCB0bwp1c2Vyc3BhY2UgQVBJLgpUaGlzIHNvcnQgb2YgY29udmVyc2lvbiBpcyBkb25lIGluIG1h
bnkgb3RoZXIgYWxzYSBrZXJuZWwgZHJpdmVycy4KCktpbmQgUmVnYXJkcwoKSmFtZXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
