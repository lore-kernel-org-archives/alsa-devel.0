From: Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Subject: Re: audio samples data flow from user mode to kernel
	mode
Date: Sat, 23 Jun 2018 16:55:19 +0530
Message-ID: <CAPY=qRR=3zSucBOzV1e2ojwtiGTjJjOZHbT+skK0z5HXzf6ZyA@mail.gmail.com>
References: <CAPY=qRRw0oyJTs0qKHbWdn2wj_iHUzqmBQFPRip08yLU1pdXQw@mail.gmail.com>
 <2927881529752293@web10g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F1A26760F
 for <alsa-devel@alsa-project.org>; Sat, 23 Jun 2018 13:25:21 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id x10-v6so1854918qto.1
 for <alsa-devel@alsa-project.org>; Sat, 23 Jun 2018 04:25:21 -0700 (PDT)
In-Reply-To: <2927881529752293@web10g.yandex.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o@goosey.org
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBKdW4gMjMsIDIwMTggYXQgNDo0MSBQTSwgPG9AZ29vc2V5Lm9yZz4gd3JvdGU6Cgo+
Cj4KPiAyMy4wNi4yMDE4LCAxNDo1MiwgIlN1Ymhhc2hpbmkgUmFvIEJlZXJpc2V0dHkiIDwKPiBz
dWJoYXNoYmVlcmlzZXR0eUBnbWFpbC5jb20+Ogo+ID4gSGVsbG8gQWxsLAo+Cj4gSGVsbG8sCj4K
Pgo+ID4gSeKAmW0gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgaG93IGF1ZGlvIHNhbXBsZXMgdHJhbnNm
ZXJyZWQgYmV0d2VlbiB1c2VyIG1vZGUKPiB0byBrZXJuZWwgbW9kZSBkdXJpbmcgcGxheWJhY2sg
YW5kIGNhcHR1cmUuIEnigJltIHVzaW5nIGFwbGF5ICYgYXJlY29yZCBhbHNhCj4gdXRpbGl0aWVz
IGZvciBwbGF5YmFjayBhbmQgY2FwdHVyZS4KPiA+Cj4gPiBMZXQgdXMgdGFrZSBhIFBDTSB3YXYg
ZmlsZSBvZiBzYW1wbGUgcmF0ZSA0ODAwMCBhbmQgaXQgaGFzIGEgdG90YWwKPiBudW1iZXIgb2Yg
c2FtcGxlcyA0ODAwMDAgKEFwcHJveC5EdXJhdGlvbiBpbiBzZWNvbmRzPTEwKS4gU2l6ZSBvZiBl
YWNoCj4gc2FtcGxlIGlzIDggYnl0ZXModHdvIGNoYW5uZWxzKS4gQWZ0ZXIgaW52b2NhdGlvbiBv
ZiBhcGxheSBmcm9tIHVzZXIgbW9kZSwKPiBob3cgZG9lcyB0aGVzZSBhdWRpbyBzYW1wbGVzIGdl
dHMgY29waWVkIHRvIGtlcm5lbCBtb2RlPyBDYW4gc29tZW9uZQo+IGV4cGxhaW4gbWUgb24gdGhp
cz8KPiA+Cj4gPiBJcyBpdCBwb3NzaWJsZSB0byBjYXB0dXJlIHRoZSB0aW1lc3RhbXBzIGZvciB0
aGUgZmlyc3QgYW5kIGxhc3QgYXVkaW8KPiBzYW1wbGVzIHRoYXQgYXJyaXZlIGF0IHRoZSBkcml2
ZXIgbGV2ZWw/Cj4gPgo+ID4gQ2FuIEkgY29uc2lkZXIgdGhlIC50cmlnZ2VyKGZvciBwbGF5YmFj
ayAmIGNhcHR1cmUpIGNhbGxiYWNrIGluCj4gU05EUlZfUENNX1RSSUdHRVJfU1RBUlQgIGNhc2Ug
aXMgdGltZXN0YW1wIGZvciB0aGUgZmlyc3QgYXVkaW8gc2FtcGxlPwo+ID4KPiA+IFNpbWlsYXJs
eSBkb2VzIC50cmlnZ2VyIGNhbGxiYWNrcyBTTkRSVl9QQ01fVFJJR0dFUl9TVE9QIGdpdmVzIHRo
ZSBsYXN0Cj4gYXVkaW8gc2FtcGxlIHRpbWVzdGFtcD8KPgo+IEkgdGhpbmsgbm8sIGJlY2F1c2Ug
dGhlIFNORFJWX1BDTV9UUklHR0VSX1NUQVJUIGFuZCBTTkRSVl9QQ01fVFJJR0dFUl9TVE9QCj4g
ZnVuY3Rpb25zIG9ubHkgc3lzdGVtIGNhbGwgdG8gdGhlIFBDTSB0cmFuc21pdHRlZC4KPiBTbywg
d2lsbCB3YW50IHR3byBkaWZmZXJlbnQgZnVuY3Rpb25zIGFzIHBsYXliYWNrIC8gY2FwdHVyZSBh
bmQgdGhlIG1ldGhvZAo+IGRlcGVuZHMgb24geW91IHVzZSBhbHNhIG9yIHB1bHNlLgo+Cj4gSSB0
aGluayB5b3Ugd2FudCB0bzoKPgo+IHNuZF9teWNoaXBfcGxheWJhY2tfb3Blbgo+IHNuZF9teWNo
aXBfcGxheWJhY2tfY2xvc2UKPgo+IHNuZF9teWNoaXBfY2FwdHVyZV9vcGVuCj4gc25kX215Y2hp
cF9jYXB0dXJlX2Nsb3NlCj4KQXJlIHRoZXNlIHBhcnQgb2YgInN0cnVjdCBzbmRfcGNtX29wcyIg
Lm9wZW4gJiAuY2xvc2U/ICBJZiBzbyB0aW1lc3RhbXBzCmNhcHR1cmVkIGF0IHRoZXNlIEFQSSdz
IGdpdmVzIHRoZSBmaXJzdCBhbmQgbGFzdCBhdWRpbyBzYW1wbGUgdGltZXN0YW1wcz8KClRyaWdn
ZXIgZnVuY3MgdGltZXMgYXJlIG5vdCByZWFsIHBsYXliYWNrIG9yIGNhcHR1cmUgdGltZS1zdGFt
cHMuCgpSZWdhcmRzCgpPemd1cgoKPiBUaGFua3MsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
