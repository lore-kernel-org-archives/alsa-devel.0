From: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v2 2/5] ALSA: hda: Add api to program
 stripe control bits
Date: Sat, 12 Jan 2019 12:17:33 +0530
Message-ID: <99e9230d-9e23-d79d-005f-9396f7d219c1@nvidia.com>
References: <1547227328-32558-1-git-send-email-spujar@nvidia.com>
 <1547227328-32558-3-git-send-email-spujar@nvidia.com>
 <13164ff6-1ea0-9e28-b3b2-a590949a7200@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id B600F266914
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2019 07:47:40 +0100 (CET)
In-Reply-To: <13164ff6-1ea0-9e28-b3b2-a590949a7200@linux.intel.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDEvMTEvMjAxOSAxMToyNSBQTSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4KPj4g
Kwo+PiArwqDCoMKgIC8qIGZvbGxvd2luZyBpcyBmcm9tIEhEIGF1ZGlvIHNwZWMgKi8KPj4gK8Kg
wqDCoCBmb3IgKHNkb19saW5lID0gbWF4X3Nkb19saW5lczsgc2RvX2xpbmUgPiAwOyBzZG9fbGlu
ZSA+Pj0gMSkgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHJhdGUgPiA0ODAwMCkKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdmFsdWUgPSAoY2hhbm5lbHMgKiBiaXRzX3Blcl9zYW1wbGUgKgo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHJhdGUgLyA0ODAwMCkp
IC8gc2RvX2xpbmU7Cj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZhbHVlID0gY2hhbm5lbHMgKiBiaXRzX3Blcl9zYW1wbGUgLyBzZG9fbGluZTsKPiAo
Y2hhbm5lbHMgKiBiaXRfcGVyX3NhbXBsZSkgLyBzZG9fbGluZSBhcyBpbiB0aGUgc3BlYz8KClRo
b3VnaCBJIGhhdmUgbm90IHVzZWQgZXhwbGljaXQgYnJhY2VzLCBidXQgYXMgcGVyIG9wZXJhdG9y
IHByZWNlZGVuY2UgCml0IHdpbGwgYmUgdHJlYXRlZCB0aGUgc2FtZSB3YXkgYXMgaXQgaXMgbWVu
dGlvbmVkIGluIHNwZWMuCkxldCBtZSBrbm93IGlmIHlvdSB3YW50IHRoaXMgdG8gYmUgZXhwbGlj
aXRseSBtZW50aW9uZWQuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIGVtYWlsIG1l
c3NhZ2UgaXMgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGFu
ZCBtYXkgY29udGFpbgpjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uICBBbnkgdW5hdXRob3JpemVk
IHJldmlldywgdXNlLCBkaXNjbG9zdXJlIG9yIGRpc3RyaWJ1dGlvbgppcyBwcm9oaWJpdGVkLiAg
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhl
IHNlbmRlciBieQpyZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9mIHRoZSBvcmln
aW5hbCBtZXNzYWdlLgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
