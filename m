From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] ALSA: hda - add mic fixup for ALC269VB on
 Ordissimo EVE2
Date: Wed, 5 Jun 2013 17:36:43 +0200
Message-ID: <20130605173643.01dc1a3a@serenity>
References: <20120717151109.66d239a5@destiny.ordissimo>
 <1370253190-25072-1-git-send-email-anisse@astier.eu>
 <s5hehcgvong.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f41.google.com (mail-ee0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 428F22654AC
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 17:37:19 +0200 (CEST)
Received: by mail-ee0-f41.google.com with SMTP id d4so526311eek.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Jun 2013 08:37:18 -0700 (PDT)
In-Reply-To: <s5hehcgvong.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwNSBKdW4gMjAxMyAxMjoyNjo1OSArMDIwMCwgVGFrYXNoaSBJd2FpIDx0aXdhaUBz
dXNlLmRlPiB3cm90ZSA6Cgo+ID4gSSdtIG9uIGEgZGVhZCBlbmQgb24gdGhpcyBjb21wdXRlciwg
SSBjYW4ndCBzZWVtIHRvIGZpbmQgaG93IHRoZSBtaWMgamFjawo+ID4gcHJlc2VuY2Ugd29ya3Mu
IEl0J3MgYWx3YXlzIG9uKHByZXNlbmNlIGRldGVjdGVkIHdoYXRldmVyIHRoZSBzdGF0dXMpIG9u
IE5JRAo+ID4gMHgxOCwgdGhlIG9uZSB1c2VkIGZvciB0aGUgZXh0ZXJuYWwgbWljLiBJIGhhdmUg
dHJpZWQgZXZlcnkgTklELCBtYW51YWxseQo+ID4gZW5hYmxpbmcgcGluX3NlbnNlIG9uIGVhY2gs
IGJ1dCBvbmx5IHRoZSBoZWFkcGhvbmUgamFjayBkZXRlY3Rpb24gd29ya3MuIFRoZQo+ID4gbWlj
IHNlbnNlIGlzIG5vd2hlcmUgdG8gYmUgc2Vlbi4gIAo+IAo+IEkgYWxzbyBkb24ndCBrbm93IGFu
eSBvdGhlciBtZXRob2QgZm9yIFJlYWx0ZWsuICBGb3IgSURUIGNvZGVjcywgdGhlcmUKPiBhcmUg
c29tZSBkZXZpY2VzIHdpdGggR1BJTyB1bnNvbCBldmVudHMsIGJ1dCBSZWFsdGVrIGNvZGVjcyBz
ZWVtIHRvCj4gdXNlIG9ubHkgdGhlIG5vcm1hbCBwaW4gZGV0ZWN0aW9uIHVuc29sIGV2ZW50cy4K
PiAKPiBTbywgb24geW91ciBkZXZpY2UsIEdFVF9QSU5fU0VOU0UgZG9lc24ndCByZXR1cm4gdGhl
IGRldGVjdGlvbiBiaXQKPiBzZXQ/ICBZb3UgdHJpZWQgc2V0dGluZyBTRVRfUElOX1NFTlNFIGJl
Zm9yZSBHRVRfUElOX1NFTlNFLCByaWdodD8KPiAKCkkgZGlkIG1vcmUgdGVzdHMsIHRoaXMgdGlt
ZSB1c2luZyBoZGEtdmVyYiBkaXJlY3RseSBpbnN0ZWFkIG9mCmhkYS1hbmFseXplciB0b29scy4g
QW5kIEdFVF9QSU5fU0VOU0UgZG9lcyByZXR1cm4gdGhlIGNvcnJlY3QgdmFsdWXigKYKc29tZXRp
bWVzLiAod2l0aG91dCB0aGUgbmVlZCBmb3IgU0VUX1BJTl9TRU5TRSkKSXQgc2VlbXMgdGhlIHZh
bHVlIGlzIGNvcnJlY3Qgb25seSBpZiBxdWVyaWVkIG9uY2UgZXZlcnkgMTAgdG8gMTUKc2Vjb25k
cy4gQ2hhbmdpbmcgdGhlIGphY2twb2xsX21zIGFyZ3VtZW50IGRvZXMgbm90IHNlZW0gdG8gaGVs
cCwgc28gSSdsbAprZWVwIGRpZ2dpbmcgaW50byBpdC4KCkFuaXNzZQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
