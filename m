From: Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH v3 02/11] ASoC: tlv320aic32x4: Model PLL in
 CCF
Date: Thu, 21 Mar 2019 09:12:05 -0700
Message-ID: <E298AB4E-9154-4E99-8FA8-22CE3BDBDB9D@nh6z.net>
References: <20190321023854.16947-1-nh6z@nh6z.net>
 <20190321023854.16947-3-nh6z@nh6z.net> <20190321151208.GA24351@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.100.42\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp64.iad3a.emailsrvr.com (smtp64.iad3a.emailsrvr.com
 [173.203.187.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15C0AF8986C
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 17:12:09 +0100 (CET)
In-Reply-To: <20190321151208.GA24351@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org

Cgo+IE9uIE1hciAyMSwgMjAxOSwgYXQgODoxMiBBTSwgTWFyayBCcm93biA8YnJvb25pZUBrZXJu
ZWwub3JnPiB3cm90ZToKPiAKPiBPbiBXZWQsIE1hciAyMCwgMjAxOSBhdCAwNzozODo0NVBNIC0w
NzAwLCBBbm5hbGllc2UgTWNEZXJtb25kIHdyb3RlOgo+PiBNb2RlbCBhbmQgbWFuYWdlIHRoZSBv
bi1ib2FyZCBQTEwgYXMgYSBjb21wb25lbnQgaW4gdGhlIENvcmUKPj4gQ2xvY2sgRnJhbWV3b3Jr
LiAgVGhpcyBzaG91bGQgYWxsb3cgdXMgdG8gZG8gc29tZSBtb3JlIGNvbXBsZXgKPj4gY2xvY2sg
bWFuYWdlbWVudCBhbmQgcG93ZXIgY29udHJvbC4gIEFsc28sIHNvbWUgb2YgdGhlCj4+IG9uLWJv
YXJkIGNoaXAgY2xvY2tzIGNhbiBiZSBleHBvc2VkIHRvIHRoZSBvdXRzaWRlLCBhbmQgdGhpcwo+
PiBjaGFuZ2Ugd2lsbCBtYWtlIHRob3NlIGNsb2NrcyBlYXNpZXIgdG8gY29uc3VtZSBieSBvdGhl
cgo+PiBwYXJ0cyBvZiB0aGUga2VybmVsLgo+IAo+IFRoaXMgZG9lc24ndCBhcHBseSBhZ2FpbnN0
IGN1cnJlbnQgY29kZSwgcGxlYXNlIGNoZWNrIGFuZCByZXNlbmQ6Cj4gCj4gQXBwbHlpbmc6IEFT
b0M6IHRsdjMyMGFpYzMyeDQ6IE1vZGVsIFBMTCBpbiBDQ0YKPiBVc2luZyBpbmRleCBpbmZvIHRv
IHJlY29uc3RydWN0IGEgYmFzZSB0cmVlLi4uCj4gTQlzb3VuZC9zb2MvY29kZWNzL0tjb25maWcK
PiBNCXNvdW5kL3NvYy9jb2RlY3MvTWFrZWZpbGUKPiBlcnJvcjogcGF0Y2ggZmFpbGVkOiBzb3Vu
ZC9zb2MvY29kZWNzL3RsdjMyMGFpYzMyeDQuYzo3MjIKPiBlcnJvcjogc291bmQvc29jL2NvZGVj
cy90bHYzMjBhaWMzMng0LmM6IHBhdGNoIGRvZXMgbm90IGFwcGx5Cj4gZXJyb3I6IERpZCB5b3Ug
aGFuZCBlZGl0IHlvdXIgcGF0Y2g/Cj4gSXQgZG9lcyBub3QgYXBwbHkgdG8gYmxvYnMgcmVjb3Jk
ZWQgaW4gaXRzIGluZGV4Lgo+IAo+IEkgYWxzbyBoYWQgdG8gYXBwbHkgdGhlIGZpcnN0IHBhdGNo
IGZvciAtbmV4dCBzaW5jZSBpdCBzZWVtcyB0byBkZXBlbmQKPiBvbiBvdGhlciBjaGFuZ2VzLCBs
aWtlIHlvdSBzYWlkIGl0J3Mgbm90IGEgc3VwZXIgaW1wb3J0YW50IGZpeCBzbyB0aGF0J3MKPiBu
byBiaWcgZGVhbC4KClRoYXTigJlzIGZ1bm55LiAgSSBqdXN0IGNoZWNrZWQgYW5kIEnigJltIHJl
YmFzZWQgYWdhaW5zdCBmb3ItbmV4dC4gIFRoZQpwYXRjaGVzIGFyZSBnZW5lcmF0ZWQgd2l0aCBn
aXQgcHJlcGFyZS1wYXRjaC4gIFRoZXnigJlyZSBhcHBseWluZyBvbgp0b3Agb2YgZTM5MGM0NmZh
Zi4KCgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiBo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwKCi0tCkFubmFsaWVzZSBNY0Rlcm1vbmQKbmg2ekBuaDZ6Lm5ldApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
