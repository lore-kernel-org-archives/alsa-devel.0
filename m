From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Date: Sun, 26 May 2019 21:00:30 +0200
Message-ID: <CAJiuCce8UNbA+Ljkbw92ZJu3Ni6N9ciFKGsLtBYJ0_J8E1Gi2g@mail.gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-4-peron.clem@gmail.com>
 <20190526182410.soqb6bne6w66d5j6@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190526182410.soqb6bne6w66d5j6@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGkgTWF4aW1lLAoKT24gU3VuLCAyNiBNYXkgMjAxOSBhdCAyMDoyNCwgTWF4aW1lIFJpcGFyZCA8
bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4gd3JvdGU6Cj4KPiBPbiBTYXQsIE1heSAyNSwgMjAx
OSBhdCAwNjoyMzoxOVBNICswMjAwLCBDbMOpbWVudCBQw6lyb24gd3JvdGU6Cj4gPiBBbGx3aW5u
ZXIgSDYgaGFzIGEgZGlmZmVyZW50IGJpdCB0byBmbHVzaCB0aGUgVFggRklGTy4KPiA+Cj4gPiBB
ZGQgYSBxdWlya3MgdG8gcHJlcGFyZSBpbnRyb2R1Y3Rpb24gb2YgSDYgU29DLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+Cj4gPiAt
LS0KPiA+ICBzb3VuZC9zb2Mvc3VueGkvc3VuNGktc3BkaWYuYyB8IDExICsrKysrKysrKystCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3N1bnhpL3N1bjRpLXNwZGlmLmMgYi9zb3VuZC9zb2Mv
c3VueGkvc3VuNGktc3BkaWYuYwo+ID4gaW5kZXggYjZjNjZhNjJlOTE1Li44MzE3YmJlZTA3MTIg
MTAwNjQ0Cj4gPiAtLS0gYS9zb3VuZC9zb2Mvc3VueGkvc3VuNGktc3BkaWYuYwo+ID4gKysrIGIv
c291bmQvc29jL3N1bnhpL3N1bjRpLXNwZGlmLmMKPiA+IEBAIC0xNjYsMTAgKzE2NiwxMiBAQAo+
ID4gICAqCj4gPiAgICogQHJlZ19kYWNfdHhfZGF0YTogVFggRklGTyBvZmZzZXQgZm9yIERNQSBj
b25maWcuCj4gPiAgICogQGhhc19yZXNldDogU29DIG5lZWRzIHJlc2V0IGRlYXNzZXJ0ZWQuCj4g
PiArICogQHJlZ19mY3RsX2Z0eDogVFggRklGTyBmbHVzaCBiaXRtYXNrLgo+Cj4gSXQncyBhIGJp
dCB3ZWlyZCB0byB1c2UgdGhlIHNhbWUgcHJlZml4IGZvciBhIHJlZ2lzdGVyIG9mZnNldAo+IChy
ZWdfZGFjX3R4X2RhdGEpIGFuZCBhIHZhbHVlIChyZWdfZmN0bF9mdHgpLgoKSSBqdXN0IGxvb2sg
YXQgc3VuNGktY29kZWMgYW5kIHRoZXkgdXNlIGEgcmVnbWFwLCBCdXQgSSB0aGluayBpdCdzIGEK
Yml0IG92ZXJraWxsIG5vPwoKV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdmFsX2ZjdGxfZnR4ID8K
ClRoYW5rcyBmb3IgeW91ciByZXZpZXcsCkNsw6ltZW50Cgo+Cj4gTWF4aW1lCj4KPiAtLQo+IE1h
eGltZSBSaXBhcmQsIEJvb3RsaW4KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVy
aW5nCj4gaHR0cHM6Ly9ib290bGluLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
