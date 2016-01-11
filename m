From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM
	clock
Date: Mon, 11 Jan 2016 14:38:03 +0100
Message-ID: <4412078.STjb1rKkbV@wuerfel>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <20160110115858.GV6588@sirena.org.uk>
 <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id DDE15260412
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 14:38:26 +0100 (CET)
In-Reply-To: <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Michael Turquette <mturquette@baylibre.com>, Lee Jones <lee@kernel.org>, Takashi Iwai <tiwai@suse.com>, Eric Anholt <eric@anholt.net>, Remi Pommarel <repk@triplefau.lt>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-rpi-kernel@lists.infradead.org, lFlorian Meier <florian.meier@koalo.de>, Matthias Reichl <hias@horus.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

T24gU3VuZGF5IDEwIEphbnVhcnkgMjAxNiAxMzoxNzoxNyBNYXJ0aW4gU3Blcmwgd3JvdGU6Cj4g
Cj4gV2hhdCB5b3UgcHJvcG9zZSBpcyBhIG1ham9yIGNoYW5nZSB0byB0aGUgY2xvY2sgZnJhbWV3
b3JrLCBzbyBJIHdvdWxkCj4gaG9wZSB0aGF0IEVyaWMgKHRoZSBvcmlnaW5hbCBhdXRob3Igb2Yg
dGhpcyBjbG9jay1kcml2ZXIpIHdvdWxkIGFkZHJlc3MKPiBpdC4KPiAKPiBNYXliZSBzb21lb25l
IGhhcyBhIGJldHRlciBpZGVhIGZvciBhIHBhdHRlcm4gdG8gdXNlIHRvIGFjaGlldmUgCj4gdGhl
IHJlcXVpcmVkIHdoaWxlIG1haW50YWluaW5nIOKAnHN5bmNocm9uaXphdGlvbuKAnSBiZXR3ZWVu
IGRlZmluZXMKPiBpbnNpZGUgdGhlIGR0LWJpbmRpbmcgYW5kIHRoZSBkcml2ZXIuCgpJdCdzIGZ1
bm55IHRvIGxvb2sgYXQgdGhlIHJlZ2lzdGVyIGxpc3Q6CgojZGVmaW5lIENNX1ZQVUNUTCAgICAg
ICAgICAgICAgIDB4MDA4CiNkZWZpbmUgQ01fVlBVRElWICAgICAgICAgICAgICAgMHgwMGMKI2Rl
ZmluZSBDTV9TWVNDVEwgICAgICAgICAgICAgICAweDAxMAojZGVmaW5lIENNX1NZU0RJViAgICAg
ICAgICAgICAgIDB4MDE0CiNkZWZpbmUgQ01fUEVSSUFDVEwgICAgICAgICAgICAgMHgwMTgKI2Rl
ZmluZSBDTV9QRVJJQURJViAgICAgICAgICAgICAweDAxYwojZGVmaW5lIENNX1BFUklJQ1RMICAg
ICAgICAgICAgIDB4MDIwCiNkZWZpbmUgQ01fUEVSSUlESVYgICAgICAgICAgICAgMHgwMjQKI2Rl
ZmluZSBDTV9IMjY0Q1RMICAgICAgICAgICAgICAweDAyOAojZGVmaW5lIENNX0gyNjRESVYgICAg
ICAgICAgICAgIDB4MDJjCgpUaGlzIG9uZSBzZWVtcyBjb21wbGV0ZWx5IHJlZ3VsYXIsIHRoZXJl
IGlzIGFsd2F5cyBhIHBhaXIgb2YgQ1RMIGFuZCBESVYKcmVnaXN0ZXJzLCBzbyBJIHdvdWxkIGhh
dmUgZ3Vlc3NlZCB0aGF0IHdlIGNvdWxkIGp1c3QgdGFrZSB0aGUgaW5kZXgKb2YgdGhhdCB0byBj
b21wbGV0ZWx5IGF2b2lkIHRoZSBuZWVkIGZvciB0aGUgaGVhZGVyIGZpbGUgYW5kIGp1c3QgaGF2
ZQphIGxvb2t1cCB0YWJsZSBvZiBlYWNoIGluZGV4LgoKSSBjYW4gc2VlIHR3byBwb3NzaWJsZSB3
YXlzIGZvcndhcmQ6CgphKSBkZXByZWNhdGUgdGhlIGV4aXN0aW5nIGJpbmRpbmcgYW5kIHdyaXRl
IGEgbmV3IHNpbXBsZXIgZHJpdmVyIHRvCiAgIHJlcGxhY2UgaXQgd2l0aCBvbmUgdGhhdCBkb2Vz
IG5vdCBuZWVkIHRoZSBoZWFkZXIuIFdlIHByb2JhYmx5IG5lZWQKICAgdG8ga2VlcCBib3RoIGRy
aXZlcnMgYXJvdW5kIGluZGVmaW5pdGVseSB0aG91Z2ggdG8gZGVhbCB3aXRoIHBlb3BsZQogICB0
aGF0IGhhdmUgdGhlaXIgb3duIGR0YiBmaWxlcywgc28gdGhpcyBpcyBhIGJpdCBhd2t3YXJkLgoK
YikgbG9vayBhdCBhbGwgdGhlIGhvbGVzIGluIHRoZSB0YWJsZSBhbmQgZGVmaW5lIG5ldyBudW1i
ZXJzIGZvciB0aGVtCiAgIG5vdywgdGhlbiByZW1vdmUgdGhlIGNvdW50IGFzIHRoZSBkcml2ZXIg
Y2FuIHNpbXBseSBoYXJkY29kZSB0aGUKICAgbWF4aW11bSBudW1iZXIgYXMgaXQga25vd3MgaXQg
d2lsbCBuZXZlciBjaGFuZ2UuCgoJQXJuZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
