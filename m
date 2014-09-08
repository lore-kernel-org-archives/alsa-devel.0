From: Bram Bos <bos3@upcmail.nl>
Subject: Asynchronous ALSA - callback and latency questions
Date: Mon, 8 Sep 2014 18:03:13 +0200 (CEST)
Message-ID: <1135001813.415555.1410192193064.open-xchange@upcmail.upc.nl>
Reply-To: Bram Bos <bos3@upcmail.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep42.mx.upcmail.net (fep42.mx.upcmail.net [62.179.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id CAD1526007E
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 18:03:13 +0200 (CEST)
Received: from edge02.upcmail.net ([192.168.13.237])
 by viepfeppe42-int.chello.at
 (InterMail vM.8.01.05.11 201-2260-151-128-20120928) with ESMTP
 id <20140908160313.ZABJ11119.viepfeppe42-int.chello.at@edge02.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 8 Sep 2014 18:03:13 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8gYWxsLAoKSeKAmW0gdXNpbmcgQUxTQSBmb3IgYnVpbGRpbmcgYSBwZXJmb3JtYW5jZSBt
dXNpY2FsIGluc3RydW1lbnQsIHNvIEnigJltIGFmdGVyCiBsb3ctbGF0ZW5jeSBhdWRpbyBvdXRw
dXQuCkkgaGF2ZSBzb21lIHF1ZXN0aW9ucyAoc2luY2UgSSdtIGZhaXJseSBuZXcgdG8gQUxTQSBh
bmQgdG8gTGludXggdGhleSBtYXkgIGJlIGEKYmlnIG4wMGJ5LCBzbyBwbGVhc2UgYmVhciB3aXRo
IG1lKeKApgoKMS4gSeKAmW0gdXNpbmcgYXN5bmNocm9ub3VzIGF1ZGlvIG91dHB1dCAoaS5lLiB1
c2luZyBhIGNhbGxiYWNrKS4gU29tZXRpbWVzIHRoZQpzeXN0ZW0gc2ltcGx5IHN0b3BzIGNhbGxp
bmcgdGhlIGNhbGxiYWNrIGZ1bmN0aW9uIHdpdGhvdXQgZ2l2aW5nIGFuIGVycm9yLiBJbgpjYXNl
IG9mIGFuIHhydW4gSSB3b3VsZCBleHBlY3QgdGhlcmUgdG8gYmUgYW4gdW5kZXJydW4gbWVzc2Fn
ZSAod2hpY2ggSQpzb21ldGltZXMgYWxzbyBnZXQpIHNvIEkgY2FuIGhhbmRsZSBpdCBwcm9wZXJs
eS4gU28gSSBndWVzcyBzb21ldGhpbmcgZWxzZSBpcwpjYXVzaW5nIHRoZSBpc3N1ZT8gQW55IHBv
aW50ZXJzPwoKMi4gV2hhdCBkb2VzIOKAnEZpbGUgZGVzY3JpcHRvciBpcyBpbiBhIGJhZCBzdGF0
ZeKAnSBtZWFuLCB3aGVuIGl0IGlzIHJldHVybmVkIGJ5CnNuZF9wY21fd3JpdGVpPyBJIG5vdGlj
ZSB0aGF0IEkgY2FuIG9mdGVuIGF2b2lkIGdldHRpbmcgaXQgYnkgaW5jcmVhc2luZyB0aGUKc2l6
ZSBvZiBteSBidWZmZXIgYnV0IHRoZSBtZXNzYWdlIGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBtZS4K
CjMuIE9jY2FzaW9uYWxseSBteSBhcHBsaWNhdGlvbiBncmluZHMgdG8gYSBoYWx0IHdpdGggYSDi
gJxJL08gaXMgcG9zc2libGXigJ0gbWVzc2FnZQrigJMgcHJlc3VtYWJseSB0aGlzIGlzIHRyaWdn
ZXJlZCBieSB0aGUgQUxTQSBjYWxsYmFjayBtZWNoYW5pc20/Cgo0LiBNeSBsYXN0IHF1ZXN0aW9u
IGlzIGEgYml0IG1vcmUgY29uY2VwdHVhbDogd2hhdCBkZXRlcm1pbmVzIHRoZSBwbGF5YmFjawps
YXRlbmN5IG9mIG15IGF1ZGlvIHN0cmVhbT8gVGhlIHBlcmlvZCBzaXplPyBUaGUgdG90YWwgcmlu
ZyBidWZmZXIgc2l6ZT8gSQphc3N1bWUgaXQgc2hvdWxkIGJlIHRoZSBkaWZmZXJlbmNlIGJldHdl
ZW4gdGhlIGhhcmR3YXJlIHBsYXliYWNrIHBvaW50ZXIgYW5kIHRoZQpzb2Z0d2FyZSB3cml0ZSBw
b2ludGVyLCBidXQgSSBjYW7igJl0IGZpZ3VyZSBvdXQgaG93IHRoZXkgYXJlIGRldGVybWluZWQu
CgpUaGFua3MgZm9yIGFueSBoZWxwLgoKCgpTeXN0ZW0gaW5mbzogUmFzcGJlcnJ5IFBpIEIrIChu
b24tb3ZlcmNsb2NrZWQpLCBSYXNwYmlhbiBXaGVlenksIFVTQiBQblAgQ00xMDgKYXVkaW8gZGV2
aWNlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
