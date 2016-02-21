From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] Revert "ASoC: fsl_ssi: remove explicit
	register defaults"
Date: Sun, 21 Feb 2016 18:41:00 -0300
Message-ID: <CAOMZO5BVCZ-w8We2=9MATSL-S0Rap-L9NzCxO=Aqi=3_LnwqTA@mail.gmail.com>
References: <1456065300-23752-1-git-send-email-festevam@gmail.com>
 <56CA0C56.8060109@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1D426057F
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 22:41:02 +0100 (CET)
Received: by mail-io0-f179.google.com with SMTP id 9so160120875iom.1
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 13:41:02 -0800 (PST)
In-Reply-To: <56CA0C56.8060109@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
List-Id: alsa-devel@alsa-project.org

SGkgTWFjaWVqLAoKT24gU3VuLCBGZWIgMjEsIDIwMTYgYXQgNDoxMyBQTSwgTWFjaWVqIFMuIFN6
bWlnaWVybwo8bWFpbEBtYWNpZWouc3ptaWdpZXJvLm5hbWU+IHdyb3RlOgo+IE9uIDIxLjAyLjIw
MTYgMTU6MzUsIEZhYmlvIEVzdGV2YW0gd3JvdGU6Cj4+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZh
YmlvLmVzdGV2YW1AbnhwLmNvbT4KPj4KPj4gQ29tbWl0IDVjNDA4ZmVlMjU0NiAoIkFTb0M6IGZz
bF9zc2k6IHJlbW92ZSBleHBsaWNpdCByZWdpc3RlciBkZWZhdWx0cyIpCj4+IGNhdXNlcyB0aGUg
ZHJpdmVyIHRvIGZhaWwgdG8gcHJvYmU6Cj4+Cj4+IGZzbC1zc2ktZGFpIDIwMjgwMDAuc3NpOiBO
byBjYWNoZSBkZWZhdWx0cywgcmVhZGluZyBiYWNrIGZyb20gSFcKPj4gZnNsLXNzaS1kYWkgMjAy
ODAwMC5zc2k6IEZhaWxlZCB0byBpbml0IHJlZ2lzdGVyIG1hcAo+PiBmc2wtc3NpLWRhaTogcHJv
YmUgb2YgMjAyODAwMC5zc2kgZmFpbGVkIHdpdGggZXJyb3IgLTIyCj4+Cj4+ICwgc28gcmV2ZXJ0
IHRoaXMgY29tbWl0Lgo+Pgo+PiBDYzogTWFjaWVqIFMuIFN6bWlnaWVybyA8bWFpbEBtYWNpZWou
c3ptaWdpZXJvLm5hbWU+Cj4+IFJlcG9ydGVkLWJ5OiBNaWthIFBlbnR0aWzDpCA8bWlrYS5wZW50
dGlsYUBuZXh0Zm91ci5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIEVzdGV2YW0gPGZhYmlv
LmVzdGV2YW1AbnhwLmNvbT4KPj4gLS0tCj4+IE1hY2llaiwKPj4KPj4gQXMgdGhpcyBjdXJyZW50
bHkgYnJlYWtzIFNTSSBvbiA0LjUtcmMgd2Ugc2hvdWxkIGJldHRlciByZXZlcnQgaXQgZm9yCj4+
IHRoaXMgY3ljbGUuCj4+Cj4+IFdlIGNhbiB0aGVuIGFkZCBpdCBiYWNrIHRvIDQuNyB3aGVuIE1h
cmsncyBwYXRjaCAzMjQ1ZDQ2MGExZWI1NQo+PiAoInJlZ21hcDogY2FjaGU6IEZhbGwgYmFjayB0
byByZWdpc3RlciBieSByZWdpc3RlciByZWFkIGZvciBjYWNoZSBkZWZhdWx0cyIpCj4+IHdpbGwg
YmUgYXZhaWxhYmxlIGFuZCB0aGVuIHRoZSBkcml2ZXIgd2lsbCB3b3JrIGZpbmUgd2l0aCB5b3Vy
IHBhdGNoLgo+Cj4gV2hpbGUgSSBzZWUgbm8gcHJvYmxlbSB3aXRoIGRlbGF5aW5nIHRoaXMgcGF0
Y2ggdG8gbmV4dCBrZXJuZWwgd291bGRuJ3QKPiBpdCBiZSBlYXNpZXIgdG8gc2ltcGx5IG1lcmdl
IHRoZSByZWdtYXAgY2hhbmdlIGFzIGEgZml4IGFzIHlvdQo+IGhhZCBzdWdnZXN0ZWQgcHJldmlv
dXNseT8KClRoYXQgd291bGQgd29yayB0b28sIGJ1dCBhcyB3ZSBhcmUgbGF0ZSBpbiB0aGUgNC41
LXJjIGN5Y2xlIHdlIGZhY2UKdGhlIHJpc2sgb2YgYnJlYWtpbmcgc29tZSBvdGhlciBkcml2ZXJz
IGFmdGVyIGFwcGx5aW5nIDMyNDVkNDYwYTFlYjU1CigicmVnbWFwOiBjYWNoZTogRmFsbCBiYWNr
IHRvIHJlZ2lzdGVyIGJ5IHJlZ2lzdGVyIHJlYWQgZm9yIGNhY2hlCmRlZmF1bHRzIikuCgpTbyBl
aXRoZXIgdGhpcyByZXZlcnQgb3IgYXBwbHlpbmcgMzI0NWQ0NjBhMWViNTUgd291bGQgd29yaywg
YnV0IHRoZQpyZXZlcnQgaXMgYml0IHNhZmVyIElNSE8uCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
