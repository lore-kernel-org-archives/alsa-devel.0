From: Micka <mickamusset@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 21 Mar 2016 15:29:00 +0000
Message-ID: <CAF+MRtkm+OHQHwW4cTihSV5MOnJWiq4XfjoxghYN7eq05e0pWw@mail.gmail.com>
References: <1458525542-2168-1-git-send-email-yesanishhere@gmail.com>
 <20160321145642.GV2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id BE2F22654BA
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 16:29:09 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id l68so115020972wml.0
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 08:29:09 -0700 (PDT)
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

SGkgTWFyaywKCkNvdWxkIHlvdSB0ZWxsIG1lIGhvdyBkbyB5b3UgY29udHJvbCB0aGlzIGRldmlj
ZS9jb2RlYyB3aXRoIExpbnV4ID8gV2hhdCBpcwp0aGUgY29tbWFuZCA/CgpUaGFuayB5b3UgIQoK
TGUgbHVuLiAyMSBtYXJzIDIwMTYgw6AgMTY6MDMsIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVs
Lm9yZz4gYSDDqWNyaXQgOgoKPiBPbiBTdW4sIE1hciAyMCwgMjAxNiBhdCAwNjo1OTowMlBNIC0w
NzAwLCBhbmlzaCBrdW1hciB3cm90ZToKPgo+IFRoaXMgbG9va3MgbW9zdGx5IGdvb2QsIGEgZmV3
IHNtYWxsIHRoaW5nczoKPgo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICpjb25zdCB2b2x0YWdlX2xl
dmVsX3RleHRbXSA9IHsKPiA+ICsgICAgICI5LjVkQiIsICIxMC41ZEIiLCAiMTEuNWRCIiwgIjEx
LjVkQiIsICIxMi41ZEIiLAo+ID4gKyAgICAgIjEzLjVkQiIsICIxNC41ZEIiLCAiMTUuNWRCIiwg
IjE2LjVkQiIsICIxNy41ZEIiLAo+ID4gKyAgICAgIjE4LjVkQiIsICIxOS41ZEIiLCAiMjAuNWRC
Igo+ID4gK307Cj4KPiBWb2x1bWUgY29udHJvbHMgc2hvdWxkIGJlIGRvbmUgd2l0aCBUTFYgZGF0
YSBub3QgZW51bXMuCj4KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHNuZF9rY29udHJvbF9uZXcg
bWF4OTgzNzFfc25kX2NvbnRyb2xzW10gPSB7Cj4gPiArICAgICBTT0NfU0lOR0xFX1RMVigiU3Bl
YWtlciBHYWluIiwgTUFYOTgzNzFfR0FJTiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICBNQVg5
ODM3MV9HQUlOX1NISUZULCAoMTw8TUFYOTgzNzFfR0FJTl9XSURUSCktMSwgMCwKPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBtYXg5ODM3MV9nYWluX3RsdiksCj4KPiBWb2x1bWUgY29udHJvbHMg
c2hvdWxkIGVuZCB3aXRoIFZvbHVtZS4KPgo+ID4gK3N0YXRpYyBpbnQgbWF4OTgzNzFfcHJvYmUo
c3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjKQo+ID4gK3sKPiA+ICsgICAgIHN0cnVjdCBtYXg5
ODM3MV9wcml2ICptYXg5ODM3MSA9IHNuZF9zb2NfY29kZWNfZ2V0X2RydmRhdGEoY29kZWMpOwo+
ID4gKwo+ID4gKyAgICAgbWF4OTgzNzEtPmNvZGVjID0gY29kZWM7Cj4gPiArICAgICByZXR1cm4g
MDsKPiA+ICt9Cj4KPiBEbyB3ZSBldmVyIGFjdHVhbGx5IHVzZSB0aGlzPwo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiBodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
