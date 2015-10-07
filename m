From: sugar <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels
 capture and lrck-mode support
Date: Wed, 7 Oct 2015 16:01:38 +0800
Message-ID: <5614D162.3020500@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk> <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.139])
 by alsa0.perex.cz (Postfix) with ESMTP id DE5622658CB
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 10:01:45 +0200 (CEST)
In-Reply-To: <20150930184655.GX15635@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

U29ycnkgZm9yIGxhdGUgcmVwbHksIHdlIHdlcmUgaW4gdGhlIE5hdGlvbmFsIERheSBIb2xpZGF5
LgoK5ZyoIDEwLzEvMjAxNSAwMjo0NiwgTWFyayBCcm93biDlhpnpgZM6Cj4gT24gTW9uLCBTZXAg
MjgsIDIwMTUgYXQgMDQ6MTY6MTJQTSArMDgwMCwgc3VnYXIgd3JvdGU6Cj4+IOWcqCA5LzI0LzIw
MTUgMDA6MjQsIE1hcmsgQnJvd24g5YaZ6YGTOgo+Cj4+PiBNeSBpbml0aWFsIHRob3VnaHQgaGVy
ZSBpcyB0aGF0IHRoZSBtYWNoaW5lIGRyaXZlciBzaG91bGQgYmUgcmVzcG9uc2libGUKPj4+IGZv
ciBzZXR0aW5nIHRoaXMgYW5kIHRoZW4gdGhlIERBSSBkcml2ZXIgc2hvdWxkIGNoZWNrIHRvIHNl
ZSBpZgo+Pj4gc3ltbWV0cmljX3JhdGVzIGFyZSBpbiB1c2UgYW5kIGNvbmZpZ3VyZSBpdHNlbGYg
YXBwcm9wcmlhdGVseS4gIElzIHRoZXJlCj4+PiBhIHJlYXNvbiB3aHkgdGhpcyB3b24ndCB3b3Jr
IGhlcmU/Cj4KPj4gSXQncyBmb3IgaTJzIGlwIGNvbmZpZ3VyYXRpb24sIGluIHRoZSBtb3N0IHNp
dHVhdGlvbiwgdGhlcmUgaXMgbm8gbmVlZAo+PiB0byB1c2UgdGhpcyBwcm9wZXJ0eSwgZXhjZXB0
IG9uZSBjYXNlOgo+Cj4+IEluIG9yZGVyIHRvIHNhdmUgZ3BpbyBwaW5zIGZvciBvdGhlciBmdW5j
dGlvbiB1c2UsIHdlIG1heSB1c2Ugc2luZ2xlCj4+IGxyY2sodHggb3IgcngpIHBpbi4gb2YgY291
cnNlLCBpdCBkZXBlbmRzIG9uIHByb2R1Y3QgZGVzaWduLiB3aGVuIGluIGkycwo+PiBzbGF2ZSBt
b2RlLCB3ZSBuZWVkIHRvIGNvbmZpZ3VyZSB0aGlzIHRvIHNoYXJlIGxyY2sgd2l0aCB0eC9yeCBp
bnNpZGUgaTJzCj4+IGxvZ2ljLgo+Cj4+IHN5bW1ldHJpY19yYXRlcyBmbGFnIHdvcmtzIGZpbmUg
b24gcm9ja2NoaXAgcGxhdGZvcm0sIGJ1dCBpdCBjYW4ndCBjb3ZlciB0aGUKPj4gYWJvdmUgY2Fz
ZS4KPgo+PiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbiBhYm91dCB0aGlzIG9yIG1heWJlIHRo
ZXJlIGlzIG5vIG5lZWQgdG8gdXBzdHJlYW0KPj4gdGhpcyBzcGVjaWFsIHBhcnQ/Cj4KPiBXaGF0
IG1ha2VzIHlvdSBzYXkgdGhhdCB0aGUgc3ltbWV0cmljX3JhdGVzIGZsYWcgY2FuJ3QgYmUgdXNl
ZCB0byBjb3Zlcgo+IHRoaXMgY2FzZT8gIFdoYXQgeW91IGRlc2NyaWJlIGFib3ZlIGlzIGh0ZSBu
b3JtYWwgcmVhc29uIGZvciBuZWVkaW5nIHRvCj4gZW5mb3JjZSBzeW1tZXRyaWNfcmF0ZXMuICBU
aGUgZHJpdmVyIHNob3VsZCBiZSBhYmxlIHRvIGNoZWNrIGlmIHRoZSBmbGFnCj4gaGFzIGJlZW4g
c2V0IGp1c3QgYXMgd2VsbCBhcyB0aGUgY29yZSBpcy4KPgoKR290IGl0LCBIb3cgYWJvdXQgdGhl
IGZvbGxvd2luZyBtb2RpZnk/CgppZiAoZGFpLT5zeW1tZXRyaWNfcmF0ZXMpCglyZWdtYXBfdXBk
YXRlX2JpdHMoaTJzLT5yZWdtYXAsIEkyU19DS1IsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBJMlNfQ0tSX1RSQ01fTUFTSywKICAgICAgICAgICAgICAgICAgICAgICAgICAgIEkyU19DS1Jf
VFJDTSh2YWwpKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
