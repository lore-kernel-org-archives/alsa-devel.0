From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH][alsa-lib] topology: fix
	unused-const-variable warning
Date: Sat, 24 Dec 2016 00:34:29 +0900
Message-ID: <6e6431cf-b498-f79b-f4dc-ab3aa78f6e1f@sakamocchi.jp>
References: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
 <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
 <1482482964.24233.51.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A09C9B@shsmsx102.ccr.corp.intel.com>
 <fd274637-f92f-b4aa-0f48-13e844ce9721@sakamocchi.jp>
 <1482506626.24233.71.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 825E1267131
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 16:34:36 +0100 (CET)
In-Reply-To: <1482506626.24233.71.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDEy5pyIMjTml6UgMDA6MjMsIExpYW0gR2lyZHdvb2Qgd3JvdGU6Cj4gT24gU2F0
LCAyMDE2LTEyLTI0IGF0IDAwOjA4ICswOTAwLCBUYWthc2hpIFNha2Ftb3RvIHdyb3RlOgo+PiBP
biAyMDE25bm0MTLmnIgyM+aXpSAyMzo0OCwgTGluLCBNZW5nZG9uZyB3cm90ZToKPj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4+IEZyb206IGFsc2EtZGV2ZWwtYm91bmNlc0BhbHNh
LXByb2plY3Qub3JnIFttYWlsdG86YWxzYS1kZXZlbC0KPj4+PiBib3VuY2VzQGFsc2EtcHJvamVj
dC5vcmddIE9uIEJlaGFsZiBPZiBMaWFtIEdpcmR3b29kCj4+Pj4gU2VudDogRnJpZGF5LCBEZWNl
bWJlciAyMywgMjAxNiA0OjQ5IFBNCj4+Pj4KPj4+PiBUaGlzIGxvb2tzIGZpbmUgYnkgbWUsIE1l
bmdkb25nIGlzIHRoaXMgc3RpbGwgdW51c2VkIG9yIGlzIGl0IG5lZWRlZCBieSBhCj4+Pj4gZnV0
dXJlIHBhdGNoID8KPj4+Cj4+PiBIaSBMaWFtLAo+Pj4KPj4+IFRoaXMgIndpZGdldF9jb250cm9s
X21hcCIgaXMgc3RpbGwgdW51c2VkIG5vdy4KPj4+Cj4+PiBDb3VsZCB5b3UgcmVtZW1iZXIgd2h5
IHdlIGRlZmluZSB0aGlzIG1hcCBpbiB0aGUgZWFybHkgcGhhc2U/Cj4+PiBJIGd1ZXNzIHByZXZp
b3VzbHkgd2Ugd2FudCB0byBkaXN0aW5ndWlzaCBzdGFuZC1hbG9uZSBjb250cm9scyBmcm9tIGNv
bnRyb2xzIGVtYmVkZGVkIGluIHdpZGdldHMuIEJ1dCBub3cgd2UgcHJvY2VzcyB0aGVtIGluIHRo
ZSBzYW1lIHdheSwgYm90aCBpbiB1c2VyIHNwYWNlIGFuZCBrZXJuZWwuCj4+Pgo+Pj4gU28gSSBm
ZWVsIHdlIGNhbiByZW1vdmUgdGhpcyBzdHJ1Y3R1cmUuCj4+Cj4+IEFkZGl0aW9uYWxseSwgd291
bGQgeW91IGNoZWNrIHRoaXMgcG9zdCB0byBmaXggc29tZSB3YXJuaW5ncyB3aGljaCB5b3UKPj4g
YWRkZWQgaW50byBhbHNhLWxpYiwgcGxlYXNlLgo+PiBbYWxzYS1kZXZlbF0gW1BBVENIXVthbHNh
LWxpYl0gdG9wb2xvZ3k6IGZpeCBzaWduLWNvbXBhcmUgd2FybmluZwo+PiBpbnRyb2R1Y2VkIHRv
IHNldF9saW5rX2h3X2NvbmZpZygpIGFuZCB0cGxnX2FkZF9saW5rX29iamVjdCgpCj4+IGh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwvMjAxNi1EZWNl
bWJlci8xMTU4OTYuaHRtbAo+Pgo+Pgo+Cj4gQm90aCBsb29rIGdvb2QgdG8gbWUuIEFwb2xvZ2ll
cyB0aGF0IEkgbWlzc2VkIHRoZW0uCj4KPiBZb3UgbWF5IHdhbnQgdG8gcmVzZW5kIHRoZW0gYm90
aCB3aXRoIG15IEFjayAobWF5YmUgd2FpdCBmb3IgdW50aWwgYWZ0ZXIKPiBDaHJpc3RtYXMgdGhv
dWdoKS4KCk5vIG5lZWQuIEl3YWktc2FuIGFscmVhZHkgcmV2aWV3ZWQgdGhlbS4gTmV4dCB5ZWFy
LCBJJ2xsIHJlcXVlc3QgaGltIHRvIAphcHBseSB0aGVtLgpodHRwOi8vbWFpbG1hbi5hbHNhLXBy
b2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIwMTYtRGVjZW1iZXIvMTE1NzI1Lmh0bWwK
CkkgcmVxdWVzdCBNZW5nZG9uZy1MaW4gdG8gY2FyZSBvZiBjb21waWxlciB3YXJuaW5ncyBhZ2Fp
bi4gSGVyIHBhdGNoZXMgCmZyZXF1ZW50bHkgYnJpbmcgdGhpcyBraW5kIG9mIG1pc3Rha2VzLCBh
bmQgSSBoYXZlIG5vIG1vdGl2YXRpb25zIHRvIGZpeCAKdGhlbSBhbnltb3JlLgoKClRoYW5rcwoK
VGFrYXNoaSBTYWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
