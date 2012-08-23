From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 14:26:19 +0100
Message-ID: <20120823132618.GB1047@gmail.com>
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
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 27AAD26655E
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 15:26:23 +0200 (CEST)
Received: by eeke50 with SMTP id e50so222317eek.38
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 06:26:22 -0700 (PDT)
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

PiA+ICJJJ20gc29ycnkgYnV0IHRoaXMgcGF0Y2ggaXMgYnJlYWtpbmcgdGhlIGRlc2lnbiBvZiBB
U29DLiBUaGUgQVNvQy0KPiA+IHBsYXRmb3JtIGlzIHRoZSBETUEtYmxvY2sgKGluIGNvbWJpbmF0
aW9uIHdpdGggdGhlIE1TUC1ibG9jayksIGFuZAo+ID4gdGhlcmUgc2hvdWxkIGJlIGEgcGxhdGZv
cm0tZHJpdmVyIGZvciB0aGUgRE1BL1BDTS4gVGhlIHBsYXRmb3JtLWRyaXZlciAKPiA+IHRoZW4g
aGFzIGEgREFJIHdoaWNoIGlzIHRoZSBNU1AuIFRoZSBBU29DIERBSS1saW5rLXN0cnVjdCBzaG91
bGQgaGF2ZQo+ID4gb25lIGRyaXZlciBmb3IgZWFjaCBvZiB0aGVzZSwgc28gdGhlIGR1bW15LWRy
aXZlciBmb3IgUENNIHNob3VsZCBiZQo+ID4gdGhlcmUuIgo+IAo+ID4gU28gSSBkb24ndCByZWFs
bHkga25vdyB3aGVyZSB0byBnbyB3aXRoIGl0LiBBbnkgaWRlYXM/Cj4gCj4gSSB0aGluayBPbGEg
aXMgc3VnZ2VzdGluZyBwcm9iaW5nIHRoZSBETUEgZHJpdmVyIGZyb20gdGhlIG1hY2hpbmUgd2hp
Y2gKPiB3aWxsIGFsc28gd29yayB0aG91Z2ggSSdtIG5vdCAxMDAlIHN1cmUgaWYgSSdtIHBhcnNp
bmcgdGhlIGFib3ZlCj4gY29ycmVjdGx5LiAgVGhlIGlzc3VlIGluIERUIHRlcm1zIGlzIHRoYXQg
aWYgdGhlIERNQSBjb250cm9sbGVyIGlzCj4gc2hhcmVkIHdpdGggYSBidW5jaCBvZiBvdGhlciBJ
UHMgdGhlbiBpdCBzaG91bGQgaGF2ZSBvbmUgbm9kZSBzaGFyZWQKPiBiZXR3ZWVuIHRoZW0gYWxs
IGFuZCBub3QgYSBidW5jaCBvZiBzaGltIG5vZGVzIGluc2VydGVkIGluIHRoZSBtaWRkbGUKPiB3
aGljaCBvbmx5IGV4aXN0cyBkdWUgdG8gdGhlIHdheSBMaW51eCBpbnN0YW50aWF0ZXMgc3R1ZmYu
CgpXaGVuIHlvdSBzYXkgJ21hY2hpbmUnLCBkbyB5b3UgbWVhbiBmcm9tIGFyY2gvPGFyY2g+L21h
Y2gtKj8gSWYgc28sIEknbQprZWVuIGZvciB0aGF0IG5vdCB0byBoYXBwZW4uCgo+ID4gSG93IGRv
IHRoZSBhbGwgdGhlIG90aGVyIERUOmVkIGF1ZGlvIGRyaXZlcnMgaGFuZGxlIHRoZSBQQ00gdGhl
bj8gTW9yZQo+ID4gaW1wb3J0YW50bHksIGhvdyB3b3VsZCB5b3UgbGlrZSB0byBzZWUgaXQgaGFu
ZGxlZD8gT2xhIGhhcyBOQUNLZWQgdGhpcwo+ID4gcGF0Y2ggYW5kIGV4cGxhaW5lZCB3aHk6Cj4g
Cj4gVGhleSBpbnN0YW50aWF0ZSB0aGUgUENNIGRyaXZlciBkeW5hbWljYWxseSBmcm9tIHRoZSBE
QUkgd2hlbiBpdCdzCj4gcHJvYmVkIHdoaWNoIGlzIHByZXR0eSBtdWNoIHdoYXQgeW91J3JlIHBh
dGNoIGlzIGRvaW5nLgoKU28gdGhleSBkbyBpdCBpbiB0aGUgc2FtZSB3aHkgSSBoYXZlIHdpdGgg
dGhpcyBwYXRjaD8gRG8geW91IGtub3cgd2h5Ck9sYSBtaWdodCB0aGluayB0aGlzIGlzIGEgYmFk
IGlkZWE/CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVh
ZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93
IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
