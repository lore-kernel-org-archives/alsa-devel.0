From: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v3 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Tue, 3 May 2016 00:29:52 +0200
Message-ID: <5727D4E0.8010001@invoxia.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5A0FRZ52UGeqLJaVF8BiWhzmpNSgQm4B0U1gc2wGU6KhA@mail.gmail.com>
 <20160429035402.GB1944@Asurada>
 <CAG5mAdwFd3avEv6Tup9F0YcmtTQAFgHa2oF6FzjeLaZnonpomA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E7F2260438
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 00:29:55 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id e201so124241973wme.0
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 15:29:55 -0700 (PDT)
In-Reply-To: <CAG5mAdwFd3avEv6Tup9F0YcmtTQAFgHa2oF6FzjeLaZnonpomA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

SGkgYWxsCgpMZSAyOS8wNC8yMDE2IDE4OjQ5LCBDYWxlYiBDcm9tZSBhIMOpY3JpdCA6Cj4gT24g
VGh1LCBBcHIgMjgsIDIwMTYgYXQgODo1NCBQTSwgTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FA
Z21haWwuY29tPiB3cm90ZToKPj4gT24gRnJpLCBBcHIgMjksIDIwMTYgYXQgMTI6NDQ6MTZBTSAt
MDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToKPj4+IEhpIE5pY29saW4gYW5kIFRpbXVyLAo+Pj4K
Pj4+IE9uIE1vbiwgSmFuIDE4LCAyMDE2IGF0IDE6MjYgUE0sIEFybmF1ZCBNb3VpY2hlCj4+PiA8
YXJuYXVkLm1vdWljaGVAaW52b3hpYS5jb20+IHdyb3RlOgo+Pj4+IFRoaXMgc2VyaWVzIG9mIHBh
dGNoIGlzIGFuIGF0dGVtcHQgdG8gZml4IHRoZSBmc2xfc3NpIGRyaXZlciB0byB1c2UgaXQgaW4g
VERNIG1vZGUgKERTUCBBIG9yIEIpIHdpdGggYSBsYXJnZSBudW1iZXIgb2YgY2hhbm5lbHMvc2xv
dHMuCj4+PiBBbnkgZmVlZGJhY2sgYWJvdXQgdGhpcyBzZXJpZXM/Cj4+Pgo+Pj4gSXQgYWRkcmVz
c2VzIGltcG9ydGFudCBmaXhlcyBmb3IgdGhlIGZzbF9zc2kgZHJpdmVyLgo+PiBQYXRjaGVzIGxv
b2sgZmluZSB0byBtZS4gSSB0aG91Z2h0IHRoZXJlIHdhcyBnb2luZyB0byBiZSBhbm90aGVyIHZl
cnNpb24uCj4gVGhlcmUgaXMgYW5vdGhlciBwYXRjaCB0aGF0IGNvbWVzIGFmdGVyIHRoZXNlLCBi
dXQgdGhhdCdzIHJlbGF0aW5nIHRoZQo+IHRoZSB3YXRlcm1hcmsgaXNzdWVzIHdlIHRhbGtlZCBh
Ym91dCBiZWZvcmUuICBUaGUgd2F0ZXJtYXJrIGlzc3VlcyBjYW4KPiBzdGFuZCBpbmRlcGVuZGVu
dGx5IG9mIHRoaXMgcGF0Y2ggc2VyaWVzLCBzbyBJIHRoaW5rIGl0J3MgYmVzdCB0byBrZWVwCj4g
dGhlIGNvbXBsZXhpdHkgd2l0aCB3YXRlcm1hcmtzIHNlcGFyYXRlIHRoaXMgc2VyaWVzLiAgICBB
cm5hdWQgbmV2ZXIKPiBtZW50aW9uZWQgdG8gbWUgdGhhdCB0aGVyZSB3YXMgYSB2ZXJzaW9uIGFm
dGVyIHYzLgpObywgbm8gbmV3IHZlcnNpb24gYWZ0ZXIgdGhpcyBvbmUuCgpSZWdhcmRzLApBcm5h
dWQKPgo+IC1DYWxlYgo+Cj4+IEFja2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBn
bWFpbC5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
