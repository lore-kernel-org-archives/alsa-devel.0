From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Mon, 23 Apr 2018 16:18:35 +0800
Message-ID: <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
 <20180423080844.yh6ndicpu6mwy336@pali>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Content-Type: text/plain; charset="utf-8"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CC59D2671EA
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 10:18:42 +0200 (CEST)
Received: from mail-pg0-f72.google.com ([74.125.83.72])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <kai.heng.feng@canonical.com>)
 id 1fAWgM-0002Wd-7x
 for alsa-devel@alsa-project.org; Mon, 23 Apr 2018 08:18:42 +0000
Received: by mail-pg0-f72.google.com with SMTP id z6so6060557pgu.20
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 01:18:42 -0700 (PDT)
In-Reply-To: <20180423080844.yh6ndicpu6mwy336@pali>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, Takashi Iwai <tiwai@suse.de>, tiwai@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

Cgo+IE9uIEFwciAyMywgMjAxOCwgYXQgNDowOCBQTSwgUGFsaSBSb2jDoXIgPHBhbGkucm9oYXJA
Z21haWwuY29tPiB3cm90ZToKPgo+IE9uIE1vbmRheSAyMyBBcHJpbCAyMDE4IDE2OjA0OjU1IEth
aSBIZW5nIEZlbmcgd3JvdGU6Cj4+PiBPbiBBcHIgMjAsIDIwMTgsIGF0IDg6MTAgUE0sIFRha2Fz
aGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6Cj4+Pgo+Pj4gT24gRnJpLCAyMCBBcHIgMjAx
OCAxMTo0NDozMiArMDIwMCwKPj4+IEthaS1IZW5nIEZlbmcgd3JvdGU6Cj4+Pj4gTm93IGl0J3Mg
YSB0eXBpY2FsIGRpc2NyZXRlLW9ubHkgc3lzdGVtLiBIRE1JIGF1ZGlvIGNvbWVzIGZyb20gQU1E
IGF1ZGlvCj4+Pj4gY29udHJvbGxlciwgb3RoZXJzIGZyb20gSW50ZWwgYXVkaW8gY29udHJvbGxl
ci4KPj4+Pgo+Pj4+IFdoZW4gU0cgaXMgZW5hYmxlZCwgdGhlIHVudXNlZCBBTUQgYXVkaW8gY29u
dG9sbGVyIHN0aWxsIGV4cG9zZXMgaXRzCj4+Pj4gc3lzZnMsIHNvIHVzZXJzcGFjZSBzdGlsbCBv
cGVucyB0aGUgY29udHJvbCBmaWxlIGFuZCBzdHJlYW0uIElmCj4+Pj4gdXNlcnNwYWNlIHRyaWVz
IHRvIG91dHB1dCBzb3VuZCB0aHJvdWdoIHRoZSBzdHJlYW0sIGl0IGhhbmdzIHRoZSBzeXN0ZW0u
Cj4+Pgo+Pj4gSG0sIGNvdWxkIHlvdSBnaXZlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgaG93IGl0
IGhhbmdzPwo+Pgo+PiBXZWxsLCBJIHNob3VsZCBzYXkgIml0IGhhbmdzIHRoZSB1c2Vyc3BhY2Ug
cHJvY2VzcyIgaW5zdGVhZC4KPj4KPj4gJCBzcGVha2VyLXRlc3QgLXQgd2F2IC1jIDIgLUQgaHc6
Q0FSRD1IRE1JLERFVj0zCj4+IC4uLmFuZCBpdCBqdXN0IHN0b3BwZWQuIENhbid0IEN0cmwrQyB0
byBicmVhayBpdC4KPgo+IFNvIHVzZXJzcGFjZSBwcm9jZXNzIGNhbm5vdCBiZSBraWxsZWQgYXQg
YWxsPyBUaGVuIGl0IGlzIGRpZmZlcmVudCBidWcKPiBpbiBrZXJuZWwgYW5kIGRpc2FibGluZyBw
Y2kgZGV2aWNlIGlzIGp1c3QgYSB3b3JrYXJvdW5kLiBOb3QgYSByZWFsIGZpeC4KPgo+IEkgd291
bGQgcHJvcG9zZSB0byBmaW5kIG91dCB3aGF0IGhhcHBlbiBhbmQgd2h5IGl0IGNhbm5vdCBiZSBr
aWxsZWQKPiAocHJvYmFibHkgaXQgc3R1Y2sgc29tZXdoZXJlIGluIGtlcm5lbCkgYW5kIGZpeCBp
dCBwcm9wZXJseS4KClRoYXQncyBiZWNhdXNlIHRoZSBhdWRpbyBkZXZpY2UgZ290IHJ1bnRpbWUg
c3VzcGVuZGVkIGJ5IHRoZSBncmFwaGljcy4KCkluIHRoaXMgY2FzZSwgaWYgd2UgcmVhbGx5IHdh
bnQgdG8gdXNlIHRoZSB0aGUgZGlzY3JldGUgYXVkaW8sIHRoZW4gd2UgYWxzbyAgCm5lZWQgdG8g
d2FrZSB1cCB0aGUgZ3JhcGhpY3MuClRoZSBkaXNjcmV0ZSBhdWRpbyBpcyB0b3RhbGx5IHVzZWxl
c3Mgd2hlbiBTRyBpcyBlbmFibGVkLCBzbyBteSBhcHByb2FjaCBpcyAgCmp1c3QgdG8gZGlzYWJs
ZSBpdC4KCkthaS1IZW5nCgo+Cj4+Pj4gQEAgLTE2MjcsNiArMTYyOSw0MiBAQCBzdGF0aWMgdm9p
ZCBjaGVja19tc2koc3RydWN0IGF6eCAqY2hpcCkKPj4+PiAgCX0KPj4+PiAgfQo+Pj4+Cj4+Pj4g
KyNpZiBJU19FTkFCTEVEKENPTkZJR19ERUxMX0xBUFRPUCkKPj4+Cj4+PiBUaGlzIHNob3VsZCBi
ZSBJU19SRUFDSEFCTEUoKSwgYXMgYm90aCBkZWxsLWxhcHRvcCBhbmQgSEQtYXVkaW8gYXJlCj4+
PiB0cmlzdGF0ZS4KPj4KPj4gVGhhbmtzLCB3aWxsIHVwZGF0ZSBpbiBuZXh0IHZlcnNpb24uCj4+
Cj4+Pj4gK3N0YXRpYyBib29sIGNoZWNrX2RlbGxfc3dpdGNoYWJsZV9nZngoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpCj4+Pgo+Pj4gSSdkIHJlbW92ZSAiX2RlbGwiIHdvcmQgaGVyZS4gIFN1Y2ggYSBj
aGVjayB3b3VsZCBiZSBsaWtlbHkgbmVlZGVkIGZvcgo+Pj4gb3RoZXIgdmVuZG9ycywgYW5kIGl0
J3MgcXVpdGUgcG9zc2libGUgdGhhdCB0aGUgZnVuY3Rpb24gd2lsbCBiZQo+Pj4gZXh0ZW5kZWQg
dG8gY292ZXIgYSB3aWRlciBETUkgdGFibGUuCj4+Cj4+IE1ha2VzIHNlbnNlLiBXaWxsIGFsc28g
dXBkYXRlIHRoaXMgb25lLgo+Pgo+PiBLYWktSGVuZwo+Pgo+Pj4gdGhhbmtzLAo+Pj4KPj4+IFRh
a2FzaGkKPgo+IC0tIAo+IFBhbGkgUm9ow6FyCj4gcGFsaS5yb2hhckBnbWFpbC5jb20KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWls
aW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
