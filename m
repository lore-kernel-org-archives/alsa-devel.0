From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] AsoC/s6000: use resource_size for
	{request/release}_mem_region and ioremap
Date: Wed, 2 Jun 2010 21:40:13 +0800
Message-ID: <AANLkTimZV7VyQq31taz2tJOsoBD8Upi3B0ROnZI5O5xn@mail.gmail.com>
References: <4C063751.2060001@gmail.com>
	<20100602105123.GB3020@opensource.wolfsonmicro.com>
	<4C065006.7030305@emlix.com> <20100602124556.GD10031@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id B7B6A2438B
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 15:40:14 +0200 (CEST)
Received: by vws8 with SMTP id 8so1359310vws.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2010 06:40:13 -0700 (PDT)
In-Reply-To: <20100602124556.GD10031@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Daniel Gl?ckner <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

MjAxMC82LzIgTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNyby5jb20+
Ogo+IE9uIFdlZCwgSnVuIDAyLCAyMDEwIGF0IDAyOjM1OjE4UE0gKzAyMDAsIERhbmllbCBHbD9j
a25lciB3cm90ZToKPgo+PiBJIGRvbid0IHRoaW5rIGl0IGlzIG5lY2Vzc2FyeSB0byBhZGQgYW4g
ZW50cnkgdG8gTUFJTlRBSU5FUlMuCj4+IE15IG5hbWUgYW5kIGFkZHJlc3MgbGlzdGVkIGF0IHRo
ZSB0b3Agb2YgdGhlIGZpbGUgc2hvdWxkIGJlIGVub3VnaC4KPj4gSXQncyBub3QgbGlrZSBJJ20g
c3RpbGwgd29ya2luZyBvbiBpdCwgYnV0IGlmIG5lZWRlZCBJIGNhbiB0YWtlIHRoZQo+PiBkZXZp
Y2UgZnJvbSB0aGUgc2hlbGYgdG8gcGVyZm9ybSBzb21lIHRlc3RzLCBzaG91bGQgYW55b25lIG1h
a2UgbW9yZQo+PiBzZXJpb3VzIGNoYW5nZXMgdG8gdGhlIGRyaXZlci4KPgo+IE1BSU5UQUlORVJT
IGlzIHVzZWQgYnkgYXV0b21hdGljIHRvb2xzIGxpa2UgZ2V0X21haW50YWluZXIgdG8gZmluZCB3
aG8KPiB0byBDQyBzbyBlbnRyaWVzIHRoZXJlIGFyZSBzdGlsbCB1c2VmdWwgLSBvcmlnaW5hbCBh
dXRob3JzaGlwIGlzIG9mdGVuCj4gbm90IGEgZ29vZCBpbmRpY2F0b3IgdGhhdCBzb21lb25lIGlz
IHdpbGxpbmcgdG8gdGFrZSByZXNwb25zaWJpbGl0eSBmb3IKPiB0aGUgY29kZS4gwqBGcm9tIHRo
ZSBzb3VuZHMgb2YgaXQgdGhvdWdoIGl0IHdhcyBmb3IgYSBwYXJ0aWN1bGFyIHByb2plY3QKPiBh
bmQgeW91J3ZlIG1vdmVkIG9uIGZyb20gaXQgc28geW91J3JlIG5vdCBwYXJ0aWN1bGFybHkgY29u
Y2VybmVkIGFib3V0Cj4gbm93IHNvIGl0J3Mgbm90IHdvcnRoIGl0IGFueXdheT8KCk9oLCBpdCBq
dXN0IGJlIG15IHdvcnJ5LgpJZiBzb21lIGNvZGVzIHdlcmUgbm8gbG9uZ2VyIHVzZWZ1bCBvciB2
YWx1YWJsZSwgd2hhdCBzaG91bGQgd2UgZG8gZm9yIHRoZW0/CmRlbGV0ZSB0aGVtIG9yIGtlZXAg
dGhlbSBiZSB0aGVyZSB5ZXQ/CgpJZiBJIG15IHBhdGNoIHRvIGZpeCBhIHdvcnRobGVzcyBjb2Rl
cywgZXZlcnl0aGluZyBJIGRvIHdpbGwgYmUgbm90aGluZy4KCj4KCgoKLS0gCipsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdAptYWlsIGFkZHI6bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCnlvdSBjYW4gc3Vic2NyaWJlIGJ5OgpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKCiogbGludXgtYXJtLU5VQzkwMCBt
YWlsaW5nIGxpc3QKbWFpbCBhZGRyOk5VQzkwMEBnb29nbGVncm91cHMuY29tCm1haW4gd2ViOiBo
dHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2dyb3VwL05VQzkwMAp5b3UgY2FuIHN1YnNjcmliZSBp
dCBieSBzZW5kaW5nIG1lIG1haWw6Cm1jdW9zLmNvbUBnbWFpbC5jb20KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
