From: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix forgotten conversion
 of control query functions
Date: Mon, 23 Apr 2018 13:58:04 +0300
Message-ID: <b13cfb4c-c7a8-a51f-5632-d3e9ff15f8d5@mokrynskyi.com>
References: <20180423070634.10758-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.mokrynskyi.com (mx.mokrynskyi.com [46.4.12.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A348B26725C
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 12:58:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx.mokrynskyi.com (Postfix) with ESMTP id C5760377F
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 10:58:05 +0000 (UTC)
Received: from mx.mokrynskyi.com ([127.0.0.1])
 by localhost (mx.mokrynskyi.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 68b5Sp7kP6F9 for <alsa-devel@alsa-project.org>;
 Mon, 23 Apr 2018 10:58:05 +0000 (UTC)
In-Reply-To: <20180423070634.10758-1-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Andrew Chant <achant@google.com>
List-Id: alsa-devel@alsa-project.org

U3VjY2Vzc2Z1bGx5IHRlc3RlZCB3aXRoIGNvbmZpZ3VyYXRpb24gZGVzY3JpYmVkIGluIGJ1ZyBy
ZXBvcnQsIHRoYW5rcyEKClRlc3RlZC1ieTogTmF6YXIgTW9rcnluc2t5aSA8bmF6YXJAbW9rcnlu
c2t5aS5jb20+CgpTaW5jZXJlbHksIE5hemFyIE1va3J5bnNreWkKZ2l0aHViLmNvbS9uYXphci1w
YwoKMjMuMDQuMTggMTA6MDYsIFRha2FzaGkgSXdhaSDQv9C40YjQtToKPiBUaGUgcmVjZW50IGNv
ZGUgcmVmYWN0b3JpbmcgbWFkZSB0aGUgYXJndW1lbnQgZm9yIHNvbWUgaGVscGVyCj4gZnVuY3Rp
b25zIHRvIGJlIHRoZSBleHBsaWNpdCBVQUNfQ1NfKiBhbmQgVUFDMl9DU18qIHZhbHVlIGluc3Rl
YWQgb2YKPiAwLWJhc2VkIG9mZnNldC4gIEhvd2V2ZXIsIHRoZXJlIHdhcyBvbmUgcGxhY2UgbGVm
dCBmb3Jnb3R0ZW4sIGFuZCBpdAo+IGNhdXNlZCBhIHJlZ3Jlc3Npb24gb24gc29tZSBkZXZpY2Vz
IGFwcGVhcmluZyBhcyB0aGUgaW5jb25zaXN0ZW50Cj4gbWl4ZXIgc2V0dXAuCj4KPiBUaGlzIHBh
dGNoIGNvcnJlY3RzIHRoZSBmb3Jnb3R0ZW4gY29udmVyc2lvbi4KPgo+IEJ1Z3ppbGxhOiBodHRw
czovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5OTQ0OQo+IEZpeGVzOiAy
MWU5YjNlOTMxZjcgKCJBTFNBOiB1c2ItYXVkaW86IGZpeCB1YWMgY29udHJvbCBxdWVyeSBhcmd1
bWVudCIpCj4gU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgo+IC0t
LQo+ICBzb3VuZC91c2IvbWl4ZXIuYyB8IDMgKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9zb3VuZC91c2IvbWl4ZXIu
YyBiL3NvdW5kL3VzYi9taXhlci5jCj4gaW5kZXggMzAxYWQ2MWVkNDI2Li4zMzg3NDgzMzEwYjEg
MTAwNjQ0Cj4gLS0tIGEvc291bmQvdXNiL21peGVyLmMKPiArKysgYi9zb3VuZC91c2IvbWl4ZXIu
Ywo+IEBAIC0xNzc2LDcgKzE3NzYsOCBAQCBzdGF0aWMgaW50IHBhcnNlX2F1ZGlvX2ZlYXR1cmVf
dW5pdChzdHJ1Y3QgbWl4ZXJfYnVpbGQgKnN0YXRlLCBpbnQgdW5pdGlkLAo+ICAJCQkJYnVpbGRf
ZmVhdHVyZV9jdGwoc3RhdGUsIF9mdHIsIGNoX2JpdHMsIGNvbnRyb2wsCj4gIAkJCQkJCSAgJml0
ZXJtLCB1bml0aWQsIGNoX3JlYWRfb25seSk7Cj4gIAkJCWlmICh1YWNfdjJ2M19jb250cm9sX2lz
X3JlYWRhYmxlKG1hc3Rlcl9iaXRzLCBjb250cm9sKSkKPiAtCQkJCWJ1aWxkX2ZlYXR1cmVfY3Rs
KHN0YXRlLCBfZnRyLCAwLCBpLCAmaXRlcm0sIHVuaXRpZCwKPiArCQkJCWJ1aWxkX2ZlYXR1cmVf
Y3RsKHN0YXRlLCBfZnRyLCAwLCBjb250cm9sLAo+ICsJCQkJCQkgICZpdGVybSwgdW5pdGlkLAo+
ICAJCQkJCQkgICF1YWNfdjJ2M19jb250cm9sX2lzX3dyaXRlYWJsZShtYXN0ZXJfYml0cywKPiAg
CQkJCQkJCQkJCSBjb250cm9sKSk7Cj4gIAkJfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
