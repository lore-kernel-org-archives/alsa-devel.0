From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Subject: Re: [PATCH] ASoC: rsnd: fixup index of SSI mod when
 SRC is used
Date: Thu, 3 Jul 2014 23:05:50 +0900
Message-ID: <CA+t-KAhAdoE_oAvdWAPTe+j-c7Yt8338_eqs2hO6xw5Y3keAfQ@mail.gmail.com>
References: <1404299931-21384-1-git-send-email-j@bitron.ch>
 <CA+t-KAiFNi2cdfKQfNYf7svWKXg4sBhPzib+Q7qfONosuwdy7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 47D332618ED
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 16:05:53 +0200 (CEST)
Received: by mail-qa0-f43.google.com with SMTP id k15so219895qaq.30
 for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2014 07:05:50 -0700 (PDT)
In-Reply-To: <CA+t-KAiFNi2cdfKQfNYf7svWKXg4sBhPzib+Q7qfONosuwdy7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon Horman <horms@verge.net.au>, Takashi Iwai <tiwai@suse.de>, Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

SGkgYWdhaW4KCgoyMDE0LTA3LTAzIDIyOjU3IEdNVCswOTowMCBLdW5pbm9yaSBNb3JpbW90byA8
a3VuaW5vcmkubW9yaW1vdG8uZ3hAZ21haWwuY29tCj46Cgo+IEhpCj4KPiBJZiB5b3UgYWRkIHRo
aXMgY29kZSwKPgo+ICAgICAgICAgaWYgKCFzc2kpIHsKPiAgICAgICAgICAgICAgICBicmVhazsK
PiAgICAgICAgIH0gZWxzZSAuLi4KPgo+IHRoZW4sIEkgZ3Vlc3Mgd2UgY2FuIHJlbW92ZSB0aGlz
IGNvZGUgPwo+Cj4gCWlmIChtb2RbaV0gPT0gc3NpKQo+IAlicmVhazsKPgo+Cj4KTWF5YmUgdGhp
cyBpcyBub3QgY29ycmVjdCBjb21tZW50LgpOb3csIEknbSBjb25mdXNpbmcgYWJvdXQgdGhpcyBw
YXRjaC4KV2hhdCBraW5kIG9mIGlzc3VlIGhhcHBlbiB3aXRob3V0IHRoaXMgcGF0Y2ggPwoKCgo+
Cj4gMjAxNC0wNy0wMiAyMDoxOCBHTVQrMDk6MDAgSsO8cmcgQmlsbGV0ZXIgPGpAYml0cm9uLmNo
PjoKPgo+IFRoZSBkZWZhdWx0IGluZGV4IDEgd2FzIHVzZWQgYXMgdGhlIGxvb3Agd2FzIHRlcm1p
bmF0ZWQgYmVmb3JlIHRoZQo+PiBmb2xsb3dpbmcgY29kZSBjb3VsZCBiZSByZWFjaGVkOgo+Pgo+
PiAgICAgICAgIGlmIChtb2RbaV0gPT0gdGhpcykKPj4gICAgICAgICAgICAgICAgIGluZGV4ID0g
aTsKPj4KPj4gU2lnbmVkLW9mZi1ieTogSsO8cmcgQmlsbGV0ZXIgPGpAYml0cm9uLmNoPgo+PiAt
LS0KPj4gIHNvdW5kL3NvYy9zaC9yY2FyL2NvcmUuYyB8IDYgKysrKy0tCj4+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL3NoL3JjYXIvY29yZS5jIGIvc291bmQvc29jL3NoL3JjYXIvY29yZS5jCj4+IGlu
ZGV4IDRlODYyNjUuLmQ3MzdmZWEgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3NvYy9zaC9yY2FyL2Nv
cmUuYwo+PiArKysgYi9zb3VuZC9zb2Mvc2gvcmNhci9jb3JlLmMKPj4gQEAgLTI5NSw5ICsyOTUs
MTEgQEAgc3RhdGljIHZvaWQgcnNuZF9kbWFfb2ZfbmFtZShzdHJ1Y3QgcnNuZF9kbWEgKmRtYSwK
Pj4gICAgICAgICBtb2RbMF0gPSBOVUxMOyAvKiBmb3IgIm1lbSIgKi8KPj4gICAgICAgICBpbmRl
eCA9IDE7Cj4+ICAgICAgICAgZm9yIChpID0gMTsgaSA8IE1PRF9NQVg7IGkrKykgewo+PiAtICAg
ICAgICAgICAgICAgaWYgKCFzcmMpIHsKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgbW9kW2ld
ID0gc3NpOwo+PiArICAgICAgICAgICAgICAgaWYgKCFzc2kpIHsKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7Cj4+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKCFzcmMpIHsKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgbW9kW2ldID0gc3NpOwo+PiArICAgICAgICAgICAgICAg
ICAgICAgICBzc2kgPSBOVUxMOwo+PiAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICghZHZjKSB7
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgIG1vZFtpXSA9IHNyYzsKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgc3JjID0gTlVMTDsKPj4gLS0KPj4gMi4wLjEKPj4KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKPj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCj4+IGh0dHA6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCj4+Cj4KPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
