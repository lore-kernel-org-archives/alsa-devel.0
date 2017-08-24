From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Thu, 24 Aug 2017 20:12:12 +0300
Message-ID: <1503594732.25945.90.camel@linux.intel.com>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 72CF3266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 19:13:25 +0200 (CEST)
In-Reply-To: <s5hziaphrof.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCAyMDE3LTA4LTI0IGF0IDE4OjExICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4g
T24gVGh1LCAyNCBBdWcgMjAxNyAxNzo0OTo0NyArMDIwMCwKPiBNYXJrIEJyb3duIHdyb3RlOgo+
ID4gCj4gPiBPbiBUaHUsIEF1ZyAyNCwgMjAxNyBhdCAwNDozMzoyOVBNICswMjAwLCBUYWthc2hp
IEl3YWkgd3JvdGU6Cj4gPiA+IE1hcmsgQnJvd24gd3JvdGU6Cj4gPiA+ID4gT24gVGh1LCBBdWcg
MjQsIDIwMTcgYXQgMDQ6NDE6MTBQTSArMDMwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOgo+ID4g
PiA+IAo+ID4gPiA+ID4gVGhlcmUgaXMgbm8gcGxhdGZvcm0gY29kZSB0aGF0IHVzZXMgaTJjIG1v
ZHVsZSB0YWJsZS4KPiA+ID4gPiA+IFJlbW92ZSBpdCBhbHRvZ2V0aGVyIGFuZCBhZGp1c3QgLT5w
cm9iZSgpIHRvIGJlIC0+cHJvYmVfbmV3KCkuCj4gPiA+ID4gV2hhdCBpcyB0aGUgdmFsdWUgaW4g
ZG9pbmcgdGhpcz/CoMKgUmVtb3ZpbmcgdGhlIGFiaWxpdHkgdG8KPiA+ID4gPiBpbnN0YW50aWF0
ZQo+ID4gPiA+IHZpYSBib2FyZCBmaWxlcyBpcyBqdXN0IGluY29udmVuaWVuY2luZyBwZW9wbGUg
ZG9pbmcgdGhhdCwgaXQncwo+ID4gPiA+IG5vdCBhCj4gPiA+ID4gZ29hbCBpbiBpdHNlbGYuCj4g
PiA+IEJ1dCB0aGUgaWQgdGFibGUgaXMgYWxyZWFkeSBlbXB0eS4uLj8KPiA+IAo+ID4gUmlnaHQs
IHRoYXQgc2VlbXMgbGlrZSBhIGJ1ZyB0aG91Z2guCj4gCj4gV2VsbCwgdGhhdCdzIHdoYXQgdGhl
IGNvbW1pdCBkZGM5ZTY5YjlkYzIgZG9lcyBhZnRlciBhbGw6IGl0IGNsZWFucyB1cAo+IHRoZSBs
ZWdhY3kgdXNhZ2UsIGFuZCBtb3ZlcyBhbGwgZWl0aGVyIE9GIG9yIEFDUEkgbWF0Y2hpbmcuCj4g
Cj4gSWYgd2Ugd2FudCB0byB0YWtlIGJhY2sgb2xkIGkyYyBpZHMsIGJldHRlciB0byBwdXQgdGhl
IGV4cGxpY2l0Cj4gaTJjX21hdGNoX2lkKCkgY2hlY2sgaW4gcnQ1Njc3X2kyY19wcm9iZSgpIGlu
c3RlYWQgb2Ygc3RpY2tpbmcgd2l0aAo+IHRoZSBvbGQgaTJjIHByb2JlIGNhbGxiYWNrLgoKV2Vs
bCwgdGhlcmUgd2FzIG5ldmVyIHVzZXIgZm9yIHJ0NTY3NiwgdGh1cywgcGxhdGZvcm0gY29kZSBj
YW4gdXNlCmRyaXZlciBuYW1lIHRvIHJlZ2lzdGVyIC8gY3JlYXRlIHBsYXRmb3JtIGRldmljZSB0
byBiZSBtYXRjaGVkLgoKLS0gCkFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tPgpJbnRlbCBGaW5sYW5kIE95Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
