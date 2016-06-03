From: Timur Karaldin <karaldin@mcsplus.ru>
Subject: Re: ASoC: TLV320AIC3x changing suspend delay time
Date: Fri, 3 Jun 2016 17:38:26 +0300
Message-ID: <c549b8ef-f42d-a3a5-dc04-3f4e04439769@mcsplus.ru>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
 <5715D775.8030303@ti.com>
 <DFF31AA6-67AF-429A-B108-6544180038F2@latencyzero.com>
 <5715E008.9000500@ti.com> <3cde8b0c-3b99-d61f-7c0a-c18621fbc4bb@mcsplus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp12.mail.ru (smtp12.mail.ru [94.100.181.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9593D265554
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 16:38:31 +0200 (CEST)
Received: from [83.242.226.142] (port=32611 helo=[192.168.100.105])
 by smtp12.mail.ru with esmtpa (envelope-from <karaldin@mcsplus.ru>)
 id 1b8qF4-0002f3-KT
 for alsa-devel@alsa-project.org; Fri, 03 Jun 2016 17:38:31 +0300
In-Reply-To: <3cde8b0c-3b99-d61f-7c0a-c18621fbc4bb@mcsplus.ru>
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

SGF2ZSBmb3VuZCBwbWRvd25fdGltZSBzeXNmcyBwYXJhbWV0ZXIsIGlzc3VlIGlzIHNvbHZlZCwg
dGhhbmtzCgowMy4wNi4yMDE2IDE2OjIyLCBUaW11ciBLYXJhbGRpbiDQv9C40YjQtdGCOgo+IEhp
IQo+Cj4gQ291bGQgeW91IGhlbHAgbWUgdG8gY29udHJvbCBkZWxheSB0aW1lIGZvciBzdXNwZW5k
IGFuZCBwb3dlciBkb3duIGNvZGVjLiBCZWNhdXNlIG9mCj4gSFcgcHJvYmxlbSBmb3IgbXkgYm9h
cmQgSSBuZWVkIHRvIHdhcm0gcmVzZXQgY29kZWMgZWFjaCB0aW1lIEknbSBkb2luZyBjbG9zZS9v
cGVuCj4gQUxTQSBkZXZpY2UuIEJlY2F1c2Ugb2Ygc3VzcGVuZCBkZWxheSB0aGUgY29kZWMncyBk
cml2ZXIgZGlkbid0IHBvd2VyIG9mZiBjaGlwIHVudGlsCj4gU1cgd2FpdHMgYXQgbGVhc3QgYWJv
dXQgNSBzZWNvbmRzIGJldHdlZW4gY2xvc2UgYW5kIG9wZW4uIFRoYW5rIHlvdSBmb3IgYW55IGhl
bHAuCj4KPiBCZXN0IHJlZ2FyZHMsCj4gVGltdXIgS2FyYWxkaW4KPgo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBBbHNhLWRldmVsIG1haWxpbmcg
bGlzdAo+IEFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwo+IGh0dHA6Ly9tYWlsbWFuLmFsc2Et
cHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCgoKLS0gCtChINGD0LLQsNC2
0LXQvdC40LXQvCwK0KDRg9C60L7QstC+0LTQuNGC0LXQu9GMINC/0YDQvtC10LrRgtC+0LIK0JzQ
vtGA0YHQutC40LUg0LrQvtC80L/Qu9C10LrRgdGLINC4INGB0LjRgdGC0LXQvNGLINC/0LvRjtGB
CtCa0LDRgNCw0LvQtNC40L0g0KIu0JwuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkJlc3QgcmVnYXJkcywKUHJvamVjdHMgZGlyZWN0b3IK
TWFyaW5lIGNvbXBsZXhlcyBhbmQgc3lzdGVtcyBwbHVzClRpbXVyIEthcmFsZGluCl9fCis3KDkx
MSk5NzY2NzkxCis3KDgxMikzMjUzODAyICs3KDgxMikzMjUzODA0ICs3KDgxMikzMjUzODA2Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
