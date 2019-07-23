From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH 1/5] ASoC: atmel: enable SSC_PCM_DMA in Kconfig
Date: Tue, 23 Jul 2019 13:36:37 +0000
Message-ID: <1f3a4256-58de-27a4-8095-54fc6baa6d89@microchip.com>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <ee65cc7b889b2a8d1139d1d25977842c956d1cf4.1563819483.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ee65cc7b889b2a8d1139d1d25977842c956d1cf4.1563819483.git.mirq-linux@rere.qmqm.pl>
Content-Language: en-US
Content-ID: <387EFE8C7473E549982BFE82668C5F94@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mirq-linux@rere.qmqm.pl, alsa-devel@alsa-project.org
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com, tiwai@suse.com, Ludovic.Desroches@microchip.com, broonie@kernel.org, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gMjIuMDcuMjAxOSAyMToyNywgTWljaGHFgiBNaXJvc8WCYXcgd3JvdGU6DQo+IEFsbG93IFNT
QyB0byBiZSB1c2VkIG9uIHBsYXRmb3JtcyBkZXNjcmliZWQgdXNpbmcgYXVkaW8tZ3JhcGgtY2Fy
ZA0KPiBpbiBEZXZpY2UgVHJlZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhxYIgTWlyb3PF
gmF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5wbD4NCj4gLS0tDQo+ICAgc291bmQvc29jL2F0bWVs
L0tjb25maWcgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2F0bWVsL0tjb25maWcgYi9z
b3VuZC9zb2MvYXRtZWwvS2NvbmZpZw0KPiBpbmRleCAwNmMxZDVjZTY0MmMuLjllZjlkMjViYjUx
NyAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2F0bWVsL0tjb25maWcNCj4gKysrIGIvc291bmQv
c29jL2F0bWVsL0tjb25maWcNCj4gQEAgLTI1LDcgKzI1LDcgQEAgY29uZmlnIFNORF9BVE1FTF9T
T0NfRE1BDQo+ICAgCWRlZmF1bHQgeSBpZiBTTkRfQVRNRUxfU09DX1NTQ19ETUE9eSB8fCAoU05E
X0FUTUVMX1NPQ19TU0NfRE1BPW0gJiYgU05EX0FUTUVMX1NPQ19TU0M9eSkNCj4gICANCj4gICBj
b25maWcgU05EX0FUTUVMX1NPQ19TU0NfRE1BDQo+IC0JdHJpc3RhdGUNCj4gKwl0cmlzdGF0ZSAi
U29DIFBDTSBEQUkgc3VwcG9ydCBmb3IgQVQ5MSBTU0MgY29udHJvbGxlciB1c2luZyBETUEiDQoN
CkNvdWxkIHlvdSBwbGVhc2UgbWFrZSBzb21ldGhpbmcgc2ltaWxhciBmb3IgU05EX0FUTUVMX1NP
Q19TU0NfUERDPyBBbHNvLCANCkkgdGhpbmsgdGhhdCBpdCBzaG91bGQgc2VsZWN0IEFUTUVMX1NT
QywgdG8gYmUgYWJsZSB0byB1c2UgDQpzaW1wbGUvZ3JhcGgtY2FyZCB3aXRoIFNTQy4NCg0KVGhh
bmtzIGFuZCBiZXN0IHJlZ2FyZHMsDQpDb2RyaW4NCg0KPiAgIA0KPiAgIGNvbmZpZyBTTkRfQVRN
RUxfU09DX1NTQw0KPiAgIAl0cmlzdGF0ZQ0KPiANCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
