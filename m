From: Jeremy McDermond <mcdermj-MdGE8NL7F62ukZHgTAicrQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: simple-card: Add support jack
 detection via codec
Date: Fri, 22 Apr 2016 09:37:39 -0700
Message-ID: <3C927D46-BC52-4B5C-B5B4-CCBA3AAE6F87@xenotropic.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
 <20160421141921.GA25900@rob-hp-laptop> <57197BBA.50304@rock-chips.com>
 <20160422092250.GA3217@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160422092250.GA3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Cj4gT24gQXByIDIyLCAyMDE2LCBhdCAyOjIyIEFNLCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+IHdyb3RlOgo+IAo+IE9uIEZyaSwgQXByIDIyLCAyMDE2IGF0IDA5OjE3OjQ2QU0gKzA4
MDAsIFhpbmcgWmhlbmcgd3JvdGU6Cj4gCj4+IEhpIE1hcmssIHRoZSBvdGhlciBxdWVzdGlvbiBo
ZXJlLCBob3cgZG8gd2UgbWFrZSBzZW5zZSB0byB1c2UgdGhlCj4+IHNpbXBsZS1jYXJkIHRvIGNh
bGwgdGhlICJzbmRfc29jX2RhaV9zZXRfcGxsIiBpZiB0aGUgY29kZWMgKGxpa2UgZGE3MjE5KQo+
PiByZXF1aXJlcyBkbyB0aGlzPwo+IAo+IFdoYXQgd2Ugc2hvdWxkIGRvIHRoZXJlIGlzIG1vdmUg
dGhlIENPREVDIGNsb2NraW5nIHRvIGJlIHJlcHJlc2VudGVkCj4gdXNpbmcgdGhlIGNsb2NrIEFQ
SSBhbmQgdGhlbiB0aGVyZSBhcmUgY29tbW9uIGNsb2NrIGJpbmRpbmdzIHRoYXQKPiBhbHJlYWR5
IGV4aXN0IGZvciBjb25maWd1cmluZyBjbG9ja3MuCgpJ4oCZbSBhIGxpdHRsZSBiaXQgY3VyaW91
cyBhYm91dCB0aGlzLiAgSeKAmW0gd29ya2luZyB3aXRoIHRoZSBjbG9ja2luZwpvbiB0aGUgdGx2
MzIwYWljMzJ4NCBkcml2ZXIgYmVjYXVzZSBJ4oCZbSBkZWFsaW5nIHdpdGggYSBwbGF0Zm9ybSB0
aGF0CndpbGwgYmUgY2xvY2tpbmcgaXQgZnJvbSBhIGR5bmFtaWMgY2xvY2sgY29udHJvbGxlZCBi
eSB0aGUgQ0NGLiAgVGhhdApwcmVzZW50cyBzb21lIHByb2JsZW1zIGJlY2F1c2UgdGhlIGFpYzMy
eDQgZHJpdmVyIGhhcyBhIHRhYmxlIG9mIGNsb2NrCnBhcmFtZXRlcnMgYW5kIHRob3NlIHJlbHkg
b24gdGhlIG1jbGsgcmF0ZSBiZWluZyBhIHByZWNpc2UgdmFsdWUuClRoZSBtY2xrIG1pZ2h0IG5v
dCBiZSBhYmxlIHRvIHByb3ZpZGUgdGhvc2UgZXhhY3QgdmFsdWVzLCBzbyB0aGUKYWljMzJ4NCBk
cml2ZXIgbmVlZHMgdG8gc2V0IGl0cyBQTExzIGFuZCBkaXZpZGVycyBhY2NvcmRpbmdseS4KClRo
ZSBoYXJkd2FyZSBoYXMgYSBjb3VwbGUgb2YgY2xvY2sgbXV4ZXMsIGEgZmV3IGRpdmlkZXJzIGFu
ZCB0aGUKUExMLiAgSXQgc2VlbXMgdG8gYmUgYWJsZSB0byBiZSBtb2RlbGVkIGJ5IHRoZSBjdXJy
ZW50IENDRgpjb21wb25lbnRzIGZhaXJseSB3ZWxsLiAgSeKAmW0ganVzdCB0cnlpbmcgdG8gd3Jh
cCBteSBoZWFkIGFyb3VuZAp3aGVyZSB0aGlzIGFsbCB3b3VsZCBmaXQgaW4uICBTaG91bGQgdGhl
IGNvZGVjIGRyaXZlciBqdXN0IHJlZ2lzdGVyCmEgYnVuY2ggb2YgY2xvY2sgY29tcG9uZW50cyBp
biBpdHMgaW5pdGlhbGl6YXRpb24gc29tZXdoZXJlPwpJ4oCZbSB0aGlua2luZyB0aGF0IGl0IGNh
buKAmXQgaGF2ZSBpdHMgb3duIENDRiBkcml2ZXIgc2VwYXJhdGUgZnJvbQp0aGUgY29kZWMgZHJp
dmVyIGJlY2F1c2UgeW91IHdvbuKAmXQgaGF2ZSBwcm9wZXIgYWNjZXNzIHRvIHRoZQpyZWdpc3Rl
cnMgb3ZlciBJMkMgb3IgU1BJLiAgSSBkb27igJl0IGZpbmQgYSBsb3Qgb2YgZXhhbXBsZXMgaW4g
dGhlCmNvZGVjIGRyaXZlcnMsIGFuZCB0aGVyZSBhcmVu4oCZdCB2ZXJ5IG1hbnkgb3RoZXIgZHJp
dmVycyBpbiB0aGUgdHJlZQp0aGF0IHNlZW0gdG8gcmVnaXN0ZXIgY2xvY2tzIHdpdGggQ0NGIHRo
YXQgSSBjYW4gZmluZC4KCknigJltIGhhcHB5IHRvIHdvcmsgdGhyb3VnaCB0aGlzIHdpdGggdGhl
IGFpYzMyeDQgZHJpdmVyLiAgSSBqdXN0Cm5lZWQgc29tZSBndWlkYW5jZSBvbiBob3cgdG8gZG8g
aXQgc28gaXQgZml0cyBpbiB3ZWxsIHdpdGgKZXZlcnl0aGluZyBlbHNlIHN1cnJvdW5kaW5nIGl0
LgoKLS0KSmVyZW15IE1jRGVybW9uZCAoTkg2WikKWGVub3Ryb3BpYyBTeXN0ZW1zCm1jZGVybWpA
eGVub3Ryb3BpYy5jb20KCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgtcm9ja2NoaXBAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXJvY2tjaGlwCg==
