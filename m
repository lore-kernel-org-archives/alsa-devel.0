From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/6] ASoC: ux500: Do not clear state if
	already idle
Date: Wed, 8 May 2013 09:04:48 +0100
Message-ID: <20130508080448.GG3102@gmail.com>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-3-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 08AD4261698
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 10:04:55 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id m15so1512135wgh.17
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 01:04:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367997261-32048-3-git-send-email-fabio.baltieri@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwOCBNYXkgMjAxMywgRmFiaW8gQmFsdGllcmkgd3JvdGU6Cgo+IEFzIGVuYWJsZV9t
c3AgZ2V0cyBjYWxsZWQgb25seSBhZnRlciBzb21lIGF1ZGlvIGRhdGEgaGFzIGJlZW4gcmVjZWl2
ZWQsCj4gaWYgdGhlIHVzZXJzcGFjZSBjbG9zZXMgdGhlIGRldmljZSBiZWZvcmUgc2VuZGluZyBh
bnkgZGF0YSBpdCBjYXVzZXMKPiB1eDUwMF9tc3BfaTJzX2Nsb3NlIHRvIGNsZWFyIGRldmljZSBz
dGF0ZSBldmVuIGlmIGl0IHdhcyBub3QgcHJldmlvdXNseQo+IGluaXRpYWxpemVkLgo+IAo+IFRo
aXMgaW4gdHVybnMgbGVhZHMgdG8gc29tZSBub24gbmVjZXNzYXJ5IGJ1dCBoYXJtbGVzcyB3cml0
ZWwsIGJ1dCBhbHNvCiAgIFNpbmd1bGFyIF4KCj4gdG8gZGVjcmVtZW50aW5nIHRoZSBwaW5jdHJs
IHVzYWdlIGNvdW50ZXIgKHBpbmN0cmxfcnh0eF9yZWYpIGJlbG93IHplcm8uCj4gCj4gVG8gcHJl
dmVudCB0aGlzIGZyb20gaGFwcGVuaW5nIGFkZCBhIGNvbmRpdGlvbiB0byBza2lwIHJlZ2lzdGVy
IGFuZAo+IHBpbmN0cmwgY2xlYXIgaWYgY3VycmVudCBtc3Agc3RhdGUgaXMgYWxyZWFkeSBNU1Bf
U1RBVEVfSURMRS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBGYWJpbyBCYWx0aWVyaSA8ZmFiaW8uYmFs
dGllcmlAbGluYXJvLm9yZz4KPiAtLS0KPiAgc291bmQvc29jL3V4NTAwL3V4NTAwX21zcF9pMnMu
YyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy91eDUwMC91eDUwMF9tc3BfaTJzLmMgYi9zb3Vu
ZC9zb2MvdXg1MDAvdXg1MDBfbXNwX2kycy5jCj4gaW5kZXggYTI2YzZiZi4uOTY0Y2ZkNiAxMDA2
NDQKPiAtLS0gYS9zb3VuZC9zb2MvdXg1MDAvdXg1MDBfbXNwX2kycy5jCj4gKysrIGIvc291bmQv
c29jL3V4NTAwL3V4NTAwX21zcF9pMnMuYwo+IEBAIC02MzgsNyArNjM4LDcgQEAgaW50IHV4NTAw
X21zcF9pMnNfY2xvc2Uoc3RydWN0IHV4NTAwX21zcCAqbXNwLCB1bnNpZ25lZCBpbnQgZGlyKQo+
ICAJZGV2X2RiZyhtc3AtPmRldiwgIiVzOiBFbnRlciAoZGlyID0gMHglMDF4KS5cbiIsIF9fZnVu
Y19fLCBkaXIpOwo+ICAKPiAgCXN0YXR1cyA9IGRpc2FibGVfbXNwKG1zcCwgZGlyKTsKPiAtCWlm
IChtc3AtPmRpcl9idXN5ID09IDApIHsKPiArCWlmIChtc3AtPmRpcl9idXN5ID09IDAgJiYgbXNw
LT5tc3Bfc3RhdGUgIT0gTVNQX1NUQVRFX0lETEUpIHsKPiAgCQkvKiBkaXNhYmxlIHNhbXBsZSBy
YXRlIGFuZCBmcmFtZSBnZW5lcmF0b3JzICovCj4gIAkJbXNwLT5tc3Bfc3RhdGUgPSBNU1BfU1RB
VEVfSURMRTsKPiAgCQl3cml0ZWwoKHJlYWRsKG1zcC0+cmVnaXN0ZXJzICsgTVNQX0dDUikgJgoK
Q29kZSBsb29rcyBnb29kIHRob3VnaDoKCkFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFt
IExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZv
bGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
