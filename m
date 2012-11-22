From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
Date: Thu, 22 Nov 2012 14:05:40 +0000
Message-ID: <20121122140540.GA10986@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
 <505ADBE6.6080509@stericsson.com> <20120920125259.GA2755@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120920125259.GA2755@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAyMCBTZXAgMjAxMiwgTGVlIEpvbmVzIHdyb3RlOgoKPiA+ID4gQ2FuIHdlIGhhdmUg
c29tZSBjbG9zdXJlIG9uIHRoaXMgcGF0Y2ggcGxlYXNlLCBhcyBpdCdzIGJsb2NraW5nIHRoZQo+
ID4gPiBwYXRjaC1zZXQ/IEknbSBmYWlybHkgc3VyZSB0aGUgcGF0Y2ggaXMgZG9pbmcgdGhlIGNv
cnJlY3QgdGhpbmcsIGFzCj4gPiA+IHNlY29uZGVkIGJ5IE1hcmsuCj4gPiAKPiA+IEkgc3RpbGwg
ZG9uJ3QgbGlrZSB0aGlzLiBJdCBpcyB0aGUgZGFpX2xpbmstc3RydWN0IHRoYXQgYm90aGVycyBt
ZS4gV2UgaGF2ZQo+ID4gInV4NTAwLW1zcC1pMnMuMSIgYXMgbmFtZSBvZiB0aGUgcGxhdGZvcm0g
QU5EIHRoZSBjcHVfZGFpLiBUaGUgTVNQIEkyUy1ibG9jayBpcwo+ID4gbm90IHRoZSBwbGF0Zm9y
bSBhbmQgaXQgaXMgY2VydGFpbmx5IG5vdCBib3RoIHBsYXRmb3JtIGFuZCBjcHUtREFJIGF0IHRo
ZSBzYW1lIHRpbWUuCj4gPiBNYXJrOiBEaWQgeW91IGhhdmUgYSBzb2x1dGlvbiBmb3IgdGhpcz8g
Q291bGRuJ3Qgd2UganVzdCBwdXQgTlVMTCBvbiB0aGUKPiA+IHBsYXRmb3JtX25hbWUgaW5zdGVh
ZD8KPiAKPiBUaGVyZSBhcmUgb3RoZXIgZHJpdmVycyB3aGljaCBkbyB0aGlzIGFscmVhZHkuIAo+
IAo+IEkgZG9uJ3QgdGhpbmsgaXQncyBhbiBpc3N1ZSB0byBkbyB0aGlzLgoKSGFzIGFueW9uZSBo
YWQgYW55IG1vcmUgYnJpZ2h0IGlkZWFzIG9uIGhvdyB3ZSBtaWdodCBoYW5kbGUgdGhpcz8KClRo
ZSBkZXZpY2UgaXMgc3RpbGwgYmVpbmcgaGFuZGxlZCBpbiBwbGF0Zm9ybSBjb2RlIGFuZCBJJ20g
ZGVzcGVyYXRlCnRvIGdldCBpdCBvdXQgb2YgdGhlcmUuCgotLSAKTGVlIEpvbmVzCkxpbmFybyBT
VC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBz
b2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwg
QmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
