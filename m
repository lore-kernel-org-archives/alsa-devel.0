From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: 1.0.15rc3 patch_analog.s bug + fix
Date: Tue, 16 Oct 2007 21:30:50 +0300
Message-ID: <200710162130.51168.anarsoul@gmail.com>
References: <20071015025303.GA17664@jay.phy.queensu.ca>
	<200710161039.55191.anarsoul@gmail.com>
	<s5hmyuj47zf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 808A9246C3
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 20:30:28 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2284080mue
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 11:30:27 -0700 (PDT)
In-Reply-To: <s5hmyuj47zf.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

PiBBdCBUdWUsIDE2IE9jdCAyMDA3IDEwOjM5OjU1ICswMzAwLAo+Cj4gVmFzaWx5IEtob3J1emhp
Y2sgd3JvdGU6Cj4gPiBbMSAgPHRleHQvcGxhaW47IGlzby04ODU5LTEgKHF1b3RlZC1wcmludGFi
bGUpPl0KPiA+Cj4gPiBPbiBNb25kYXkgMTUgT2N0b2JlciAyMDA3IDIzOjM0OjIxIFBldGVyIFNr
ZW5zdmVkIHdyb3RlOgo+ID4gPiA+IEhtbSwgdGhlIGNvZGUgbG9naWMgbG9va3MgY29ycmVjdCB0
byBtZS4gwqBJZiBIUCBqYWNrIGlzIHByZXNlbnQsIHRoZQo+ID4gPiA+IGludGVybmFsIHNwZWFr
ZXIgc2hvdWxkIGJlIG11dGVkLiDCoE90aGVyd2lzZSBpdCBmb2xsb3dzIHRoZSBzdGF0ZSBvZgo+
ID4gPiA+IEhQIGphY2sgKG11dGVkL3VubXV0ZWQsIHRoYXQgYWN0cyBhcyBhIG1hc3RlciBzd2l0
Y2gpCj4gPgo+ID4gQ29kZSBsb2dpYyBpcyBicm9rZW4uCj4gPiBJbnRlcm5hbCBzcGVha2VycyBt
dXRlZCB3aGlsZSBqYWNrIHVucGx1Z2dlZCBhbmQgdW5tdXRlZCB3aGlsZSBpdCdzCj4gPiBwbHVn
Z2VkLgo+Cj4gTm8sIGl0J3MgdGhlIHdyb25nIGxvZ2ljLiAgVGhlIGludGVybmFsIHNwZWFrZXIg
c2hvdWxkIGJlIHVubXV0ZWQgd2hlbgo+IEhQIGlzIHVucGx1Z2dlZCwgYW5kIG11dGVkIHdoZW4g
cGx1Z2dlZC4gIFlvdSBkb24ndCB3YW50IHRvIGhlYXIgZnJvbQo+IGJvdGggYXQgdGhlIHNhbWUg
dGltZS4KPgoKU29ycnksIGkndmUgbWFkZSBtaXN0YWtlLCBvZiBjb3Vyc2UgaW50ZXJuYWwgc3Bl
YWtlcnMgc2hvdWxkIGJlIG11dGVkIHdoZW4gCmphY2sgcGx1Z2dlZC4gUGF0Y2ggdGhhdCBJJ3Zl
IGF0dGFjaGVkIHRvIHByZXZpb3VzIG1lc3NhZ2UgaGFzIGV4YWN0bHkgdGhhdCAKbG9naWMuCgo+
IFRoaXMgaW1wbGllcyByYXRoZXIgdGhhdCB0aGUgamFjayBkZXRlY3Rpb24gaXRzZWxmIGlzIHJl
dmVyc2VkIGZyb20KPiB0aGUgc3RhbmRhcmQuIMKgQ291bGQgeW91IHRyeSB0aGUgcGF0Y2ggYmVs
b3c/CgpZb3VyIHBhdGNoIHdvcmtzLgoKQnV0IGl0IHNlZW1zIHRoYXQgdGhlcmUncyBhbm90aGVy
IGJ1ZyAtIGkgaGF2ZSBsb3VkIGNsaWNrIHdoZW4gaSB0byBwbGF5IApzb21ldGhpbmcgb3IgY2hh
bmdlIG1peGVyIHNldHRpbmdzIGFmdGVyIG5vdCB1c2luZyBhdWRpbyBmb3IgfjFtaW4KClRoYW5r
cy4KClJlZ2FyZHMKVmFzaWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
