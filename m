From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: wm5110: ARIZONA_CLOCK_CONTROL
	should be volatile
Date: Mon, 9 May 2016 12:16:47 +0100
Message-ID: <20160509111647.GH8324@dell>
References: <1461686780-22885-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1461686780-22885-2-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 561C82606F5
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 13:16:36 +0200 (CEST)
Received: by mail-wm0-f43.google.com with SMTP id e201so132560515wme.0
 for <alsa-devel@alsa-project.org>; Mon, 09 May 2016 04:16:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461686780-22885-2-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCAyNiBBcHIgMjAxNiwgUmljaGFyZCBGaXR6Z2VyYWxkIHdyb3RlOgoKPiBTb21lIG9m
IHRoZSBiaXRzIGluIHRoaXMgcmVnaXN0ZXIgY2FuIGJlIGNoYW5nZWQgYnkgdGhlIGNvZGVjCj4g
c28gd2UgbXVzdCBtYXJrIGl0IHZvbGF0aWxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQg
Rml0emdlcmFsZCA8cmZAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+ICBkcml2
ZXJzL21mZC93bTUxMTAtdGFibGVzLmMgfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpBcHBsaWVkLCB0aGFua3MuCgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC93bTUx
MTAtdGFibGVzLmMgYi9kcml2ZXJzL21mZC93bTUxMTAtdGFibGVzLmMKPiBpbmRleCA4ZTc0ZTcx
Li4xZWU2OGJkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbWZkL3dtNTExMC10YWJsZXMuYwo+ICsr
KyBiL2RyaXZlcnMvbWZkL3dtNTExMC10YWJsZXMuYwo+IEBAIC0zMDY2LDYgKzMwNjYsNyBAQCBz
dGF0aWMgYm9vbCB3bTUxMTBfdm9sYXRpbGVfcmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2LCB1
bnNpZ25lZCBpbnQgcmVnKQo+ICAJY2FzZSBBUklaT05BX0FPRF9JUlFfUkFXX1NUQVRVUzoKPiAg
CWNhc2UgQVJJWk9OQV9GWF9DVFJMMjoKPiAgCWNhc2UgQVJJWk9OQV9BU1JDX1NUQVRVUzoKPiAr
CWNhc2UgQVJJWk9OQV9DTE9DS19DT05UUk9MOgo+ICAJY2FzZSBBUklaT05BX0RTUF9TVEFUVVM6
Cj4gIAljYXNlIEFSSVpPTkFfRFNQMV9TVEFUVVNfMToKPiAgCWNhc2UgQVJJWk9OQV9EU1AxX1NU
QVRVU18yOgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0cm9uaWNzIExhbmRpbmcg
VGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29D
cwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
