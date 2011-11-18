From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: RE: [alsa-devel] [PATCH v5 1/3] ARM: mxs: add saif clkmux functions
Date: Fri, 18 Nov 2011 09:29:55 +0100
Message-ID: <20166.6019.921262.50184@ipc1.ka-ro>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
 <1321003855-13430-2-git-send-email-b29396@freescale.com>
 <201111180554.42242.marek.vasut@gmail.com>
 <65EE16ACC360FA4D99C96DC085B3F7722E47BC@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722E47BC@039-SN1MPN1-002.039d.mgd.msft.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, Marek Vasut <marek.vasut@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGksCgpEb25nIEFpc2hlbmctQjI5Mzk2IHdyaXRlczoKWy4uLl0KPiA+ID4gKyNkZWZpbmUgSFdf
RElHQ1RMX0NUUkwJCQkweDAKPiA+ID4gKyNkZWZpbmUgIEJQX0RJR0NUTF9DVFJMX1NBSUZfQ0xL
TVVYCSgxMCkKPiA+IAo+ID4gRG8geW91IG5lZWQgdGhlIHBhcmVudGhlc2lzIGFib3ZlID8KPiA+
IAo+IEknbSBub3Qgc3VyZSBhYm91dCBoaXMuCj4gSFdfRElHQ1RMX0NUUkwgaXMgdGhlIHJlZ2lz
dGVyIG9mZnNldC4KPiBEbyB3ZSBoYXZlIHRvIGRvIHRoaXM/Cj4gCllvdSBuZWVkIHBhcmVucyBh
cm91bmQgbWFjcm8gcGFyYW1ldGVycyB0aGF0IGFyZSB1c2VkIGluIGFuIGV4cHJlc3Npb24KaW5z
aWRlIHRoZSBtYWNyby4gQnV0IHlvdSBuZXZlciBldmVyIG5lZWQgdG8gZW5jbG9zZSBhIGJhcmUg
bnVtYmVyIGluCnBhcmVucyEKCgpMb3RoYXIgV2HDn21hbm4KLS0gCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCgpLYS1SbyBlbGVjdHJv
bmljcyBHbWJIIHwgUGFzY2Fsc3RyYcOfZSAyMiB8IEQgLSA1MjA3NiBBYWNoZW4KUGhvbmU6ICs0
OSAyNDA4IDE0MDItMCB8IEZheDogKzQ5IDI0MDggMTQwMi0xMApHZXNjaMOkZnRzZsO8aHJlcjog
TWF0dGhpYXMgS2F1c3NlbgpIYW5kZWxzcmVnaXN0ZXJlaW50cmFnOiBBbXRzZ2VyaWNodCBBYWNo
ZW4sIEhSQiA0OTk2Cgp3d3cua2Fyby1lbGVjdHJvbmljcy5kZSB8IGluZm9Aa2Fyby1lbGVjdHJv
bmljcy5kZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
