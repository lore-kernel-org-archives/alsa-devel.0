From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
 support
Date: Mon, 25 Jun 2018 14:12:38 +0200
Message-ID: <1529928758.2900.36.camel@baylibre.com>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk>
 <1529926289.2900.26.camel@baylibre.com>
 <20180625114445.GG9413@sirena.org.uk>
 <1529927459.2900.32.camel@baylibre.com>
 <CAC8rN+BM-y=8xRE53xsjozdWNM=vMzRCeC8Nv-gB27nkFMoWpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2097A2677A0
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:12:39 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id l14-v6so8363930wrq.13
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 05:12:39 -0700 (PDT)
In-Reply-To: <CAC8rN+BM-y=8xRE53xsjozdWNM=vMzRCeC8Nv-gB27nkFMoWpQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Cc: hdegoede@redhat.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMDE4LTA2LTI1IGF0IDE0OjA3ICswMjAwLCBOaWNvbMOyIFZlcm9uZXNlIHdyb3Rl
Ogo+IElmIHlvdSBjYW4gZG8gaXQsIGl0J3MgYmV0dGVyLgo+IEknbSBzdGlsbCBsZWFybmluZywg
dGFrZSBjYXJlIHRoYXQgdGhlICJzaW1wbGUtYW1wbGlmaWVyIiBjYW4gc3VwcG9ydCBzdXBwbHlz
LgoKc3VwcGxpZXMgc3VwcG9ydCBtYWtlcyBzZW5zZS4KCklmIEkgbWF5IHN1Z2dlc3QgdGhlIGZv
bGxvd2luZzoKKiAxKSBKdXN0IHBlcmZvcm0gYSBzaW1wbGUgcmVuYW1lL3NlZCBmaXJzdCAoRG9u
J3QgZm9yZ2V0IHRoZSBEVCBkb2N1bWVudGF0aW9uKQoqIDIpIEFkZCB5b3VyIGNvbXBhdGlibGUg
dG8gdGhlIGxpc3QKKiAzKSBBZGQgb3B0aW9uYWwgc3VwcGx5IHN1cHBvcnQgaWYgeW91IG5lZWQg
aXQKCkNoZWVycwpKZXJvbWUKCj4gCj4gUmVnYXJkcywKPiBOaWNvbMOyCj4gCj4gSWwgZ2lvcm5v
IGx1biAyNSBnaXUgMjAxOCBhbGxlIG9yZSAxMzo1MSBKZXJvbWUgQnJ1bmV0IDxqYnJ1bmV0QGJh
eWxpYnJlLmNvbT4gaGEgc2NyaXR0bzoKPiA+IE9uIE1vbiwgMjAxOC0wNi0yNSBhdCAxMjo0NCAr
MDEwMCwgTWFyayBCcm93biB3cm90ZToKPiA+ID4gT24gTW9uLCBKdW4gMjUsIDIwMTggYXQgMDE6
MzE6MjlQTSArMDIwMCwgSmVyb21lIEJydW5ldCB3cm90ZToKPiA+ID4gCj4gPiA+ID4gU2FtZSBj
b21tZW50IGFzIG9uIElSQywgeW91IGRyaXZlciBsb29rcyB2ZXJ5IHNpbWlsYXIgdG8gdGhlIG9u
ZSBJIHBvc3RlZCBhCj4gPiA+ID4gd2hpbGUgYmFjayAoc291bmQvc29jL2NvZGVjcy9kaW8yMTI1
LmMpCj4gPiA+ID4gQ291bGQgeW91IGp1c3QgYWRkIHlvdXIgY29tcGF0aWJsZSB0byB0aGUgbGlz
dCBpbiB0aGUgZXhpc3RpbmcgZHJpdmVyID8KPiA+ID4gPiBJcyB0aGVyZSBhbnl0aGluZyBJIG1p
c3NlZCB3aGljaCBtYWtlcyB0aGVtIGluY29tcGF0aWJsZSA/Cj4gPiA+IAo+ID4gPiBJdCdzIHBy
b2JhYmx5IGEgZ29vZCBpZGVhIHRvIHJlbmFtZSB0aGF0IGRyaXZlciBzbyBpdCdzIGEgYml0IG1v
cmUKPiA+ID4gZGlzY292ZXJhYmxlIC0geW91J3JlIGFic29sdXRlbHkgcmlnaHQgdGhhdCBpdCdz
IHZlcnkgc2ltaWxhciBhbmQgZG9pbmcKPiA+ID4gYmFzaWNhbGx5IHRoZSBzYW1lIHRoaW5nIGJ1
dCBJJ2QgY29tcGxldGVseSBmb3Jnb3R0ZW4gdGhhdCBpdCBleGlzdGVkIDovCj4gPiAKPiA+IEFn
cmVlZCAsIHRoZSBuYW1lIGlzIHBvb3JseSBjaG9zZW4uIEkgZGlkIG5vdCB0aG91Z2h0IGl0IHdh
cyBhIGdlbmVyaWMgbmVlZCBhdAo+ID4gdGhlIHRpbWUuCj4gPiAKPiA+IE5pY29sw7IsIGRvIHlv
dSB3YW50IHRvIGRvIHRoZSByZW1hbWUgPyBvciB3b3VsZCB5b3UgcHJlZmVyIG1lIHRvIGRvIGl0
ID8KPiA+IAo+ID4gQ2hlZXJzCj4gPiBKZXJvbWUKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
