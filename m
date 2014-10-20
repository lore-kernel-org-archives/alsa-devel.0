From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 2/2] ASoC: fsl: use strncpy() to prevent
 copying of over-long names
Date: Mon, 20 Oct 2014 07:55:22 +0200
Message-ID: <5444A3CA.3030008@topic.nl>
References: <1413702456-8624-1-git-send-email-daniel@zonque.org>
 <1413702456-8624-3-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.mer-nm.internl.net (smtp103.mer-nm.internl.net
 [217.149.192.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 30C732606A5
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 07:55:25 +0200 (CEST)
Received: from amavisd-new (mailscanner06.wrt-nm.internl.net [217.149.192.58])
 by smtp103.mer-nm.internl.net (Postfix) with ESMTP id 771A53F76A
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 07:55:24 +0200 (CEST)
Received: from smtp103.mer-nm.internl.net ([217.149.192.139])
 by amavisd-new (mailscanner06.wrt-nm.internl.net [217.149.192.160])
 (amavisd-new, port 10024)
 with ESMTP for <alsa-devel@alsa-project.org>;
 Mon, 20 Oct 2014 07:55:24 +0200 (CEST)
Received: from TOP-EX01.TOPIC.LOCAL (mail.topic.nl [82.204.13.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by smtp103.mer-nm.internl.net (Postfix) with ESMTPS
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 07:55:23 +0200 (CEST)
In-Reply-To: <1413702456-8624-3-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

77u/VGhpcyBoYXJkbHkgaW1wcm92ZXMgbWF0dGVycy4gV2hlbiB0aGUgc291cmNlIHN0cmluZyBp
cyBsYXJnZXIgdGhhbiB0aGUgCmJ1ZmZlciwgdGhlIGRlc3RpbmF0aW9uIG1heSBub3QgYmUgbnVs
LXRlcm1pbmF0ZWQuCkFsc28sIHN0cm5jcHkgQUxXQVlTIHdyaXRlcyB0aGUgZnVsbCBidWZmZXIg
c28gaXQgbWF5IGJlIHdhc3RpbmcgY3ljbGVzIHdoZW4gCnRoZSBkZXN0aW5hdGlvbiBidWZmZXIg
aXMgbGFyZ2UuCgpJJ20gc3VyZSB0aGUga2VybmVsIG9mZmVycyBhIGJldHRlciBhbHRlcm5hdGl2
ZS4gRXZlbiAic25wcmludGYiIGlzIGEgYmV0dGVyIAphbHRlcm5hdGl2ZS4KCk1pa2UuCgoKT24g
MTAvMTkvMjAxNCAwOTowNyBBTSwgRGFuaWVsIE1hY2sgd3JvdGU6Cj4gVXNlIHN0cm5jcHkoKSBp
bnN0ZWFkIG9mIHN0cmNweSgpLiBUaGF0J3Mgbm90IGEgc2VjdXJpdHkgaXNzdWUsIGFzIHRoZQo+
IHNvdXJjZSBidWZmZXIgaXMgdGFrZW4gZnJvbSBEVCBub2RlcywgYnV0IHdlIHNob3VsZCBzdGls
bCBlbmZvcmNlIGJvdW5kCj4gY2hlY2tzLiBTcG90dGVkIGJ5IENvdmVyaXR5Lgo+Cj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIE1hY2sgPGRhbmllbEB6b25xdWUub3JnPgo+IC0tLQo+ICAgc291bmQv
c29jL2ZzbC9mc2xfYXNyYy5jIHwgMiArLQo+ICAgc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jIHwg
MiArLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfYXNyYy5jIGIvc291bmQvc29jL2Zz
bC9mc2xfYXNyYy5jCj4gaW5kZXggODIyMTEwNC4uZGQwMGI5ZCAxMDA2NDQKPiAtLS0gYS9zb3Vu
ZC9zb2MvZnNsL2ZzbF9hc3JjLmMKPiArKysgYi9zb3VuZC9zb2MvZnNsL2ZzbF9hc3JjLmMKPiBA
QCAtNzkyLDcgKzc5Miw3IEBAIHN0YXRpYyBpbnQgZnNsX2FzcmNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPiAgIAkJcmV0dXJuIC1FTk9NRU07Cj4KPiAgIAlhc3JjX3ByaXYt
PnBkZXYgPSBwZGV2Owo+IC0Jc3RyY3B5KGFzcmNfcHJpdi0+bmFtZSwgbnAtPm5hbWUpOwo+ICsJ
c3RybmNweShhc3JjX3ByaXYtPm5hbWUsIG5wLT5uYW1lLCBzaXplb2YoYXNyY19wcml2LT5uYW1l
KSAtIDEpOwo+Cj4gICAJLyogR2V0IHRoZSBhZGRyZXNzZXMgYW5kIElSUSAqLwo+ICAgCXJlcyA9
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7Cj4gZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWkuYyBiL3NvdW5kL3NvYy9mc2wvZnNsX2VzYWku
Ywo+IGluZGV4IGEzYjI5ZWQuLmZkYTFkNDYgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL2ZzbC9m
c2xfZXNhaS5jCj4gKysrIGIvc291bmQvc29jL2ZzbC9mc2xfZXNhaS5jCj4gQEAgLTcyOSw3ICs3
MjksNyBAQCBzdGF0aWMgaW50IGZzbF9lc2FpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+Cj4gICAJZXNhaV9wcml2LT5wZGV2ID0gcGRl
djsKPiAtCXN0cmNweShlc2FpX3ByaXYtPm5hbWUsIG5wLT5uYW1lKTsKPiArCXN0cm5jcHkoZXNh
aV9wcml2LT5uYW1lLCBucC0+bmFtZSwgc2l6ZW9mKGVzYWlfcHJpdi0+bmFtZSkgLSAxKTsKPgo+
ICAgCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJiaWctZW5kaWFuIikpCj4gICAJCWZz
bF9lc2FpX3JlZ21hcF9jb25maWcudmFsX2Zvcm1hdF9lbmRpYW4gPSBSRUdNQVBfRU5ESUFOX0JJ
RzsKPgoKCgpNZXQgdnJpZW5kZWxpamtlIGdyb2V0IC8ga2luZCByZWdhcmRzLAoKTWlrZSBMb29p
am1hbnMKClRPUElDIEVtYmVkZGVkIFN5c3RlbXMKRWluZGhvdmVuc2V3ZWcgMzItQywgTkwtNTY4
MyBLSCBCZXN0ClBvc3RidXMgNDQwLCBOTC01NjgwIEFLIEJlc3QKVGVsZWZvb246ICgrMzEpICgw
KSA0OTkgMzMgNjkgNzkKVGVsZWZheDogICgrMzEpICgwKSA0OTkgMzMgNjkgNzAKRS1tYWlsOiBt
aWtlLmxvb2lqbWFuc0B0b3BpYy5ubApXZWJzaXRlOiB3d3cudG9waWMubmwKClBsZWFzZSBjb25z
aWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsCgpUb3BpYyB6
b2VrdCBnZWRyZXZlbiAoZW1iZWRkZWQpIHNvZnR3YXJlIHNwZWNpYWxpc3RlbiEKaHR0cDovL3Rv
cGljLm5sL3ZhY2F0dXJlcy90b3BpYy16b2VrdC1zb2Z0d2FyZS1lbmdpbmVlcnMvCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
