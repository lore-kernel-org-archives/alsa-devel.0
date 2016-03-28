From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: dice: fix a fatal bug when no
 sound card is registered
Date: Mon, 28 Mar 2016 16:44:45 +0900
Message-ID: <56F8E0ED.7090709@sakamocchi.jp>
References: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
 <56F8696B.8000704@sakamocchi.jp> <s5hzitj6olw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E0E3260511
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 09:44:50 +0200 (CEST)
In-Reply-To: <s5hzitj6olw.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiAyMDE25bm0MDPmnIgyOOaXpSAxNjozNiwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9u
IE1vbiwgMjggTWFyIDIwMTYgMDE6MTQ6NTEgKzAyMDAsCj4gVGFrYXNoaSBTYWthbW90byB3cm90
ZToKPj4KPj4gSGksCj4+Cj4+IE9uIE1hciAyNiAyMDE2IDIxOjA1LCBUYWthc2hpIFNha2Ftb3Rv
IHdyb3RlOgo+Pj4gSGksCj4+Pgo+Pj4gVGhpcyBwYXRjaHNldCBpcyBmb3IgTGludXggNC42LXJj
Mi4KPj4+Cj4+PiBBTFNBIGRpY2UgZHJpdmVyIGNhdXNlcyBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGluIGEgY2FzZSB0aGF0Cj4+PiBubyBzb3VuZCBjYXJkIGluc3RhbmNlIGlzIHJl
Z2lzdGVyZWQgYW5kIHVuaXQgaXMgZ29pbmcgdG8gYmUgcmVtb3ZlZC4KPj4+IFRoaXMgaXMgb2Jz
ZXJ2ZWQgd2hlbiBkaWNlLWJhc2VkIHVuaXRzIGFyZSBjb25uZWN0ZWQgdG8gTGludXggc3lzdGVt
IGFuZAo+Pj4gZGlzY29ubmVjdGVkIHdpdGhpbiAyIHNlY29uZHMsIHRodXMgaXQncyByYXJlLgo+
Pj4KPj4+IEFkZGl0aW9uYWxseSwgZXZlbiBpZiB0aGUgYnVnIGlzIGZpeGVkLCB0aGUgZHJpdmVy
IGR1bXBzIHdhcm5pbmdzIGZvcgo+Pj4gbW9zdCBkaWNlLWJhc2VkIG1vZGVscyB3aGljaCBzdXBw
b3J0cyBhIHBhaXIgb2YgaXNvY2hyb25vdXMgc3RyZWFtcy4KPj4+IFRoaXMgY2FuIG9jY3VyIHJl
Z2FyZGxlc3Mgb2YgdGhlIGZvcm1lciBidWcuIFVzZXJzIGNhbiBzZWUgdGhpcyBmb3IKPj4+IHVu
c3VwcG9ydGVkIGRpY2UtYmFzZWQgbW9kZWxzLgo+Pj4KPj4+IFRoaXMgcGF0Y2hzZXQgZml4ZXMg
dGhlc2UgYnVncy4KPj4KPj4gSSByZWFsaXplZCB0aGF0IHRoaXMgcGF0Y2hzZXQgaXMgbm90IHBy
b3BlciB0byBMaW51eCA0LjYtcmMyLiBUaGUgc3RyZWFtCj4+IGRhdGEgaXMgY29uZmlybWVkIHRv
IGluaXRpYWxpemVkIGluIHVuaXQgcHJvYmUgY2FsbGJhY2ssIGFuZCBzYWZlbHkKPj4gcmVsZWFz
ZWQgd2hlbiByZWxlYXNpbmcgcHJpdmF0ZSBkYXRhLiBJIHdvcmtlZCBvbiB0aGUgb3RoZXIgYnJh
bmNoIGFuZAo+PiBoYWQgYSBjb25mdXNpb24uIFNvIHBsZWFzZSBkcm9wIHRoaXMuCj4+Cj4+IEhv
d2V2ZXIsIGN1cnJlbnQgQUxTQSBkaWNlIGRyaXZlciBoYXMgYSBidWcgbm90IHRvIHJlbGVhc2Ug
c3RyZWFtIGRhdGEKPj4gd2hlbiByZWxlYXNpbmcgcHJpdmF0ZSBkYXRhLiBUaGlzIGNhdXNlcyBt
ZW1vcnkgbGVhayBhbmQgc2hvdWxkIGJlIGZpeGVkCj4+IGluIDQuNi1yYzIuIEknbGwgcG9zdCBh
IHBhdGNoIGZvciB0aGUgYnVnIHNvb24uCj4KPiBTbywgSSBkb24ndCBuZWVkIHRvIHBpY2sgdXAg
dGhpcyBwYXRjaHNldCBhZnRlciBhcHBseWluZyB5b3VyIGZpeAo+IChbUEFUQ0ggdjJdIEFMU0E6
IGRpY2U6IGZpeCBtZW1vcnkgbGVhayB3aGVuIHVucGx1Z2dpbmcpPwoKRXhhY3RseS4gU29ycnkg
dG8gdHJvdWJsZSB5b3UuCgo+IHRoYW5rcywKPgo+IFRha2FzaGkKCgpSZWdhcmRzCgpUYWthc2hp
IFNha2Ftb3RvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
