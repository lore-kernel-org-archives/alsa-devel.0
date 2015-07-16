From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for
	max98090 codec
Date: Thu, 16 Jul 2015 19:20:52 +0800
Message-ID: <55A79394.5090905@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.131])
 by alsa0.perex.cz (Postfix) with ESMTP id E1DCE260561
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 13:27:01 +0200 (CEST)
In-Reply-To: <1437033944.27428.11.camel@tiscali.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dianders@chromium.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, dgreid@chromium.org, sonnyrao@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgUGF1bCwKICAgICBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuCgpPbiAyMDE15bm0MDfmnIgx
NuaXpSAxNjowNSwgUGF1bCBCb2xsZSB3cm90ZToKPiBPbiB3bywgMjAxNS0wNy0xNSBhdCAxMTox
NSArMDgwMCwgWGluZyBaaGVuZyB3cm90ZToKPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIHJvY2tjaGlwX21heDk4MDkwX29mX21hdGNoW10gPSB7Cj4+ICsJeyAuY29tcGF0aWJs
ZSA9ICJyb2NrY2hpcCxyb2NrY2hpcC1hdWRpby1tYXg5ODA5MCIsIH0sCj4+ICsJe30sCj4+ICt9
Owo+PiArCj4+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzbmRfcmtfbWNfZHJpdmVy
ID0gewo+PiArCS5wcm9iZSA9IHNuZF9ya19tY19wcm9iZSwKPj4gKwkucmVtb3ZlID0gc25kX3Jr
X21jX3JlbW92ZSwKPj4gKwkuZHJpdmVyID0gewo+PiArCQkubmFtZSA9IERSVl9OQU1FLAo+PiAr
CQkub3duZXIgPSBUSElTX01PRFVMRSwKPj4gKwkJLnBtID0mc25kX3NvY19wbV9vcHMsCj4+ICsJ
CS5vZl9tYXRjaF90YWJsZSA9IHJvY2tjaGlwX21heDk4MDkwX29mX21hdGNoLAo+PiArCX0sCj4+
ICt9Owo+PiArCj4+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKHNuZF9ya19tY19kcml2ZXIpOwo+
IE5pdDogZW1wdHkgbGluZSBoZXJlLgpEb25lLgo+Cj4+ICtNT0RVTEVfQVVUSE9SKCJqaWFucXVu
PGpheS54dUByb2NrLWNoaXBzLmNvbT4iKTsKPj4gK01PRFVMRV9ERVNDUklQVElPTigiUm9ja2No
aXAgbWF4OTgwOTAgbWFjaGluZSBBU29DIGRyaXZlciIpOwo+PiArTU9EVUxFX0xJQ0VOU0UoIkdQ
TCB2MiIpOwo+PiArTU9EVUxFX0FMSUFTKCJwbGF0Zm9ybToiIERSVl9OQU1FKTsKPiBUaGlzIHNl
ZW1zIG9ubHkgdXNlZnVsIGlmIHRoZXJlJ3MgYSBjb3JyZXNwb25kaW5nIHN0cnVjdAo+IHBsYXRm
b3JtX2RldmljZS4gSWUsIGEgcGxhdGZvcm1fZGV2aWNlIHdpdGggYSAicm9ja2NoaXAtc25kLW1h
eDk4MDkwIgo+IC5uYW1lLCB3aGljaCB3aWxsIHRyaWdnZXIgYSAiTU9EQUxJQVM9cGxhdGZvcm06
cm9ja2NoaXAtc25kLW1heDk4MDkwIgo+IHVldmVudCB3aGVuIGl0J3MgY3JlYXRlZC4gQnV0IEkg
Y291bGRuJ3QgZmluZCB3aGVyZSBzdWNoIGEKPiBwbGF0Zm9ybV9kZXZpY2UgaXMgY3JlYXRlZC4K
Pgo+IERpZCBJIG1pc3Mgc29tZXRoaW5nPyBPciBpcyB0aGVyZSBhbm90aGVyIHdheSB0aGlzIGFs
aWFzIGlzIHVzZWZ1bCBoZXJlPwpZZXMsIEkgZGlkbid0IGNhcmUgYWJvdXQgdGhpcyBidXQgSSB0
aGluayBpdCBtYXliZSBjb3JyZWN0Lgo+PiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgcm9ja2No
aXBfbWF4OTgwOTBfb2ZfbWF0Y2gpOwo+IFRoZSBjb21tb24gcGF0dGVybiBpcyB0byBwdXQgTU9E
VUxFX0RFVklDRV9UQUJMRSgpIGRpcmVjdGx5IGFmdGVyIHRoZQo+IHRhYmxlIGl0IGV4cG9ydHMu
CkRvbmUuCj4gTGlrZXdpc2UgZm9yIDIvMiAoZXhjZXB0IHRoZSBlbXB0eSBsaW5lIG5pdCwgdGhh
dCBpcykuCk9LLCBkb25lLgoKPiBUaGFua3MsCj4KPgo+IFBhdWwgQm9sbGUKPgo+Cj4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxz
YS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
