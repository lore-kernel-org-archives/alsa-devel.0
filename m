From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Wed, 19 Sep 2012 14:29:47 +0200
Message-ID: <20120919122943.GB25479@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
 <20120823125903.GA7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DDEDA2651AE
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 14:29:51 +0200 (CEST)
Received: by eaa13 with SMTP id 13so260851eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 05:29:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120823125903.GA7995@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: roger.xr.nilsson@stericsson.com, 'Linus Walleij' <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Ola Lilja <olalilja@yahoo.se>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBBdWcgMjMsIDIwMTIgYXQgMDE6NTk6MDRQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBUaHUsIEF1ZyAyMywgMjAxMiBhdCAwMToyMDowM1BNICswMTAwLCBMZWUgSm9uZXMg
d3JvdGU6Cj4gPiA+IEkgc2F5IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgbW90aXZhdGlvbiBmb3Ig
dGhpcyBjaGFuZ2UuICBBbGwgdGhlIG1vZGVybgo+ID4gPiBEVCBiaW5kaW5ncyBhcmUgcGVyZmVj
dGx5IGhhcHB5IGhhbmRsaW5nIHRoaXMgd2l0aG91dCBhbiBleHBsaWNpdCBzaGltCj4gPiA+IGlu
IHRoZSBkZXZpY2UgdHJlZSB0byBib2RnZSB0aGluZ3MgZm9yIExpbnV4LCBhZGRpbmcgdGhlbSBp
biBzZWVtcyBsaWtlCj4gPiA+IGl0J2QgYmUgYSByZXRyb2dyYWRlIHN0ZXAuICBXaGF0IGJlbmVm
aXQgZG8geW91IGJlbGlldmUgdGhpcyBicmluZ3M/Cj4gCj4gPiBIb3cgZG8gdGhlIGFsbCB0aGUg
b3RoZXIgRFQ6ZWQgYXVkaW8gZHJpdmVycyBoYW5kbGUgdGhlIFBDTSB0aGVuPyBNb3JlCj4gPiBp
bXBvcnRhbnRseSwgaG93IHdvdWxkIHlvdSBsaWtlIHRvIHNlZSBpdCBoYW5kbGVkPyBPbGEgaGFz
IE5BQ0tlZCB0aGlzCj4gPiBwYXRjaCBhbmQgZXhwbGFpbmVkIHdoeToKPiAKPiBUaGV5IGluc3Rh
bnRpYXRlIHRoZSBQQ00gZHJpdmVyIGR5bmFtaWNhbGx5IGZyb20gdGhlIERBSSB3aGVuIGl0J3MK
PiBwcm9iZWQgd2hpY2ggaXMgcHJldHR5IG11Y2ggd2hhdCB5b3UncmUgcGF0Y2ggaXMgZG9pbmcu
CgpDYW4gd2UgaGF2ZSBzb21lIGNsb3N1cmUgb24gdGhpcyBwYXRjaCBwbGVhc2UsIGFzIGl0J3Mg
YmxvY2tpbmcgdGhlCnBhdGNoLXNldD8gSSdtIGZhaXJseSBzdXJlIHRoZSBwYXRjaCBpcyBkb2lu
ZyB0aGUgY29ycmVjdCB0aGluZywgYXMKc2Vjb25kZWQgYnkgTWFyay4KCi0tIApMZWUgSm9uZXMK
TGluYXJvIFNULUVyaWNzc29uIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4g
c291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3
aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
