From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Mon, 23 Apr 2018 10:08:44 +0200
Message-ID: <20180423080844.yh6ndicpu6mwy336@pali>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC8F2675D0
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 10:08:46 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id z73-v6so38553651wrb.0
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 01:08:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, Takashi Iwai <tiwai@suse.de>, tiwai@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uZGF5IDIzIEFwcmlsIDIwMTggMTY6MDQ6NTUgS2FpIEhlbmcgRmVuZyB3cm90ZToKPiAK
PiAKPiA+IE9uIEFwciAyMCwgMjAxOCwgYXQgODoxMCBQTSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBz
dXNlLmRlPiB3cm90ZToKPiA+IAo+ID4gT24gRnJpLCAyMCBBcHIgMjAxOCAxMTo0NDozMiArMDIw
MCwKPiA+IEthaS1IZW5nIEZlbmcgd3JvdGU6Cj4gPiA+IE5vdyBpdCdzIGEgdHlwaWNhbCBkaXNj
cmV0ZS1vbmx5IHN5c3RlbS4gSERNSSBhdWRpbyBjb21lcyBmcm9tIEFNRCBhdWRpbwo+ID4gPiBj
b250cm9sbGVyLCBvdGhlcnMgZnJvbSBJbnRlbCBhdWRpbyBjb250cm9sbGVyLgo+ID4gPiAKPiA+
ID4gV2hlbiBTRyBpcyBlbmFibGVkLCB0aGUgdW51c2VkIEFNRCBhdWRpbyBjb250b2xsZXIgc3Rp
bGwgZXhwb3NlcyBpdHMKPiA+ID4gc3lzZnMsIHNvIHVzZXJzcGFjZSBzdGlsbCBvcGVucyB0aGUg
Y29udHJvbCBmaWxlIGFuZCBzdHJlYW0uIElmCj4gPiA+IHVzZXJzcGFjZSB0cmllcyB0byBvdXRw
dXQgc291bmQgdGhyb3VnaCB0aGUgc3RyZWFtLCBpdCBoYW5ncyB0aGUgc3lzdGVtLgo+ID4gCj4g
PiBIbSwgY291bGQgeW91IGdpdmUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBob3cgaXQgaGFuZ3M/
Cj4gCj4gV2VsbCwgSSBzaG91bGQgc2F5ICJpdCBoYW5ncyB0aGUgdXNlcnNwYWNlIHByb2Nlc3Mi
IGluc3RlYWQuCj4gCj4gJCBzcGVha2VyLXRlc3QgLXQgd2F2IC1jIDIgLUQgaHc6Q0FSRD1IRE1J
LERFVj0zCj4gLi4uYW5kIGl0IGp1c3Qgc3RvcHBlZC4gQ2FuJ3QgQ3RybCtDIHRvIGJyZWFrIGl0
LgoKU28gdXNlcnNwYWNlIHByb2Nlc3MgY2Fubm90IGJlIGtpbGxlZCBhdCBhbGw/IFRoZW4gaXQg
aXMgZGlmZmVyZW50IGJ1ZwppbiBrZXJuZWwgYW5kIGRpc2FibGluZyBwY2kgZGV2aWNlIGlzIGp1
c3QgYSB3b3JrYXJvdW5kLiBOb3QgYSByZWFsIGZpeC4KCkkgd291bGQgcHJvcG9zZSB0byBmaW5k
IG91dCB3aGF0IGhhcHBlbiBhbmQgd2h5IGl0IGNhbm5vdCBiZSBraWxsZWQKKHByb2JhYmx5IGl0
IHN0dWNrIHNvbWV3aGVyZSBpbiBrZXJuZWwpIGFuZCBmaXggaXQgcHJvcGVybHkuCgo+ID4gCj4g
PiAKPiA+ID4gQEAgLTE2MjcsNiArMTYyOSw0MiBAQCBzdGF0aWMgdm9pZCBjaGVja19tc2koc3Ry
dWN0IGF6eCAqY2hpcCkKPiA+ID4gIAl9Cj4gPiA+ICB9Cj4gPiA+IAo+ID4gPiArI2lmIElTX0VO
QUJMRUQoQ09ORklHX0RFTExfTEFQVE9QKQo+ID4gCj4gPiBUaGlzIHNob3VsZCBiZSBJU19SRUFD
SEFCTEUoKSwgYXMgYm90aCBkZWxsLWxhcHRvcCBhbmQgSEQtYXVkaW8gYXJlCj4gPiB0cmlzdGF0
ZS4KPiAKPiBUaGFua3MsIHdpbGwgdXBkYXRlIGluIG5leHQgdmVyc2lvbi4KPiAKPiA+IAo+ID4g
PiArc3RhdGljIGJvb2wgY2hlY2tfZGVsbF9zd2l0Y2hhYmxlX2dmeChzdHJ1Y3QgcGNpX2RldiAq
cGRldikKPiA+IAo+ID4gSSdkIHJlbW92ZSAiX2RlbGwiIHdvcmQgaGVyZS4gIFN1Y2ggYSBjaGVj
ayB3b3VsZCBiZSBsaWtlbHkgbmVlZGVkIGZvcgo+ID4gb3RoZXIgdmVuZG9ycywgYW5kIGl0J3Mg
cXVpdGUgcG9zc2libGUgdGhhdCB0aGUgZnVuY3Rpb24gd2lsbCBiZQo+ID4gZXh0ZW5kZWQgdG8g
Y292ZXIgYSB3aWRlciBETUkgdGFibGUuCj4gCj4gTWFrZXMgc2Vuc2UuIFdpbGwgYWxzbyB1cGRh
dGUgdGhpcyBvbmUuCj4gCj4gS2FpLUhlbmcKPiAKPiA+IAo+ID4gCj4gPiB0aGFua3MsCj4gPiAK
PiA+IFRha2FzaGkKCi0tIApQYWxpIFJvaMOhcgpwYWxpLnJvaGFyQGdtYWlsLmNvbQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
