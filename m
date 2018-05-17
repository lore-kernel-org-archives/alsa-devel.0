From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing
Date: Thu, 17 May 2018 11:14:24 -0500
Message-ID: <CAL_JsqKhkVOYf+XEA3MYpK4JYfMrZTbHZtoXgaH=wCBRoU6cfQ@mail.gmail.com>
References: <20180517133009.26079-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id BCF442671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:14:47 +0200 (CEST)
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 30B312084E
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 16:14:46 +0000 (UTC)
Received: by mail-qt0-f181.google.com with SMTP id f1-v6so6486801qtj.6
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 09:14:46 -0700 (PDT)
In-Reply-To: <20180517133009.26079-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBNYXkgMTcsIDIwMTggYXQgODozMCBBTSwgTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBw
ZW5ndXRyb25peC5kZT4gd3JvdGU6Cj4gRnJvbTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5n
dXRyb25peC5kZT4KPgo+IEFjY29yZGluZyB0byB0aGUgc3NtMjYwMyBkYXRhIHNoZWV0IChjb250
cm9sIHJlZ2lzdGVyIHNlcXVlbmNpbmcpLCB0aGUKPiBkaWdpdGFsIGNvcmUgc2hvdWxkIGJlIGFj
dGl2YXRlZCBvbmx5IGFmdGVyIGFsbCBuZWNlc3NhcnkgYml0cyBpbiB0aGUKPiBwb3dlciByZWdp
c3RlciBhcmUgZW5hYmxlZCwgYW5kIGEgZGVsYXkgZGV0ZXJtaW5lZCBieSB0aGUgZGVjb3VwbGlu
Zwo+IGNhcGFjaXRvciBvbiB0aGUgVk1JRCBwaW4gaGFzIHBhc3NlZC4gSWYgdGhlIGRpZ2l0YWwg
Y29yZSBpcyBhY3RpdmF0ZWQKPiB0b28gZWFybHksIG9yIGV2ZW4gYmVmb3JlIHRoZSBBREMgaXMg
cG93ZXJlZCB1cCwgYXVkaWJsZSBhcnRpZmFjdHMKPiBhcHBlYXIgYXQgdGhlIGJlZ2lubmluZyBv
ZiB0aGUgcmVjb3JkZWQgc2lnbmFsLgo+Cj4gVGhlIGRpZ2l0YWwgY29yZSBpcyBhbHNvIG5lZWRl
ZCBmb3IgcGxheWJhY2ssIHNvIHdoZW4gcmVjb3JkaW5nIHN0YXJ0cwo+IGl0IG1heSBhbHJlYWR5
IGJlIGVuYWJsZWQuIFRoaXMgbWVhbnMgd2UgY2Fubm90IGdldCB0aGUgcG93ZXIgc2VxdWVuY2UK
PiBjb3JyZWN0IHdoZW4gd2Ugd2FudCB0byBiZSBhYmxlIHRvIHN0YXJ0IHJlY29yZGluZyBhZnRl
ciBwbGF5YmFjay4KPgo+IEFzIGEgd29ya2Fyb3VuZCBwdXQgdGhlIE1JQyBtdXRlIHN3aXRjaCBp
bnRvIHRoZSBEQVBNIHJvdXRlcy4gVGhpcwo+IHdheSB3ZSBjYW4ga2VlcCB0aGUgcmVjb3JkaW5n
IGRpc2FibGVkIHVudGlsIHRoZSBNSUMgQmlhcyBoYXMgc2V0dGxlZAo+IGFuZCB0aHVzIGdldCBy
aWQgb2YgYXVkaWJsZSBhcnRpZmFjdHMuCj4KPiBUaGUgZGVsYXkgd2UgaGF2ZSB0byB3YWl0IGRl
cGVuZHMgb24gYSBib2FyZCBzcGVjaWZpYyBjYXBhY2l0b3IKPiBjb25uZWN0ZWQgdG8gdGhlIFZN
SUQgcGlucywgc28gbWFrZSB0aGUgZGVsYXkgY29uZmlndXJhYmxlIGluIHRoZSBkZXZpY2UKPiB0
cmVlLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25p
eC5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU+Cj4gU2lnbmVkLW9mZi1ieTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5k
ZT4KPiAtLS0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYWRpLHNzbTI2MDIudHh0
IHwgIDcgKysrKysKPiAgc291bmQvc29jL2NvZGVjcy9zc20yNjAyLmMgICAgICAgICAgICAgICAg
ICAgIHwgMzAgKysrKysrKysrKysrKysrKystLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FkaSxzc20yNjAyLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksc3NtMjYwMi50eHQKPiBpbmRleCAzYjMzMDJm
ZTM5OWIuLjkzMzRkNDhjMDQ2MiAxMDA2NDQKPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvYWRpLHNzbTI2MDIudHh0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FkaSxzc20yNjAyLnR4dAo+IEBAIC0xMSw5ICsxMSwx
NiBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICAgIC0gcmVnIDogdGhlIEkyQyBhZGRyZXNzIG9m
IHRoZSBkZXZpY2UgZm9yIEkyQywgdGhlIGNoaXAgc2VsZWN0Cj4gICAgICAgICAgICBudW1iZXIg
Zm9yIFNQSS4KPgo+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOgo+ICsKPiArICAtIHN0YXJ0dXAtZGVs
YXktdXMgOiBkZWxheSBiZXR3ZWVuIHBvd2VyaW5nIG9uIGFuZCBhY3RpdmF0aW5nIHRoZSBkaWdp
dGFsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29yZSwgZGV0ZXJtaW5lZCBieSB0aGUgZGVj
b3VwbGluZyBjYXBhY2l0b3IgQyBvbiB0aGUKPiArICAgICAgICAgICAgICAgICAgICAgIFZNSUQg
cGluOiBkZWxheSBbwrVzXSA9IEMgW8K1Rl0gKiAyNTAwMCAvIDMuNQo+ICsKCldlIGFscmVhZHkg
aGF2ZSBzaW1pbGFybHkgZGVmaW5lZCBwcm9wZXJ0eS4gUGxlYXNlIHJldXNlIHRoYXQuIFNlZSBt
bWMKcHdyc2VxIGJpbmRpbmcuCgpBbHNvLCBwbGVhc2Ugc3BsaXQgYmluZGluZ3MgdG8gc2VwYXJh
dGUgcGF0Y2guCgpSb2IKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
