From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 6/7] ASoC: Fix inverted WM8580 capture mute
	control
Date: Sun, 15 Aug 2010 15:20:50 +0900
Message-ID: <AANLkTi=TPLVhOtKrLBnyqw3VyXDqkO=5WxhhmyTHcTJM@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTinBu55RMSgWOmfa3hMKuP4ze3+0yz0qF1Wr8Uv4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 46A8D243EC
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 08:20:51 +0200 (CEST)
Received: by wwi17 with SMTP id 17so2579561wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2010 23:20:51 -0700 (PDT)
In-Reply-To: <AANLkTinBu55RMSgWOmfa3hMKuP4ze3+0yz0qF1Wr8Uv4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBBdWcgMTUsIDIwMTAgYXQgMTo1MCBQTSwgU2V1bmd3aGFuIFlvdW4gPGNsYXVkZS55
b3VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gU2F0LCBBdWcgMTQsIDIwMTAgYXQgNDozNSBBTSwg
TWFyayBCcm93bgo+IDxicm9vbmllQG9wZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6
Cj4+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29u
bWljcm8uY29tPgo+PiAtLS0KPj4gwqBzb3VuZC9zb2MvY29kZWNzL3dtODU4MC5jIHwgwqAgwqAy
ICstCj4+IMKgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3dtODU4MC5jIGIvc291bmQvc29j
L2NvZGVjcy93bTg1ODAuYwo+PiBpbmRleCA2MjYyMTI0Li4zNTdmN2Q1IDEwMDY0NAo+PiAtLS0g
YS9zb3VuZC9zb2MvY29kZWNzL3dtODU4MC5jCj4+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204
NTgwLmMKPj4gQEAgLTI2Miw3ICsyNjIsNyBAQCBTT0NfU0lOR0xFKCJEQUMxIFN3aXRjaCIsIFdN
ODU4MF9EQUNfQ09OVFJPTDUsIDAsIDEsIDApLAo+PiDCoFNPQ19TSU5HTEUoIkRBQzIgU3dpdGNo
IiwgV004NTgwX0RBQ19DT05UUk9MNSwgMSwgMSwgMCksCj4+IMKgU09DX1NJTkdMRSgiREFDMyBT
d2l0Y2giLCBXTTg1ODBfREFDX0NPTlRST0w1LCAyLCAxLCAwKSwKPj4KPj4gLVNPQ19ET1VCTEUo
IkNhcHR1cmUgU3dpdGNoIiwgV004NTgwX0FEQ19DT05UUk9MMSwgMCwgMSwgMSwgMCksCj4+ICtT
T0NfRE9VQkxFKCJDYXB0dXJlIFN3aXRjaCIsIFdNODU4MF9BRENfQ09OVFJPTDEsIDAsIDEsIDEs
IDEpLAo+PiDCoFNPQ19TSU5HTEUoIkNhcHR1cmUgSGlnaC1QYXNzIEZpbHRlciBTd2l0Y2giLCBX
TTg1ODBfQURDX0NPTlRST0wxLCA0LCAxLCAwKSwKPj4gwqB9Owo+Pgo+PiAtLQo+PiAxLjcuMQo+
Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBB
bHNhLWRldmVsIG1haWxpbmcgbGlzdAo+PiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPj4g
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwKPj4KPgo+IEkgY2FuJ3QgYXBwbHkgb25seSB0aGlzIHBhdGNoIG9uIExpYW0ncyBicmFuY2gg
J2Zvci0yLjYuMzcnLAo+ICdmb3ItMi42LjM2JyBhbmQgJ3RvcGljL211bHRpLWNvbXBvbmVudCcg
LiBDYW4geW91IHRlbGwgbWUgd2hpY2gKPiBicmFuY2ggZGlkIHlvdSB3b3JrIG9uPwo+CgpTb3Jy
eSwgSSBmb3VuZCB5b3VyIHdvcmtpbmcgYnJhbmNoIG9uIHlvdXIgZ2l0IHJlcC4gJ2Zvci0yLjYu
MzcnLiA6LSkKClRoYW5rcywKCkNsYXVkZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
