From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 17/17] ASoC: ux500: Use generic dmaengine
	PCM
Date: Thu, 18 Apr 2013 14:50:37 +0100
Message-ID: <20130418135037.GB3959@gmail.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-18-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 19203264F13
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 15:50:43 +0200 (CEST)
Received: by mail-wi0-f180.google.com with SMTP id h11so1931031wiv.13
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 06:50:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366046404-8759-18-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAxNSBBcHIgMjAxMywgTGFycy1QZXRlciBDbGF1c2VuIHdyb3RlOgoKPiBVc2UgdGhl
IGdlbmVyaWMgZG1hZW5naW5lIFBDTSBkcml2ZXIgaW5zdGVhZCBvZiBhIGN1c3RvbSBpbXBsZW1l
bnRpb24uICBUaGVyZSBpcwo+IGEgbWlub3IgZnVuY3Rpb25hbCBjaGFuZ2UsIHRoZSB1eDUwMCBQ
Q00gZHJpdmVyIGRpZCBub3QgcHJlYWxsb2NhdGUgdGhlIGF1ZGlvCj4gYnVmZmVyLCB3aGlsZSB0
aGUgZ2VuZXJpYyBkbWFlbmdpbmUgUENNIGRyaXZlciB3aWxsIGRvIHRoaXMuCj4gCj4gU2lnbmVk
LW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+Cj4gLS0tCj4gIGlu
Y2x1ZGUvc291bmQvZG1hZW5naW5lX3BjbS5oIHwgICAyICstCj4gIHNvdW5kL3NvYy91eDUwMC9L
Y29uZmlnICAgICAgIHwgICAyICstCj4gIHNvdW5kL3NvYy91eDUwMC91eDUwMF9wY20uYyAgIHwg
MTU5ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE0NCBkZWxldGlvbnMoLSkKCkJ5IHJpZ2h0cyB5
b3UgcmVhbGx5IG5lZWQgT2xhJ3MgYXBwcm92YWwgb24gdGhpcywgYnV0IGJlY2F1c2U6CgphKSAu
Li4gdGhpcyByZW1vdmVzIGEgaGVsbCBvZiBhIGxvdCBvZiBvbGQgY29kZSwgYW5kCmIpIC4uLiB1
c2luZyB0aGUgbmV3IERNQSBBUElzIF9pc18gdGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8sIGFuZApj
KSAuLi4gdGhpcyBhaWRzIG1lIGluIGdldHRpbmcgdGhlIEQ0MCBETUEgY29udHJvbGxlciB1cC10
by1zY3JhdGNoLCBhbmQKZCkgLi4uIEkgaGF2ZSBwYXRjaGVzIHdoaWNoIHJlbHkgb24gdGhlc2Ug
Y2hhbmdlcywgYW5kCmUpIC4uLiB0aGUgZHJpdmVyIGlzIGFscmVhZHkgcHJldHR5IGJyb2tlbgoK
Li4uIHlvdSBjYW4gaGF2ZSBteTogQWNrZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1Fcmljc3NvbiBMYW5kaW5nIFRlYW0gTGVh
ZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93
IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
