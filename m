From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] ALSA: fireface: Use ULL suffixes for
	64-bit constants
Date: Wed, 29 May 2019 18:57:31 +0900
Message-ID: <20190529095730.GA7089@workstation>
References: <20190528142424.19626-1-geert@linux-m68k.org>
 <20190528142424.19626-5-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3EC2F8065A
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2019 11:57:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190528142424.19626-5-geert@linux-m68k.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-block@vger.kernel.org, alsa-devel@alsa-project.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>, Jamal Hadi Salim <jhs@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@mellanox.com>, Cong Wang <xiyou.wangcong@gmail.com>, Joe Perches <joe@perches.com>, "Mohit P . Tahiliani" <tahiliani@nitk.edu.in>, Matias Bjorling <mb@lightnvm.io>, Eran Ben Elisha <eranbe@mellanox.com>, Dan Carpenter <dan.carpenter@oracle.com>, Igor Konopko <igor.j.konopko@intel.com>
List-Id: alsa-devel@alsa-project.org

SGksCgpPbiBUdWUsIE1heSAyOCwgMjAxOSBhdCAwNDoyNDoyM1BNICswMjAwLCBHZWVydCBVeXR0
ZXJob2V2ZW4gd3JvdGU6Cj4gV2l0aCBnY2MgNC4xOgo+IAo+ICAgICBzb3VuZC9maXJld2lyZS9m
aXJlZmFjZS9mZi1wcm90b2NvbC1sYXR0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbGF0dGVyX3N3aXRj
aF9mZXRjaGluZ19tb2Rl4oCZOgo+ICAgICBzb3VuZC9maXJld2lyZS9maXJlZmFjZS9mZi1wcm90
b2NvbC1sYXR0ZXIuYzo5Nzogd2FybmluZzogaW50ZWdlciBjb25zdGFudCBpcyB0b28gbGFyZ2Ug
Zm9yIOKAmGxvbmfigJkgdHlwZQo+ICAgICBzb3VuZC9maXJld2lyZS9maXJlZmFjZS9mZi1wcm90
b2NvbC1sYXR0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbGF0dGVyX2JlZ2luX3Nlc3Npb27igJk6Cj4g
ICAgIHNvdW5kL2ZpcmV3aXJlL2ZpcmVmYWNlL2ZmLXByb3RvY29sLWxhdHRlci5jOjE3MDogd2Fy
bmluZzogaW50ZWdlciBjb25zdGFudCBpcyB0b28gbGFyZ2UgZm9yIOKAmGxvbmfigJkgdHlwZQo+
ICAgICBzb3VuZC9maXJld2lyZS9maXJlZmFjZS9mZi1wcm90b2NvbC1sYXR0ZXIuYzoxOTc6IHdh
cm5pbmc6IGludGVnZXIgY29uc3RhbnQgaXMgdG9vIGxhcmdlIGZvciDigJhsb25n4oCZIHR5cGUK
PiAgICAgc291bmQvZmlyZXdpcmUvZmlyZWZhY2UvZmYtcHJvdG9jb2wtbGF0dGVyLmM6MjA1OiB3
YXJuaW5nOiBpbnRlZ2VyIGNvbnN0YW50IGlzIHRvbyBsYXJnZSBmb3Ig4oCYbG9uZ+KAmSB0eXBl
Cj4gICAgIHNvdW5kL2ZpcmV3aXJlL2ZpcmVmYWNlL2ZmLXByb3RvY29sLWxhdHRlci5jOiBJbiBm
dW5jdGlvbiDigJhsYXR0ZXJfZmluaXNoX3Nlc3Npb27igJk6Cj4gICAgIHNvdW5kL2ZpcmV3aXJl
L2ZpcmVmYWNlL2ZmLXByb3RvY29sLWxhdHRlci5jOjIxNDogd2FybmluZzogaW50ZWdlciBjb25z
dGFudCBpcyB0b28gbGFyZ2UgZm9yIOKAmGxvbmfigJkgdHlwZQo+IAo+IEZpeCB0aGlzIGJ5IGFk
ZGluZyB0aGUgbWlzc2luZyAiVUxMIiBzdWZmaXhlcy4KPiBBZGQgdGhlIHNhbWUgc3VmZml4IHRv
IHRoZSBsYXN0IGNvbnN0YW50LCB0byBtYWludGFpbiBjb25zaXN0ZW5jeS4KPiAKPiBGaXhlczog
ZmQxY2M5ZGU2NGMyY2E2YyAoIkFMU0E6IGZpcmVmYWNlOiBhZGQgc3VwcG9ydCBmb3IgRmlyZWZh
Y2UgVUNYIikKPiBTaWduZWQtb2ZmLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4
LW02OGsub3JnPgo+IC0tLQo+ICBzb3VuZC9maXJld2lyZS9maXJlZmFjZS9mZi1wcm90b2NvbC1s
YXR0ZXIuYyB8IDEwICsrKysrLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkKClRoYW5rcyBmb3IgeW91ciBjYXJlLgoKUmV2aWV3ZWQtYnk6IFRh
a2FzaGkgU2FrYW1vdG8gPG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPgoKPiBkaWZmIC0tZ2l0IGEv
c291bmQvZmlyZXdpcmUvZmlyZWZhY2UvZmYtcHJvdG9jb2wtbGF0dGVyLmMgYi9zb3VuZC9maXJl
d2lyZS9maXJlZmFjZS9mZi1wcm90b2NvbC1sYXR0ZXIuYwo+IGluZGV4IGM4MjM2ZmY4OWI3ZmI5
ZGUuLmIzMGQwMmQzNTliMWQyMWIgMTAwNjQ0Cj4gLS0tIGEvc291bmQvZmlyZXdpcmUvZmlyZWZh
Y2UvZmYtcHJvdG9jb2wtbGF0dGVyLmMKPiArKysgYi9zb3VuZC9maXJld2lyZS9maXJlZmFjZS9m
Zi1wcm90b2NvbC1sYXR0ZXIuYwo+IEBAIC05LDExICs5LDExIEBACj4gIAo+ICAjaW5jbHVkZSAi
ZmYuaCIKPiAgCj4gLSNkZWZpbmUgTEFUVEVSX1NURgkJMHhmZmZmMDAwMDAwMDQKPiAtI2RlZmlu
ZSBMQVRURVJfSVNPQ19DSEFOTkVMUwkweGZmZmYwMDAwMDAwOAo+IC0jZGVmaW5lIExBVFRFUl9J
U09DX1NUQVJUCTB4ZmZmZjAwMDAwMDBjCj4gLSNkZWZpbmUgTEFUVEVSX0ZFVENIX01PREUJMHhm
ZmZmMDAwMDAwMTAKPiAtI2RlZmluZSBMQVRURVJfU1lOQ19TVEFUVVMJMHgwMDAwODAxYzAwMDAK
PiArI2RlZmluZSBMQVRURVJfU1RGCQkweGZmZmYwMDAwMDAwNFVMTAo+ICsjZGVmaW5lIExBVFRF
Ul9JU09DX0NIQU5ORUxTCTB4ZmZmZjAwMDAwMDA4VUxMCj4gKyNkZWZpbmUgTEFUVEVSX0lTT0Nf
U1RBUlQJMHhmZmZmMDAwMDAwMGNVTEwKPiArI2RlZmluZSBMQVRURVJfRkVUQ0hfTU9ERQkweGZm
ZmYwMDAwMDAxMFVMTAo+ICsjZGVmaW5lIExBVFRFUl9TWU5DX1NUQVRVUwkweDAwMDA4MDFjMDAw
MFVMTAo+ICAKPiAgc3RhdGljIGludCBwYXJzZV9jbG9ja19iaXRzKHUzMiBkYXRhLCB1bnNpZ25l
ZCBpbnQgKnJhdGUsCj4gIAkJCSAgICBlbnVtIHNuZF9mZl9jbG9ja19zcmMgKnNyYykKPiAtLSAK
PiAyLjE3LjEKPiAKCgpSZWdhcmRzCgpUYWthc2hpIFNha2Ftb3RvCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
