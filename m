From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 6/9] rate: handle negative values from
	snd_pcm_mmap_playback_hw_avail
Date: Tue, 16 Sep 2014 19:26:57 +0200
Message-ID: <541872E1.7020700@perex.cz>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>	<1410633021-20395-7-git-send-email-patrakov@gmail.com>	<s5hoauhw9oc.wl-tiwai@suse.de>	<5416B98D.3010505@gmail.com>
 <s5hbnqhw5pu.wl-tiwai@suse.de> <54185CD3.3030701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A46B261A7E
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 19:26:59 +0200 (CEST)
In-Reply-To: <54185CD3.3030701@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

RGF0ZSAxNi45LjIwMTQgMTc6NTIsIEFsZXhhbmRlciBFLiBQYXRyYWtvdiB3cm90ZToKPiAxNS4w
OS4yMDE0IDE2OjE0LCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4+IEF0IE1vbiwgMTUgU2VwIDIwMTQg
MTY6MDM6NTcgKzA2MDAsCj4+IEFsZXhhbmRlciBFLiBQYXRyYWtvdiB3cm90ZToKPj4+Cj4+PiAx
NS4wOS4yMDE0IDE0OjQ5LCBUYWthc2hpIEl3YWkg0L/QuNGI0LXRgjoKPj4+PiBBdCBTdW4sIDE0
IFNlcCAyMDE0IDAwOjMwOjE4ICswNjAwLAo+Pj4+IEFsZXhhbmRlciBFLiBQYXRyYWtvdiB3cm90
ZToKPj4+Pj4KPj4+Pj4gU3VjaCBuZWdhdGl2ZSByZXR1cm5zIGFyZSBwb3NzaWJsZSBkdXJpbmcg
YW4gdW5kZXJydW4gaWYgeHJ1biBkZXRlY3Rpb24KPj4+Pj4gaXMgZGlzYWJsZWQuCj4+Pj4+Cj4+
Pj4+IFNvLCBkb24ndCBzdG9yZSB0aGUgcmVzdWx0IGluIGFuIHVuc2lnbmVkIHZhcmlhYmxlICh3
aGVyZSBpdCB3aWxsCj4+Pj4+IG92ZXJmbG93KSwgYW5kIHBvc3Rwb25lIHRoZSB0cmlnZ2VyIGlu
IHN1Y2ggY2FzZSwgdG9vLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRS4g
UGF0cmFrb3YgPHBhdHJha292QGdtYWlsLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+Cj4+Pj4+IFRoZSBw
YXRjaCBpcyBvbmx5IGNvbXBpbGUtdGVzdGVkIGFuZCB0aGUgc2Vjb25kIGh1bmsgbWF5IHdlbGwg
YmUgd3JvbmcuCj4+Pj4+Cj4+Pj4+IFRoZXJlIGFyZSBhbHNvIHNpbWlsYXIgaXNzdWVzIGluIHBj
bV9zaGFyZS5jLCBidXQsIGFzIEkgZG9uJ3QgY29tcGxldGVseQo+Pj4+PiB1bmRlcnN0YW5kIHRo
ZSBjb2RlIHRoZXJlIGFuZCBjYW5ub3QgdGVzdCB0aGF0IHBsdWdpbiBhdCBhbGwgZHVlIHRvCj4+
Pj4+IHVucmVsYXRlZCBjcmFzaGVzLCB0aGVyZSB3aWxsIGJlIG5vIHBhdGNoIGZyb20gbWUuCj4+
Pj4KPj4+PiBJbiBnZW5lcmFsLCBod19hdmFpbCBtdXN0IG5vdCBiZSBuZWdhdGl2ZSBiZWZvcmUg
c3RhcnRpbmcgdGhlIHN0cmVhbS4KPj4+PiBJZiBpdCBpcywgdGhlbiBpdCBtZWFucyBtb3N0IGxp
a2VseSB0aGUgZHJpdmVyIHByb2JsZW0sIHNvIHdlIHNob3VsZAo+Pj4+IHJldHVybiBlcnJvciBp
bW1lZGlhdGVseSBpbnN0ZWFkLgo+Pj4KPj4+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4gV291bGQg
LUVCQURGRCBiZSBhIGNvcnJlY3QgZXJyb3IgY29kZSwgb3IgZG8geW91Cj4+PiB3YW50IHNvbWV0
aGluZyBkaWZmZXJlbnQ/IG9yIG1heWJlIGV2ZW4gYW4gYXNzZXJ0Pwo+Pgo+PiBJJ2QgdGFrZSBl
aXRoZXIgRVBJUEUgb3IgRUJBREZELgo+PiBBbiBhc3NlcnQgd291bGQgYmUgYW4gb3ZlcmtpbGws
IElNTy4KPiAKPiBJIGhhdmUgc2VudCB0aGUgZml4IHRvIHRoZSBsaXN0LCBidXQgbm9ib2R5IHJl
YWN0ZWQuIFJlc2VuZGluZyBhcyBhbiAKPiBhdHRhY2htZW50IHRvIHRoaXMgbWVzc2FnZS4KCkFw
cGxpZWQgbm93LiBUaGFua3MuCgogICAgICAgICAgICAgICAgICAgICAgICAgSmFyb3NsYXYKCj4g
Cj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+
IGh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCj4gCgoKLS0gCkphcm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+CkxpbnV4IEtlcm5l
bCBTb3VuZCBNYWludGFpbmVyCkFMU0EgUHJvamVjdDsgUmVkIEhhdCwgSW5jLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
