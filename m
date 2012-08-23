From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 23 Aug 2012 13:20:03 +0100
Message-ID: <20120823121936.GA1047@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
 <20120823092216.GA27264@gmail.com>
 <20120823113922.GZ7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 553212661AA
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 14:20:07 +0200 (CEST)
Received: by eeke50 with SMTP id e50so197112eek.38
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 05:20:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120823113922.GZ7995@opensource.wolfsonmicro.com>
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

PiBJIHNheSBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgY2hhbmdl
LiAgQWxsIHRoZSBtb2Rlcm4KPiBEVCBiaW5kaW5ncyBhcmUgcGVyZmVjdGx5IGhhcHB5IGhhbmRs
aW5nIHRoaXMgd2l0aG91dCBhbiBleHBsaWNpdCBzaGltCj4gaW4gdGhlIGRldmljZSB0cmVlIHRv
IGJvZGdlIHRoaW5ncyBmb3IgTGludXgsIGFkZGluZyB0aGVtIGluIHNlZW1zIGxpa2UKPiBpdCdk
IGJlIGEgcmV0cm9ncmFkZSBzdGVwLiAgV2hhdCBiZW5lZml0IGRvIHlvdSBiZWxpZXZlIHRoaXMg
YnJpbmdzPwoKSG93IGRvIHRoZSBhbGwgdGhlIG90aGVyIERUOmVkIGF1ZGlvIGRyaXZlcnMgaGFu
ZGxlIHRoZSBQQ00gdGhlbj8gTW9yZQppbXBvcnRhbnRseSwgaG93IHdvdWxkIHlvdSBsaWtlIHRv
IHNlZSBpdCBoYW5kbGVkPyBPbGEgaGFzIE5BQ0tlZCB0aGlzCnBhdGNoIGFuZCBleHBsYWluZWQg
d2h5OgoKIkknbSBzb3JyeSBidXQgdGhpcyBwYXRjaCBpcyBicmVha2luZyB0aGUgZGVzaWduIG9m
IEFTb0MuIFRoZSBBU29DLQpwbGF0Zm9ybSBpcyB0aGUgRE1BLWJsb2NrIChpbiBjb21iaW5hdGlv
biB3aXRoIHRoZSBNU1AtYmxvY2spLCBhbmQKdGhlcmUgc2hvdWxkIGJlIGEgcGxhdGZvcm0tZHJp
dmVyIGZvciB0aGUgRE1BL1BDTS4gVGhlIHBsYXRmb3JtLWRyaXZlciAKdGhlbiBoYXMgYSBEQUkg
d2hpY2ggaXMgdGhlIE1TUC4gVGhlIEFTb0MgREFJLWxpbmstc3RydWN0IHNob3VsZCBoYXZlCm9u
ZSBkcml2ZXIgZm9yIGVhY2ggb2YgdGhlc2UsIHNvIHRoZSBkdW1teS1kcml2ZXIgZm9yIFBDTSBz
aG91bGQgYmUKdGhlcmUuIgoKU28gSSBkb24ndCByZWFsbHkga25vdyB3aGVyZSB0byBnbyB3aXRo
IGl0LiBBbnkgaWRlYXM/CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5n
IFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
