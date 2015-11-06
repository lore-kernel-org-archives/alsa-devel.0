From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH v1 1/5] ASoC: rockchip: i2s: Support to set
 the divider clock API
Date: Fri, 6 Nov 2015 17:42:30 +0800
Message-ID: <563C7606.7050504@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
 <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
 <20151104143431.GH1717@sirena.org.uk> <563AEF97.1080304@gmail.com>
 <20151105161615.GS18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BA08265DDC
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 10:42:39 +0100 (CET)
In-Reply-To: <20151105161615.GS18409@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Dylan Reid <dgreid@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

SGkgIE1hcmssCgpWZXJ5IHJlc3BvbnNpdmUsIHRoYW5rcyB5b3VyIGNvbW1lbnQuCgrlnKggMjAx
NeW5tDEx5pyIMDbml6UgMDA6MTYsIE1hcmsgQnJvd24g5YaZ6YGTOgo+IE9uIFRodSwgTm92IDA1
LCAyMDE1IGF0IDAxOjU2OjM5UE0gKzA4MDAsIENhZXNhciBXYW5nIHdyb3RlOgo+PiDlnKggMjAx
NeW5tDEx5pyIMDTml6UgMjI6MzQsIE1hcmsgQnJvd24g5YaZ6YGTOgo+Pj4gU2FtZSB0aGluZyBh
cyB5b3VyIG90aGVyIHZlcnkgc2ltaWxhciBwYXRjaDogd2h5IGRvZXMgdGhpcyBmZWF0dXJlCj4+
PiByZXF1aXJlIHNldF9jbGtkaXYoKT8KPj4gT2theSwgeW91IHNhaWQgIgo+PiBXaHkgaXMgdGhp
cyBhIHJlcXVpcmVtZW50PyAgVGhlIGNsb2NrIHRvIHVzZSBhcyBhIHNvdXJjZSBzaG91bGQgbm9y
bWFsbHkKPj4gYmUgc3BlY2lmaWVkIHZpYSBzZXRfc3lzY2xrKCkgYW5kIGFueSBpbnRlcm5hbCBk
aXZpZGVycyBjYWxjdWxhdGVkCj4+IGF1dG9tYXRpY2FsbHkgYnkgdGhlIGRyaXZlci4KPj4gIgo+
PiBJIHRoaW5rIHdlIHNob3VsZCBkaXZpZGVyIHNldHRpbmdzIGZvciB0aGVzZSBkaWZmZXJlbnQg
c2FtcGxlIHJhdGVzLgo+IFN1cmUsIHRoZSBxdWVzdGlvbiBpcyBob3cgdGhlc2UgdGhpbmdzIGdl
dCBzZXQuCj4KPj4gICBJZiB0aGUgY29kZWMgaXMgbWFzdGVyIG1vZGUsIHdlIGFyZSAqbm90KiBu
ZWVkIHRoaXMgb3BlcmF0ZS4KPj4gICBJZiB0aGUgY29kZWMgaXMgc2xhdmUgbW9kZSwgd2UgYXJl
IG5lZWQgdG8gZGl2aWRlciB0aGUgTUNMSyB0byBzZXR0aW5nIHRoZSBkaWZmZXJlbnQgc2FtcGxl
IHJhdGVzLgo+PiAoZm9yIGV4YW1wbGUsIHRoZSBzYW1wbGUgcmF0ZXMgKDhrLCA0OGspIHRoZSBj
bG9jayBpcyBNQ0xLLCB0aGUgY2xvY2sgc2hvdWxkIGJlIGRpdmlkZXIgY3B1IGlwICkKPj4gImRp
dmlkZXJzIGNhbGN1bGF0ZWQgYXV0b21hdGljYWxseSBieSB0aGUgZHJpdmVyIiwgdGhhdCBzaG91
bGQgYmUgb2NjdXJlZCBieSBjb2RlYyhtYXg5ODA5MAo+PiApIGRyaXZlciwgYnV0IHRoZSBkaXZp
ZGVyIGNsb2NrcyAoTFJDSywgU0NMSykgc2hvdWxkIG5lZWQgdG8gc2V0IGZvciBjcHUgaW50ZXJu
YWwgc2lkZS4KPiBTbyB0aGUgQ1BVIGtub3dzIHdoYXQgcmF0ZXMgaXQgbmVlZHMgdG8gc2V0IGFu
ZCB3aGF0IGNsb2NrcyBpdCdzIGdldHRpbmcKPiBpbiwgd2h5IGNhbid0IGl0IHNldCB0aGUgZGl2
aWRlcnMgYXV0b25vbW91c2x5LgoKU291bmQgcmVzb25hYmxlLCAgZml4ZWQgaW4gbmV4dCB2ZXJz
aW9uLgoKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKPiBMaW51eC1yb2NrY2hpcEBsaXN0cy5p
bmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1yb2NrY2hpcAoKCi0tIApjYWVzYXIgd2FuZyB8IHNvZnR3YXJlIGVuZ2luZWVyIHwg
d3h0QHJvY2stY2hpcC5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
