From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Subject: Re: [PATCH] ASoC: rsnd: fixup index of SSI mod when
 SRC is used
Date: Thu, 3 Jul 2014 22:57:34 +0900
Message-ID: <CA+t-KAiFNi2cdfKQfNYf7svWKXg4sBhPzib+Q7qfONosuwdy7A@mail.gmail.com>
References: <1404299931-21384-1-git-send-email-j@bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C8E452619E9
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 15:57:34 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id dc16so210180qab.15
 for <alsa-devel@alsa-project.org>; Thu, 03 Jul 2014 06:57:34 -0700 (PDT)
In-Reply-To: <1404299931-21384-1-git-send-email-j@bitron.ch>
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

SGkKCklmIHlvdSBhZGQgdGhpcyBjb2RlLAoKICAgICAgICBpZiAoIXNzaSkgewogICAgICAgICAg
ICAgICBicmVhazsKICAgICAgICB9IGVsc2UgLi4uCgp0aGVuLCBJIGd1ZXNzIHdlIGNhbiByZW1v
dmUgdGhpcyBjb2RlID8KCglpZiAobW9kW2ldID09IHNzaSkKCWJyZWFrOwoKCgoyMDE0LTA3LTAy
IDIwOjE4IEdNVCswOTowMCBKw7xyZyBCaWxsZXRlciA8akBiaXRyb24uY2g+OgoKPiBUaGUgZGVm
YXVsdCBpbmRleCAxIHdhcyB1c2VkIGFzIHRoZSBsb29wIHdhcyB0ZXJtaW5hdGVkIGJlZm9yZSB0
aGUKPiBmb2xsb3dpbmcgY29kZSBjb3VsZCBiZSByZWFjaGVkOgo+Cj4gICAgICAgICBpZiAobW9k
W2ldID09IHRoaXMpCj4gICAgICAgICAgICAgICAgIGluZGV4ID0gaTsKPgo+IFNpZ25lZC1vZmYt
Ynk6IErDvHJnIEJpbGxldGVyIDxqQGJpdHJvbi5jaD4KPiAtLS0KPiAgc291bmQvc29jL3NoL3Jj
YXIvY29yZS5jIHwgNiArKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc2gvcmNhci9jb3JlLmMg
Yi9zb3VuZC9zb2Mvc2gvcmNhci9jb3JlLmMKPiBpbmRleCA0ZTg2MjY1Li5kNzM3ZmVhIDEwMDY0
NAo+IC0tLSBhL3NvdW5kL3NvYy9zaC9yY2FyL2NvcmUuYwo+ICsrKyBiL3NvdW5kL3NvYy9zaC9y
Y2FyL2NvcmUuYwo+IEBAIC0yOTUsOSArMjk1LDExIEBAIHN0YXRpYyB2b2lkIHJzbmRfZG1hX29m
X25hbWUoc3RydWN0IHJzbmRfZG1hICpkbWEsCj4gICAgICAgICBtb2RbMF0gPSBOVUxMOyAvKiBm
b3IgIm1lbSIgKi8KPiAgICAgICAgIGluZGV4ID0gMTsKPiAgICAgICAgIGZvciAoaSA9IDE7IGkg
PCBNT0RfTUFYOyBpKyspIHsKPiAtICAgICAgICAgICAgICAgaWYgKCFzcmMpIHsKPiAtICAgICAg
ICAgICAgICAgICAgICAgICBtb2RbaV0gPSBzc2k7Cj4gKyAgICAgICAgICAgICAgIGlmICghc3Np
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICAgICAgICAgIH0g
ZWxzZSBpZiAoIXNyYykgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIG1vZFtpXSA9IHNzaTsK
PiArICAgICAgICAgICAgICAgICAgICAgICBzc2kgPSBOVUxMOwo+ICAgICAgICAgICAgICAgICB9
IGVsc2UgaWYgKCFkdmMpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBtb2RbaV0gPSBzcmM7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgc3JjID0gTlVMTDsKPiAtLQo+IDIuMC4xCj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IEFsc2EtZGV2
ZWwgbWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCj4gaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwKPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
