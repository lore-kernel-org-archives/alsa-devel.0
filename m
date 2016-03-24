From: Micka <mickamusset@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Thu, 24 Mar 2016 10:49:59 +0000
Message-ID: <CAF+MRtnwdsDdEfmnZLcO=-kKURAt9uf5kTsxfGiAbVrsrSP49g@mail.gmail.com>
References: <1458525542-2168-1-git-send-email-yesanishhere@gmail.com>
 <20160321145642.GV2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id E78B626645E
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 11:50:08 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id l68so268747843wml.0
 for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2016 03:50:08 -0700 (PDT)
In-Reply-To: <20160321145642.GV2566@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

SGkgTWFyaywKCldoZXJlIEkgY2FuIGZpbmQgeW91ciBwYXRjaCA/IFdpbGwgaXQgd29yayB1bmRl
ciB0aGUga2VybmVsIDQuMSA/IEFuZCBob3cKZG8geW91IG1ha2UgaXQgd29yayB3aXRoIHRoZSBk
dHMgZmlsZSA/CgpNaWNrYSwKCkxlIGx1bi4gMjEgbWFycyAyMDE2IMOgIDE2OjAzLCBNYXJrIEJy
b3duIDxicm9vbmllQGtlcm5lbC5vcmc+IGEgw6ljcml0IDoKCj4gT24gU3VuLCBNYXIgMjAsIDIw
MTYgYXQgMDY6NTk6MDJQTSAtMDcwMCwgYW5pc2gga3VtYXIgd3JvdGU6Cj4KPiBUaGlzIGxvb2tz
IG1vc3RseSBnb29kLCBhIGZldyBzbWFsbCB0aGluZ3M6Cj4KPiA+ICtzdGF0aWMgY29uc3QgY2hh
ciAqY29uc3Qgdm9sdGFnZV9sZXZlbF90ZXh0W10gPSB7Cj4gPiArICAgICAiOS41ZEIiLCAiMTAu
NWRCIiwgIjExLjVkQiIsICIxMS41ZEIiLCAiMTIuNWRCIiwKPiA+ICsgICAgICIxMy41ZEIiLCAi
MTQuNWRCIiwgIjE1LjVkQiIsICIxNi41ZEIiLCAiMTcuNWRCIiwKPiA+ICsgICAgICIxOC41ZEIi
LCAiMTkuNWRCIiwgIjIwLjVkQiIKPiA+ICt9Owo+Cj4gVm9sdW1lIGNvbnRyb2xzIHNob3VsZCBi
ZSBkb25lIHdpdGggVExWIGRhdGEgbm90IGVudW1zLgo+Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBzbmRfa2NvbnRyb2xfbmV3IG1heDk4MzcxX3NuZF9jb250cm9sc1tdID0gewo+ID4gKyAgICAg
U09DX1NJTkdMRV9UTFYoIlNwZWFrZXIgR2FpbiIsIE1BWDk4MzcxX0dBSU4sCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgTUFYOTgzNzFfR0FJTl9TSElGVCwgKDE8PE1BWDk4MzcxX0dBSU5fV0lE
VEgpLTEsIDAsCj4gPiArICAgICAgICAgICAgICAgICAgICAgbWF4OTgzNzFfZ2Fpbl90bHYpLAo+
Cj4gVm9sdW1lIGNvbnRyb2xzIHNob3VsZCBlbmQgd2l0aCBWb2x1bWUuCj4KPiA+ICtzdGF0aWMg
aW50IG1heDk4MzcxX3Byb2JlKHN0cnVjdCBzbmRfc29jX2NvZGVjICpjb2RlYykKPiA+ICt7Cj4g
PiArICAgICBzdHJ1Y3QgbWF4OTgzNzFfcHJpdiAqbWF4OTgzNzEgPSBzbmRfc29jX2NvZGVjX2dl
dF9kcnZkYXRhKGNvZGVjKTsKPiA+ICsKPiA+ICsgICAgIG1heDk4MzcxLT5jb2RlYyA9IGNvZGVj
Owo+ID4gKyAgICAgcmV0dXJuIDA7Cj4gPiArfQo+Cj4gRG8gd2UgZXZlciBhY3R1YWxseSB1c2Ug
dGhpcz8KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IEFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCj4g
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
