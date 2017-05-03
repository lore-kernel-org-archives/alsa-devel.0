From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH 0/2] ASoC: sunxi: Add ADC support for A33
Date: Wed, 3 May 2017 16:02:54 +0200
Message-ID: <66e3f902-e24c-459a-56fb-2106d1f054b9@free-electrons.com>
References: <20170503135617.25193-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BA8D2667FE
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 16:02:55 +0200 (CEST)
In-Reply-To: <20170503135617.25193-1-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgpPbiAwMy8wNS8yMDE3IDE1OjU2LCBNeWzDqG5lIEpvc3NlcmFuZCB3cm90ZToKPiBI
ZWxsbyBldmVyeW9uZSwKPgo+IFRoaXMgaXMgYSBmaXJzdCB2ZXJzaW9uIG9mIGEgc2VyaWUgdG8g
YWRkIEFEQyBzdXBwb3J0Cj4gZm9yIFN1bjhpLUEzMy4KPiBCYXNlZCBvbiBhc29jL2Zvci1uZXh0
IGJyYW5jaCwgbGFzdCBjb21taXQ6Cj4gMjBkNWM4NGJlZjA2N2I3ZTgwNGExNjNlMmFiY2ExNmM0
NzEyNWJhZC4KPgo+IFRoZSBmaXJzdCBwYXRjaCBhZGRzIHRoZSBzdXBwb3J0IG9mIEFEQyBhbmQg
bWljcm9waG9uZXMgaW4gdGhlIGRpZ2l0YWwKPiBwYXJ0IChkcml2ZXIgc3VuOGktY29kZWMpLgo+
IFRoZSBzZWNvbmQgb25lIGFkZHMgdGhlIHJvdXRlIGJldHdlZW4gYW5hbG9nIChzdW44aS1jb2Rl
Yy1hbmFsb2cpIGFuZAo+IGRpZ2l0YWwgKHN1bjhpLWNvZGVjKSBwYXJ0cyB0byBoYXZlIGEgZnVu
Y3Rpb25hbCBBREMgcm91dGUgb24gU3VuOGktQTMzCj4gZGV2aWNlIHRyZWUuCj4KPiBUZXN0ZWQg
b24gQWxsd2lubmVyIFIxNiBQYXJyb3QgYm9hcmQgd2l0aCBtaWNyb3Bob25lIDEgKGV4dGVybmFs
KSBhbmQKPiBtaWNyb3Bob25lIDIgKGhlYWRzZXQpLgoKSSBmb3Jnb3QgdG8gYWRkIGluIG15IGNv
dmVyLWxldHRlciBhbWl4ZXIgY29tbWFuZHMgdXNlZCB0byB0ZXN0IGl0OgoKYW1peGVyIHNldCAn
QUlGMSBEYXRhIERpZ2l0YWwgQURDJyBjYXAKYW1peGVyIHNldCAnTWljMScgY2FwCm9yCmFtaXhl
ciBzZXQgJ01pYzInIGNhcAoKYW5kLCBqdXN0IGluIGNhc2UsIHRoZSBjb21tYW5kcyB0byBlbmFi
bGUgb3V0cHV0L0RBQzoKCmFtaXhlciBzZXQgJ0hlYWRwaG9uZScgNTAlCmFtaXhlciBzZXQgJ0hl
YWRwaG9uZScgb24KYW1peGVyIHNldCAnREFDJyBvbgphbWl4ZXIgc2V0ICdBSUYxIFNsb3QgMCBE
aWdpdGFsIERBQycgb24KCgo+IEkgYW0gbm90IHN1cmUgYWJvdXQgdGhlIGJpYXMgaGFuZGxpbmcg
c28gaWYgeW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIGl0LAo+IGRvIG5vdCBoZXNpdGF0ZS4KPgo+
IFRoYW5rIHlvdSBpbiBhZHZhbmNlIQo+Cj4gQmVzdCByZWdhcmRzLAo+Cj4gTXlsw6huZSBKb3Nz
ZXJhbmQgKDIpOgo+ICAgQVNvQzogc3VuOGktY29kZWM6IEFkZCBBREMgc3VwcG9ydCBmb3IgYTMz
Cj4gICBBUk06IGR0czogc3VuOGk6IEFkZCBBREMgcm91dGluZwo+Cj4gIGFyY2gvYXJtL2Jvb3Qv
ZHRzL3N1bjhpLWEzMy5kdHNpIHwgMTAgKysrKy0KPiAgc291bmQvc29jL3N1bnhpL3N1bjhpLWNv
ZGVjLmMgICAgfCA4MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4g
IDIgZmlsZXMgY2hhbmdlZCwgODcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgoKQmVz
dCByZWdhcmRzLAoKLS0gCk15bMOobmUgSm9zc2VyYW5kLCBGcmVlIEVsZWN0cm9ucwpFbWJlZGRl
ZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb20K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
