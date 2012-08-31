From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Regression fixes for 3.5
Date: Fri, 31 Aug 2012 20:15:00 +0200
Message-ID: <5040FF24.5060409@gmail.com>
References: <5040B517.5050101@sharpsaw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 9718026648E
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 20:15:08 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so1501404wib.2
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 11:15:08 -0700 (PDT)
In-Reply-To: <5040B517.5050101@sharpsaw.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?4piIa2luZw==?= <alsa-devel@sharpsaw.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gMzEuMDguMjAxMiAxNDo1OSwg4piIa2luZyB3cm90ZToKPiBJIGFtIGhhdmluZyB0aGUgZm9s
bG93aW5nIHN5bXB0b21zLCBiZWZvcmUgYW5kIGFmdGVyIGFwcGxpY2F0aW9uIG9mIHRoaXMKPiB0
aHJlYWQncyBwYXRjaGVzOgo+IAo+IEdpdmVuOgo+IC0gQW4gb25ib2FyZCBjYXJkCj4gLSBBIExv
Z2l0ZWNoIGgzOTAgVVNCIGhlYWRzZXQKPiAtIGFsc2EtaW5mbyBvZjogaHR0cDovL3d3dy5hbHNh
LXByb2plY3Qub3JnL2RiLz9mPTk0MmI1ZTk2YjUzYTY2NzI3MGY4OTVlYzUwNjFjYTE0YWYwMzM5
ZWUKPiAKPiBXaGVuOgo+IC0gSSBkbzogYXBsYXkgJChsb2NhdGUgLndhdiB8IGdyZXAgRnJvbnQp
Cj4gICBpdCBvdXRwdXRzOgo+ICAgYWxzYSBBTFNBIGxpYiBwY21fZGlyZWN0LmM6OTgwOihzbmQx
X3BjbV9kaXJlY3RfaW5pdGlhbGl6ZV9zbGF2ZSkKPiB1bmFibGUgdG8gaW5zdGFsbCBodyBwYXJh
bXMKPiAgIEFMU0EgbGliIHBjbV9kbWl4LmM6MTAzMDooc25kX3BjbV9kbWl4X29wZW4pIHVuYWJs
ZSB0byBpbml0aWFsaXplIHNsYXZlCj4gICBhcGxheTogbWFpbjo2ODI6IGF1ZGlvIG9wZW4gZXJy
b3I6IEJyb2tlbiBwaXBlCj4gLSBJIGRvIGEgU2t5cGUgIk1ha2UgYSB0ZXN0IHNvdW5kIgo+ICAg
L3Zhci9sb2cvbWVzc2FnZXMgc3RyZWFtcyBkb3plbnMgb2YgdGhlc2U6Cj4gICBrZXJuZWw6IGNh
bm5vdCBzdWJtaXQgdXJiIDAsIGVycm9yIC0yODogbm90IGVub3VnaCBiYW5kd2lkdGgKPiAKPiBO
b3RlIHRoYXQgdGhpcyBpcyBhIG5ldyBsYXB0b3AgYW5kIGhlYWRzZXQsIHNvIEkgaGF2ZW4ndCBj
b21wYXJlZCBob3cKPiBlaXRoZXIgd29ya3Mgb24gb3RoZXIgc2V0dXBzLCBzdWNoIGFzIHdpdGgg
b3RoZXIga2VybmVscyBvciBhbHNhIHZlcnNpb25zLgo+IAo+IEFueSBoaW50cz8gQW55IGZ1cnRo
ZXIgaW5mbyBuZWVkZWQ/CgpXaGF0IGtlcm5lbCBkbyB5b3Ugd29yayBvbj8gRGlkIHlvdSB0cnkg
dGhlIG90aGVyIHBhdGNoIHRoYXQgSSBzZW50IHNvbWUKZGF5cyBhZ28gYW5kIHRoYXQgYWxyZWFk
eSB3ZW50IG1haW5saW5lPwoKCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvP3A9bGludXgva2VybmVs
L2dpdC90aXdhaS9zb3VuZC5naXQ7YT1jb21taXQ7aD0wMTU2MThiOTAyYWU4ZTI4NzA1YjdhZjli
NDY2ODYxNWZlYTQ4ZGRkCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qu
b3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCg==
