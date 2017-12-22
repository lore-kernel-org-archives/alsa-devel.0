From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 0/4] pcm: minor code cleanup
Date: Fri, 22 Dec 2017 11:06:43 +0900
Message-ID: <4af15937-59bf-291d-61a4-5d1afd994dd9@sakamocchi.jp>
References: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
 <s5h1sjo9m16.wl-tiwai@suse.de>
 <7514db92-4dc2-aeec-bcf5-1193f5342e94@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 02186266D61
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 03:06:46 +0100 (CET)
In-Reply-To: <7514db92-4dc2-aeec-bcf5-1193f5342e94@sakamocchi.jp>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gRGVjIDIyIDIwMTcgMDg6MjUsIFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4gSGksCj4gCj4g
T24gRGVjIDIxIDIwMTcgMjM6NDYsIFRha2FzaGkgSXdhaSB3cm90ZToKPj4gT24gV2VkLCAyMCBE
ZWMgMjAxNyAxODoxNjo1OSArMDEwMCwKPj4gVGFrYXNoaSBTYWthbW90byB3cm90ZToKPj4+Cj4+
PiBIaSwKPj4+Cj4+PiBXaGVuIHJldmlld2luZyBNYWNpZWoncyBwYXRjaGVzWzFdLCBJIGZvdW5k
IHRoYXQgYWxzYS1saWIgaW5jbHVkZXMgc29tZQo+Pj4gdW51c2VkIGNvZGVzIGluIGxpbmVhciBp
bnRlcnBvbGF0aW9uIGZ1bmN0aW9uYWxpdHkuIEZ1cnRoZXJtb3JlLCBzb21lIAo+Pj4gY29kZQo+
Pj4gY29tbWVudHMgaW5jbHVkZXMgJ2NvcHkgJiBwYXN0ZScgbWlzdGFrZXMuCj4+Pgo+Pj4gVGhp
cyBwYXRjaHNldCBpbXByb3ZlcyB0aGVtLgo+Pj4KPj4+IFsxXSAKPj4+IGh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvcGlwZXJtYWlsL2Fsc2EtZGV2ZWwvMjAxNy1EZWNlbWJlci8xMjkz
NzAuaHRtbCAKPj4+Cj4+Pgo+Pj4gVGFrYXNoaSBTYWthbW90byAoNCk6Cj4+PiDCoMKgIHBjbTog
cmVtb3ZlIHVudXNlZCBtYWNyb3Mgb2YgQ09QWV9MQUJFTFMvQ09QWV9FTkQKPj4+IMKgwqAgcGNt
OiByZW1vdmUgdW51c2VkIG1hY3JvcyBvZiBHRVRVX0xBQkVMUy9HRVRVX0VORAo+Pj4gwqDCoCBw
Y206IHJlbW92ZSB1bnVzZWQgbWFjcm9zIG9mIE5PUk1TX0xBQkVMUy9OT1JNU19FTkQKPj4+IMKg
wqAgcGNtOiBmaXggd3JvbmcgY29tbWVudHMgZm9yIHNvbWUgY2FzZXMgb2YgbGluZWFyIGludGVy
cG9sYXRpb24gb2YgUENNCj4+PiDCoMKgwqDCoCBzYW1wbGVzCj4+Cj4+IEFsbCBwYXRjaGVzIHNl
ZW0gbWlzc2luZyB5b3VyIHNpZ24tb2ZmLgo+PiBJdCdzIG5vdCBtYW5kYXRvcnkgZm9yIGFsc2Et
bGliLCBidXQgcHJlZmVyYWJsZS7CoCBXb3VsZCB5b3UgbGlrZSBtZQo+PiBhZGRpbmcgdGhlbSBt
YW51YWxseT8KPiAKPiBPb3BzLi4uIFllcywgcGxlYXNlLgo+IChJIHNob3VsZCBoYXZlIGEgc2Ny
aXB0IHRvIGNoZWNrIGl0IGJlZm9yZSBwb3N0aW5nLi4uKQoKU2lnbmVkLW9mZi1ieTogVGFrYXNo
aSBTYWthbW90byA8by10YWthc2hpQHNha2Ftb2NjaGkuanA+CgoKUmVnYXJkcwoKVGFrYXNoaSBT
YWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
