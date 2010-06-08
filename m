From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 2/2] pxa: modify the pxa2xx-ac97 file for
	pxa168
Date: Tue, 8 Jun 2010 22:49:09 +0800
Message-ID: <AANLkTimZjKvAAcK9xiXng7wJ0tVBJrmTIvMgyzrS7HqH@mail.gmail.com>
References: <4C0E21A1.4000909@gmail.com>
	<AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 36F8324444
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 16:49:12 +0200 (CEST)
Received: by pwj10 with SMTP id 10so234724pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 07:49:10 -0700 (PDT)
In-Reply-To: <AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

MjAxMC82LzggRXJpYyBNaWFvIDxlcmljLnkubWlhb0BnbWFpbC5jb20+Ogo+IDIwMTAvNi84IFdh
biBab25nU2h1biA8bWN1b3MuY29tQGdtYWlsLmNvbT46Cj4+IEluIG9yZGVyIHRvIGFsbG93IHRo
ZSBzaGFyaW5nIG9mIHRoZSBweGEyeHgtYWM5NyBkcml2ZXIgZmlsZSB3aXRoIHB4YTE2OCwKPj4g
d2UgaGF2ZSB0byBkbyBhIGxpdHRsZSBjaGFuZ2UgdG8gcHhhMnh4LWFjOTcgZmlsZS4KPj4KPj4g
QWxsIHByaXZhdGUgcmVnaXN0ZXIgYWRkcmVzc2VzIHdlcmUgbG9jYXRlZCBpbiBtYWNoL2luY2x1
ZGUvYWM5Ny5oLgo+Cj4gVGhpcyBpcyBub3QgdGhlIHJpZ2h0IHdheSB0byBnbywgYXMgc3VnZ2Vz
dGVkIGFscmVhZHkuIEkgaG9wZSB0aGUgYWM5Nwo+IGRyaXZlciBpcyBtb3JlIHNlbGYtY29udGFp
bmVkLiBpLmUuIGhhdmluZyBhIHBsYXRmb3JtIGRldmljZSBmb3I6Cj4KPiDCoC0gd2hlcmUgdGhl
IHJlZ2lzdGVycyBhcmUgbWFwcGVkIGZyb20KPiDCoC0gZHJjbXIgY2hhbm5lbCBudW1iZXJzIGNh
biBiZSBlbmNvZGVkIHdpdGhpbiBkbWEgcmVzb3VyY2UKPiDCoC0gYWM5NyByZWdpc3RlciBkZWZp
bml0aW9ucyBhcmUgbm90IGV4cG9zZWQgZXZlcnl3aGVyZQo+CgpHb3QgaXQsIHNvIEkgc2hvdWxk
IHB1dCBhYm92ZSB0byBwbGF0Zm9ybV9kZXZpY2UgYW5kIHJlbW92ZSByZWdzLWFjOTcuaCwKYW55
IHByaXZhdGUgYml0IGRlZmluaXRpb24gc2hvdWxkIGJlIHJlbW92ZWQgdG8gZHJpdmVyIGRpcmVj
dG9yeSBhcwpkcml2ZXIgX29ubHlfLgoKCi0tIAoqbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbWFpbCBhZGRyOmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwp5b3UgY2Fu
IHN1YnNjcmliZSBieToKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCgoqIGxpbnV4LWFybS1OVUM5MDAgbWFpbGluZyBsaXN0Cm1haWwg
YWRkcjpOVUM5MDBAZ29vZ2xlZ3JvdXBzLmNvbQptYWluIHdlYjogaHR0cHM6Ly9ncm91cHMuZ29v
Z2xlLmNvbS9ncm91cC9OVUM5MDAKeW91IGNhbiBzdWJzY3JpYmUgaXQgYnkgc2VuZGluZyBtZSBt
YWlsOgptY3Vvcy5jb21AZ21haWwuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
