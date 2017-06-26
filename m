From: Romain Perier <romain.perier@collabora.com>
Subject: Re: [PATCH v3 0/3] Add support for es8323 and hdmi
 audio to the firefly-rk3288
Date: Mon, 26 Jun 2017 16:00:17 +0200
Message-ID: <98ec8d72-2977-4347-86b0-4b423b55c434@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-9-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id CA1F6266A0C
 for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2017 16:00:21 +0200 (CEST)
In-Reply-To: <20170512132227.24916-9-romain.perier@collabora.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Romain Perier <romain.perier@collabora.co.uk>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgpwaW5nLAoKbm8gb3RoZXIgZmVlZGJhY2tzIChmb3IgMi8zIGFuZCAzLzMpPwoKUm9t
YWluCgoKTGUgMTIvMDUvMjAxNyDDoCAxNToyMiwgUm9tYWluIFBlcmllciBhIMOpY3JpdCA6Cj4g
VGhpcyBzZXQgb2YgcGF0Y2hlcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBlczgzMjMgY29kZWNz
IG9uIHRoZQo+IGZpcmVmbHktcmszMjg4LiBJdCBhZGRzIHRoZSByZXF1aXJlZCBEVCBkZWZpbml0
aW9ucyB0byBsaW5rIHJvY2tjaGlwLWkycwo+IHRvIHRoZSBlczgzODggYW5hbG9nIG91dHB1dC4g
QXMgdGhlIHN1cHBvcnQgZm9yIEhETUkgYXVkaW8gaXMgYWxzbwo+IGJ1aWx0LWluIGluIHRoZSBj
b3JyZXNwb25kaW5nIEFTb0MgbWFjaGluZSBkcml2ZXIsIEhETUkgYXVkaW8gb3V0cHV0IGlzCj4g
YWxzbyBlbmFibGVkLgo+Cj4gQ2hhbmdlcyBpbiB2MzoKPiAgLSBTeW5jZWQgRFQgd2l0aCB0aGUg
b25lIG9mIHRoZSBSb2NrMiwgdGhlIHByb3BlcnRpZXMgaGF2ZSBiZWVuCj4gICAgbGV4aWNhbGx5
IHJlLW9yZGVyZWQgaW4gdGhlIHJpZ2h0IG9yZGVyLCBJIGhhdmUgc3BsaXR0ZWQgdGhlCj4gICAg
aGVhZHBob25lIHBpbmN0cmwgaW4gdHdvOiBwaG9uZV9jdGwgYW5kIGhwX2RldAo+IENoYW5nZXMg
aW4gdjI6Cj4gIC0gQWRhcHRlZCBEVCBmb3IgdGhlIGZpcmVmbHktcmszMjg4IHRvIHRoZSBBU29D
IG1hY2hpbmUgZHJpdmVyCj4gICAgcmszMjg4LWhkbWktYW5hbG9nCj4gIC0gQWRkZWQgcGF0Y2gg
MDIvMDMgdG8gdGhpcyBzZXJpZXMKPiAgLSBSZS13cm90ZSB0aGlzIGNvdmVyIGxldHRlcgo+Cj4g
Um9tYWluIFBlcmllciAoMyk6Cj4gICBTb0M6IGVzODMyOC1pMmM6IEFkZCBjb21wYXRpYmxlIGZv
ciBFUzgzMjMKPiAgIGFybTogZHRzOiByb2NrY2hpcDogRG9uJ3Qgc2V0IG90cC1ncGlvIHBpbmN0
cmwgYnkgZGVmYXVsdCBpbgo+ICAgICByazMyODguZHRzaQo+ICAgYXJtOiBkdHM6IEFkZCBzdXBw
b3J0IGZvciBFUzgzMjMgdG8gdGhlIEZpcmVmbHktUkszMjg4Cj4KPiAgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2VzODMyOC50eHQgfCAgNSArKy0KPiAgYXJjaC9hcm0v
Ym9vdC9kdHMvcmszMjg4LWV2Yi5kdHNpICAgICAgICAgICAgICAgICAgfCAgNCArKysKPiAgYXJj
aC9hcm0vYm9vdC9kdHMvcmszMjg4LWZpcmVmbHkuZHRzaSAgICAgICAgICAgICAgfCAzOCArKysr
KysrKysrKysrKysrKysrKysrCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3JrMzI4OC12ZXlyb24uZHRz
aSAgICAgICAgICAgICAgIHwgIDQgKysrCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3JrMzI4OC5kdHNp
ICAgICAgICAgICAgICAgICAgICAgIHwgIDQgLS0tCj4gIHNvdW5kL3NvYy9jb2RlY3MvZXM4MzI4
LWkyYy5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysKPiAgNiBmaWxlcyBjaGFuZ2VkLCA1
MiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
