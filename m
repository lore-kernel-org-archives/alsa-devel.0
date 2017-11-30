From: =?UTF-8?B?V3UtQ2hlbmcgTGkgKOadjuWLmeiqoCk=?= <wuchengli@google.com>
Subject: Re: [PATCH] ASoC: nau8825: set clear_irq when imm IRQ
	happened
Date: Thu, 30 Nov 2017 15:14:41 +0800
Message-ID: <CAOMLVLhns6trDziXnVS9tndMkfUjJjyY0F_jouaHg2e1g9xwPQ@mail.gmail.com>
References: <1512007997-31704-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMLVLh8gWtoimHBe2Nh-yPY7Lp5BXsOvB_hsELEYZ1RShB6EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 23DC6266A74
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 08:15:03 +0100 (CET)
Received: by mail-io0-f194.google.com with SMTP id 81so6497898iof.3
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 23:15:03 -0800 (PST)
In-Reply-To: <CAOMLVLh8gWtoimHBe2Nh-yPY7Lp5BXsOvB_hsELEYZ1RShB6EQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, Cheng-yi Chiang <cychiang@google.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, AC30 WTLi <WTLI@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, Mac Chiang <mac.chiang@intel.com>, broonie@kernel.org, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <mhkuo@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

TmV2ZXIgbWluZC4gQWN0dWFsbHkgIkFTb0M6IG5hdTg4MjU6IGRpc2FibGUgY3Jvc3N0YWxrIGJ5
IGRlZmF1bHQiIHdhcwphbHJlYWR5IGFwcHJvdmVkLgoKUmV2aWV3ZWQtYnk6IFd1LUNoZW5nIExp
IDx3dWNoZW5nbGlAY2hyb21pdW0ub3JnPgpUZXN0ZWQtYnk6IFd1LUNoZW5nIExpIDx3dWNoZW5n
bGlAY2hyb21pdW0ub3JnPgpPbiBUaHUsIE5vdiAzMCwgMjAxNyBhdCAxMDozMCBBTSwgV3UtQ2hl
bmcgTGkgKOadjuWLmeiqoCkKPHd1Y2hlbmdsaUBnb29nbGUuY29tPiB3cm90ZToKPiBDYW4geW91
IGNvbWJpbmUgdGhpcyBwYXRjaCB3aXRoICJBU29DOiBuYXU4ODI1OiBkaXNhYmxlIGNyb3NzdGFs
ayBieQo+IGRlZmF1bHQiPyBUaGlzIHNob3VsZCBiZSBhIHBhcnQgb2YgdGhhdCBwYXRjaC4KPgo+
IE9uIFRodSwgTm92IDMwLCAyMDE3IGF0IDEwOjEzIEFNLCBKb2huIEhzdSA8S0NIU1UwQG51dm90
b24uY29tPiB3cm90ZToKPj4gQWx0aG91Z2ggdGhlIGNyb3NzdGFsayBpcyBkaXNhYmxlZCwgaXQg
aXMgYmV0dGVyIHRvIHNldCBjbGVhcl9pcnEKPj4gcHJvcGVybHkgd2hlbiB0aGUgaW1wZWRhbmNl
IG1lYXN1cmVtZW50IGludGVycnVwdCBoYXBwZW5zLgo+PiBJdCBjYW4gYXZvaWQgdGhhdCB0aGUg
ZHJpdmVyIGNsZWFycyBvdGhlciBJUlFzIGJ5IGFjY2lkZW50Cj4+IGlmIHRoZSBhY3RpdmVfaXJx
IGhhcyBhbm90aGVyIElSUSBldmVudHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gSHN1IDxL
Q0hTVTBAbnV2b3Rvbi5jb20+Cj4+IC0tLQo+PiAgc291bmQvc29jL2NvZGVjcy9uYXU4ODI1LmMg
fCA1ICsrLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9uYXU4ODI1LmMgYi9zb3Vu
ZC9zb2MvY29kZWNzL25hdTg4MjUuYwo+PiBpbmRleCBkM2MxYTAyLi42MDNjZDcyIDEwMDY0NAo+
PiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL25hdTg4MjUuYwo+PiArKysgYi9zb3VuZC9zb2MvY29k
ZWNzL25hdTg4MjUuYwo+PiBAQCAtMTczMywxMCArMTczMyw5IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dCBuYXU4ODI1X2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkYXRhKQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICBuYXU4ODI1LT54dGFsa19ldmVudF9tYXNrID0gZXZlbnRfbWFzazsKPj4gICAg
ICAgICAgICAgICAgIH0KPj4gICAgICAgICB9IGVsc2UgaWYgKGFjdGl2ZV9pcnEgJiBOQVU4ODI1
X0lNUEVEQU5DRV9NRUFTX0lSUSkgewo+PiAtICAgICAgICAgICAgICAgaWYgKG5hdTg4MjUtPnh0
YWxrX2VuYWJsZSkgewo+PiArICAgICAgICAgICAgICAgaWYgKG5hdTg4MjUtPnh0YWxrX2VuYWJs
ZSkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgc2NoZWR1bGVfd29yaygmbmF1ODgyNS0+eHRh
bGtfd29yayk7Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgIGNsZWFyX2lycSA9IE5BVTg4MjVf
SU1QRURBTkNFX01FQVNfSVJROwo+PiAtICAgICAgICAgICAgICAgfQo+PiArICAgICAgICAgICAg
ICAgY2xlYXJfaXJxID0gTkFVODgyNV9JTVBFREFOQ0VfTUVBU19JUlE7Cj4+ICAgICAgICAgfSBl
bHNlIGlmICgoYWN0aXZlX2lycSAmIE5BVTg4MjVfSkFDS19JTlNFUlRJT05fSVJRX01BU0spID09
Cj4+ICAgICAgICAgICAgICAgICBOQVU4ODI1X0pBQ0tfSU5TRVJUSU9OX0RFVEVDVEVEKSB7Cj4+
ICAgICAgICAgICAgICAgICAvKiBPbmUgbW9yZSBzdGVwIHRvIGNoZWNrIEdQSU8gc3RhdHVzIGRp
cmVjdGx5LiBUaHVzLCB0aGUKPj4gLS0KPj4gMi42LjQKPj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
