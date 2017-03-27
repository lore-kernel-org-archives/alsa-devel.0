From: Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: remove unused variable data
 and associated code
Date: Mon, 27 Mar 2017 17:41:29 +0800
Message-ID: <58D8DE49.5030306@linux.intel.com>
References: <20170322143644.29051-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D597626648D
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 11:37:54 +0200 (CEST)
In-Reply-To: <20170322143644.29051-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDIwMTflubQwM+aciDIy5pelIDIyOjM2LCBDb2xpbiBLaW5nIHdyb3RlOgo+IEZyb206IENv
bGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4KPiBUaGUgdmFyaWFibGUg
J2RhdGEnIGlzIGFzc2lnbmVkIG51bGwgYW5kIG5ldmVyIHJlLWFzc2lnbmVkLiBUaGVyZQo+IGlz
IGFsc28gYSByZWR1bmRhbnQgY2hlY2sgZm9yIGRhdGEgYmVpbmcgbm9uLW51bGwgd2hpY2ggaXMg
YWx3YXlzCj4gZmFsc2UsIHNvIHJlbW92ZSB0aGlzIGFuZCB0aGUgdmFyaWFibGUgZGF0YSBhbmQg
ZG1hX2FkZHIgYXMgdGhleQo+IGFyZSBub3QgdXNlZCBvbmNlIHRoZSBkZWFkIGNvZGUgaGFzIGJl
ZW4gcmVtb3ZlZC4KPgo+IERldGVjdGVkIHdpdGggQ292ZXJpdHlTY2FuLCBDSUQjMTMyNDAxNSAo
IidDb25zdGFudCcgdmFyaWFibGUgZ2F1cmRzCj4gZGVhZCBjb2RlIikKPgo+IFNpZ25lZC1vZmYt
Ynk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+CgpUaGFuayB5b3Ug
Zm9yIGZpeGluZyBpdC4KCkFja2VkLWJ5OiBKaWUgWWFuZyA8eWFuZy5qaWVAaW50ZWwuY29tPgoK
dGhhbmtzLAp+S2V5b24KCj4gLS0tCj4gICBzb3VuZC9zb2MvaW50ZWwvaGFzd2VsbC9zc3QtaGFz
d2VsbC1pcGMuYyB8IDYgLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvaW50ZWwvaGFzd2VsbC9zc3QtaGFzd2VsbC1pcGMu
YyBiL3NvdW5kL3NvYy9pbnRlbC9oYXN3ZWxsL3NzdC1oYXN3ZWxsLWlwYy5jCj4gaW5kZXggYTM0
NTlkMTY4MmE2Li5kMzNiZGFmOTJjNTcgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL2ludGVsL2hh
c3dlbGwvc3N0LWhhc3dlbGwtaXBjLmMKPiArKysgYi9zb3VuZC9zb2MvaW50ZWwvaGFzd2VsbC9z
c3QtaGFzd2VsbC1pcGMuYwo+IEBAIC0yMDAwLDEwICsyMDAwLDggQEAgaW50IHNzdF9oc3dfbW9k
dWxlX3NldF9wYXJhbShzdHJ1Y3Qgc3N0X2hzdyAqaHN3LAo+ICAgCXUzMiBwYXJhbV9zaXplLCBj
aGFyICpwYXJhbSkKPiAgIHsKPiAgIAlpbnQgcmV0Owo+IC0JdW5zaWduZWQgY2hhciAqZGF0YSA9
IE5VTEw7Cj4gICAJdTMyIGhlYWRlciA9IDA7Cj4gICAJdTMyIHBheWxvYWRfc2l6ZSA9IDAsIHRy
YW5zZmVyX3BhcmFtZXRlcl9zaXplID0gMDsKPiAtCWRtYV9hZGRyX3QgZG1hX2FkZHIgPSAwOwo+
ICAgCXN0cnVjdCBzc3RfaHN3X3RyYW5zZmVyX3BhcmFtZXRlciAqcGFyYW1ldGVyOwo+ICAgCXN0
cnVjdCBkZXZpY2UgKmRldiA9IGhzdy0+ZGV2Owo+Cj4gQEAgLTIwNDcsMTAgKzIwNDUsNiBAQCBp
bnQgc3N0X2hzd19tb2R1bGVfc2V0X3BhcmFtKHN0cnVjdCBzc3RfaHN3ICpoc3csCj4KPiAgIAlr
ZnJlZShwYXJhbWV0ZXIpOwo+Cj4gLQlpZiAoZGF0YSkKPiAtCQlkbWFfZnJlZV9jb2hlcmVudCho
c3ctPmRzcC0+ZG1hX2RldiwKPiAtCQkJcGFyYW1fc2l6ZSwgKHZvaWQgKilkYXRhLCBkbWFfYWRk
cik7Cj4gLQo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4KPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
