From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH][alsa-lib] topology: fix
	unused-const-variable warning
Date: Fri, 23 Dec 2016 15:23:46 +0000
Message-ID: <1482506626.24233.71.camel@loki>
References: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
 <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
 <1482482964.24233.51.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A09C9B@shsmsx102.ccr.corp.intel.com>
 <fd274637-f92f-b4aa-0f48-13e844ce9721@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 20BD7267131
 for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2016 16:24:11 +0100 (CET)
In-Reply-To: <fd274637-f92f-b4aa-0f48-13e844ce9721@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCAyMDE2LTEyLTI0IGF0IDAwOjA4ICswOTAwLCBUYWthc2hpIFNha2Ftb3RvIHdyb3Rl
Ogo+IE9uIDIwMTblubQxMuaciDIz5pelIDIzOjQ4LCBMaW4sIE1lbmdkb25nIHdyb3RlOgo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPj4gRnJvbTogYWxzYS1kZXZlbC1ib3VuY2Vz
QGFsc2EtcHJvamVjdC5vcmcgW21haWx0bzphbHNhLWRldmVsLQo+ID4+IGJvdW5jZXNAYWxzYS1w
cm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIExpYW0gR2lyZHdvb2QKPiA+PiBTZW50OiBGcmlkYXks
IERlY2VtYmVyIDIzLCAyMDE2IDQ6NDkgUE0KPiA+Pgo+ID4+IFRoaXMgbG9va3MgZmluZSBieSBt
ZSwgTWVuZ2RvbmcgaXMgdGhpcyBzdGlsbCB1bnVzZWQgb3IgaXMgaXQgbmVlZGVkIGJ5IGEKPiA+
PiBmdXR1cmUgcGF0Y2ggPwo+ID4KPiA+IEhpIExpYW0sCj4gPgo+ID4gVGhpcyAid2lkZ2V0X2Nv
bnRyb2xfbWFwIiBpcyBzdGlsbCB1bnVzZWQgbm93Lgo+ID4KPiA+IENvdWxkIHlvdSByZW1lbWJl
ciB3aHkgd2UgZGVmaW5lIHRoaXMgbWFwIGluIHRoZSBlYXJseSBwaGFzZT8KPiA+IEkgZ3Vlc3Mg
cHJldmlvdXNseSB3ZSB3YW50IHRvIGRpc3Rpbmd1aXNoIHN0YW5kLWFsb25lIGNvbnRyb2xzIGZy
b20gY29udHJvbHMgZW1iZWRkZWQgaW4gd2lkZ2V0cy4gQnV0IG5vdyB3ZSBwcm9jZXNzIHRoZW0g
aW4gdGhlIHNhbWUgd2F5LCBib3RoIGluIHVzZXIgc3BhY2UgYW5kIGtlcm5lbC4KPiA+Cj4gPiBT
byBJIGZlZWwgd2UgY2FuIHJlbW92ZSB0aGlzIHN0cnVjdHVyZS4KPiAKPiBBZGRpdGlvbmFsbHks
IHdvdWxkIHlvdSBjaGVjayB0aGlzIHBvc3QgdG8gZml4IHNvbWUgd2FybmluZ3Mgd2hpY2ggeW91
IAo+IGFkZGVkIGludG8gYWxzYS1saWIsIHBsZWFzZS4KPiBbYWxzYS1kZXZlbF0gW1BBVENIXVth
bHNhLWxpYl0gdG9wb2xvZ3k6IGZpeCBzaWduLWNvbXBhcmUgd2FybmluZyAKPiBpbnRyb2R1Y2Vk
IHRvIHNldF9saW5rX2h3X2NvbmZpZygpIGFuZCB0cGxnX2FkZF9saW5rX29iamVjdCgpCj4gaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZlbC8yMDE2LURl
Y2VtYmVyLzExNTg5Ni5odG1sCj4gCj4gCgpCb3RoIGxvb2sgZ29vZCB0byBtZS4gQXBvbG9naWVz
IHRoYXQgSSBtaXNzZWQgdGhlbS4KCllvdSBtYXkgd2FudCB0byByZXNlbmQgdGhlbSBib3RoIHdp
dGggbXkgQWNrIChtYXliZSB3YWl0IGZvciB1bnRpbCBhZnRlcgpDaHJpc3RtYXMgdGhvdWdoKS4K
ClRoYW5rcwoKTGlhbQoKPiBUaGFua3MKPiAKPiBUYWthc2hpIFNha2Ftb3RvCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
