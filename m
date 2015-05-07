From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Thu, 07 May 2015 22:53:30 +0900
Message-ID: <554B6E5A.5080907@sakamocchi.jp>
References: <CAJ0eYfWCoqBBLdXpfitc1KZczZmPYXVy9n4-3YEU2Fw0sTRMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id A8CEF265122
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 15:53:32 +0200 (CEST)
In-Reply-To: <CAJ0eYfWCoqBBLdXpfitc1KZczZmPYXVy9n4-3YEU2Fw0sTRMNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Ood <jh1ood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpTb3JyeSB0byBiZSBsYXRlIGJ1dCBJIGhhdmUgYSBzaG9ydCB2YWNhdGlvbi4KCk9uIDIw
MTXlubQwNOaciDI35pelIDE3OjM0LCBNaWtlIE9vZCB3cm90ZToKPiBUaGUgcmVzdWx0cyBhcmU6
Cj4gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLQo+IExvY2FsICAgICAgICBPSwo+IFdvcmRjbG9jayBO
Rwo+IERJICAgICAgICAgICAgIE5HCj4gUEMgREFXICAgIE9LCj4gQ1NQICAgICAgICAgIE9LCj4g
LS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IFNvIGl0IHNlZW1zIHRoYXQgaWYgdGhlcmUgaXMgbm8g
ZXh0ZXJuYWwgY2xvY2sgYXBwbGllZCwKPiB3aGVuIG9uZSBpcyBleHBlY3RlZCwgT3JwaGV1cyBz
dG9wcyBwbGF5aW5nIHJhdGhlciB0aGFuCj4gdHJ5aW5nIHRvIGNvbnRpbnVlIG9wZXJhdGlvbiBi
eSBmcmVlLXJ1bm5pbmcgaXRzIGNsb2NrLgoKSW4gdGhpcyBjYXNlLCB0aGUgV2luZG93cyBkcml2
ZXIgbWF5IGRpc3R1cmIgc3RyZWFtaW5nIHdoZW4gZGV0ZWN0aW5nCmRlLXN5bmNocm9uaXphdGlv
bi4KCj4+IEJyaWRnZUNvIEFHIChjdXJyZW50bHkgQXJjaFdhdmUgQUcpIHByb2R1Y2VkIERNMTAw
MC9ETTExMDAvRE0xNTAwCj4+IGNoaXBzZXQgd2l0aCBCZUJvQiBmaXJtd2FyZS4gUHJpc21Tb3Vu
ZCBMdGQuIHV0aWxpemVkIHRoZSBjaGlwc2V0IGFuZAo+PiBmaXJtd2FyZSBmb3Igc3RyZWFtaW5n
IGZ1bmN0aW9uYWxpdHkgb2YgeW91ciBPcnBoZXVzLgo+IAo+PiBCZUJvQiBmaXJtd2FyZSBnaXZl
cyBjb21tb24gd2F5cyB0byBjb250cm9sIGl0c2VsZiwgd2hpbGUgdGhlIGhhZHdhcmUKPj4gdmVu
ZG9yIGFkZGVkIHRoZWlyIG93biBjdXNvbWl6YXRpb24gYWdhaW5zdCBpdC4gSSBkb24ndCBrbm93
IGV4YWN0bHkgdGhlCj4+IHJlYXNvbiBiZWNhdXNlIHRoZXJlJ3JlIGZldyBpbmZvcm1hdGlvbiBh
Ym91dCB5b3VyIGRldmljZS4KPiAKPiBJIGRvIG5vdCB0aGluayBJIHVuZGVyc3RhbmQgd2hhdCB5
b3Ugc2FpZCBoZXJlIGR1ZSB0byB0aGUgbGFjayBvZiB0ZWNobmljYWwKPiBiYWNrZ3JvdW5kLCBi
dXQgd2hhdCBkbyB5b3Ugc3VnZ2VzdCBhdCB0aGlzIG1vbWVudCB0byBhIGNhc3VhbCBhcHBsaWNh
dGlvbnMKPiBwcm9ncmFtbWVyIHdobyB3aXNoIHRvIHVzZSBzbmQtYmVib2Igd2l0aCBPcnBoZXVz
PwoKU3VjaCBwcm9ncmFtbWVyIGNhbiBoZWxwIGRyaXZlciBkZXZlbG9wZXJzLgoKClJlZ2FyZHMK
ClRha2FzaGkgU2FrYW1vdG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
