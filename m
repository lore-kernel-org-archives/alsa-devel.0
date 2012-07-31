From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all
	mop500 platforms
Date: Tue, 31 Jul 2012 15:29:48 +0100
Message-ID: <5017EBDC.6010005@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-10-git-send-email-lee.jones@linaro.org>
 <20120731135614.GR6802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D09D265E25
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 16:29:48 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so1121781eaa.38
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 07:29:50 -0700 (PDT)
In-Reply-To: <20120731135614.GR6802@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMzEvMDcvMTIgMTQ6NTYsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCB3cm90ZToKPiBPbiBU
dWUsIEp1bCAzMSwgMjAxMiBhdCAwMjozMTozMFBNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4+
IFRoZSBjdXJyZW50IGtlcm5lbCBjb21tYW5kbGluZSBmb3IgdXg1MDAgYmFzZWQgZGV2aWNlcyBp
bmNsdWRlcwo+PiBoYXJkLWNvZGVkIGFsbG9jYXRpb25zIGZvciB0aGluZ3MgbGlrZSBtYWxpIGFu
ZCBod21lbSwgd2hpY2gKPj4gYWN0dWFsbHkgcnVuIG92ZXIgbG93bWVtLiBIZXJlIHdlIGVuYWJs
ZSBoaWdobWVtIGluIG9yZGVyIHRvCj4+IGF2b2lkIG1lbW9yeSBjb3JydXB0aW9uIGVycm9ycy4K
Pgo+IEVyciB3aGF0PyAgaGlnaG1lbSBzaG91bGQgbWFrZSBubyBkaWZmZXJlbmNlIGlmIHRoaW5n
cyBhcmUgYmVpbmcgZG9uZQo+IGNvcnJlY3RseS4KPgo+IEluIG90aGVyIHdvcmRzLCB5b3VyIHBh
dGNoIGRlc2NyaXB0aW9uIGlzIHRvbyB2YWd1ZSB0byB1bmRlcnN0YW5kIHdoYXQKPiB0aGUgcHJv
YmxlbSBpcyBhbmQgd2h5IHlvdSBoYXZlIHRvIGZvcmNlIGhpZ2htZW0gb24gLSBhbmQgbm90aGlu
ZyBzaG91bGQKPiBfcmVxdWlyZV8gaGlnaG1lbS4KCkkgdGhpbmsgSSBtdXN0IGhhdmUgbWlzdW5k
ZXJzdG9vZCBzb21lIGFkdmljZSB3aGljaCB3YXMgcmVjZW50bHkgZ2l2ZW4gCnRvIG1lLiBJJ2xs
IGRyb3AgdGhlIHBhdGNoLgoKVGhhbmtzIGZvciByZXZpZXdpbmcuCgotLSAKTGVlIEpvbmVzCkxp
bmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNv
dXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0
dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
