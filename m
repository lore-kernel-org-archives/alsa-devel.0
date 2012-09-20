From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise
 PCM from MSP probe rather than as a device
Date: Thu, 20 Sep 2012 14:52:59 +0200
Message-ID: <20120920125259.GA2755@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
 <505ADBE6.6080509@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 65F98265315
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 14:53:05 +0200 (CEST)
Received: by eeke50 with SMTP id e50so818650eek.38
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 05:53:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <505ADBE6.6080509@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

PiA+IENhbiB3ZSBoYXZlIHNvbWUgY2xvc3VyZSBvbiB0aGlzIHBhdGNoIHBsZWFzZSwgYXMgaXQn
cyBibG9ja2luZyB0aGUKPiA+IHBhdGNoLXNldD8gSSdtIGZhaXJseSBzdXJlIHRoZSBwYXRjaCBp
cyBkb2luZyB0aGUgY29ycmVjdCB0aGluZywgYXMKPiA+IHNlY29uZGVkIGJ5IE1hcmsuCj4gCj4g
SSBzdGlsbCBkb24ndCBsaWtlIHRoaXMuIEl0IGlzIHRoZSBkYWlfbGluay1zdHJ1Y3QgdGhhdCBi
b3RoZXJzIG1lLiBXZSBoYXZlCj4gInV4NTAwLW1zcC1pMnMuMSIgYXMgbmFtZSBvZiB0aGUgcGxh
dGZvcm0gQU5EIHRoZSBjcHVfZGFpLiBUaGUgTVNQIEkyUy1ibG9jayBpcwo+IG5vdCB0aGUgcGxh
dGZvcm0gYW5kIGl0IGlzIGNlcnRhaW5seSBub3QgYm90aCBwbGF0Zm9ybSBhbmQgY3B1LURBSSBh
dCB0aGUgc2FtZSB0aW1lLgo+IE1hcms6IERpZCB5b3UgaGF2ZSBhIHNvbHV0aW9uIGZvciB0aGlz
PyBDb3VsZG4ndCB3ZSBqdXN0IHB1dCBOVUxMIG9uIHRoZQo+IHBsYXRmb3JtX25hbWUgaW5zdGVh
ZD8KClRoZXJlIGFyZSBvdGhlciBkcml2ZXJzIHdoaWNoIGRvIHRoaXMgYWxyZWFkeS4gCgpJIGRv
bid0IHRoaW5rIGl0J3MgYW4gaXNzdWUgdG8gZG8gdGhpcy4KCi0tIApMZWUgSm9uZXMKTGluYXJv
IFNULUVyaWNzc29uIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIg
fCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
