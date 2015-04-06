From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH/alsa-utils] amixer: fix 'cset' operation to
 set several channels
Date: Mon, 06 Apr 2015 16:42:02 +0900
Message-ID: <552238CA.8060601@sakamocchi.jp>
References: <1428287450-3665-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hr3rxwwyh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 847BE2607F7
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 09:42:05 +0200 (CEST)
In-Reply-To: <s5hr3rxwwyh.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gQXByIDA2IDIwMTUgMTY6MTMsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBBdCBNb24sICA2IEFw
ciAyMDE1IDExOjMwOjUwICswOTAwLAo+IFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4+Cj4+IEZv
ciBhbiBlbnVtZXJhdGVkIGVsZW1lbnQgd2l0aCBzZXZlcmFsIGNoYW5uZWxzLCB3aGVuIGdpdmVu
IGNvbW1hLXNlcGFyYXRlZAo+PiBzdHJpbmcgdmFsdWVzLCAnY3NldCcgb3BlcmF0aW9uIHNldHMg
dGhlc2UgdmFsdWVzIGp1c3QgdG8gdGhlIGZpcnN0IGNoYW5uZWwsCj4+IGluc3RlYWQgb2YgY29y
cmVzcG9uZGluZyBjaGFubmVscy4KPj4KPj4gVGhpcyBjb21taXQgYWRkcyBtaXNzaW5nLWluY3Jl
bWVudCB0byBmaXggdGhpcyBidWcuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFRha2FzaGkgU2FrYW1v
dG8gPG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPgo+Cj4gRGlkIHlvdSByZWFsbHkgdGVzdCB0aGlz
IHBhdGNoLi4uPwo+Cj4gYW1peGVyLmM6IEluIGZ1bmN0aW9uIOKAmHNzZXRfZW51beKAmToKPiBh
bWl4ZXIuYzoxMjk1OjU6IGVycm9yOiDigJhjaG7igJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGlu
IHRoaXMgZnVuY3Rpb24pCgpJIHdvcmtkIG9uIDZmOTgzNWYuIEFmdGVyIHRlc3RpbmcsIHJlYmFz
ZSB0byBjdXJyZW50IG1hc3Rlci4gVGhlbiBJIAptaXNzZWQgMWExOWVjMS4gSSBzaG91bGQgaGF2
ZSBjb21waWxlIGFnYWluIGluIHRoaXMgdHJlZS4gKG1pc3NpbmcgCmVub3VnaCBjYXV0aW9uLi4u
KQoKV2VsbCwgSSB0aGluayB0aGUgMWExOWVjMSBzdGlsbCBpbmNsdWRlcyBhIGJ1Zy4gSXQgY2Fu
bm90IHBhcnNlIHRoaXMgCm9wdGlvbiBjb3JyZWN0bHkuCgokIGFtaXhlciBzc2V0IGVudW0tZWxl
bWVudC0xMywxMDE5IEEsQiwsRAoKSW4gdGhpcyBjYXNlLCBubyB2YWx1ZXMgc2hvdWxkIGJlIHNl
dCB0byB0aGUgdGhpcmQgY2hhbm5lbCBvZiB0aGUgCmVsZW1lbnQuIEJ1dCBjdXJyZW50IGltcGxl
bWVudGF0aW9uIHNldCBEIHRvIHRoZSBjaGFubmVsIGFuZCB0aGUgbGFzdCAKY2hhbm5lbCBpcyBu
b3QgY2hhbmdlZC4KCkknbGwgcG9zdCBhIG5ldyBwYXRjaCwgbGF0ZXIuCgoKVGhhbmtzIGZvciB5
b3VyIGluZGljYXRpb24uCgpUYWthc2hpIFNha2Ftb3RvCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxt
YW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
