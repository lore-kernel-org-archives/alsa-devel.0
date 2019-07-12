From: "Wasko, Michal" <michal.wasko@linux.intel.com>
Subject: Re: [PATCH] sound: pci: emu10k1: Remove unneeded
 variable "change"
Date: Fri, 12 Jul 2019 10:06:23 +0200
Message-ID: <d92d60c5-2a59-0d1f-05fa-a8ab13f6bdd0@linux.intel.com>
References: <20190711171726.GA4356@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A7A7F800D8
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2019 10:06:31 +0200 (CEST)
In-Reply-To: <20190711171726.GA4356@hari-Inspiron-1545>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Allison Randal <allison@lohutok.net>, Richard Fontana <rfontana@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gNy8xMS8yMDE5IDc6MTcgUE0sIEhhcmlwcmFzYWQgS2VsYW0gd3JvdGU6Cj4gZml4IGJlbG93
IGlzc3VlIHJlcG9ydGVkIGJ5IGNvY2NpY2hlY2sKPiBzb3VuZC9wY2kvZW11MTBrMS9lbXUxMGsx
eC5jOjEwNzc6NS0xMTogVW5uZWVkZWQgdmFyaWFibGU6ICJjaGFuZ2UiLgo+IFJldHVybiAiMCIg
b24gbGluZSAxMDkyCj4KPiBTaWduZWQtb2ZmLWJ5OiBIYXJpcHJhc2FkIEtlbGFtIDxoYXJpcHJh
c2FkLmtlbGFtQGdtYWlsLmNvbT4KU2luY2UgdGhlwqAgZnVuY3Rpb24gYWx3YXlzIHJldHVybiAw
IGFuZCB5b3UgcGVyZm9ybSBjb2RlIGNsZWFuLXVwIHRoZW4KbWF5YmUgaXQgd291bGQgYmUgYSBn
b29kIGlkZWEgdG8ganVzdCBjaGFuZ2UgZnVuY3Rpb24gdG8gdm9pZCBpbnN0ZWFkCm9mIHJldHVy
bmluZyBpbnQgdmFsdWUgd2hpY2ggZG9lcyBub3Qgc2VlbSB0byBoYXZlIHVzZS4KCk1pY2hhbCBX
Lgo+IC0tLQo+ICAgc291bmQvcGNpL2VtdTEwazEvZW11MTBrMXguYyB8IDMgKy0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL2VtdTEwazEvZW11MTBrMXguYyBiL3NvdW5kL3BjaS9lbXUxMGsxL2VtdTEw
azF4LmMKPiBpbmRleCA2N2Q2NDczLi45Y2Y4MTgzIDEwMDY0NAo+IC0tLSBhL3NvdW5kL3BjaS9l
bXUxMGsxL2VtdTEwazF4LmMKPiArKysgYi9zb3VuZC9wY2kvZW11MTBrMS9lbXUxMGsxeC5jCj4g
QEAgLTEwNzQsNyArMTA3NCw2IEBAIHN0YXRpYyBpbnQgc25kX2VtdTEwazF4X3NoYXJlZF9zcGRp
Zl9wdXQoc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsCj4gICB7Cj4gICAJc3RydWN0IGVt
dTEwazF4ICplbXUgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7Cj4gICAJdW5zaWduZWQg
aW50IHZhbDsKPiAtCWludCBjaGFuZ2UgPSAwOwo+ICAgCj4gICAJdmFsID0gdWNvbnRyb2wtPnZh
bHVlLmludGVnZXIudmFsdWVbMF0gOwo+ICAgCj4gQEAgLTEwODksNyArMTA4OCw3IEBAIHN0YXRp
YyBpbnQgc25kX2VtdTEwazF4X3NoYXJlZF9zcGRpZl9wdXQoc3RydWN0IHNuZF9rY29udHJvbCAq
a2NvbnRyb2wsCj4gICAJCXNuZF9lbXUxMGsxeF9wdHJfd3JpdGUoZW11LCBST1VUSU5HLCAwLCAw
eDEwMDNGKTsKPiAgIAkJc25kX2VtdTEwazF4X2dwaW9fd3JpdGUoZW11LCAweDEwODApOwo+ICAg
CX0KPiAtCXJldHVybiBjaGFuZ2U7Cj4gKwlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3IHNuZF9lbXUxMGsxeF9zaGFyZWRfc3BkaWYg
PQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
