From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda/hdmi - Don't report Jack event
 if no need to do that
Date: Sat, 4 May 2019 17:25:49 +0800
Message-ID: <dda15837-1da9-8b68-853b-ccd513d3e93d@canonical.com>
References: <20190430065711.14977-1-hui.wang@canonical.com>
 <s5hh8aghro8.wl-tiwai@suse.de>
 <b0c859a8-3f7f-2948-2fc8-f657adf3c804@canonical.com>
 <s5h36lzj27d.wl-tiwai@suse.de>
 <1be4853e-05cd-fc87-8db6-7ba17ee009ab@canonical.com>
 <s5ha7g4ua92.wl-tiwai@suse.de>
 <4611984b-c80f-8aa4-a760-72343572470e@canonical.com>
 <s5himurr0no.wl-tiwai@suse.de>
 <a1c69f75-da2b-8ac0-9dfa-34958cdb5fd8@canonical.com>
 <s5hzho2lmal.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85B1CF8075A
 for <alsa-devel@alsa-project.org>; Sat,  4 May 2019 11:25:56 +0200 (CEST)
In-Reply-To: <s5hzho2lmal.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDIwMTkvNS80IOS4i+WNiDM6MTgsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBTYXQsIDA0
IE1heSAyMDE5IDA0OjQ1OjM2ICswMjAwLAo+IEh1aSBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDE5
LzUvMyDkuIvljYgxMTo1NywgVGFrYXNoaSBJd2FpIHdyb3RlOgo+Pj4gT24gRnJpLCAwMyBNYXkg
MjAxOSAwNjowNTowOSArMDIwMCwKPj4+IEh1aSBXYW5nIHdyb3RlOgo+Pgo+IFJpZ2h0Li4uCj4K
Pj4gQW5kIGluc3BpcmVkIGJ5IHlvdXIgY2hhbmdlLCBtYXliZSB3ZSBqdXN0IG1ha2UgdGhpcyBj
aGFuZ2UsIHRoZW4gaXQKPj4gaXMgZW5vdWdoIHRvIGZpeCB0aGUgZmFsc2VseSByZXBvcnQgaXNz
dWUgaGVyZS4KPj4KPj4gQEAgLTE1NTEsOCArMTU1MSwxMSBAQCBzdGF0aWMgYm9vbCBoZG1pX3By
ZXNlbnRfc2Vuc2VfdmlhX3ZlcmJzKHN0cnVjdCBoZG1pX3NwZWNfcGVyX3BpbiAqcGVyX3BpbiwK
Pj4gICAJcmV0ID0gIXJlcG9sbCB8fCAhZWxkLT5tb25pdG9yX3ByZXNlbnQgfHwgZWxkLT5lbGRf
dmFsaWQ7Cj4+ICAgCWphY2sgPSBzbmRfaGRhX2phY2tfdGJsX2dldChjb2RlYywgcGluX25pZCk7
Cj4+IC0JaWYgKGphY2spCj4+ICsJaWYgKGphY2spIHsKPj4gICAJCWphY2stPmJsb2NrX3JlcG9y
dCA9ICFyZXQ7Cj4+ICsJCWphY2stPnBpbl9zZW5zZSA9IChlbGQtPm1vbml0b3JfcHJlc2VudCAm
JiBlbGQtPmVsZF92YWxpZCkgPwo+PiArCQkJQUNfUElOU0VOU0VfUFJFU0VOQ0UgOiAwOwo+PiAr
CX0KPj4KPj4gYmVjYXVzZSBpbiB0aGUgc25kX2hkYV9waW5fc2Vuc2UoKSwgdGhlIGphY2tfZGly
dHkgaXMgc2V0IHRvIDAsIHRoZW4KPj4gd2UgY2hhbmdlIHRoZSBqYWNrLT5waW5fc2Vuc2UswqAg
YW5kIGluIHRoZSByZXBvcnRfc3luYygpIGl0IHdpbGwKPj4gZGVjaWRlIHRoZSBqYWNrIHN0YXRl
IGFjY29yZGluZyB0byB0aGUgamFjay0+cGluX3NlbnNlIHdlIGNoYW5nZWQuCj4gT0ssIHRoYXQg
c2hvdWxkIHdvcmssIGp1c3Qgb3ZlcnJpZGluZyBhbmQgY29ycmVjdGluZyB0aGUgcGluX3NlbnNl
Lgo+Cj4gSSBndWVzcyB0aGUgb25seSBtaXNzaW5nIGNvZGUgcGF0aCBpcyB0aGUgY2FzZSB3aGVy
ZSBqYWNrLT5kaXJ0eSBpcwo+IHNldCBtYW51YWxseSB3aXRob3V0IHRoZSBjYWxsYmFjayBjYWxs
IHZpYQo+IHNuZF9oZGFfamFja19zZXRfZGlydHlfYWxsKCkuICBUaHJvdWdoIGEgcXVpY2sgZ2xh
bmNlLCBpdCdzIGNhbGxlZAo+IGZyb20gdGhlIGNvbW1vbiByZXN1bWUgY29kZSwgaGRhX2NhbGxf
Y29kZWNfcmVzdW1lKCkuICBCdXQsIGFnYWluLAo+IEhETUkgY29kZWMgaGFzIGl0cyBvd24gcmVz
dW1lIHRvIHJlZnJlc2ggcGluIGRldGVjdGlvbgo+IChnZW5lcmljX2hkbWlfcmVzdW1lKCkpLCBh
bmQgdGhlIGNoYW5nZWQgY29kZS1wYXRoIHNob3VsZCBiZQo+IGludm9sdmVkLgo+Cj4gVGhlIHJl
c3QgY2FsbGVycyBvZiBzbmRfaGRhX2phY2tfc2V0X2RpcnR5X2FsbCgpIGFyZSB0aGUgcG9sbGlu
ZyBtb2RlCj4gYW5kIHRoZSB1bnNvbCBldmVudCBoYW5kbGVyIGZvciB0aGUgb2xkIEhETUkgY29k
ZWNzLCBib3RoIG9mIHdoaWNoIHdlCj4gZG9uJ3QgY2FyZSBtdWNoLgo+Cj4gVGhhdCBzYWlkLCB5
b3VyIG1pbmltYWwgY2hhbmdlIGxvb2tzIGdvb2QgdG8gbWUsIGFuZCBJJ2xsIGhhcHBpbHkKPiBh
cHBseSBhcyBsb25nIGFzIGl0J3MgdGVzdGVkLiAgT2YgY291cnNlLCBpdCBuZWVkcyBzb21lIG1v
cmUgY2FyZWZ1bAo+IGNvbW1lbnRzIGFib3V0IHRoZSBiZWhhdmlvci4KCk9LLMKgIGFmdGVyIHRl
c3RpbmcgaXQsIEkgd2lsbCBzZW5kIHRoZSBwYXRjaCB0byByZXZpZXcuCgpUaGFua3MuCgoKPgo+
Cj4gVGhhbmtzIQo+Cj4gVGFrYXNoaQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKPiBodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2pl
Y3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
