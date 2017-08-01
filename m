From: Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Reset hw_ptr on resume
 trigger
Date: Tue, 1 Aug 2017 13:04:14 +0800
Message-ID: <60e20968-28b2-dd91-c30c-318aee9d298f@linux.intel.com>
References: <20170731104734.5776-1-cychiang@chromium.org>
 <20170801033006.GL3053@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 392E7266D44
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 06:59:40 +0200 (CEST)
In-Reply-To: <20170801033006.GL3053@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "U . Artie Eoff" <ullysses.a.eoff@intel.com>
List-Id: alsa-devel@alsa-project.org

Ck9uIDIwMTflubQwOOaciDAx5pelIDExOjMwLCBWaW5vZCBLb3VsIHdyb3RlOgo+IE9uIE1vbiwg
SnVsIDMxLCAyMDE3IGF0IDA2OjQ3OjM0UE0gKzA4MDAsIENoZW5nLVlpIENoaWFuZyB3cm90ZToK
Pj4gRnJvbTogIlUuIEFydGllIEVvZmYiIDx1bGx5c3Nlcy5hLmVvZmZAaW50ZWwuY29tPgo+Pgo+
PiBSZXNldCB0aGUgaHdfcHRyIGJlZm9yZSBxdWV1aW5nIHRoZSByZXN0b3JlX3N0cmVhbV9jb250
ZXh0Cj4+IHdvcmsgdG8gZXJhZGljYXRlIGEgbmFzdHkgd2hpdGUgYXVkaW8gbm9pc2Ugb24gcmVz
dW1lLgo+IAo+IExpYW0sIEppZT8gVGhpcyBvbiBsZWdhY3kgQllUIGRyaXZlci4uCj4gCj4+Cj4+
IFRlc3RlZC1ieTogQ2hlbmctWWkgQ2hpYW5nIDxjeWNoaWFuZ0BjaHJvbWl1bS5vcmc+Cj4+IFNp
Z25lZC1vZmYtYnk6IFUuIEFydGllIEVvZmYgPHVsbHlzc2VzLmEuZW9mZkBpbnRlbC5jb20+Cj4+
IFNpZ25lZC1vZmYtYnk6IENoZW5nLVlpIENoaWFuZyA8Y3ljaGlhbmdAY2hyb21pdW0ub3JnPgo+
PiAtLS0KPj4gICBzb3VuZC9zb2MvaW50ZWwvYmF5dHJhaWwvc3N0LWJheXRyYWlsLXBjbS5jIHwg
NCArKystCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ludGVsL2JheXRyYWlsL3NzdC1iYXl0cmFp
bC1wY20uYyBiL3NvdW5kL3NvYy9pbnRlbC9iYXl0cmFpbC9zc3QtYmF5dHJhaWwtcGNtLmMKPj4g
aW5kZXggNDc2NWFkNDc0NTQ0Li5lMGRiNzA3MGNkNDIgMTAwNjQ0Cj4+IC0tLSBhL3NvdW5kL3Nv
Yy9pbnRlbC9iYXl0cmFpbC9zc3QtYmF5dHJhaWwtcGNtLmMKPj4gKysrIGIvc291bmQvc29jL2lu
dGVsL2JheXRyYWlsL3NzdC1iYXl0cmFpbC1wY20uYwo+PiBAQCAtMTg3LDggKzE4NywxMCBAQCBz
dGF0aWMgaW50IHNzdF9ieXRfcGNtX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpz
dWJzdHJlYW0sIGludCBjbWQpCj4+ICAgCQlzc3RfYnl0X3N0cmVhbV9zdGFydChieXQsIHBjbV9k
YXRhLT5zdHJlYW0sIDApOwo+PiAgIAkJYnJlYWs7Cj4+ICAgCWNhc2UgU05EUlZfUENNX1RSSUdH
RVJfUkVTVU1FOgo+PiAtCQlpZiAocGRhdGEtPnJlc3RvcmVfc3RyZWFtID09IHRydWUpCj4+ICsJ
CWlmIChwZGF0YS0+cmVzdG9yZV9zdHJlYW0gPT0gdHJ1ZSkgewo+PiArCQkJcGNtX2RhdGEtPmh3
X3B0ciA9IDA7CgpXb24ndCB0aGlzIGJyZWFrIHRoZSBod19wdHIgYW5kIG1ha2UgdGhlIHJlc3Vt
aW5nIHdvbid0IHBsYXkgZnJvbSB0aGUgCnBhdXNpbmcgcG9pbnQgb2YgdGhlIGxhc3Qgc3VzcGVu
ZGluZz8KClRoYW5rcywKfktleW9uCgo+PiAgIAkJCXNjaGVkdWxlX3dvcmsoJnBjbV9kYXRhLT53
b3JrKTsKPj4gKwkJfQo+PiAgIAkJZWxzZQo+PiAgIAkJCXNzdF9ieXRfc3RyZWFtX3Jlc3VtZShi
eXQsIHBjbV9kYXRhLT5zdHJlYW0pOwo+PiAgIAkJYnJlYWs7Cj4+IC0tIAo+PiAyLjEyLjIKPj4K
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
