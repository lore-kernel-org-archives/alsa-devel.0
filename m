From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 6/7] ASoC: Fix inverted WM8580 capture mute
	control
Date: Sun, 15 Aug 2010 13:50:20 +0900
Message-ID: <AANLkTinBu55RMSgWOmfa3hMKuP4ze3+0yz0qF1Wr8Uv4@mail.gmail.com>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E420624152
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 06:50:20 +0200 (CEST)
Received: by wwi17 with SMTP id 17so2534576wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2010 21:50:20 -0700 (PDT)
In-Reply-To: <1281728107-25386-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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

T24gU2F0LCBBdWcgMTQsIDIwMTAgYXQgNDozNSBBTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IE1hcmsgQnJv
d24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgo+IC0tLQo+IMKgc291bmQv
c29jL2NvZGVjcy93bTg1ODAuYyB8IMKgIMKgMiArLQo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAxIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2Nv
ZGVjcy93bTg1ODAuYyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204NTgwLmMKPiBpbmRleCA2MjYyMTI0
Li4zNTdmN2Q1IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204NTgwLmMKPiArKysg
Yi9zb3VuZC9zb2MvY29kZWNzL3dtODU4MC5jCj4gQEAgLTI2Miw3ICsyNjIsNyBAQCBTT0NfU0lO
R0xFKCJEQUMxIFN3aXRjaCIsIFdNODU4MF9EQUNfQ09OVFJPTDUsIDAsIDEsIDApLAo+IMKgU09D
X1NJTkdMRSgiREFDMiBTd2l0Y2giLCBXTTg1ODBfREFDX0NPTlRST0w1LCAxLCAxLCAwKSwKPiDC
oFNPQ19TSU5HTEUoIkRBQzMgU3dpdGNoIiwgV004NTgwX0RBQ19DT05UUk9MNSwgMiwgMSwgMCks
Cj4KPiAtU09DX0RPVUJMRSgiQ2FwdHVyZSBTd2l0Y2giLCBXTTg1ODBfQURDX0NPTlRST0wxLCAw
LCAxLCAxLCAwKSwKPiArU09DX0RPVUJMRSgiQ2FwdHVyZSBTd2l0Y2giLCBXTTg1ODBfQURDX0NP
TlRST0wxLCAwLCAxLCAxLCAxKSwKPiDCoFNPQ19TSU5HTEUoIkNhcHR1cmUgSGlnaC1QYXNzIEZp
bHRlciBTd2l0Y2giLCBXTTg1ODBfQURDX0NPTlRST0wxLCA0LCAxLCAwKSwKPiDCoH07Cj4KPiAt
LQo+IDEuNy4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IEFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCj4gaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwKPgoKSSBjYW4ndCBhcHBseSBvbmx5IHRoaXMgcGF0Y2ggb24gTGlhbSdzIGJyYW5j
aCAnZm9yLTIuNi4zNycsCidmb3ItMi42LjM2JyBhbmQgJ3RvcGljL211bHRpLWNvbXBvbmVudCcg
LiBDYW4geW91IHRlbGwgbWUgd2hpY2gKYnJhbmNoIGRpZCB5b3Ugd29yayBvbj8KClRoYW5rIHlv
dSwKCkNsYXVkZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
