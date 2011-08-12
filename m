From: Daniel Mack <zonque@gmail.com>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Fri, 12 Aug 2011 11:55:54 +0200
Message-ID: <CACTFLAOc4QRm7sRQd0-MQLORO72s3_ZTu3KocgEtv1wuZ=2pUw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
	<3166003.Y8gKYdUrh9@edgy> <4E446873.9020508@gmail.com>
	<1451239.ZLFiT5MIDr@edgy>
	<CACTFLANyL95Gy6c2YznV-h0tYdZ7nvRhObsq8dvp9n4_9=D_Mw@mail.gmail.com>
	<20110812044605.GA8533@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id E68D310384D
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 11:55:57 +0200 (CEST)
Received: by pzk1 with SMTP id 1so925753pzk.2
	for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2011 02:55:55 -0700 (PDT)
In-Reply-To: <20110812044605.GA8533@xanatos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: William Light <wrl@illest.net>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Alan Stern <stern@rowland.harvard.edu>, =?UTF-8?B?TWF0xJtqIExhaXRs?= <matej@laitl.cz>, pedrib@gmail.com, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgMTIsIDIwMTEgYXQgNjo0NiBBTSwgU2FyYWggU2hhcnAKPHNhcmFoLmEuc2hh
cnBAbGludXguaW50ZWwuY29tPiB3cm90ZToKPiBPbiBGcmksIEF1ZyAxMiwgMjAxMSBhdCAwMzoy
ODo0MkFNICswMjAwLCBEYW5pZWwgTWFjayB3cm90ZToKPj4gT24gRnJpLCBBdWcgMTIsIDIwMTEg
YXQgMTo1MCBBTSwgTWF0xJtqIExhaXRsIDxtYXRlakBsYWl0bC5jej4gd3JvdGU6Cj4+ID4gT24g
MTIu4oCvOC7igK8yMDExIERhbmllbCBNYWNrIHdyb3RlOgo+PiA+PiA+IFRoaXMgcGF0Y2ggYWN0
dWFsbHkgbWFrZXMgdGhlIHNvdW5kIHBsYXliYWNrIF93b3JzZV8uIE5vdyBJIGdldCBzdHJhbmdl
Cj4+ID4+ID4gc3F1YXdrcyB3aGVyZSBwcmV2aW91c2x5IGF0IGxlYXN0IGZpcnN0IHNlY29uZHMg
b2YgYSBzb25nIHNvdW5kZWQKPj4gPj4gPiBub3JtYWxseS4KPj4gPj4gPgo+PiA+PiA+IEhvd2V2
ZXIsIEkgbm8gbG9uZ2VyIGdldCAiemVybyBsZW5ndGggYnVmZmVyIHN1Ym1pdHRlZCIgb3IgdGhh
dCAiLi4uCj4+ID4+ID4gV2VpcmQuIiBkZWJ1ZyBtZXNzYWdlcywgb25seSBzZXZlcmFsIG1lZ2Fi
eXRlcyBvZjogKHNob3VsZCBJIHBvc3QgdGhlc2UKPj4gPj4gPiBzb21ld2hlcmU/KQo+PiA+PiA+
Cj4+ID4+ID4geGhjaV9oY2QgMDAwMDowNTowMC4wOiBHaXZlYmFjayBVUkIgZmZmZjg4MDExNGNl
YzAwMCwgbGVuID0gODgwLAo+PiA+PiA+IGV4cGVjdGVkID0gMTAwMCwgc3RhdHVzID0gLTExNQo+
PiA+PiA+IHhoY2lfaGNkIDAwMDA6MDU6MDAuMDogR2l2ZWJhY2sgVVJCIGZmZmY4ODAxMTQ3NDAw
MDAsIGxlbiA9IDM1MiwKPj4gPj4gPiBleHBlY3RlZCA9IDEwMDAsIHN0YXR1cyA9IC0xMTUKPj4g
Pj4gPiB4aGNpX2hjZCAwMDAwOjA1OjAwLjA6IHVuZGVycnVuIGV2ZW50IG9uIGVuZHBvaW50Cj4+
ID4+Cj4+ID4+IE1pZ2h0IGJlIHRoZSBoYXJkd2FyZSBkb2Vzbid0IGxpa2UgdGhpcy4gQXMgSSBz
YWlkLCB0aGUgcGF0Y2ggaXMgYmxpbmRseQo+PiA+PiB3cml0dGVuIGFuZCBJIGNvdWxkbid0IHRl
c3QgaXQuIERpZCB5b3UgdGVzdCB0aGlzIG9uIGEgRUhDSSBwb3J0IGFzIHdlbGw/Cj4+ID4KPj4g
PiBHb29kIHBvaW50LCB0aGlzIHBhdGNoIGRpc3RvcnRzIHRoZSBwbGF5YmFjayBhbHNvIG9uIHRo
ZSBFSENJIHBvcnQuICh0aGUKPj4gPiBwbGF5YmFjayBzZWVtcyB0byBiZSAxMCB0aW1lcyBzbG93
ZXIgdGhhbiBpdCBzaG91bGQgYmUpCj4+Cj4+IEFuZCBpdCBpcyBvbmx5IHRoaXMgKmxhc3QqIHBh
dGNoIHRoYXQgY2F1c2VzIGl0LCB5ZXM/Cj4+Cj4+IElmIHRoYXQgaXMgdGhlIGNhc2UsIHdlIG5l
ZWQgZW1wdHkgc3ViZnJhbWVzIGluIHRoZSBtaWRkbGUgb2YgdXJicywKPj4gYW5kIHdlIG5lZWQg
dG8gZmlndXJlIGEgd2F5IGhvdyB0byB0ZWFjaCB0aGUgWEhDSSBkcml2ZXIgdG8gY29wZSB3aXRo
Cj4+IHRoYXQsIHRvby4KPgo+IEJ5IGVtcHR5IHN1YmZyYW1lcywgeW91IG1lYW4gemVyby1sZW5n
dGggZnJhbWUgYnVmZmVycyBpbiB0aGUgbWlkZGxlIG9mCj4gdGhlIFVSQiwgY29ycmVjdD8KClll
cC4KCj4gQW5kaXJ5IGFuZCBBbGFuIGhhZCBzb21lIHN1Z2dlc3Rpb25zIGZvciBob3cgdG8gZml4
Cj4gdGhhdCwgc28gSSdsbCB0cnkgdG8gY29vayB1cCBhIHBhdGNoIHRvbW9ycm93LiDCoFRoZW4g
d2UnbGwgaGF2ZSB0bwo+ICJ1bnBlZWwiIHRoZSBkZWJ1ZyBwYXRjaGVzIGFuZCBtYWtlIHN1cmUg
dGhlIHN5c3RlbSBpcyBzdGlsbCB1c2FibGUuCgpHb29kIDopIEFuZCBJJ2xsIG1ha2UgYSBwYXRj
aCB0byBtYWtlIGRvdWJsZS1zdWJtaXNzaW9uIGltcG9zc2libGUgaW4KYSBuaWNlIHdheS4KCgpE
YW5pZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
