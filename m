From: Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/2] ASoC: refine ASoC hdmi audio
 suspend/resume
Date: Mon, 14 Jan 2019 09:16:02 +0800
Message-ID: <1a7ffff2-4249-f2a0-ba7e-549910ad49b9@linux.intel.com>
References: <1546827721-25586-1-git-send-email-libin.yang@intel.com>
 <e2c257fb-e292-b23d-1f20-e5467e0d93dd@linux.intel.com>
 <96A12704CE18D347B625EE2D4A099D19527AE0B4@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p71jvh.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AE92B@SHSMSX103.ccr.corp.intel.com>
 <s5h8szui68f.wl-tiwai@suse.de> <s5h4laii46l.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AF06F@SHSMSX103.ccr.corp.intel.com>
 <s5h4lagyagb.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527AFEB3@SHSMSX103.ccr.corp.intel.com>
 <s5hd0p3mi6t.wl-tiwai@suse.de> <s5hsgxz5l29.wl-tiwai@suse.de>
 <s5hk1jb5hed.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19527B078E@SHSMSX103.ccr.corp.intel.com>
 <s5hk1jajp89.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B792667F5
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 02:14:19 +0100 (CET)
In-Reply-To: <s5hk1jajp89.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Yang, Libin" <libin.yang@intel.com>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

CgpPbiAyMDE5LzEvMTIg5LiL5Y2IMzo0MywgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIFNhdCwg
MTIgSmFuIDIwMTkgMDI6NDY6MzMgKzAxMDAsCj4gWWFuZywgTGliaW4gd3JvdGU6Cj4+Cj4+IEhp
IFRha2FzaGksCj4+Cj4+Pj4+Cj4+Pj4+IE9uIEZyaSwgMTEgSmFuIDIwMTkgMDY6MjA6MjMgKzAx
MDAsCj4+Pj4+IFlhbmcsIExpYmluIHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+IFRoZSBiZWxvdyBwYXRj
aCBtYXkgaGF2ZSBhIHNtYWxsIGNvbmZsaWN0aW9uIHRoYXQgdGhlIHRyaWdnZXIgd2lsbAo+Pj4+
Pj4gYmUgY2FsbGVkIHR3aWNlIGFzIG91ciBTT0YgaGFzIGFscmVhZHkgY2FsbCBzbmRfcGNtX3N1
c3BlbmQoKSBpbgo+Pj4+Pj4gY2FyZCBzdXNwZW5kLgo+Pj4+Pgo+Pj4+PiBJdCBzaG91bGQgYmUg
bm8gcHJvYmxlbSwgc25kX3BjbV9zdXNwZW5kKCkgY2FuIGJlIGNhbGxlZCBtdWx0aXBsZQo+Pj4+
PiB0aW1lcy4gIElmIGl0J3MgYWxyZWFkeSBzdXNwZW5kZWQsIGp1c3Qgbm90aGluZyBoYXBwZW5z
Lgo+Pj4+Cj4+Pj4gVGhpbmtpbmcgb2YgdGhpcyBwcm9ibGVtIGFnYWluLCBkb2VzIGEgcGF0Y2gg
bGlrZSBiZWxvdyB3b3JrIGluc3RlYWQ/Cj4+Pj4gVGhpcyBsb29rcyBsaWtlIGEgYmV0dGVyIGFu
ZCBtb3JlIGdlbmVyaWMgc29sdXRpb24uCj4+Pj4KPj4+PiBXaGF0IEknbSBub3QgcXVpdGUgc3Vy
ZSBpcyB3aGV0aGVyIHRoZSBkZXZpY2Ugc3VzcGVuZCBvcmRlciBiZXR3ZWVuCj4+Pj4gUENNIGRl
dmljZSBhbmQgSEQtYXVkaW8gY29kZWMgZGV2aWNlIGlzIGd1YXJhbnRlZWQuICBJIGd1ZXNzIHll
cywKPj4+PiBiZWNhdXNlIHRoZSBQQ00gZGV2aWNlIGlzIHJlZ2lzdGVyZWQgYWx3YXlzIGFmdGVy
IHRoZSBjb2RlYy4gIEJ1dCBBU29DCj4+Pj4gbWlnaHQgaGF2ZSBhbm90aGVyIHdlaXJkbmVzcyA6
KQo+Pgo+PiBUaGUgc3VzcGVuZCBvcmRlciBpcyBhbHdheXMgYSBxdWl0ZSBoYXJkIGlzc3VlIGZv
ciBtZS4gSSBoYXZlIHRvIHNwZW5kCj4+IGEgbG90IHRpbWUgY2hlY2tpbmcgdGhlIHBhcmVudC1j
aGlsZCByZWxhdGlvbnNoaXAuIEFuZCBpZiB0aGV5IGRvbid0IGhhdmUKPj4gc3VjaCByZWxhdGlv
bnNoaXAsIEkgZG9uJ3Qga25vdyBob3cgdG8gZmluZCB0aGUgb3JkZXIuCj4+Cj4+IE15IGluaXRp
YWwgaWRlYSB0byBnZXQgcmlkIG9mIHN1Y2ggZGVwZW5kZW5jeSBpczogZG8gdGhlIHBjbSBzdXNw
ZW5kIGJlZm9yZQo+PiBzdXNwZW5kKCksIGZvciBleGFtcGxlIHB1dCBpdCBpbiBwcmVwYXJlKCku
IEFuZCBzZXQgZGV2aWNlIGNsayBvZmYgYW5kIHBvd2VyCj4+IG9mZiBpbiBzdXNwZW5kKCkuIFRo
aXMgY2FuIG1ha2Ugc3VyZSBwY20gaXMgYWx3YXlzIHByb3Blcmx5IHN1c3BlbmRlZC4KPj4gQnV0
LCBJJ20gbm90IHN1cmUgcHJlcGFyZSgpIGlzIGEgcmlnaHQgcGxhY2UgYmVjYXVzZSBpdCBzZWVt
cyBwcmVwYXJlKCkgaXMgbm90Cj4+IGRlc2lnbmVkIHRvIGRvIHN1Y2ggdGhpbmdzIGFuZCBwcmVw
YXJlKCkgbWF5IGltcGFjdCB0aGUgc3VzcGVuZC9yZXN1bWUKPj4gc2VxdWVuY2UgYmFzZWQgb24g
aXRzIHJldHVybiB2YWx1ZS4gSWYgeW91ciBiZWxvdyBwYXRjaCB3b3JrcywgSSB0aGluayBpdCB3
aWxsCj4+IGJlIGEgYmVzdCBzb2x1dGlvbiB3aGljaCBjYW4gaGFuZGxlIHN1Y2ggdGhpbmdzIGlu
IEFMU0EgbGV2ZWwuIEkgdGhpbmsgd2UKPj4gbWF5IG5lZWQgdG8gZG8gYSBsb3Qgb2YgdGVzdCBi
ZWNhdXNlIHRoZSBkaWZmZXJlbnQgY2FyZHMgZHJpdmVycyBhcmUKPj4gZXh0cmVtZWx5IGRpZmZl
cmVudC4KPiAKPiBBcyBtZW50aW9uZWQgYmVsb3csIEFTb0MgaXMgYW5vdGhlciB0aGluZy4gIEl0
cyBQTSBzZXF1ZW5jZSBpcyBmb3VuZAo+IGluIHNuZF9zb2Nfc3VzcGVuZCgpLgo+IAo+IAo+IFRh
a2FzaGkKClRoaXMgaXMgYW4gaW50ZXJlc3RpbmcgdG9waWMsIGl0IHdvcnRoIHRvIGRvIGEgc3Vy
Z2VyeSB0byByZW1vdmUgdGhvc2UgCkFTb0Mgc25kX3BjbV9zdXNwZW5kX2FsbCgpIGludm9raW5n
IGFuZCBkbyB1bmlmaWVkIFBDTSBzdXNwZW5kIGluIEFMU0EgClBDTSBsZXZlbD8KClRoYW5rcywK
fktleW9uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
