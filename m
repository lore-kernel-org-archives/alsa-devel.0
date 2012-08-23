From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 15:59:06 +0100
Message-ID: <20120823145904.GC1047@gmail.com>
References: <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
 <20120823121936.GA1047@gmail.com>
 <20120823125903.GA7995@opensource.wolfsonmicro.com>
 <20120823132618.GB1047@gmail.com>
 <20120823143757.GB7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CDF3A266599
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 16:59:09 +0200 (CEST)
Received: by eeke50 with SMTP id e50so262520eek.38
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 07:59:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120823143757.GB7995@opensource.wolfsonmicro.com>
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

T24gVGh1LCBBdWcgMjMsIDIwMTIgYXQgMDM6Mzc6NTdQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToKPiBPbiBUaHUsIEF1ZyAyMywgMjAxMiBhdCAwMjoyNjoxOVBNICswMTAwLCBMZWUgSm9uZXMg
d3JvdGU6Cj4gCj4gPiA+IEkgdGhpbmsgT2xhIGlzIHN1Z2dlc3RpbmcgcHJvYmluZyB0aGUgRE1B
IGRyaXZlciBmcm9tIHRoZSBtYWNoaW5lIHdoaWNoCj4gPiA+IHdpbGwgYWxzbyB3b3JrIHRob3Vn
aCBJJ20gbm90IDEwMCUgc3VyZSBpZiBJJ20gcGFyc2luZyB0aGUgYWJvdmUKPiA+ID4gY29ycmVj
dGx5LiAgVGhlIGlzc3VlIGluIERUIHRlcm1zIGlzIHRoYXQgaWYgdGhlIERNQSBjb250cm9sbGVy
IGlzCj4gPiA+IHNoYXJlZCB3aXRoIGEgYnVuY2ggb2Ygb3RoZXIgSVBzIHRoZW4gaXQgc2hvdWxk
IGhhdmUgb25lIG5vZGUgc2hhcmVkCj4gPiA+IGJldHdlZW4gdGhlbSBhbGwgYW5kIG5vdCBhIGJ1
bmNoIG9mIHNoaW0gbm9kZXMgaW5zZXJ0ZWQgaW4gdGhlIG1pZGRsZQo+ID4gPiB3aGljaCBvbmx5
IGV4aXN0cyBkdWUgdG8gdGhlIHdheSBMaW51eCBpbnN0YW50aWF0ZXMgc3R1ZmYuCj4gCj4gPiBX
aGVuIHlvdSBzYXkgJ21hY2hpbmUnLCBkbyB5b3UgbWVhbiBmcm9tIGFyY2gvPGFyY2g+L21hY2gt
Kj8gSWYgc28sIEknbQo+ID4ga2VlbiBmb3IgdGhhdCBub3QgdG8gaGFwcGVuLgo+IAo+IE5vLCBz
b3VuZC9zb2MvdXg1MDAvc25vd2JhbGwuYyBvciB3aGF0ZXZlci4gIEF0IGxlYXN0IHRoYXQncyBt
eSBndWVzcy4KCkFoLCBJIHNlZS4gTWF5YmUgdGhlIG1vcDUwMC5jIGZpbGUgdGhlbi4KCj4gPiA+
IFRoZXkgaW5zdGFudGlhdGUgdGhlIFBDTSBkcml2ZXIgZHluYW1pY2FsbHkgZnJvbSB0aGUgREFJ
IHdoZW4gaXQncwo+ID4gPiBwcm9iZWQgd2hpY2ggaXMgcHJldHR5IG11Y2ggd2hhdCB5b3UncmUg
cGF0Y2ggaXMgZG9pbmcuCj4gCj4gPiBTbyB0aGV5IGRvIGl0IGluIHRoZSBzYW1lIHdoeSBJIGhh
dmUgd2l0aCB0aGlzIHBhdGNoPyBEbyB5b3Uga25vdyB3aHkKPiA+IE9sYSBtaWdodCB0aGluayB0
aGlzIGlzIGEgYmFkIGlkZWE/Cj4gCj4gSSdtIG5vdCAxMDAlIHN1cmUsIEknbSBndWVzc2luZyBp
dCBtaWdodCBiZSBkb3duIHRvIHRoZSBmYWN0IHRoYXQgeW91Cj4gZW5kIHVwIHdpdGggbXVsdGlw
bGUgUENNIGRyaXZlcnMuICBXZSBjb3VsZCBhdm9pZCB0aGF0IHdpdGggcmVmY291bnRpbmcKPiBi
dXQgbm9ib2R5J3MgcmVhbGx5IHdvcnJpZWQgYWJvdXQgaXQuCgpJIHRoaW5rIEknbGwgd2FpdCBm
b3IgT2xhIHRvIGdldCBiYWNrLCBhcyBoZSdzIHRoZSBleHBlcnQgb24gdGhpcyBzdHVmZi4KCkkn
bGwgYXR0ZW1wdCB0byByZS1qaWcgdGhlIHBhdGNoLXNldCwgYXMgdGhpcyBpcyBhIGJsb2NrZXIg
YXRtLgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQK
TGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBM
aW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
