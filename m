From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/5] ALSA: dice: ensure to release sound
 devices after sound card registration fails
Date: Tue, 29 Dec 2015 20:37:06 +0900
Message-ID: <56827062.4090805@sakamocchi.jp>
References: <1451100926-20637-1-git-send-email-o-takashi@sakamocchi.jp>
 <1451100926-20637-4-git-send-email-o-takashi@sakamocchi.jp>
 <s5hh9j1tysl.wl-tiwai@suse.de> <568266C4.1060809@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D2A926568C
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 12:37:09 +0100 (CET)
In-Reply-To: <568266C4.1060809@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

T24gMjAxNeW5tDEy5pyIMjnml6UgMTk6NTYsIFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4gT24g
MjAxNeW5tDEy5pyIMjnml6UgMTg6MDAsIFRha2FzaGkgSXdhaSB3cm90ZToKPj4gT24gU2F0LCAy
NiBEZWMgMjAxNSAwNDozNToyNCArMDEwMCwKPj4gVGFrYXNoaSBTYWthbW90byB3cm90ZToKPj4+
Cj4+PiBXaGVuIHdvcmsgb2Ygc291bmQgY2FyZCByZWdpc3RyYXRpb24gZmFpbHMsIGJ1cyByZXNl
dCBvbiBJRUVFIDEzOTQKPj4+IGNhbiBzY2hlZHVsZSB0aGUgd29yayBhZ2Fpbi4gSW4gdGhpcyBj
YXNlLCBjdXJyZW50bHkgaW5zdGFuY2VzIG9mIFBDTSBhbmQKPj4+IFJhd01JREkgZGV2aWNlcyBh
cmUgbm90IHJlbGVhc2VkLCBidXQgYWxsb2NhdGVkIGFuZCBlcnJvcnMgb2NjdXJzLgo+Pj4KPj4+
IFRoaXMgY29tbWl0IHNvbHZlcyB0aGlzIGlzc3VlLiBUaGUgYWxsb2NhdGVkIGRhdGEgaXMga2Vw
dCBhbmQgcmVsZWFzZWQKPj4+IGF0IGFueSBmYWlsdXJlcyBpbiB0aGUgd29yay4KPj4KPj4gQXJl
bid0IHRoZXkgYmUgcmVsZWFzZWQgaW4gc25kX2NhcmRfZnJlZSgpIGluIHRoZSBsYXRlciBlcnJv
ciBwYXRoPwo+IAo+IE5vdCBpbiB0aGUgZXJyb3IgcGF0aCwgYnV0IGluZGVlZCBpbiBjYXJkIGZy
ZWUgcHJvY2Vzc2luZy4gVGhleSdyZSBub3QKPiByZWxlYXNlZCBhbnltb3JlLiBJIHNob3VsZCBo
YXZlIHVzZWQgc25kX3BjbV9mcmVlKCkgYW5kCj4gc25kX3Jhd21pZGlfZnJlZSgpIGZvciB0aGlz
IHB1cnBvc2UuIChJIG1pc3VuZGVyc3RhbmQgdGhleSBzaG91bGQgYmUKPiB1c2VkIGFmdGVyIGNh
bGxpbmcgc25kX2NhcmRfcmVnaXN0ZXIoKS4pCgpJIHJlYWxpemVkIHRoYXQgYm90aCBvZiBzbmRf
cmF3bWlkaV9mcmVlKCkgYW5kIHNuZF9wY21fZnJlZSgpIGFyZSBjYWxsZWQKYnkgc25kX2Rldmlj
ZV9mcmVlKCksIHRoZW4gYWxsIG9mIGFsbG9jYXRlZCBtZW1vcnkgYmxvY2tzIGFyZSBmcmVlZC4K
CldoaWNoIGVycm9yIHBhdGhlcyBkbyB5b3UgdGhpbmsgdG8gY2F1c2UgdGhlIHByb2JsZW1zPwoK
ClJlZ2FyZHMKClRha2FzaGkgU2FrYW1vdG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbHNhLWRldmVsCg==
