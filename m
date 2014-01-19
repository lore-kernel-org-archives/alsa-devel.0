From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 01/16] ALSA: Oxygen: Add the separate
 SPI waiting function
Date: Sun, 19 Jan 2014 10:39:20 +0100
Message-ID: <52DB9D48.4010309@ladisch.de>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>	<52DA56E9.2020703@ladisch.de>
 <20140119121006.3ee8bde7@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 37CF226164C
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 10:39:37 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EBC1D209F4
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 04:39:31 -0500 (EST)
In-Reply-To: <20140119121006.3ee8bde7@v1ron-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Um9tYW4gVm9sa292IHdyb3RlOgo+IENsZW1lbnMgTGFkaXNjaCA8Y2xlbWVuc0BsYWRpc2NoLmRl
PiDQv9C40YjQtdGCOgo+PiBUaGUgU1BJIHRyYW5zYWN0aW9uIHdpbGwgbm90IGJlIGZpbmlzaGVk
IGZvciB0aGUgZmlyc3QgMzAgwrVzIG9yIHNvLCBzbwo+PiBwb2xsaW5nIGlzIG5vdCBuZWVkZWQg
Zm9yIHRoYXQgdGltZS4KPgo+IFdlIG1heSBzd2l0Y2ggdGhlIGNvbnRleHQgYW5kIGZvcmNlIENQ
VSB0bwo+IGV4ZWN1dGUgdXNlZnVsIGNvZGUsIHVzaW5nIHNvbWV0aGluZyBsaWtlIHVzbGVlcCwg
bXNsZWVwLiBIb3dldmVyLAo+IHRoaXMgbWF5IGJsb2NrIHRoZSB0aHJlYWQgZm9yIHRvbyBsb25n
IHRpbWUuIFBsZWFzZSBzdWdnZXN0Cj4gc29tZXRoaW5nIGhvdyB0byBvcHRpbWl6ZSB0aGlzLgoK
QWN0dWFsbHksIFNQSSB0cmFuc2FjdGlvbnMgY291bGQgdXNlIDIgYnl0ZXMgb3IgYSBmYXN0ZXIg
Y2xvY2ssCnNvIEkgZG9uJ3QgdGhpbmsgdGhpcyBuZWVkcyB0byBiZSBvcHRpbWl6ZWQuCgo+PiBX
aXRoIHRoZSB3YWl0IGNvbWluZyBhZnRlciB0aGUgdHJhbnNhY3Rpb24sIGl0IG1ha2VzIG1vcmUg
c2Vuc2UgdG8KPj4gaGF2ZSB0aGUgYnVzeSBjaGVjayBub3QgYmVmb3JlIGJ1dCBhZnRlciB0aGUg
dWRlbGF5Lgo+Cj4gT2theSwgdGhpcyB3aWxsIGJlOgo+Cj4gZm9yIChjb3VudCA9IDEwMDsgY291
bnQgPiAwOyBjb3VudC0tKSB7Cj4gCXVkZWxheSg0KTsKPiAJaWYgKChveHlnZW5fcmVhZDgoY2hp
cCwgT1hZR0VOX1NQSV9DT05UUk9MKSAmCj4gCQkJCQlPWFlHRU5fU1BJX0JVU1kpID09IDApCj4g
CQlyZXR1cm4gMDsKPiB9CgpZZXMuCgoKUmVnYXJkcywKQ2xlbWVucwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
