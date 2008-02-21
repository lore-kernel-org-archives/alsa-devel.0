From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH]  Fix a compile warning under gcc-4.2.3.
Date: Thu, 21 Feb 2008 09:48:30 +0100
Message-ID: <47BD3ADE.8040501@ladisch.de>
References: <1203528197-24227-1-git-send-email-roysjosh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id AF24524339
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 09:46:43 +0100 (CET)
In-Reply-To: <1203528197-24227-1-git-send-email-roysjosh@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joshua Roys <roysjosh@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sm9zaHVhIFJveXMgd3JvdGU6Cj4gc291bmQvY29yZS9pbml0LmM6IEluIGZ1bmN0aW9uIOKAmHNu
ZF9jYXJkX2Rpc2Nvbm5lY3TigJk6Cj4gc291bmQvY29yZS9pbml0LmM6MzA3OiB3YXJuaW5nOiB0
aGUgYWRkcmVzcyBvZiDigJhzbmRfc2h1dGRvd25fZl9vcHPigJkgd2lsbCBhbHdheXMgZXZhbHVh
dGUgYXMg4oCYdHJ1ZeKAmQo+Cj4gU2lnbmVkLW9mZi1ieTogSm9zaHVhIFJveXMgPHJveXNqb3No
QGdtYWlsLmNvbT4KPiAtLS0KPiAgc291bmQvY29yZS9pbml0LmMgfCAgICAxIC0KPiAgMSBmaWxl
cyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvc291bmQvY29yZS9pbml0LmMgYi9zb3VuZC9jb3JlL2luaXQuYwo+IGluZGV4IDJjYjcwOTku
LjFhZmM1OGIgMTAwNjQ0Cj4gLS0tIGEvc291bmQvY29yZS9pbml0LmMKPiArKysgYi9zb3VuZC9j
b3JlL2luaXQuYwo+IEBAIC0zMDQsNyArMzA0LDYgQEAgaW50IHNuZF9jYXJkX2Rpc2Nvbm5lY3Qo
c3RydWN0IHNuZF9jYXJkICpjYXJkKQo+ICAJCWxpc3RfYWRkKCZtZmlsZS0+c2h1dGRvd25fbGlz
dCwgJnNodXRkb3duX2ZpbGVzKTsKPiAgCQlzcGluX3VubG9jaygmc2h1dGRvd25fbG9jayk7Cj4K
PiAtCQlmb3BzX2dldCgmc25kX3NodXRkb3duX2Zfb3BzKTsKPiAgCQltZmlsZS0+ZmlsZS0+Zl9v
cCA9ICZzbmRfc2h1dGRvd25fZl9vcHM7Cj4gIAkJCj4gIAkJbWZpbGUgPSBtZmlsZS0+bmV4dDsK
ClRoaXMgY2hhbmdlIG1heSBnZXQgcmlkIG9mIHRoZSB3YXJuaW5nLCBidXQgaXMgaGFzIHRoZSBz
bGlnaHQKZGlzYWR2YW50YWdlIHRoYXQgdGhlIGtlcm5lbCB3aWxsIGJsb3cgdXAgaWYgeW91IHRy
eSB0byB1bmxvYWQgdGhlIHNvdW5kCm1vZHVsZXMgYmVmb3JlIGFsbCBkZXZpY2UgZmlsZXMgaGF2
ZSBiZWVuIGNsb3NlZC4KCklmIHlvdSB3YW50IHRvIGdldCByaWQgb2YgdGhpcyB3YXJuaW5nLCB0
ZWxsIHRoZSBjb21waWxlciB0aGF0IGZvcHNfZ2V0Cmtub3dzIHdoYXQgaXQgZG9lczsgb3IgdHJ5
IG1ha2luZyBmb3BzX2dldCBhbiBpbmxpbmUgZnVuY3Rpb24gaW5zdGVhZCBvZgphIG1hY3JvLgoK
ClJlZ2FyZHMsCkNsZW1lbnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
