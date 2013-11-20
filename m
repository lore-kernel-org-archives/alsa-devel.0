From: Roman Volkov <v1ron@mail.ru> (by way of Roman Volkov <v1ron@mail.ru>)
Subject: Re: [PATCH 1/2] snd-oxygen: Changes for oxygen driver
 to fix the Xonar DG card
Date: Wed, 20 Nov 2013 12:21:12 +0400
Message-ID: <20131120122112.41c80d5c@v1ron-desktop>
References: <20131119182617.0bbae792@v1ron-desktop>
 <528BE4ED.4050105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp33.i.mail.ru (smtp33.i.mail.ru [94.100.177.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AC722615F3
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 15:13:16 +0100 (CET)
Received: from [213.87.140.72] (port=63787 helo=v1ron-desktop)
 by smtp33.i.mail.ru with esmtpa (envelope-from <v1ron@mail.ru>)
 id 1Vj8Wp-0002L2-Hj
 for alsa-devel@alsa-project.org; Wed, 20 Nov 2013 18:13:16 +0400
In-Reply-To: <528BE4ED.4050105@ladisch.de>
Resent-Message-ID: <20131120181308.6c98f1e0@v1ron-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

0JIgVHVlLCAxOSBOb3YgMjAxMyAyMzoyMzo0MSArMDEwMApDbGVtZW5zIExhZGlzY2ggPGNsZW1l
bnNAbGFkaXNjaC5kZT4g0L/QuNGI0LXRgjoKCj4gTWFueSB0aGFua3MgZm9yIGRvaW5nIGFsbCB0
aGlzIHdvcmshCj4gSG93ZXZlciwgdGhlcmUgYXJlIHN0aWxsIGEgZmV3IHNtYWxsIHByb2JsZW1z
Lgo+IAo+IFJvbWFuIFZvbGtvdiB3cm90ZToKPiA+IFRoaXMgcGF0Y2ggZG9lcyBzb21lIHByZXBh
cmF0aW9uIG9mIGV4aXN0aW5nIE94eWdlbiBkcml2ZXIuCj4gCj4gVGhpcyBwYXRjaCBzaG91bGQg
YmUgc2VwYXJhdGVkIGludG8gZm91ciBsb2dpY2FsIGNoYW5nZXMuCgpPa2F5LCB3aWxsIHNwbGl0
IHRoaXMgYW5kIHNlbmQgYWdhaW4sIGNvbnNpZGVyaW5nIGFsbCB5b3VyIGNvbW1lbnRzLgoKPiAK
PiA+ICsrKyBsaW51eC0zLjEyLW15L3NvdW5kL3BjaS9veHlnZW4vb3h5Z2VuX2lvLmMJMjAxMy0x
MS0xOQo+ID4gMDA6NTY6MTIuMDAwMDAwMDAwICswNDAwCj4gPiAtCXdhaXRfZXZlbnRfdGltZW91
dChjaGlwLT5hYzk3X3dhaXRxdWV1ZSwKPiA+IC0JCQkgICAoeyBzdGF0dXMgfD0gb3h5Z2VuX3Jl
YWQ4KGNoaXAsCj4gPiBPWFlHRU5fQUM5N19JTlRFUlJVUFRfU1RBVFVTKTsKPiA+ICsJd2FpdF9l
dmVudF90aW1lb3V0KGNoaXAtPmFjOTdfd2FpdHF1ZXVlLCAoeyBzdGF0dXMgfD0KPiA+IG94eWdl
bl9yZWFkOChjaGlwLAo+ID4gKwo+ID4gT1hZR0VOX0FDOTdfSU5URVJSVVBUX1NUQVRVUyk7IHN0
YXR1cyAmIG1hc2s7IH0pLAo+IAo+IFdoeSB0aGlzIGNoYW5nZT8KCkp1c3QgY2hlY2twYXRjaC5w
bCBwb3BwZWQgbWUgYSB3YXJuaW5nICg4MCBjb2x1bW5zIGV4Y2VlZGVkKSwKYW5kIEkgb2NjYXNp
b25hbGx5IGNoYW5nZWQgdGhpcy4gV2lsbCByZXZlcnQgdGhpcyBhcyB0aGlzIGNvZGUKaXMgYWxy
ZWFkeSBpbiB0aGUga2VybmVsLgoKPiA+ICtpbnQgb3h5Z2VuX3dhaXRfc3BpKHN0cnVjdCBveHln
ZW4gKmNoaXApCj4gPiAgLi4uCj4gPiAtCQl1ZGVsYXkoNCk7Cj4gPiArCQl1ZGVsYXkoMSk7Cj4g
Cj4gUGxlYXNlIGRvbid0IHJlZHVjZSB0aGlzIGRlbGF5OyB0aGUgQ01JODc4OCBoYXMgYSBidWcg
dGhhdCBjYW4gY3Jhc2gKPiB0aGUgbWFjaGluZSBpZiB0aGlzIHJlZ2lzdGVyIGlzIHBvbGxlZCB0
b28gb2Z0ZW4uCj4gCj4gPiArRVhQT1JUX1NZTUJPTChveHlnZW5fd2FpdF9zcGkpOwo+IAo+IFdo
eSB0aGlzIGV4cG9ydD8KCkhvd2V2ZXIgeWVzLCB3aGVuIEkgbW92ZWQgd2FpdCBjYWxsIHRvIHRo
ZSBlbmQgb2Ygb3h5Z2VuX3dyaXRlX3NwaSgpLAphZGRpdGlvbmFsIHdhaXRpbmcgaXMgbm90IG5l
Y2Vzc2FyeS4gV2lsbCBiZSB0aGUgc3RhdGljIGZ1bmN0aW9uLgoKPiA+ICsrKyBsaW51eC0zLjEy
LW15L3NvdW5kL3BjaS9veHlnZW4vb3h5Z2VuX21peGVyLmMJMjAxMy0xMS0xOAo+ID4gMTQ6MDM6
NTQuMDAwMDAwMDAwICswNDAwCj4gCj4gPiArRVhQT1JUX1NZTUJPTChveHlnZW5fdXBkYXRlX2Rh
Y19yb3V0aW5nKTsKPiAKPiBUaGlzIHNob3VsZCBiZSBpbnRlZ3JhdGVkIGludG8gdGhlIHBhdGNo
IHRoYXQgYWRkcyB0aGUgYWN0dWFsIGNhbGwuCj4gCj4gCj4gUmVnYXJkcywKPiBDbGVtZW5zCj4g
CgpLaW5kIHJlZ2FyZHMsClJvbWFuIFZvbGtvdgp2MXJvbkBtYWlsLnJ1Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
