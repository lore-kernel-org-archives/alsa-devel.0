From: =?UTF-8?Q?=C3=89meric_MASCHINO?= <emeric.maschino@gmail.com>
Subject: Re: [PATCH v1] ALSA: fm801: Initialize chip after IRQ
	handler is registered
Date: Mon, 17 Jul 2017 21:27:47 +0200
Message-ID: <CAA9xbM6Kr669SeSyjubj=1-YzPzK1zMrfupGAi1+_qEXpEcXWQ@mail.gmail.com>
References: <20170716184003.54877-1-andriy.shevchenko@linux.intel.com>
 <s5hh8ycb4op.wl-tiwai@suse.de> <s5hbmokb4ip.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f171.google.com (mail-yb0-f171.google.com
 [209.85.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id D05B4266C1B
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 21:27:49 +0200 (CEST)
Received: by mail-yb0-f171.google.com with SMTP id z37so3866087ybh.1
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 12:27:49 -0700 (PDT)
In-Reply-To: <s5hbmokb4ip.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SnVzdCB0ZXN0ZWQtYnkuCgpJZiBpdCBkb2VzIG1hdHRlciBmb3IgZnV0dXJlIHJlZmVyZW5jZXMs
IHRlc3RlZCB3aXRoIGEgR2VuaXVzIFNvdW5kCk1ha2VyIExpdmUgNS4xIGV4YWN0bHkgbGlrZSB0
aGlzIG9uZSBbMV0gaW4gYW4gaHAgd29ya3N0YXRpb24geng2MDAwCihpYTY0IGFyY2hpdGVjdHVy
ZSkuCgpUaGFua3MsCgogICAgIMOJbWVyaWMKCgpbMV0gaHR0cDovL2l4YnRsYWJzLmNvbS9hcnRp
Y2xlcy9nZW5pdXNzb3VuZG1ha2VybGl2ZTUxL2luZGV4Lmh0bWwKCjIwMTctMDctMTYgMjA6NTAg
R01UKzAyOjAwIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT46Cj4gT24gU3VuLCAxNiBKdWwg
MjAxNyAyMDo0NjozMCArMDIwMCwKPiBUYWthc2hpIEl3YWkgd3JvdGU6Cj4+Cj4+IE9uIFN1biwg
MTYgSnVsIDIwMTcgMjA6NDA6MDMgKzAyMDAsCj4+IEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPj4g
Pgo+PiA+IFRoZSBjb21taXQgYjU2ZmE2ODdlMDJiICgiQUxTQTogZm04MDE6IGRldGVjdCBGTS1v
bmx5IGNhcmQgZWFybGllciIpCj4+ID4gcmVhcnJhbmdlZCBpbml0aWFsaXphdGlvbiBjYWxscywg
aS5lLiBpdCBtYWtlcyBzbmRfZm04MDFfY2hpcF9pbml0KCkgdG8KPj4gPiBiZSBjYWxsZWQgYmVm
b3JlIHdlIHJlZ2lzdGVyIGludGVycnVwdCBoYW5kbGVyIGFuZCBzZXQgUENJIGJ1cwo+PiA+IG1h
c3RlcmluZy4KPj4gPgo+PiA+IFNvbWVob3cgaXQgcHJldmVudHMgRk04MDEtQVUgdG8gd29yayBw
cm9wZXJseS4gVGh1cywgcGFydGlhbGx5IHJldmVydAo+PiA+IGluaXRpYWxpemF0aW9uIG9yZGVy
IGNoYW5nZWQgYnkgY29tbWl0IG1lbnRpb25lZCBhYm92ZS4KPj4gPgo+PiA+IEZpeGVzOiBiNTZm
YTY4N2UwMmIgKCJBTFNBOiBmbTgwMTogZGV0ZWN0IEZNLW9ubHkgY2FyZCBlYXJsaWVyIikKPj4g
PiBSZXBvcnRlZC1ieTogw4ltZXJpYyBNQVNDSElOTyA8ZW1lcmljLm1hc2NoaW5vQGdtYWlsLmNv
bT4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbT4KPj4KPj4gQXBwbGllZCBub3cgd2l0aCBDYyB0byBzdGFibGUuICBU
aGFua3MuCj4KPiBBaCwgSSBzZWUgeW91IHdhbnQgdG8gZ2V0IGNvbmZpcm1hdGlvbiBmcm9tIEVt
ZXJpYy4KPiBPSyBJIHRha2UgaXQgYmFjayBhbmQgd2FpdCBmb3IgdGhlIHRlc3RlZC1ieS4KPgo+
Cj4gVGFrYXNoaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
