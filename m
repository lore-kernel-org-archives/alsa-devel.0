From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v2 4/8] sound: soc: pxa: Suppress
	SND_MMP_SOC for arm64
Date: Thu, 23 Feb 2017 15:45:56 +0100
Message-ID: <48c91f5d-6ff3-af67-c4eb-4e958a7de465@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
 <20170222022929.10540-5-afaerber@suse.de>
 <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
 <473e4976-77eb-4b67-e874-ae6bd717ddaa@suse.de> <s5hefyp6l4i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9FEC266703
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 15:45:58 +0100 (CET)
In-Reply-To: <s5hefyp6l4i.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: info@andromedabox.org, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

QW0gMjMuMDIuMjAxNyB1bSAxNToyNCBzY2hyaWViIFRha2FzaGkgSXdhaToKPiBPbiBUaHUsIDIz
IEZlYiAyMDE3IDE1OjExOjQ2ICswMTAwLAo+IEFuZHJlYXMgRsOkcmJlciB3cm90ZToKPj4gQW0g
MjIuMDIuMjAxNyB1bSAxOTo0NyBzY2hyaWViIE1hcmsgQnJvd246Cj4+PiBQbGVhc2UgdXNlIHN1
YmplY3QgbGluZXMgbWF0Y2hpbmcgdGhlIHN0eWxlIGZvciB0aGUgc3Vic3lzdGVtLiAgVGhpcwo+
Pj4gbWFrZXMgaXQgZWFzaWVyIGZvciBwZW9wbGUgdG8gaWRlbnRpZnkgcmVsZXZhbnQgcGF0Y2hl
cy4KPj4KPj4gU2hvdWxkIEkgbWFrZSBpdCAiQVNvQzogcHhhOiAuLi4iIHRoZW4/IFNORF9NTVBf
U09DIHNlbGVjdHMgU05EX0FSTSwKPj4gd2hpY2ggaW4gc291bmQvYXJtL0tjb25maWcgc2F5cyAn
RHJpdmVycyB0aGF0IGFyZSBpbXBsZW1lbnRlZCBvbiBBU29DCj4+IGNhbiBiZSBmb3VuZCBpbiAi
QUxTQSBmb3IgU29DIGF1ZGlvIHN1cHBvcnQiIHNlY3Rpb24uJywgd2hpY2ggY29uZnVzZWQKPj4g
bWUgYWJvdXQgd2hldGhlciBvciBub3QgdGhpcyBpcyBhbiBBU29DIGNvbXBsaWFudCBkcml2ZXIg
aWYgaXQgc2VsZWN0cyBhCj4+IG5vbi1BU29DIHN5bWJvbC4KPiAKPiBJdCdzIGEgYnVnIHRoYXQg
c2VsZWN0cyBTTkRfQVJNIHRoZXJlLiAgSSBndWVzcyB0aGlzIHdhcyB3cm9uZ2x5IHRha2VuCj4g
ZnJvbSB0aGUgb2xkIGV4YW1wbGUgb2YgQUM5NyBBUk0gU29DIGNvZGUsIHdoaWNoIHdhcyBmaXhl
ZCBsYXRlci4KPiBBU29DIHN0dWZmIGlzIGJhc2ljYWxseSBpcnJlbGV2YW50IGZyb20gdGhlIGxl
Z2FjeSBzb3VuZC9hcm0vKi4KClRoYW5rcywgVGFrYXNoaS1zYW4uIEknbGwgdXBkYXRlIGFzIGZv
bGxvd3MgdGhlbi4KCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvcHhhL0tjb25maWcgYi9zb3VuZC9z
b2MvcHhhL0tjb25maWcKaW5kZXggZjhlMWMwNi4uYWJhNzIxMyAxMDA2NDQKLS0tIGEvc291bmQv
c29jL3B4YS9LY29uZmlnCisrKyBiL3NvdW5kL3NvYy9weGEvS2NvbmZpZwpAQCAtOSwxMCArOSw5
IEBAIGNvbmZpZyBTTkRfUFhBMlhYX1NPQwoKIGNvbmZpZyBTTkRfTU1QX1NPQwogICAgICAgIGJv
b2wgIlNvQyBBdWRpbyBmb3IgTWFydmVsbCBNTVAgY2hpcHMiCi0gICAgICAgZGVwZW5kcyBvbiBB
UkNIX01NUCAmJiBBUk0KLSAgICAgICBzZWxlY3QgTU1QX1NSQU0KKyAgICAgICBkZXBlbmRzIG9u
IEFSQ0hfTU1QIHx8IENPTVBJTEVfVEVTVAorICAgICAgIHNlbGVjdCBNTVBfU1JBTSBpZiBBUk0K
ICAgICAgICBzZWxlY3QgU05EX1NPQ19HRU5FUklDX0RNQUVOR0lORV9QQ00KLSAgICAgICBzZWxl
Y3QgU05EX0FSTQogICAgICAgIGhlbHAKICAgICAgICAgIFNheSBZIGlmIHlvdSB3YW50IHRvIGFk
ZCBzdXBwb3J0IGZvciBjb2RlY3MgYXR0YWNoZWQgdG8KICAgICAgICAgIHRoZSBNTVAgU1NQQSBp
bnRlcmZhY2UuCgpPa2F5IHRvIGRvIHRoYXQgaW4gb25lIHBhdGNoIG9yIGJyZWFrIHVwIGludG8g
dGhyZWU/CgpSZWdhcmRzLApBbmRyZWFzCgotLSAKU1VTRSBMaW51eCBHbWJILCBNYXhmZWxkc3Ry
LiA1LCA5MDQwOSBOw7xybmJlcmcsIEdlcm1hbnkKR0Y6IEZlbGl4IEltZW5kw7ZyZmZlciwgSmFu
ZSBTbWl0aGFyZCwgR3JhaGFtIE5vcnRvbgpIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
