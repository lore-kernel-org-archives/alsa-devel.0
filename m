From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH 2/3] ASoC: simple-card: Add support jack
 detection via codec
Date: Fri, 22 Apr 2016 09:17:46 +0800
Message-ID: <57197BBA.50304@rock-chips.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
 <20160421141921.GA25900@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.130])
 by alsa0.perex.cz (Postfix) with ESMTP id E214F266847
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 03:17:54 +0200 (CEST)
In-Reply-To: <20160421141921.GA25900@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>, broonie@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org, Adam.Thomson@diasemi.com, Kumar Gala <galak@codeaurora.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jun Nie <jun.nie@linaro.org>, jay.xu@rock-chips.com, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDIwMTblubQwNOaciDIx5pelIDIyOjE5LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBNb24s
IEFwciAxOCwgMjAxNiBhdCAwNDoxNzozMVBNICswODAwLCBYaW5nIFpoZW5nIHdyb3RlOgo+PiBJ
biBtb3N0IGNhc2VzLCBtYW55IGNvZGVjcyBhbHJlYWR5IHN1cHBvcnRzIGphY2sgZGV0ZWN0aW9u
LCBwcmV2aW91c2xseSwKPj4gd2UgbmVlZCB0byBjcmVhdGUgYSBjdXN0b21pemVkIG1hY2hpbmUg
ZHJpdmVyIGV2ZXJ5IHRpbWUuCj4+Cj4+IEhlbmNlLCB0aGUgc2ltcGxlLWNhcmQgbmVlZCB0byBz
dXBwb3J0IHVzZSB0aGVtIGR5bmFtaWNhbGx5IHZpYSBwYXJzZSBkdHMKPj4gZmlsZSBmb3IgYmV0
dGVyIGZsZXhpYmlsaXR5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYaW5nIFpoZW5nIDx6aGVuZ3hp
bmdAcm9jay1jaGlwcy5jb20+Cj4+IC0tLQo+Pgo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvdW5kL3NpbXBsZS1jYXJkLnR4dCAgICAgIHwgICAxNyArKysKPj4gICBzb3VuZC9zb2MvZ2Vu
ZXJpYy9zaW1wbGUtY2FyZC5jICAgICAgICAgICAgICAgICAgICB8ICAxMjYgKysrKysrKysrKysr
KysrKysrKy0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0MCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvdW5kL3NpbXBsZS1jYXJkLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb3VuZC9zaW1wbGUtY2FyZC50eHQKPj4gaW5kZXggY2YzOTc5ZS4uZDI1YzhlYiAxMDA2
NDQKPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3NpbXBs
ZS1jYXJkLnR4dAo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvc2ltcGxlLWNhcmQudHh0Cj4+IEBAIC0yMiw2ICsyMiwyMyBAQCBPcHRpb25hbCBwcm9wZXJ0
aWVzOgo+PiAgIAkJCQkJICBoZWFkcGhvbmVzIGFyZSBhdHRhY2hlZC4KPj4gICAtIHNpbXBsZS1h
dWRpby1jYXJkLG1pYy1kZXQtZ3Bpbwk6IFJlZmVyZW5jZSB0byBHUElPIHRoYXQgc2lnbmFscyB3
aGVuCj4+ICAgCQkJCQkgIGEgbWljcm9waG9uZSBpcyBhdHRhY2hlZC4KPj4gKy0gc2ltcGxlLWF1
ZGlvLWNhcmQsY29kZWMtamFjawkJOiBBIGxpc3Qgb2YgdGhlIGNvZGVjIHN1cHBvcnRzIGphY2sg
ZGV0ZWN0aW9uLgo+PiArCQkJCQkgIFRoZSBqYWNrIHR5cGVzIHdoaWNoIGFyZSBzdXBwb3J0ZWQg
cmVmZXIgdG8gaW5jbHVkZS9zb3VuZC9qYWNrLmguCj4+ICsJCQkJCSAgQWxsIG9mIHRoZSBqYWNr
IHR5cGVzOgo+PiArCQkJCQkJIkpBQ0tfSEVBRFBIT05FIiwKPj4gKwkJCQkJCSJKQUNLX01JQ1JP
UEhPTkUiLAo+PiArCQkJCQkJIkpBQ0tfSEVBRFNFVCIsCj4+ICsJCQkJCQkiSkFDS19MSU5FT1VU
IiwKPj4gKwkJCQkJCSJKQUNLX01FQ0hBTklDQUwiLAo+PiArCQkJCQkJIkpBQ0tfVklERU9PVVQi
LAo+PiArCQkJCQkJIkpBQ0tfQVZPVVQiLAo+PiArCQkJCQkJIkpBQ0tfTElORUlOIiwKPj4gKwkJ
CQkJCSJKQUNLX0JUTl8wIiwKPj4gKwkJCQkJCSJKQUNLX0JUTl8xIiwKPj4gKwkJCQkJCSJKQUNL
X0JUTl8yIiwKPj4gKwkJCQkJCSJKQUNLX0JUTl8zIiwKPj4gKwkJCQkJCSJKQUNLX0JUTl80IiwK
Pj4gKwkJCQkJCSJKQUNLX0JUTl81Ii4KPiBzaW1wbGUtY2FyZCBpcyBub3Qgc28gc2ltcGxlLi4u
Cj4KPiBJIHRoaW5rIHRoaXMgaW5mb3JtYXRpb24gYmUgcGFydCBvZiB0aGUgY29kZWMgbm9kZSBp
ZiB0aGUgY29kZWMKPiBwcm92aWRlcyB0aGUgZnVuY3Rpb25hbGl0eS4gVGhlIGJpbmRpbmcgc2hv
dWxkIG5vdCBiZSBkaWZmZXJlbnQgd2hldGhlcgo+IGEgY29kZWMgaXMgcGFydCBvZiBzaW1wbGUt
Y2FyZCBvciBub3QuIEFsc28sIEkgd291bGQgbWFrZSBhbGwgdGhlc2UganVzdAo+IGJvb2xlYW4g
cHJvcHMuClllcywgdGhlc2UgdGhpbmdzIHNlZW0gbGlrZSBtYWtlIHNpbXBsZS1jYXJkIGJlY29t
ZXMgbW9yZSBjb21wbGljYXRlZCwgCmFuZCB0aGUgZ2VuZXJpYyBqYWNrIGRldGVjdGlvbiBtZXRo
b2QgaXMgc3RpbGwgYSBwcm9ibGVtIGN1cnJlbnRseS4KCkhpIE1hcmssIHRoZSBvdGhlciBxdWVz
dGlvbiBoZXJlLCBob3cgZG8gd2UgbWFrZSBzZW5zZSB0byB1c2UgdGhlIApzaW1wbGUtY2FyZCB0
byBjYWxsIHRoZSAic25kX3NvY19kYWlfc2V0X3BsbCIgaWYgdGhlIGNvZGVjIChsaWtlIGRhNzIx
OSkgCnJlcXVpcmVzIGRvIHRoaXM/CgpUaGFua3MuCgotLSAKLSBYaW5nIFpoZW5nCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
