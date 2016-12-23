From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][alsa-lib] topology: fix
	unused-const-variable warning
Date: Sat, 24 Dec 2016 00:08:44 +0900
Message-ID: <fd274637-f92f-b4aa-0f48-13e844ce9721@sakamocchi.jp>
References: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
 <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
 <1482482964.24233.51.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A09C9B@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D5CB7267131
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 16:08:52 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F881A09C9B@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "mengdong.lin" <mengdong.lin@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDEy5pyIMjPml6UgMjM6NDgsIExpbiwgTWVuZ2Rvbmcgd3JvdGU6Cj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IGFsc2EtZGV2ZWwtYm91bmNlc0BhbHNhLXBy
b2plY3Qub3JnIFttYWlsdG86YWxzYS1kZXZlbC0KPj4gYm91bmNlc0BhbHNhLXByb2plY3Qub3Jn
XSBPbiBCZWhhbGYgT2YgTGlhbSBHaXJkd29vZAo+PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDIz
LCAyMDE2IDQ6NDkgUE0KPj4KPj4gVGhpcyBsb29rcyBmaW5lIGJ5IG1lLCBNZW5nZG9uZyBpcyB0
aGlzIHN0aWxsIHVudXNlZCBvciBpcyBpdCBuZWVkZWQgYnkgYQo+PiBmdXR1cmUgcGF0Y2ggPwo+
Cj4gSGkgTGlhbSwKPgo+IFRoaXMgIndpZGdldF9jb250cm9sX21hcCIgaXMgc3RpbGwgdW51c2Vk
IG5vdy4KPgo+IENvdWxkIHlvdSByZW1lbWJlciB3aHkgd2UgZGVmaW5lIHRoaXMgbWFwIGluIHRo
ZSBlYXJseSBwaGFzZT8KPiBJIGd1ZXNzIHByZXZpb3VzbHkgd2Ugd2FudCB0byBkaXN0aW5ndWlz
aCBzdGFuZC1hbG9uZSBjb250cm9scyBmcm9tIGNvbnRyb2xzIGVtYmVkZGVkIGluIHdpZGdldHMu
IEJ1dCBub3cgd2UgcHJvY2VzcyB0aGVtIGluIHRoZSBzYW1lIHdheSwgYm90aCBpbiB1c2VyIHNw
YWNlIGFuZCBrZXJuZWwuCj4KPiBTbyBJIGZlZWwgd2UgY2FuIHJlbW92ZSB0aGlzIHN0cnVjdHVy
ZS4KCkFkZGl0aW9uYWxseSwgd291bGQgeW91IGNoZWNrIHRoaXMgcG9zdCB0byBmaXggc29tZSB3
YXJuaW5ncyB3aGljaCB5b3UgCmFkZGVkIGludG8gYWxzYS1saWIsIHBsZWFzZS4KW2Fsc2EtZGV2
ZWxdIFtQQVRDSF1bYWxzYS1saWJdIHRvcG9sb2d5OiBmaXggc2lnbi1jb21wYXJlIHdhcm5pbmcg
CmludHJvZHVjZWQgdG8gc2V0X2xpbmtfaHdfY29uZmlnKCkgYW5kIHRwbGdfYWRkX2xpbmtfb2Jq
ZWN0KCkKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZl
bC8yMDE2LURlY2VtYmVyLzExNTg5Ni5odG1sCgoKVGhhbmtzCgpUYWthc2hpIFNha2Ftb3RvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
