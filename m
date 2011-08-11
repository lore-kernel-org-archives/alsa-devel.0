From: Daniel Mack <zonque@gmail.com>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Fri, 12 Aug 2011 01:40:35 +0200
Message-ID: <4E446873.9020508@gmail.com>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
	<20110811180507.GC5884@xanatos>
	<CACTFLAMcOMv4D8k-P24TAkPwLRgYps4hoO-vC1NH+cibcsrUFQ@mail.gmail.com>
	<3166003.Y8gKYdUrh9@edgy>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A4ECA103961
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 01:40:39 +0200 (CEST)
Received: by wyh22 with SMTP id 22so1902490wyh.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2011 16:40:39 -0700 (PDT)
In-Reply-To: <3166003.Y8gKYdUrh9@edgy>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?TWF0xJtqIExhaXRs?= <matej@laitl.cz>
Cc: William Light <wrl@illest.net>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Alan Stern <stern@rowland.harvard.edu>, Takashi Iwai <tiwai@suse.de>, pedrib@gmail.com, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gMDgvMTIvMjAxMSAwMToyOSBBTSwgTWF0xJtqIExhaXRsIHdyb3RlOgo+IE9uIDExLuKArzgu
4oCvMjAxMSBEYW5pZWwgTWFjayB3cm90ZToKPj4gT24gVGh1LCBBdWcgMTEsIDIwMTEgYXQgODow
NSBQTSwgU2FyYWggU2hhcnAKPj4+IEJlY2F1c2UgYWNjb3JkaW5nIHRvIE1hdGVqLCBoZSBhcHBs
aWVkIHRoYXQgcGF0Y2gsIHBsdXMgbXkgcGF0Y2ggdG8KPj4+IHJlamVjdCB6ZXJvLWxlbmd0aCBi
dWZmZXJzWzFdLCBhbmQgaGUgc2F3IGRlYnVnZ2luZyB0aGF0IGluZGljYXRlZCBoZQo+Pj4gKmRp
ZCogc2VlIHplcm8tbGVuZ3RoIGJ1ZmZlcnMuICBJcyB0aGVyZSBhbnkgY2hhbmNlIHlvdXIgZHJp
dmVyIG1pZ2h0Cj4+PiBzdWJtaXQgYSB6ZXJvLWxlbmd0aCBidWZmZXIgaW4gdGhlIG1pZGRsZSBv
ZiB0aGUgaXNvY2hyb25vdXMgVVJCCj4+PiB0cmFuc2ZlciBhcnJheT8KPj4KPj4gSG1tLCBqdWRn
aW5nIGZyb20gdGhlIGNvZGUsIHRoaXMgY2FuIG9ubHkgZXZlciBoYXBwZW4gaWYgd2UgcmVjZWl2
ZSBhbgo+PiBpbmJvdW5kIGlzbyBmcmFtZSB3aGljaCBoYXMgYSB2YWxpZCBzdGF0dXMgYW5kIGFu
IGFjdHVhbF9sZW5ndGggb2YKPj4gemVyby4gQWxzbywgaXQgd2FzIG5vdCBuZWNjZXNzYXJ5IHRv
IGNhdGNoIHRoaXMgY2FzZSBmb3IgRUhDSS4KPj4KPj4gTWFldGosIGRvZXMgdGhpcyBwYXRjaCBt
YWtlIGFueSBkaWZmZXJlbmNlPwo+Cj4gVGhpcyBwYXRjaCBhY3R1YWxseSBtYWtlcyB0aGUgc291
bmQgcGxheWJhY2sgX3dvcnNlXy4gTm93IEkgZ2V0IHN0cmFuZ2UKPiBzcXVhd2tzIHdoZXJlIHBy
ZXZpb3VzbHkgYXQgbGVhc3QgZmlyc3Qgc2Vjb25kcyBvZiBhIHNvbmcgc291bmRlZCBub3JtYWxs
eS4KPgo+IEhvd2V2ZXIsIEkgbm8gbG9uZ2VyIGdldCAiemVybyBsZW5ndGggYnVmZmVyIHN1Ym1p
dHRlZCIgb3IgdGhhdCAiLi4uIFdlaXJkLiIKPiBkZWJ1ZyBtZXNzYWdlcywgb25seSBzZXZlcmFs
IG1lZ2FieXRlcyBvZjogKHNob3VsZCBJIHBvc3QgdGhlc2Ugc29tZXdoZXJlPykKPgo+IHhoY2lf
aGNkIDAwMDA6MDU6MDAuMDogR2l2ZWJhY2sgVVJCIGZmZmY4ODAxMTRjZWMwMDAsIGxlbiA9IDg4
MCwgZXhwZWN0ZWQgPQo+IDEwMDAsIHN0YXR1cyA9IC0xMTUKPiB4aGNpX2hjZCAwMDAwOjA1OjAw
LjA6IEdpdmViYWNrIFVSQiBmZmZmODgwMTE0NzQwMDAwLCBsZW4gPSAzNTIsIGV4cGVjdGVkID0K
PiAxMDAwLCBzdGF0dXMgPSAtMTE1Cj4geGhjaV9oY2QgMDAwMDowNTowMC4wOiB1bmRlcnJ1biBl
dmVudCBvbiBlbmRwb2ludAoKTWlnaHQgYmUgdGhlIGhhcmR3YXJlIGRvZXNuJ3QgbGlrZSB0aGlz
LiBBcyBJIHNhaWQsIHRoZSBwYXRjaCBpcyBibGluZGx5IAp3cml0dGVuIGFuZCBJIGNvdWxkbid0
IHRlc3QgaXQuIERpZCB5b3UgdGVzdCB0aGlzIG9uIGEgRUhDSSBwb3J0IGFzIHdlbGw/CgpEYW5p
ZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
