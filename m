From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: arizona: Add DT binding for irq_gpio
	property
Date: Tue, 3 Nov 2015 13:29:52 +0000
Message-ID: <20151103132952.GF3503@x1>
References: <1446549612-18221-1-git-send-email-sjan@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ED272606BB
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 14:29:55 +0100 (CET)
Received: by wmeg8 with SMTP id g8so84537291wme.0
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2015 05:29:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446549612-18221-1-git-send-email-sjan@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Jan <sjan@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAwMyBOb3YgMjAxNSwgU2ViYXN0aWVuIEphbiB3cm90ZToKCj4gU2lnbmVkLW9mZi1i
eTogU2ViYXN0aWVuIEphbiA8c2phbkBiYXlsaWJyZS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbWZk
L2FyaXpvbmEtY29yZS5jIHwgNSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2FyaXpvbmEtY29yZS5jIGIvZHJpdmVy
cy9tZmQvYXJpem9uYS1jb3JlLmMKPiBpbmRleCA0NGNmZGJiLi4yM2EwZjkzIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbWZkL2FyaXpvbmEtY29yZS5jCj4gKysrIGIvZHJpdmVycy9tZmQvYXJpem9u
YS1jb3JlLmMKPiBAQCAtODE0LDYgKzgxNCwxMSBAQCBzdGF0aWMgaW50IGFyaXpvbmFfb2ZfZ2V0
X2NvcmVfcGRhdGEoc3RydWN0IGFyaXpvbmEgKmFyaXpvbmEpCj4gIAkJY291bnQrKzsKPiAgCX0K
PiAgCj4gKwlhcml6b25hLT5wZGF0YS5pcnFfZ3BpbyA9IG9mX2dldF9uYW1lZF9ncGlvKGFyaXpv
bmEtPmRldi0+b2Zfbm9kZSwKPiArCQkJCQkJCSJ3bGYsaXJxX2dwaW8iLCAwKTsKPiArCWlmIChh
cml6b25hLT5wZGF0YS5pcnFfZ3BpbyA8IDApCj4gKwkJYXJpem9uYS0+cGRhdGEuaXJxX2dwaW8g
PSAwOwoKVGhpcyBpcyB3cm9uZyBvbiBhIG51bWJlciBvZiBsZXZlbHMuCgpGaXJzdGx5LCBhbGwg
cHJvcGVydGllcyBtdXN0IGJlIGRvY3VtZW50ZWQuICBTZWNvbmRseSwgdW5kZXJzY29yZXMKYXJl
bid0IGFsbG93ZWQgaW4gRFQuICBUaGlyZGx5LCB0aGlzIGlzIGEgZ2VuZXJpYyBiaW5kaW5nIC0t
IG5vIG5lZWQKZm9yIHRoZSB2ZW5kb3IgcHJlZml4LiAgQW5kIGxhc3RseSwgR1BJTyBiaW5kaW5n
cyBhbHJlYWR5IGhhdmUgYQpmb3JtYXQgLS0gaXQgc2hvdWxkIGJlIHNpbXBseSAnaXJxLWdwaW9z
Jy4KCi0tIApMZWUgSm9uZXMKTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRlYW0g
TGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9s
bG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
