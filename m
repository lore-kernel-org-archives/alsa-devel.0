From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [GIT PULL] dummy: allow disabling mixer controls
Date: Sun, 21 Oct 2012 20:22:59 +0800
Message-ID: <CAN8cciZO+yqt3vrvSz53b03RmJ3qUc-WkwzEZtQBMEZqw29GiA@mail.gmail.com>
References: <50832124.4080503@ladisch.de>
 <CAN8cciZemEttvKsWAYnr3nS6ZN5EES_-t1Lfw=G=apRHMYti4g@mail.gmail.com>
 <5083D8A1.3040407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 04584265087
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 14:22:59 +0200 (CEST)
Received: by mail-qa0-f44.google.com with SMTP id 25so902729qao.17
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 05:22:59 -0700 (PDT)
In-Reply-To: <5083D8A1.3040407@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MjAxMi0xMC0yMSDkuIvljYg3OjEzIOaWvCAiQ2xlbWVucyBMYWRpc2NoIiA8Y2xlbWVuc0BsYWRp
c2NoLmRlPiDlr6vpgZPvvJoKPgo+IFJheW1vbmQgWWF1IHdyb3RlOgo+ID4gMjAxMi0xMC0yMSDk
uIrljYg2OjExIOaWvCAiQ2xlbWVucyBMYWRpc2NoIiA8Y2xlbWVuc0BsYWRpc2NoLmRlPiDlr6vp
gZPvvJoKPiA+PiBRdWl0ZSBhIGZldyBtaXhlciBhcHBsaWNhdGlvbnMgZG8gbm90IGhhbmRsZSBk
ZWFjdGl2YXRlZCBjb250cm9scwo+ID4+IGNvcnJlY3RseS4KPiA+Cj4gPiB3aGF0IGlzIHRoZSBt
ZWFuaW5nIG9mIGRlYWN0aXZhdGVkIGNvbnRyb2wgPwo+Cj4gQSBjb250cm9sIHdoZXJlIHdyaXRl
cyBkbyBub3QgaGF2ZSBhbiAoaW1tZWRpYXRlKSBlZmZlY3QuCgp3aHkgZG8geW91IG5vdCBpbXBs
ZW1lbnQgdGhpcyBraW5kIG9mIGNvbnRyb2wgYnkgZGlzYWJsZS9lbmFibGUgdGhlIHdyaXRlCmFj
Y2VzcyA/Cgo+Cj4gPiBhbWl4ZXIgc3RpbGwgY2FuIGNoYW5nZSB0aGUgdmFsdWUgb2YgdGhlIGRl
YWN0aXZhdGVkIGNkIHZvbHVtZSBjb250cm9sCmlmCj4gPiB3cml0ZSBhY2Nlc3MgaXMgbm8gZGlz
YWJsZWQKPgo+IFllcywgd2hlbiB3cml0ZSBhY2Nlc3MgaXMgZW5hYmxlZCwgdGhlIGNvbnRyb2wg
Y2FuIGJlIHdyaXR0ZW4gdG8uCj4gVGhpcyBpcyBuZWNlc3NhcnkgZm9yICJhbHNhY3RsIChyZSlz
dG9yZSIuCgppZiB0aGUgY29udHJvbCBjYW4gYmUgd3JpdGUgd2hlbiB0aGUgZHJpdmVyIGlzIGxv
YWRlZCwgdGhlIHdyaXRlIGFjY2VzcyBvZgp0aGUgY29udHJvbCBjYW4gYmUgZGlzYWJsZS9lbmFi
bGUgaW5zdGVhZCBvZiB1c2luZyBhY3RpdmUvaW5hY3RpdmUKCj4KPiBBbHNhbWl4ZXIgZGlzcGxh
eXMgc3VjaCBjb250cm9scyBhcyBncmF5IGFuZCByZWFkLW9ubHkgYmVjYXVzZSBjaGFuZ2luZwo+
IHRoZW0gd291bGQgbm90IG1ha2Ugc2Vuc2UgYXQgdGhlIG1vbWVudCwgYnV0IGFsbG93aW5nIGNo
YW5nZXMgd291bGQKPiBhY3R1YWxseSBiZSBwb3NzaWJsZSAoaWYgY29uZnVzaW5nKS4KCmFsc2Ft
aXhlciBjYW4gYWxzbyBkaXNwbGF5IG5vbiB3cml0YWJsZSBjb250cm9sIGluIGRpZmZlcmVudCBj
b2xvcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
