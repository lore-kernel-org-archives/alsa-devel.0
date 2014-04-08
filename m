From: Kailang <kailang@realtek.com>
Subject: Re: move alc892 to patch_alc882
Date: Tue, 8 Apr 2014 17:08:54 +0800
Message-ID: <CD6BB756DB7E4CE5BE9458B1523DBC82@realtek.com.tw>
References: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw><CAN8ccibu5kUnZoSbYXXZitXABzPA7C2SXvTZYanJoDDbekVCgA@mail.gmail.com><s5hsipqdh4n.wl%tiwai@suse.de><5C8998C298284925B0366DDAC8B6717F@realtek.com.tw><s5hmwfxmt5o.wl%tiwai@suse.de><A1BA38FF1354405FAD7D43DEC4C1DEC8@realtek.com.tw>
 <CAN8cciZDRX5ocMsQY2HEps5kBHyYytzku5KMRi2qJE7Ok0L5Bg@mail.gmail.com>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AA2126579C
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 11:08:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Cj4yMDE0LTQtNyDkuIvljYg1OjIwIOaWvCAiS2FpbGFuZyIgPGthaWxhbmdAcmVhbHRlay5jb20+
IOWvq+mBk++8mgo+Cj4KPgo+PiBBdCBNb24sIDcgQXByIDIwMTQgMTQ6MDQ6MzQgKzA4MDAsCj4+
IEthaWxhbmcgd3JvdGU6Cj4+Pgo+Pj4KPj4+Cj4+PiA+IEF0IFNhdCwgNSBBcHIgMjAxNCAxNDo1
MjoyNCArMDgwMCwKPj4+ID4gUmF5bW9uZCBZYXUgd3JvdGU6Cj4+PiA+PiA+PiBIaSBUYWthc2hp
LAo+Pj4gPj4gPj4gPgo+Pj4gPj4gPiBUaGUgb3JpZ2luYWwgd2FzIHBhdGNoIHRvIHBhdGNoX2Fs
YzY2Mi4KPj4+ID4+ID4gTW92ZSBpdCBpbnRvIHBhdGNoX2FsYzg4Mi4KPj4+ID4+ID4KPj4+ID4+
ID4KPj4+ID4+IGlzIHRoZXJlIGFueSByZWFzb24gbm90IGluY2x1ZGluZyB0aG9zZSBQQ0kgUVVJ
UksgZm9yIGFsYzg5MiA/Cj4+PiA+ID4gQmVjYXVzZSBpdCdzIG5vdCBjbGFyaWZpZWQgd2h5IHRo
aXMgbXVzdCBiZSBhcHBsaWVkLgo+Pj4gPiBJJ20gd2FpdGluZyBmb3IgdGhlIHVwZGF0ZWQgcGF0
Y2ggZnJvbSBLYWlsYW5nLgo+Pj4gPgo+Pj4gU29ycnkhCj4+PiBJIGp1c3QgYWxpZ25lZCB0aGUg
Y2hhbm5lbCBjb3VudC4KPj4+IFNvLCBtb3ZlIHRoZSBhbGM4OTIgdG8gcGF0Y2hfYWxjODgyLgo+
Pgo+Pgo+PiBBcyBJIGFscmVhZHkgYXNrZWQsIGNvdWxkIHlvdSByZXN1Ym1pdCB0aGUgcGF0Y2gg
d2l0aCB0aGUgcHJvcGVyCj4+IGNoYW5nZWxvZz8gIFlvdSBoYXZlIHRvIGNsYXJpZnkgd2h5IHRo
ZSBwYXRjaCBpcyBuZWVkZWQgYW5kIGhvdyBpdCdzCj4+IHNvbHZlZCBpbiB0aGUgcGF0Y2ggY2hh
bmdlbG9nLgo+Pgo+Cj4gWWVzLCBidXQgaXQgbWF5YmUgZG9lc24ndCBzb2x2ZSBhbnkgdGhpbmcu
Cj4gQnV0IEkgcmVtZW1iZXIgSSBzb2x2ZSA4Y2ggaXNzdWUgd2hpY2ggcnVuIGZvciBwYXRjaF9h
bGM4ODIuCj4gSSB3aWxsIGNoZWNrIGFsYzg5MiBmb3IgcnVuIHdpdGggcGF0Y2hfYWxjODgyLgo+
IFRoYW5rcy4KPgoKPmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0
L3Rpd2FpL3NvdW5kLmdpdC9jb21taXQvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmM/aWQ9
ZTE2ZmI2ZDE0MDhiY2EwYzBiMzZkNDkwNjg4ZWJhM2RjOTI0YjFmZAoKPisgeyAweDEwZWMwODky
LCAweGZmZmYsIDB4ODAyMCwgIkFMQzY2MSIgfSwKPisgeyAweDEwZWMwODkyLCAweGZmZmYsIDB4
ODAxMSwgIkFMQzY2MSIgfSwKPisgeyAweDEwZWMwODkyLCAweGZmZmYsIDB4NDAxMSwgIkFMQzY1
NiIgfSwKPlNlZW0gc29tZSBjb2RlYyB3ZXJlIHJlbmFtZWQgYXMgYWxjNjYxIGFuZCBhbGM2NTYK
ClllcywgaXQncyB0aGUgc2FtZSBib2R5LiBJQyBtYXJrIHNob3dzIGRpZmZlcmVudC4KCgotLS0t
LS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUt
bWFpbC4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
