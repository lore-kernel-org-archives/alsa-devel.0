From: =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
	support
Date: Mon, 25 Jun 2018 14:07:02 +0200
Message-ID: <CAC8rN+BM-y=8xRE53xsjozdWNM=vMzRCeC8Nv-gB27nkFMoWpQ@mail.gmail.com>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk> <1529926289.2900.26.camel@baylibre.com>
 <20180625114445.GG9413@sirena.org.uk> <1529927459.2900.32.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C3FE2676D8
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:07:15 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id b5-v6so3095000oiy.11
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 05:07:15 -0700 (PDT)
In-Reply-To: <1529927459.2900.32.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jbrunet@baylibre.com
Cc: hdegoede@redhat.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SWYgeW91IGNhbiBkbyBpdCwgaXQncyBiZXR0ZXIuCkknbSBzdGlsbCBsZWFybmluZywgdGFrZSBj
YXJlIHRoYXQgdGhlICJzaW1wbGUtYW1wbGlmaWVyIiBjYW4gc3VwcG9ydApzdXBwbHlzLgoKUmVn
YXJkcywKTmljb2zDsgoKSWwgZ2lvcm5vIGx1biAyNSBnaXUgMjAxOCBhbGxlIG9yZSAxMzo1MSBK
ZXJvbWUgQnJ1bmV0IDxqYnJ1bmV0QGJheWxpYnJlLmNvbT4KaGEgc2NyaXR0bzoKCj4gT24gTW9u
LCAyMDE4LTA2LTI1IGF0IDEyOjQ0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+ID4gT24gTW9u
LCBKdW4gMjUsIDIwMTggYXQgMDE6MzE6MjlQTSArMDIwMCwgSmVyb21lIEJydW5ldCB3cm90ZToK
PiA+Cj4gPiA+IFNhbWUgY29tbWVudCBhcyBvbiBJUkMsIHlvdSBkcml2ZXIgbG9va3MgdmVyeSBz
aW1pbGFyIHRvIHRoZSBvbmUgSQo+IHBvc3RlZCBhCj4gPiA+IHdoaWxlIGJhY2sgKHNvdW5kL3Nv
Yy9jb2RlY3MvZGlvMjEyNS5jKQo+ID4gPiBDb3VsZCB5b3UganVzdCBhZGQgeW91ciBjb21wYXRp
YmxlIHRvIHRoZSBsaXN0IGluIHRoZSBleGlzdGluZyBkcml2ZXIgPwo+ID4gPiBJcyB0aGVyZSBh
bnl0aGluZyBJIG1pc3NlZCB3aGljaCBtYWtlcyB0aGVtIGluY29tcGF0aWJsZSA/Cj4gPgo+ID4g
SXQncyBwcm9iYWJseSBhIGdvb2QgaWRlYSB0byByZW5hbWUgdGhhdCBkcml2ZXIgc28gaXQncyBh
IGJpdCBtb3JlCj4gPiBkaXNjb3ZlcmFibGUgLSB5b3UncmUgYWJzb2x1dGVseSByaWdodCB0aGF0
IGl0J3MgdmVyeSBzaW1pbGFyIGFuZCBkb2luZwo+ID4gYmFzaWNhbGx5IHRoZSBzYW1lIHRoaW5n
IGJ1dCBJJ2QgY29tcGxldGVseSBmb3Jnb3R0ZW4gdGhhdCBpdCBleGlzdGVkIDovCj4KPiBBZ3Jl
ZWQgLCB0aGUgbmFtZSBpcyBwb29ybHkgY2hvc2VuLiBJIGRpZCBub3QgdGhvdWdodCBpdCB3YXMg
YSBnZW5lcmljCj4gbmVlZCBhdAo+IHRoZSB0aW1lLgo+Cj4gTmljb2zDsiwgZG8geW91IHdhbnQg
dG8gZG8gdGhlIHJlbWFtZSA/IG9yIHdvdWxkIHlvdSBwcmVmZXIgbWUgdG8gZG8gaXQgPwo+Cj4g
Q2hlZXJzCj4gSmVyb21lCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
