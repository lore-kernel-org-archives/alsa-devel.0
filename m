From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Fri, 12 Apr 2013 23:19:15 +0400
Message-ID: <51685E33.4080401@list.ru>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130412181943.0338083b@stas> <516824B4.20802@gmail.com>
 <51682633.70008@list.ru> <516828C7.5090203@metafoo.de>
 <20130412203716.0a203b69@stas> <51683C7F.6080803@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
 by alsa0.perex.cz (Postfix) with ESMTP id AE6642616DB
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 21:20:48 +0200 (CEST)
In-Reply-To: <51683C7F.6080803@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

MTIuMDQuMjAxMyAyMDo1NSwgTGFycy1QZXRlciBDbGF1c2VuINC/0LjRiNC10YI6Cj4gT24gMDQv
MTIvMjAxMyAwNjozNyBQTSwgU3RhcyBTZXJnZWV2IHdyb3RlOgo+PiBUaGFua3MgZm9yIGFuIGV4
cGxhbmF0aW9uIQo+PiBCdXQgd2hhdCBoYXBwZW5zIHdoZW4gdGhlIERBSSBpcyBjb25zaWRlcmVk
IG11dGUKPj4gYnkgdGhlIGVmZmVjdCBvZiBzdWNoIGludGVyc2VjdGlvbj8KPj4gIEZyb20gd2hh
dCBJIGNhbiBzZWUsIG5vIGNhbGxiYWNrcyBmcm9tIHRoZSBEQUkgZHJpdmVyCj4+IGFyZSBjYWxs
ZWQgaW4gdGhpcyBjYXNlICh0aGlzIGlzIGV4cGVjdGVkKSwgYnV0IG5vCj4+IGVycm9yIGlzIHJl
dHVybmVkIHRvIHVzZXJzcGFjZSwgYW5kLCBtb3JlIGltcG9ydGFudGx5LAo+PiB0aGUgcGxheWJh
Y2sgc3BlZWQgaXMgc3RpbGwgY29ycmVjdCwgc28gdGhlIHVzZXJzcGFjZQo+PiBjYW4gZ2V0IGEg
cGxheWJhY2sgcG9zaXRpb24gYXMgaWYgdGhlIHBsYXliYWNrIGlzIGZpbmUuCj4+IFdoaWxlIGR1
cmluZyB0aGUgbm9ybWFsIHBsYXliYWNrLCBpZiBJIHN0b3AgY2FsbGluZwo+PiBzbmRfcGNtX3Bl
cmlvZF9lbGFwc2VkKCksIHVzZXJzcGFjZSBpcyBubyBsb25nZXIgZ2V0dGluZwo+PiB0aGUgcmln
aHQgcG9zaXRpb24uCj4+IFRoYXQncyB3aHkgSSBhbSBjb25mdXNlZCwgSSBjYW4ndCBlYXNpbHkg
ZXhwbGFpbiB0aGlzCj4+ICJubyBzb3VuZCBidXQgb3RoZXJ3aXNlIGZpbmUgcGxheWJhY2siIGVm
ZmVjdCwgc28gSSBhbQo+PiBhIGJpdCByZWx1Y3RhbnQgdG8gdHJ5IGV4cGxhaW5pbmcgdGhpcyBp
biBhIGNvbW1pdCBtc2cuCj4+IEFyZSB0aGVyZSBhcmUgc29tZSBmYWxsYmFja3M/IFN1Y2ggYXMg
d2hlbiB0aGUgREFJIGlzCj4+IGNvbnNpZGVyZWQgbXV0ZSwgaXQgZ2V0cyBzb21laG93IGVtdWxh
dGVkLCB3aXRoIHRoZSB1c2UKPj4gb2YgdGhlIHN5c3RlbSBjbG9jayBmb3IgY29ycmVjdCB0aW1p
bmcgZXRjPwo+IFRoYXQncyBhY3R1YWxseSBhIGJpdCBzdHJhbmdlIGluZGVlZCwgc2luY2UgeW91
IHNob3VsZCBnZXQgYW4gZXJyb3Igd2hlbiB5b3UKPiB0cnkgdG8gb3BlbiB0aGUgcGNtIGRldmlj
ZS4KQWggZ3JlYXQhCk5leHQgd2VlayBJJ2xsIGRvdWJsZS1jaGVjayB0aGF0IHRoZSBmYWxsLWJh
Y2sgaXMgYWN0dWFsbHkKaW4gdXNlcnNwYWNlIChpbiBhbiBhbmRyb2lkIG1lZGlhIHN0YWNrIHBl
cmhhcHMpLCBhbmQKdGhhdCB3aWxsIGJlIGVub3VnaCBpbmZvIGZvciB0aGUgcmVhc29uYWJsZSBj
b21taXQgbXNnLiA6KQpUaGFua3MgZm9yIHlvdXIgaGVscCEKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
