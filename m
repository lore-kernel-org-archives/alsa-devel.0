From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/6] ARM: ux500: Ensure probing of Audio
 devices when Device Tree is enabled
Date: Wed, 01 Aug 2012 08:34:06 +0100
Message-ID: <5018DBEE.9090203@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-11-git-send-email-lee.jones@linaro.org>
 <201207312054.13818.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AE735265357
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 09:34:06 +0200 (CEST)
Received: by eaaa13 with SMTP id a13so1301815eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 00:34:08 -0700 (PDT)
In-Reply-To: <201207312054.13818.arnd@arndb.de>
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

T24gMzEvMDcvMTIgMjE6NTQsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gT24gVHVlc2RheSAzMSBK
dWx5IDIwMTIsIExlZSBKb25lcyB3cm90ZToKPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
dXg1MDAvYm9hcmQtbW9wNTAwLmMgYi9hcmNoL2FybS9tYWNoLXV4NTAwL2JvYXJkLW1vcDUwMC5j
Cj4+IGluZGV4IGU2NDEwMDMuLjg3YTVjZDcgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtL21hY2gt
dXg1MDAvYm9hcmQtbW9wNTAwLmMKPj4gKysrIGIvYXJjaC9hcm0vbWFjaC11eDUwMC9ib2FyZC1t
b3A1MDAuYwo+PiBAQCAtNzk0LDYgKzc5NCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB1ODUwMF9p
bml0X21hY2hpbmUodm9pZCkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVJS
QVlfU0laRShtb3A1MDBfcGxhdGZvcm1fZGV2cykpOwo+Pgo+PiAgICAgICAgICAgICAgICAgIG1v
cDUwMF9zZGlfaW5pdChwYXJlbnQpOwo+PiArICAgICAgICAgICAgICAgbW9wNTAwX21zcF9pbml0
KHBhcmVudCk7Cj4+ICAgICAgICAgICAgICAgICAgaTJjMF9kZXZzID0gQVJSQVlfU0laRShtb3A1
MDBfaTJjMF9kZXZpY2VzKTsKPj4gICAgICAgICAgICAgICAgICBpMmNfcmVnaXN0ZXJfYm9hcmRf
aW5mbygwLCBtb3A1MDBfaTJjMF9kZXZpY2VzLCBpMmMwX2RldnMpOwo+PiAgICAgICAgICAgICAg
ICAgIGkyY19yZWdpc3Rlcl9ib2FyZF9pbmZvKDIsIG1vcDUwMF9pMmMyX2RldmljZXMsCj4+IEBA
IC04MDEsNiArODAyLDggQEAgc3RhdGljIHZvaWQgX19pbml0IHU4NTAwX2luaXRfbWFjaGluZSh2
b2lkKQo+Pgo+PiAgICAgICAgICAgICAgICAgIG1vcDUwMF91aWJfaW5pdCgpOwo+Pgo+PiArICAg
ICAgIH0gZWxzZSBpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJjYWxhb3N5c3RlbXMsc25v
d2JhbGwtYTk1MDAiKSkgewo+PiArICAgICAgICAgICAgICAgbW9wNTAwX29mX21zcF9pbml0KHBh
cmVudCk7Cj4+ICAgICAgICAgIH0gZWxzZSBpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJz
dC1lcmljc3NvbixocmVmdjYwKyIpKSB7Cj4+ICAgICAgICAgICAgICAgICAgLyoKPj4gICAgICAg
ICAgICAgICAgICAgKiBUaGUgSFJFRnY2MCBib2FyZCByZW1vdmVkIGEgR1BJTyBleHBhbmRlciBh
bmQgcm91dGVkCj4+IEBAIC04MTIsNiArODE1LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHU4NTAw
X2luaXRfbWFjaGluZSh2b2lkKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBB
UlJBWV9TSVpFKG1vcDUwMF9wbGF0Zm9ybV9kZXZzKSk7Cj4+Cj4+ICAgICAgICAgICAgICAgICAg
aHJlZnY2MF9zZGlfaW5pdChwYXJlbnQpOwo+PiArICAgICAgICAgICAgICAgbW9wNTAwX21zcF9p
bml0KHBhcmVudCk7Cj4+Cj4+ICAgICAgICAgICAgICAgICAgaTJjMF9kZXZzID0gQVJSQVlfU0la
RShtb3A1MDBfaTJjMF9kZXZpY2VzKTsKPj4gICAgICAgICAgICAgICAgICBpMmMwX2RldnMgLT0g
TlVNX1BSRV9WNjBfSTJDMF9ERVZJQ0VTOwo+Cj4KPiBMb29rcyBsaWtlIHlvdSdyZSBhZGRpbmcg
dGhlIHNhbWUgY2FsbCB0byBlYWNoIG9mIHRoZSB0aHJlZSBjYXNlczoKPiBtb3A1MDAsIHNub3di
YWxsIGFuZCBocmVmdjYwKy4gSG93IGFib3V0IG1vdmluZyBpdCBiZWZvcmUgb3IgYWZ0ZXIKPiB0
aGUgaWYvZWxzZWlmIGJsb2NrPwoKVGhlIFNub3diYWxsIG9uZSBpcyBkaWZmZXJlbnQgJ21vcDUw
MF9tc3BfaW5pdCcgLT4gJ21vcDUwMF9vZl9tc3BfaW5pdCcuCgotLSAKTGVlIEpvbmVzCkxpbmFy
byBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJj
ZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVy
IHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
