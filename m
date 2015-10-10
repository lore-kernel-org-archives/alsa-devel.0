From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Sat, 10 Oct 2015 23:24:13 +0200
Message-ID: <alpine.DEB.2.02.1510102321500.27509@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510100012390.7332@lnxricardw1.se.axis.com>
 <5618D0E1.1000308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id A49E3260536
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 23:24:15 +0200 (CEST)
In-Reply-To: <5618D0E1.1000308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ck9uIFNhdCwgMTAgT2N0IDIwMTUsIENsZW1lbnMgTGFkaXNjaCB3cm90ZToKCj4gSXQgd291bGQg
bm90IG1ha2Ugc2Vuc2UgdG8gaGF2ZSBhIHZhbHVlIHRoYXQgaXMgbm90IGEgbXVsdGlwbGUgb2Yg
dGhlCj4gZnJhbWUgc2l6ZS4gIChJJ20gbm90IHNheWluZyB0aGF0IGl0IGRvZXNuJ3Qgb2NjdXIg
aW4gcHJhY3RpY2UgLi4uKQoKWWVzLCBJIGp1c3Qgbm90ZWQgdGhhdCB0aGUgRWRpcm9sIFVBLTUg
aGFzIGEgbWF4IHBhY2tldCBzaXplIG9mIDYwOCwgd2hpY2ggCmlzIG5vdCBldmVubHkgZGl2aXNp
YmxlIGJ5IHRoZSBmcmFtZSBzaXplIG9mIDYgKGFkdmFuY2VkIG1vZGU6IDMgYnl0ZXMgcGVyIApz
YW1wbGUsIHN0ZXJlbykuCgovUmljYXJkCi0tIApSaWNhcmQgV29sZiBXYW5kZXJsw7ZmICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmljYXJkdyhhdClheGlzLmNvbQpBeGlzIENvbW11bmljYXRp
b25zIEFCLCBMdW5kLCBTd2VkZW4gICAgICAgICAgICB3d3cuYXhpcy5jb20KUGhvbmUgKzQ2IDQ2
IDI3MiAyMDE2ICAgICAgICAgICAgICAgICAgICAgICAgICAgRmF4ICs0NiA0NiAxMyA2MSAzMApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
