From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v2 1/2] ALSA: hda/hdmi - Read the pin sense
 from register when repolling
Date: Tue, 7 May 2019 07:29:47 +0800
Message-ID: <2738a3b7-168a-ccb2-eb2b-184c88477c65@canonical.com>
References: <20190506140932.7942-1-hui.wang@canonical.com>
 <s5himun4pu4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69759F89673
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 01:29:53 +0200 (CEST)
In-Reply-To: <s5himun4pu4.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ck9uIDIwMTkvNS82IOS4i+WNiDEwOjMxLCBUYWthc2hpIEl3YWkgd3JvdGU6Cj4gT24gTW9uLCAw
NiBNYXkgMjAxOSAxNjowOTozMSArMDIwMCwKPiBIdWkgV2FuZyB3cm90ZToKPj4gQEAgLTE2NjMs
NiArMTY2MywxMSBAQCBzdGF0aWMgdm9pZCBoZG1pX3JlcG9sbF9lbGQoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQo+PiAgIAljb250YWluZXJfb2YodG9fZGVsYXllZF93b3JrKHdvcmspLCBzdHJ1
Y3QgaGRtaV9zcGVjX3Blcl9waW4sIHdvcmspOwo+PiAgIAlzdHJ1Y3QgaGRhX2NvZGVjICpjb2Rl
YyA9IHBlcl9waW4tPmNvZGVjOwo+PiAgIAlzdHJ1Y3QgaGRtaV9zcGVjICpzcGVjID0gY29kZWMt
PnNwZWM7Cj4+ICsJc3RydWN0IGhkYV9qYWNrX3RibCAqamFjazsKPj4gKwo+PiArCWphY2sgPSBz
bmRfaGRhX2phY2tfdGJsX2dldChjb2RlYywgcGVyX3Bpbi0+cGluX25pZCk7Cj4+ICsJaWYgKGph
Y2spCj4+ICsJCWphY2sgPSBqYWNrLT5qYWNrX2RpcnR5ID0gMTsKPiBPaCwgYW5kIEkgY29ycmVj
dGVkIHRoZSBvYnZpb3VzIHR5cG8gYWJvdmUgbWFudWFsbHkgd2hpbGUgYXBwbHlpbmcuCj4gV2Ug
ZG9uJ3QgbmVlZCB0byBzdWJzdGl0dXRlIGphY2sgdHdpY2UuCgpPaCwgc29ycnkuCgo+Cj4KPiBU
YWthc2hpCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBBbHNhLWRldmVsIG1haWxpbmcgbGlzdAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+
IGh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1k
ZXZlbAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
