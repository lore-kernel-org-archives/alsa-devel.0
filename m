From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: NULL pointer dereference in ALSA triggered	through
 saa7134-alsa
Date: Mon, 10 Aug 2009 18:42:20 +0300
Message-ID: <4A803FDC.8070005@pardus.org.tr>
References: <4A8025BF.7030404@pardus.org.tr> <s5hab27n501.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A1EC8247D4
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 17:42:23 +0200 (CEST)
In-Reply-To: <s5hab27n501.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

VGFrYXNoaSBJd2FpIHdyb3RlOgo+IEF0IE1vbiwgMTAgQXVnIDIwMDkgMTY6NTA6NTUgKzAzMDAs
Cj4gT3phbiDDh2HEn2xheWFuIHdyb3RlOgo+ICAgCj4+IEhpLAo+Pgo+PiBJJ3ZlIGZpbmFsbHkg
c3VjY2VzZnVsbHkgY29tcGlsZWQgYW5kIGxpbmtlZCBzYWE3MTM0LWFsc2EgZHJpdmVyIHVzaW5n
Cj4+IGFuIGV4dGVybmFsIGFsc2EtZHJpdmVyIGFuZCBpdHMgTW9kdWxlLnN5bXZlcnMgZmlsZS4g
RXZlcnl0aGluZyBzZWVtcwo+PiBva2F5LCBubyB1bmRlZmluZWQgc3ltYm9sIG9yIHNvbWV0aGlu
ZyBlbHNlOgo+Pgo+PiAtIEFuIGluc3RhbGxlZCAyLjYuMzAuNCBrZXJuZWwgd2hpY2ggb25seSBi
dWlsZHMgYW5kIGJyaW5ncyBzb3VuZGNvcmUKPj4gYW5kIHNvdW5kX2Zpcm13YXJlLAo+PiAtIExh
dGVzdCBhbHNhLWRyaXZlciBidWlsdCBleHRlcm5hbGx5IGFuZCBpbnN0YWxsZWQsCj4+IC0gTGF0
ZXN0IHNhYTcxMzQtYWxzYSwgY3g4OC1hbHNhLCBldGMuIGNvZGUgZnJvbSBsaW51cy0yLjYgKHNl
ZW4gdGhhdAo+PiB0aGV5IGRvbid0IGFmZmVjdGVkIGJ5IHNvbWUgQVBJL0FCSSBjaGFuZ2VzKSBw
YXRjaGVkIG9uIHRvcCBvZiB0aGUKPj4gYWxzYS1kcml2ZXIgdGFyYmFsbCwKPj4gICAgIAo+Cj4g
VGhlIGV4dGVybmFsIGRyaXZlcnMgdXNpbmcgQUxTQSBBUEkgaGF2ZSB0byBiZSBidWlsdCB3aXRo
IHRoZQo+IG5ld2VyIEFMU0EgaGVhZGVyIGZpbGVzIGZyb20gYWxzYS1kcml2ZXIgdHJlZS4gIEl0
J3Mgbm90IGVub3VnaCB0bwo+IGNoYW5nZSBzbmRfY2FyZF9uZXcoKSB3aXRoIHNuZF9jYXJkX2Ny
ZWF0ZSgpLiAgVGhlIGNvcmUgc3RydWN0dXJlCj4gd2FzIGNoYW5nZWQsIHNvIHRoZSB3aG9sZSBi
dWlsZCBoYXMgdG8gYmUgYWRqdXN0ZWQsIHRvby4KPiAgIApBY3R1YWxseSB0aGF0IHdhcyB0aGUg
MHRoIHN0ZXAgdGhhdCBJIGZvcmdvdCB0byBtZW50aW9uLiBJJ20gaW5zdGFsbGluZwp0aGUgaGVh
ZGVycyBmcm9tIHRoZSBhbHNhLWRyaXZlciBzbmFwc2hvdCBpbnRvIC91c3IvaW5jbHVkZS9zb3Vu
ZCBhbmQKdGhlbiBJIGJ1aWxkIGFsc2EtZHJpdmVyLiBUaGVuIEkgdXNlIHRoZSBzeW12ZXJzIGZy
b20gdGhlIGFsc2EtZHJpdmVyCmJ1aWxkIGFsbHRvZ2V0aGVyIHdpdGggdGhlIGhlYWRlcnMgdGhh
dCBJJ3ZlIGFscmVhZHkgaW5zdGFsbGVkIGludG8KL3Vzci9pbmNsdWRlL3NvdW5kIHRvIGJ1aWxk
IHRoZSBWNEwgb25lcy4KClNvcnJ5IElmIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBzYWlkIHdyb25n
bHkuCgpUaGFua3MsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZl
bAo=
