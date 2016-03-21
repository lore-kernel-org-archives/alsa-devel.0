From: Micka <mickamusset@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 21 Mar 2016 16:41:43 +0000
Message-ID: <CAF+MRtm16ThnHwPvmR6oDeZcavvwVvMmvmgq6en-_e6U81hFeg@mail.gmail.com>
References: <1458525542-2168-1-git-send-email-yesanishhere@gmail.com>
 <20160321145642.GV2566@sirena.org.uk>
 <CAF+MRtkm+OHQHwW4cTihSV5MOnJWiq4XfjoxghYN7eq05e0pWw@mail.gmail.com>
 <20160321155659.GW2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C18826507F
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 17:41:53 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id l68so129351322wml.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 09:41:53 -0700 (PDT)
In-Reply-To: <20160321155659.GW2566@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

KlBsZWFzZSBkb24ndCB0b3AgcG9zdCwgcmVwbHkgaW4gbGluZSB3aXRoIG5lZWRlZCBjb250ZXh0
LiAgVGhpcwphbGxvd3NyZWFkZXJzIHRvIHJlYWRpbHkgZm9sbG93IHRoZSBmbG93IG9mIGNvbnZl
cnNhdGlvbiBhbmQgdW5kZXJzdGFuZAp3aGF0eW91IGFyZSB0YWxraW5nIGFib3V0IGFuZCBhbHNv
IGhlbHBzIGVuc3VyZSB0aGF0IGV2ZXJ5dGhpbmcgaW4KdGhlZGlzY3Vzc2lvbiBpcyBiZWluZyBh
ZGRyZXNzZWQuKgoKU29ycnkgLi4uCgoKCgoqPiBDb3VsZCB5b3UgdGVsbCBtZSBob3cgZG8geW91
IGNvbnRyb2wgdGhpcyBkZXZpY2UvY29kZWMgd2l0aCBMaW51eCA/IFdoYXQKaXM+IHRoZSBjb21t
YW5kID8qCipVc2luZyBhbnkgQUxTQSB1c2Vyc3BhY2UgYXBwbGljYXRpb25zLioKCkJ1dCBIb3cg
ZG8geW91IGZpbmQgdGhlIGRldmljZSBpbiB0aGUgYW1peGVyIGFwcGxpY2F0aW9uID8gVGhhdCB0
aGUgcGFydApkb24ndCBJIGRvbid0IGdldCBpdCAhCgpNaWNrYSwKCgpMZSBsdW4uIDIxIG1hcnMg
MjAxNiDDoCAxNjo1NywgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPiBhIMOpY3JpdCA6
Cgo+IE9uIE1vbiwgTWFyIDIxLCAyMDE2IGF0IDAzOjI5OjAwUE0gKzAwMDAsIE1pY2thIHdyb3Rl
Ogo+ID4gSGkgTWFyaywKPgo+IFBsZWFzZSBkb24ndCB0b3AgcG9zdCwgcmVwbHkgaW4gbGluZSB3
aXRoIG5lZWRlZCBjb250ZXh0LiAgVGhpcyBhbGxvd3MKPiByZWFkZXJzIHRvIHJlYWRpbHkgZm9s
bG93IHRoZSBmbG93IG9mIGNvbnZlcnNhdGlvbiBhbmQgdW5kZXJzdGFuZCB3aGF0Cj4geW91IGFy
ZSB0YWxraW5nIGFib3V0IGFuZCBhbHNvIGhlbHBzIGVuc3VyZSB0aGF0IGV2ZXJ5dGhpbmcgaW4g
dGhlCj4gZGlzY3Vzc2lvbiBpcyBiZWluZyBhZGRyZXNzZWQuCj4KPiA+IENvdWxkIHlvdSB0ZWxs
IG1lIGhvdyBkbyB5b3UgY29udHJvbCB0aGlzIGRldmljZS9jb2RlYyB3aXRoIExpbnV4ID8gV2hh
dAo+IGlzCj4gPiB0aGUgY29tbWFuZCA/Cj4KPiBVc2luZyBhbnkgQUxTQSB1c2Vyc3BhY2UgYXBw
bGljYXRpb25zLgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
