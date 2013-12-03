From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] ASoC: ux500: Dynamically fill DAI
 driver data on probe
Date: Tue, 3 Dec 2013 09:59:58 +0000
Message-ID: <20131203095958.GH11828@lee--X1>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-3-git-send-email-lee.jones@linaro.org>
 <529CCD2F.3060206@metafoo.de> <20131203084026.GC11828@lee--X1>
 <529D9D14.9040109@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 44D8B26514A
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 11:00:05 +0100 (CET)
Received: by mail-ie0-f170.google.com with SMTP id qd12so23496214ieb.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Dec 2013 02:00:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <529D9D14.9040109@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linus.walleij@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

PiA+PlsuLi5dCj4gPj4+K3ZvaWQgdXg1MDBfbXNwX3BvcHVsYXRlX2RhaV9kcnYoc3RydWN0IHNu
ZF9zb2NfZGFpX2RyaXZlciAqdXg1MDBfbXNwX2RhaV9kcnYpCj4gPj4+K3sKPiA+Pj4rCXV4NTAw
X21zcF9kYWlfZHJ2LT5wcm9iZSAgICAgICAgICAgICAgICAgPSB1eDUwMF9tc3BfZGFpX3Byb2Jl
Owo+ID4+PisJdXg1MDBfbXNwX2RhaV9kcnYtPnN1c3BlbmQgICAgICAgICAgICAgICA9IE5VTEw7
Cj4gPj4+Kwl1eDUwMF9tc3BfZGFpX2Rydi0+cmVzdW1lICAgICAgICAgICAgICAgID0gTlVMTDsK
PiA+Pj4rCXV4NTAwX21zcF9kYWlfZHJ2LT5wbGF5YmFjay5jaGFubmVsc19taW4gPSBVWDUwMF9N
U1BfTUlOX0NIQU5ORUxTOwo+ID4+PisJdXg1MDBfbXNwX2RhaV9kcnYtPnBsYXliYWNrLmNoYW5u
ZWxzX21heCA9IFVYNTAwX01TUF9NQVhfQ0hBTk5FTFM7Cj4gPj4+Kwl1eDUwMF9tc3BfZGFpX2Ry
di0+cGxheWJhY2sucmF0ZXMgICAgICAgID0gVVg1MDBfSTJTX1JBVEVTOwo+ID4+PisJdXg1MDBf
bXNwX2RhaV9kcnYtPnBsYXliYWNrLmZvcm1hdHMgICAgICA9IFVYNTAwX0kyU19GT1JNQVRTOwo+
ID4+PisJdXg1MDBfbXNwX2RhaV9kcnYtPmNhcHR1cmUuY2hhbm5lbHNfbWluICA9IFVYNTAwX01T
UF9NSU5fQ0hBTk5FTFM7Cj4gPj4+Kwl1eDUwMF9tc3BfZGFpX2Rydi0+Y2FwdHVyZS5jaGFubmVs
c19tYXggID0gVVg1MDBfTVNQX01BWF9DSEFOTkVMUzsKPiA+Pj4rCXV4NTAwX21zcF9kYWlfZHJ2
LT5jYXB0dXJlLnJhdGVzICAgICAgICAgPSBVWDUwMF9JMlNfUkFURVM7Cj4gPj4+Kwl1eDUwMF9t
c3BfZGFpX2Rydi0+Y2FwdHVyZS5mb3JtYXRzICAgICAgID0gVVg1MDBfSTJTX0ZPUk1BVFM7Cj4g
Pj4+Kwl1eDUwMF9tc3BfZGFpX2Rydi0+b3BzICAgICAgICAgICAgICAgICAgID0gdXg1MDBfbXNw
X2RhaV9vcHM7Cj4gPj4+ICB9Owo+ID4+Cj4gPj5Zb3UgY2FuIGp1c3QgdXNlIHRoZSBzYW1lIHN0
YXRpYyBkcml2ZXIgZm9yIGFsbCBkZXZpY2VzLiBObyBuZWVkIHRvCj4gPj5keW5hbWljYWxseSBh
bGxvY2F0ZSBpdC4KPiA+Cj4gPkhvdyBkbyB5b3UgbWVhbj8gSnVzdCBjcmVhdGUgYSAnc3RhdGlj
IHN0cnVjdCcgaW5zdGVhZD8KPiAKPiBZZXMuCj4gCj4gc3RhdGljIHN0cnVjdCBzbmRfc29jX2Rh
aV9kcml2ZXIgdXg1MDBfbXNwX2RhaV9kcml2ZXIgPSB7Cj4gCS4uLgo+IH07CgpZZXMsIHRoYXQn
cyBubyBpc3N1ZS4gSSB3YXMgbW9yZSBmb2N1c2VkIG9uIHRoZSByZWR1Y3Rpb24gb2YgY29kZQp0
aGFuIGFueXRoaW5nIGVsc2UsIGJ1dCB0aGF0IGlzIGEgYmV0dGVyIGlkZWEuCgpJJ2xsIHJlc3Vi
bWl0LgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0cm9uaWNzIExhbmRpbmcgVGVh
bSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
