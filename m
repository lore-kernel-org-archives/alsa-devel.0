From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/6] ARM: ux500: Ensure probing of Audio
 devices when Device Tree is enabled
Date: Wed, 01 Aug 2012 14:55:58 +0100
Message-ID: <5019356E.6020407@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <201207312054.13818.arnd@arndb.de> <5018DBEE.9090203@linaro.org>
 <201208011332.02500.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 023382652D1
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 15:56:00 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so1418420eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 06:56:03 -0700 (PDT)
In-Reply-To: <201208011332.02500.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMDEvMDgvMTIgMTQ6MzIsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gT24gV2VkbmVzZGF5IDAx
IEF1Z3VzdCAyMDEyLCBMZWUgSm9uZXMgd3JvdGU6Cj4+PiBMb29rcyBsaWtlIHlvdSdyZSBhZGRp
bmcgdGhlIHNhbWUgY2FsbCB0byBlYWNoIG9mIHRoZSB0aHJlZSBjYXNlczoKPj4+IG1vcDUwMCwg
c25vd2JhbGwgYW5kIGhyZWZ2NjArLiBIb3cgYWJvdXQgbW92aW5nIGl0IGJlZm9yZSBvciBhZnRl
cgo+Pj4gdGhlIGlmL2Vsc2VpZiBibG9jaz8KPj4KPj4gVGhlIFNub3diYWxsIG9uZSBpcyBkaWZm
ZXJlbnQgJ21vcDUwMF9tc3BfaW5pdCcgLT4gJ21vcDUwMF9vZl9tc3BfaW5pdCcuCj4KPiBBaCwg
SSBzZWUuIElzIHRoZXJlIGEgcHJvYmxlbSBpbiBhbHdheXMgdXNpbmcgbW9wNTAwX29mX21zcF9p
bml0IHRoZW4/Cj4gSSB3b3VsZCBndWVzcyB0aGF0IHRoaXMganVzdCBtZWFucyB5b3UnZCBoYXZl
IHRvIHB1dCB0aGUgbXNwIGludG8gdGhlCj4gZGV2aWNlIHRyZWUgZmlsZXMsIHdoaWNoIGRvbid0
IHlldCBleGlzdCBmb3IgbW9wNTAwIGFuZCBocmVmdjYwLgoKQWx0aG91Z2ggdGhhdCBpcyB0cnVl
LCBpdCdzIG9ubHkgcGFydCBvZiB0aGUgaXNzdWUuCgptb3A1MDBfb2ZfbXNwX2luaXQgaXMgb25s
eSBhIHRlbXBvcmFyeSBzb2x1dGlvbiB0byBhaWQgaW4gc3RlcC1ieS1zdGVwIAplbmFibGVtZW50
IG9mIERUIGZvciBhdWRpby4gQnkgdGhlIGVuZCBvZiB0aGUgcGF0Y2gtc2V0IGl0IGhhcyBiZWVu
IApyZW1vdmVkIChhbG9uZyB3aXRoIHRoZSBjYWxsIHRvIGl0IGlmICdvZl9tYWNoaW5lX2lzX2Nv
bXBhdGlibGUgCigiY2FsYW9zeXN0ZW1zLHNub3diYWxsLWE5NTAwIiknLiBXaGF0IEkgY2FuIGRv
IGl0IHdyaXRlIGEgcGF0Y2ggdG8gCmNvbnNvbGlkYXRlIHRoZSBjYWxscyBfYWZ0ZXJfICJBUk06
IHV4NTAwOiBSZW1vdmUgcGxhdGZvcm0gcmVnaXN0cmF0aW9uIApvZiBNU1AgZGV2aWNlcyIsIGFz
IGEgYm9sdC1vbi4KCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRl
YW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MK
Rm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
