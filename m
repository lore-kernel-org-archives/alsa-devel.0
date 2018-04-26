From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Thu, 26 Apr 2018 15:52:08 +0800
Message-ID: <A9269F25-2239-4E3C-A3B3-FFDD69A90DD0@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
 <20180423080844.yh6ndicpu6mwy336@pali>
 <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
 <20180424211347.GA18258@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 001A526722C
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 09:52:15 +0200 (CEST)
Received: from mail-pf0-f199.google.com ([209.85.192.199])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <kai.heng.feng@canonical.com>)
 id 1fBbhP-0001tb-BZ
 for alsa-devel@alsa-project.org; Thu, 26 Apr 2018 07:52:15 +0000
Received: by mail-pf0-f199.google.com with SMTP id k3so17977231pff.23
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 00:52:15 -0700 (PDT)
In-Reply-To: <20180424211347.GA18258@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

Cj4gT24gQXByIDI1LCAyMDE4LCBhdCA1OjEzIEFNLCBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5l
ci5kZT4gd3JvdGU6Cj4KPiBPbiBNb24sIEFwciAyMywgMjAxOCBhdCAwNDoxODozNVBNICswODAw
LCBLYWkgSGVuZyBGZW5nIHdyb3RlOgo+Pj4gT24gQXByIDIzLCAyMDE4LCBhdCA0OjA4IFBNLCBQ
YWxpIFJvaMODwqFyIDxwYWxpLnJvaGFyQGdtYWlsLmNvbT4gd3JvdGU6Cj4+PiBPbiBNb25kYXkg
MjMgQXByaWwgMjAxOCAxNjowNDo1NSBLYWkgSGVuZyBGZW5nIHdyb3RlOgo+Pj4+PiBPbiBBcHIg
MjAsIDIwMTgsIGF0IDg6MTAgUE0sIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6
Cj4+Pj4+IE9uIEZyaSwgMjAgQXByIDIwMTggMTE6NDQ6MzIgKzAyMDAsIEthaS1IZW5nIEZlbmcg
d3JvdGU6Cj4+Pj4+PiBOb3cgaXQncyBhIHR5cGljYWwgZGlzY3JldGUtb25seSBzeXN0ZW0uIEhE
TUkgYXVkaW8gY29tZXMgZnJvbSBBTUQgIAo+Pj4+Pj4gYXVkaW8KPj4+Pj4+IGNvbnRyb2xsZXIs
IG90aGVycyBmcm9tIEludGVsIGF1ZGlvIGNvbnRyb2xsZXIuCj4+Pj4+Pgo+Pj4+Pj4gV2hlbiBT
RyBpcyBlbmFibGVkLCB0aGUgdW51c2VkIEFNRCBhdWRpbyBjb250b2xsZXIgc3RpbGwgZXhwb3Nl
cyBpdHMKPj4+Pj4+IHN5c2ZzLCBzbyB1c2Vyc3BhY2Ugc3RpbGwgb3BlbnMgdGhlIGNvbnRyb2wg
ZmlsZSBhbmQgc3RyZWFtLiBJZgo+Pj4+Pj4gdXNlcnNwYWNlIHRyaWVzIHRvIG91dHB1dCBzb3Vu
ZCB0aHJvdWdoIHRoZSBzdHJlYW0sIGl0IGhhbmdzIHRoZSAgCj4+Pj4+PiBzeXN0ZW0uCj4+Pj4+
Cj4+Pj4+IEhtLCBjb3VsZCB5b3UgZ2l2ZSBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGhvdyBpdCBo
YW5ncz8KPj4+Pgo+Pj4+IFdlbGwsIEkgc2hvdWxkIHNheSAiaXQgaGFuZ3MgdGhlIHVzZXJzcGFj
ZSBwcm9jZXNzIiBpbnN0ZWFkLgo+Pj4+Cj4+Pj4gJCBzcGVha2VyLXRlc3QgLXQgd2F2IC1jIDIg
LUQgaHc6Q0FSRD1IRE1JLERFVj0zCj4+Pj4gLi4uYW5kIGl0IGp1c3Qgc3RvcHBlZC4gQ2FuJ3Qg
Q3RybCtDIHRvIGJyZWFrIGl0Lgo+Pj4KPj4+IFNvIHVzZXJzcGFjZSBwcm9jZXNzIGNhbm5vdCBi
ZSBraWxsZWQgYXQgYWxsPyBUaGVuIGl0IGlzIGRpZmZlcmVudCBidWcKPj4+IGluIGtlcm5lbCBh
bmQgZGlzYWJsaW5nIHBjaSBkZXZpY2UgaXMganVzdCBhIHdvcmthcm91bmQuIE5vdCBhIHJlYWwg
Zml4Lgo+Pj4KPj4+IEkgd291bGQgcHJvcG9zZSB0byBmaW5kIG91dCB3aGF0IGhhcHBlbiBhbmQg
d2h5IGl0IGNhbm5vdCBiZSBraWxsZWQKPj4+IChwcm9iYWJseSBpdCBzdHVjayBzb21ld2hlcmUg
aW4ga2VybmVsKSBhbmQgZml4IGl0IHByb3Blcmx5Lgo+Pgo+PiBUaGF0J3MgYmVjYXVzZSB0aGUg
YXVkaW8gZGV2aWNlIGdvdCBydW50aW1lIHN1c3BlbmRlZCBieSB0aGUgZ3JhcGhpY3MuCj4+Cj4+
IEluIHRoaXMgY2FzZSwgaWYgd2UgcmVhbGx5IHdhbnQgdG8gdXNlIHRoZSB0aGUgZGlzY3JldGUg
YXVkaW8sIHRoZW4gd2UgIAo+PiBhbHNvCj4+IG5lZWQgdG8gd2FrZSB1cCB0aGUgZ3JhcGhpY3Mu
Cj4+IFRoZSBkaXNjcmV0ZSBhdWRpbyBpcyB0b3RhbGx5IHVzZWxlc3Mgd2hlbiBTRyBpcyBlbmFi
bGVkLCBzbyBteSBhcHByb2FjaCAgCj4+IGlzCj4+IGp1c3QgdG8gZGlzYWJsZSBpdC4KPgo+IEkg
ZG9uJ3QgcXVpdGUgZm9sbG93LCB0aGF0IHNob3VsZCBiZSBmaXhlZCBieSBjb21taXQgMDdmNGY5
N2Q3YjRiCj4gKCJ2Z2Ffc3dpdGNoZXJvbzogVXNlIGRldmljZSBsaW5rIGZvciBIREEgY29udHJv
bGxlciIpIHdoaWNoIGxhbmRlZAo+IGluIHY0LjE3LXJjMS4KCkxvb2tzIGxpa2UgSSBoaXQgYSBu
ZXcgYnVnOiB0aGUgZGlzY3JldGUgR0ZYIGFuZCBpdHMgYXVkaW8gY29udHJvbGxlciBuZXZlciAg
CmVudGVycyB0byBEMy4KVGhlIEdGWCBjYW4gZW50ZXIgdG8gRDMgd2l0aCBteSBwcm9zZWQgcGF0
Y2guCgo+Cj4gTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhhdCB3aXRoIFNHIGVuYWJsZWQsIHRoZSBl
eHRlcm5hbCBEUC9IRE1JIHBvcnRzCj4gYXJlIG11eGVkIHRvIHRoZSBJbnRlbCBHUFUsIHNvIGF1
ZGlvIGNhbiBvbmx5IGJlIHN0cmVhbWVkIHRvIGV4dGVybmFsCj4gZGlzcGxheXMgYnkgdGhlIElu
dGVsIEhEQSwgbm90IGJ5IHRoZSBIREEgaW50ZWdyYXRlZCBpbnRvIHRoZSBkaXNjcmV0ZQo+IEFN
RC9OdmlkaWEgR1BVLiAgQXVkaW8gc3RyZWFtZWQgdG8gdGhlIGxhdHRlciB3b3VsZCBlc3NlbnRp
YWxseSBlbmQgdXAKPiBpbiBhIGJsYWNraG9sZS4gIEFuZCBwcmV2ZW50aW5nIHRoZSB1c2VyIGZy
b20gc2VlaW5nIHN1Y2ggdXNlbGVzcyBhdWRpbwo+IGRldmljZXMgd2FzIHRoZSBzb2xlIHB1cnBv
c2Ugb2YgdGhpcyBjb21taXQuICBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPwoKWWVzIHRoaXMgaXMg
dGhlIGludGVudGlvbi4KCkthaS1IZW5nCgo+Cj4gVGhhbmtzLAo+Cj4gTHVrYXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
