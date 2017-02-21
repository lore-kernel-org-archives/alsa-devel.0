From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/5] ALSA: usb-audio: purge needless
	variable length array
Date: Tue, 21 Feb 2017 11:23:12 +0900
Message-ID: <442742aa-038a-8f25-f1a6-bb76ce952b10@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
 <20170220200921.824-3-o-takashi@sakamocchi.jp> <s5hshn8pout.wl-tiwai@suse.de>
 <s5ho9xwpo9f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id B58172666F2
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 03:23:15 +0100 (CET)
In-Reply-To: <s5ho9xwpo9f.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: onkel@paraair.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMjAxN+W5tDAy5pyIMjHml6UgMDY6MDQsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBNb24s
IDIwIEZlYiAyMDE3IDIxOjUxOjU0ICswMTAwLAo+IFRha2FzaGkgSXdhaSB3cm90ZToKPj4KPj4g
T24gTW9uLCAyMCBGZWIgMjAxNyAyMTowOToxOCArMDEwMCwKPj4gVGFrYXNoaSBTYWthbW90byB3
cm90ZToKPj4+Cj4+PiBWYXJpYWJsZSBsZW5ndGggYXJyYXkgaXMgdXNlZCBpbiAnc25kX3VzMTZ4
MDhfbWV0ZXJfZ2V0KCknLCB3aGlsZSB0aGVyZQo+Pj4gaXMgbG9naWNhbGx5IG5vIG5lZWQuIEl0
J3MgYmV0dGVyIHRvIHB1cmdlIGl0IGJlY2F1c2UgdmFyaWFibGUgbGVuZ3RoIGFycmF5Cj4+PiBo
YXMgb3ZlcmhlYWQgZm9yIHN0YWNrIGhhbmRsaW5nLgo+Pj4KPj4+IFRoaXMgY29tbWl0IHJlcGxh
Y2VzIHRoZSBhcnJheSB3aXRoIHN0YXRpYyBsZW5ndGguIFNwYXJzZSBnZW5lcmF0ZWQgYmVsb3cK
Pj4+IHdhcm5pbmcuCj4+Pgo+Pj4gc291bmQvdXNiL21peGVyX3VzMTZ4MDguYzo3MTQ6MTg6IHdh
cm5pbmc6IFZhcmlhYmxlIGxlbmd0aCBhcnJheSBpcyB1c2VkLgo+Pj4KPj4+IEZpeGVzOiBkMmJi
MzkwYTIwODEgKCJBTFNBOiB1c2ItYXVkaW86IFRhc2NhbSBVUy0xNngwOCBEU1AgbWl4ZXIgcXVp
cmsiKQo+Pj4gU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBTYWthbW90byA8by10YWthc2hpQHNha2Ft
b2NjaGkuanA+Cj4+Cj4+IEFwcGxpZWQsIHRoYW5rcy4KPgo+IEVoLCBubywgdGhpcyBwYXRjaCBp
cyBidWdneS4gIFNjcmF0Y2hlZC4KPgo+PiBAQCAtNzQwLDcgKzc0MCw4IEBAIHN0YXRpYyBpbnQg
c25kX3VzMTZ4MDhfbWV0ZXJfZ2V0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAo+PiAg
CWNhc2UgMzoKPj4gIAkJbWVtY3B5KHRtcCwgbWl4X2luaXRfbXNnMiwgc2l6ZW9mKG1peF9pbml0
X21zZzIpKTsKPj4gIAkJdG1wWzJdID0gc25kX2dldF9tZXRlcl9jb21wX2luZGV4KHN0b3JlKTsK
Pj4gLQkJc25kX3VzMTZ4MDhfc2VuZF91cmIoY2hpcCwgdG1wLCAxMCk7Cj4+ICsJCXNuZF91czE2
eDA4X3NlbmRfdXJiKGNoaXAsIChjaGFyICopbWl4X2luaXRfbXNnMiwKPj4gKwkJCQkgICAgIHNp
emVvZihtaXhfaW5pdF9tc2cyKSk7Cj4KPiBIZXJlIHlvdSBvdmVybG9va2VkIHRoYXQgdG1wWzJd
IGlzIGR5bmFtaWNhbGx5IGNoYW5nZWQuCgpPb3BzLiBJJ3ZlIHJlYWxpemVkIGl0IGR1cmluZyBt
eSByZXZpZXdpbmcsIGJ1dCBmb3JnZXQgdG8gY2FyZSB3aGVuIApjb2RpbmcsIHNvcnJ5Li4uCgpQ
bGVhc2UgYWJhbmRvbiB0aGlzIHBhdGNoLiBJIHBvc3QgdGhlIGFsdGVybmF0aXZlIHRoaXMgbmln
aHQuCgoKVGhhbmtzCgpUYWthc2hpIFNha2Ftb3RvCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
