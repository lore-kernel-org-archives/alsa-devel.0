From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/6] ASoC: SOF: Intel: byt: Refactor fw
 ready / mem windows creation
Date: Wed, 7 Aug 2019 14:20:20 -0500
Message-ID: <af12fa5a-89ea-2eb7-a8a2-0ba24b9fa214@linux.intel.com>
References: <20190807150203.26359-1-pierre-louis.bossart@linux.intel.com>
 <20190807150203.26359-5-pierre-louis.bossart@linux.intel.com>
 <ac41ec50-6484-cce1-2e41-c42e6bb541ef@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37C48F800F4
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2019 21:20:23 +0200 (CEST)
In-Reply-To: <ac41ec50-6484-cce1-2e41-c42e6bb541ef@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

CgpPbiA4LzcvMTkgMjowNyBQTSwgQ2V6YXJ5IFJvamV3c2tpIHdyb3RlOgo+IE9uIDIwMTktMDgt
MDcgMTc6MDIsIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IHdyb3RlOgo+PiBGcm9tOiBEYW5pZWwgQmFs
dXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+Cj4gCj4+IFNvIHdlIGFyZSBiYXNpY2FsbHkgbW92
aW5nIGNvZGUgZnJvbSBpbnRlbC9ieXQuYyB0byBsb2FkZXIuYyBrZWVwaW5nCj4+IGluIG1pbmQg
dGhhdCBtYm94X29mZnNldCBpcyBhIHBlciBwbGF0Zm9ybSBjb25zdGFudCBzbyB3ZSBuZWVkIHRv
Cj4+IHVzZSBuZXdseSBpbnRyb2R1Y2VkIHNuZF9zb2ZfZHNwX2dldF9tYWlsYm94X29mZnNldCAv
Cj4+IHNuZF9zb2ZfZHNwX2dldF93aW5kb3dfb2Zmc2V0IGluIG9yZGVyIHRvIGdldCB0aGUgY29y
cmVjdAo+PiBtYm94IG9mZnNldCAvIHdpbmRvdyBvZmZzZXQgdmFsdWUuCj4gCj4gWW91J3ZlIGFs
cmVhZHkgZXhwbGFpbmVkIHlvdXIgZ29hbC4gVGhlc2UgZGV0YWlscyBhcmUgdW5uZWNlc3Nhcnku
CgpUaGV5IGRvbid0IGh1cnQgYW5kIGhlbHAgZXhwbGFpbiB0aGUgYXBwcm9hY2guCgo+IAo+Pgo+
PiBBbHNvLCBiYXIgaXMgYSBwZXIgcGxhdGZvcm0gY29uc3RhbnQgc28gd2UgdXNlIHNuZF9zb2Zf
ZHNwX2dldF9iYXJfaW5kZXgKPj4gaW5zdGVhZCBvZiB0aGUgaGFyZGNvZGVkIEJZVF9EU1BfQkFS
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5j
b20+Cj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IAo+PiA8cGllcnJlLWxv
dWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tPgo+PiAtLS0KPj4gwqAgc291bmQvc29jL3NvZi9p
bnRlbC9ieXQuYyB8IDE2NCArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+
IMKgIHNvdW5kL3NvYy9zb2YvbG9hZGVyLmPCoMKgwqAgfCAxNjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKPj4gwqAgc291bmQvc29jL3NvZi9zb2YtcHJpdi5owqAgfMKg
wqAgMiArCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMTg5IGluc2VydGlvbnMoKyksIDE0NSBkZWxl
dGlvbnMoLSkKPiAKPiBIbW0sIGV2ZW4gdGhlIGNvbW1pdCBtZXNzYWdlIG1lbnRpb25zIHR3byBz
dGVwcywgbm90IG9uZS4gU3BsaXR0aW5nIHRoaXMgCj4gY29tbWl0IGludG8gdHdvIC0gaW50cm9k
dWN0aW9uIG9mIG5ldyBnZW5lcmljIGZ1bmN0aW9ucyBhbmQgYnl0IAo+IGFsaWdubWVudCB0b3dh
cmRzIHRoZSBuZXdseSBhZGRlZCBhcHByb2FjaCAtIHNlZW1zIHJlYXNvbmFibGUuIEJkdyAmIGhk
YSAKPiBmb2xsb3d1cHMgYWxyZWFkeSBtYWtlIGdvb2QgZXhhbXBsZXMuCgpUaGUgbGFzdCB0d28g
anVzdCByZW1vdmUgdGhlIGR1cGxpY2F0ZSBjb2RlIGFuZCBhbGlnbiBvbiB1c2luZyB0aGUgCmNv
bW1vbiBoZWxwZXJzLgpJbiB0aGUgaW5pdGlhbCBzdGVwIHdlIHN0aWxsIG5lZWQgdG8gbW92ZSB0
aGUgY29kZSBmcm9tIGJheXRyYWlsIHRvIHRoZSAKY29tbW9uIGZ1bmN0aW9uLiBEb2luZyBpdCBp
biB0d28gc3RlcHMgZG9lc24ndCBicmluZyBtdWNoIGFkZGVkIHZhbHVlIApJTU8uIFRvIHByZXNl
cnZlIGdpdCBiaXNlY3Qgc3VwcG9ydCwgeW91J2QgbmVlZCB0byBhZGQgYSBuZXcgY29tbW9uIApj
b2RlLCB0aGVuIHJlbW92ZSB0aGUgYmF5dHJhaWwgb25lIGluIGEgZm9sbG93LXVwIHBhdGNoLiBJ
dCdkIG1ha2UgaXQgCmxlc3Mgc2VsZi1leHBsYW5hdG9yeSB3aGVyZSB0aGlzIG5ldyBjb2RlIGNv
bWVzIGZyb20uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
