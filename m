From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 00/10] Convert wm8xxx codec drivers to use
 snd_soc_cache_sync
Date: Thu, 06 Oct 2011 14:52:40 +0800
Message-ID: <1317883960.13399.17.camel@phoenix>
References: <1317881417.13399.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 54B7E103A3B
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 08:52:49 +0200 (CEST)
Received: by yxk8 with SMTP id 8so2690258yxk.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 23:52:48 -0700 (PDT)
In-Reply-To: <1317881417.13399.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lartey <ian@opensource.wolfsonmicro.com>, Kenneth Kiraly <kiraly@lab126.com>, Richard Purdie <rpurdie@rpsys.net>, Jonathan Cameron <jic23@cam.ac.uk>, Mike Arthur <linux@wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

U29ycnkuIEkganVzdCBmb3VuZCB3ZSBuZWVkIHRvIHNldCBjb2RlYy0+Y2FjaGVfc3luYyA9IDEg
aW4KU05EX1NPQ19CSUFTX09GRi4gT3RoZXJ3aXNlLCBzbmRfc29jX2NhY2hlX3N5bmMgd29uJ3Qg
c3luYyB3b3JrLgoKV2lsbCBzZW5kIGEgdjIgc29vbi4KCkF4ZWwKCuaWvCDlm5vvvIwyMDExLTEw
LTA2IOaWvCAxNDoxMCArMDgwMO+8jEF4ZWwgTGluIOaPkOWIsO+8mgo+IFRoaXMgc2VyaWFsIGNv
bnZlcnRzIHRoZSB3bTh4eHggY29kZWMgZHJpdmVycyB0byB1c2Ugc25kX3NvY19jYWNoZV9zeW5j
Lgo+IEkgZG9uJ3QgaGF2ZSB0aGVzZSBoYXJkd2FyZSwgYnV0IEkgYXNzdW1lIE1hcmsgaGFzIGFs
bCB0aGVzZSBoYXJkd2FyZS4KPiBUaGVzZSBwYXRjaGVzIGFyZSBVTlRFU1RFRC4gSSdkIGFwcHJl
Y2lhdGUgaWYgc29tZW9uZSBjYW4gdGVzdCB0aGVtLgo+IChDdXJyZW50IGNvZGUgaXMgYnJva2Vu
IGFueXdheSwgdGh1cyB3ZSBuZWVkIGNvbnZlcnQgdG8gdXNlIG5ldyBBUEkuICkKPiAKPiBBeGVs
IExpbiAoMTApOgo+ICAgQVNvQzogd204NTEwOiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3lu
Ywo+ICAgQVNvQzogd204NzExOiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+ICAgQVNv
Qzogd204NzMxOiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+ICAgQVNvQzogd204NzUw
OiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+ICAgQVNvQzogd204Nzc2OiBDb252ZXJ0
IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+ICAgQVNvQzogd204OTQwOiBDb252ZXJ0IHRvIHNuZF9z
b2NfY2FjaGVfc3luYwo+ICAgQVNvQzogd204OTYwOiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVf
c3luYwo+ICAgQVNvQzogd204OTcxOiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+ICAg
QVNvQzogd204OTc0OiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+ICAgQVNvQzogd204
OTg4OiBDb252ZXJ0IHRvIHNuZF9zb2NfY2FjaGVfc3luYwo+IAo+ICBzb3VuZC9zb2MvY29kZWNz
L3dtODUxMC5jIHwgICAzMCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gIHNvdW5kL3Nv
Yy9jb2RlY3Mvd204NzExLmMgfCAgIDE5ICsrKysrKystLS0tLS0tLS0tCj4gIHNvdW5kL3NvYy9j
b2RlY3Mvd204NzMxLmMgfCAgIDI5ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ICBzb3Vu
ZC9zb2MvY29kZWNzL3dtODc1MC5jIHwgICAzMiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0KPiAgc291bmQvc29jL2NvZGVjcy93bTg3NzYuYyB8ICAgMzMgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLQo+ICBzb3VuZC9zb2MvY29kZWNzL3dtODk0MC5jIHwgICA0NiArKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICBzb3VuZC9zb2MvY29kZWNz
L3dtODk2MC5jIHwgICAzNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICBz
b3VuZC9zb2MvY29kZWNzL3dtODk3MS5jIHwgICAzMiArKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0KPiAgc291bmQvc29jL2NvZGVjcy93bTg5NzQuYyB8ICAgMjkgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tCj4gIHNvdW5kL3NvYy9jb2RlY3Mvd204OTg4LmMgfCAgIDMyICsrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLQo+ICAxMCBmaWxlcyBjaGFuZ2VkLCAxODUgaW5zZXJ0aW9u
cygrKSwgMTM0IGRlbGV0aW9ucygtKQo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
