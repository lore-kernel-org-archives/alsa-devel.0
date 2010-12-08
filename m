From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Fix possible sprintf
	overrun	in	snd_pcm_hw_open
Date: Wed, 08 Dec 2010 14:20:19 +0100
Message-ID: <4CFF8613.5070606@canonical.com>
References: <4CFF5AF3.5030103@canonical.com> <4CFF762A.9080501@ladisch.de>
	<4CFF8061.1040802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F594244B7
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:20:26 +0100 (CET)
In-Reply-To: <4CFF8061.1040802@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

T24gMjAxMC0xMi0wOCAxMzo1NiwgRGF2aWQgSGVubmluZ3Nzb24gd3JvdGU6Cj4gT24gMjAxMC0x
Mi0wOCAxMzoxMiwgQ2xlbWVucyBMYWRpc2NoIHdyb3RlOgo+PiBEYXZpZCBIZW5uaW5nc3NvbiB3
cm90ZToKPj4+IFBvc3NpYmxlIGJ1ZmZlciBvdmVycnVuIGlmIHRoZSBudW1iZXIgb2YgImNhcmQi
IGFuZCAiZGV2aWNlIgo+Pj4gYXJlIGFic3VyZGx5IGhpZ2gsIGVzcGVjaWFsbHkgb24gNjQtYml0
IHBsYXRmb3Jtcy4KPj4KPj4gVGhlIHNpemUgb2YgImludCIgaXMgMzIgYml0cyBldmVuIG9uIDY0
LWJpdCBwbGF0Zm9ybXMuCj4KPiBTZWVtcyB5b3UncmUgcmlnaHQsIHRoZW4gSSBsZWFybmVkIHNv
bWV0aGluZyBuZXcgdG9kYXkgOi0pCj4KPiBBbHRob3VnaCB0aGlzIG1pZ2h0IGJlIGNvbXBpbGVy
IGRlcGVuZGVudCwgYW5kIHNvbWUgZXhvdGljIHBsYXRmb3JtCj4gbWlnaHQgZGVjaWRlIG90aGVy
d2lzZSBpbiB0aGUgZnV0dXJlPwo+Cj4+IEFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZXJlIGlzIG5v
IGJ1Zy4KPgo+IEV2ZW4gZm9yIDMyLWJpdCBwbGF0Zm9ybXMsIHlvdSB3b3VsZCBzdGlsbCBvdmVy
cnVuIHRoZSBidWZmZXIgaWYgeW91IHNldAo+IGNhcmQgPSBkZXZpY2UgPSDiiJIyMTQ3NDgzNjQ3
Lgo+CgouLi5vciBtYXliZSBub3QsIGZvcmdvdCB0aGF0IHRoZSAlZCBjaGFyYWN0ZXJzIGFyZSBy
ZW1vdmVkLiBPaCB3ZWxsLCAKZG9lc24ndCBodXJ0IHRvIGNoYW5nZSBpdCBpbnRvIHNucHJpbnRm
IGFueXdheSA7LSkKCi0tIApEYXZpZCBIZW5uaW5nc3NvbiwgQ2Fub25pY2FsIEx0ZC4KaHR0cDov
L2xhdW5jaHBhZC5uZXQvfmRpd2ljCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
