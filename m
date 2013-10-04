From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
Date: Fri, 4 Oct 2013 15:10:00 -0300
Message-ID: <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk> <524D963F.5080507@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 9254F26162E
 for <alsa-devel@alsa-project.org>; Fri,  4 Oct 2013 20:10:00 +0200 (CEST)
Received: by mail-wg0-f54.google.com with SMTP id m15so4634058wgh.9
 for <alsa-devel@alsa-project.org>; Fri, 04 Oct 2013 11:10:00 -0700 (PDT)
In-Reply-To: <524D963F.5080507@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Philippe_R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

SGkgUGhpbGlwcGUsCgpPbiBUaHUsIE9jdCAzLCAyMDEzIGF0IDE6MDcgUE0sIFBoaWxpcHBlIFLD
qXRvcm5hego8cGhpbGlwcGUucmV0b3JuYXpAZXBmbC5jaD4gd3JvdGU6Cgo+IEl0IHdhcyB3b3Jr
aW5nIGJ1dCBpdCBpcyBicm9rZW4gc2luY2UgYSBmZXcgcmVsZWFzZS4KPiBUaGVyZSBpcyBubyBu
ZWVkIHRvIHJ1c2ggZm9yIGEgZml4LCBib3RoIHBhdGNoZXMgY2FuIGZvbGxvdyB0aGUgc3RhbmRh
cmQKPiBwcm9jZXNzLgoKVGhhbmtzIGZvciB0aGUgZml4LgoKSWYgeW91IGhhdmUgYSBjaGFuY2Us
IGl0IHdvdWxkIGJlIHJlYWxseSBuaWNlIGlmIG14MzEtbW9ib2FyZCBjb3VsZCBiZQpjb252ZXJ0
ZWQgdG8gZGV2aWNlIHRyZWUsIGFzIHRoaXMgd291bGQgaGVscCB1cyB0b3dhcmRzIHRoZSBnb2Fs
IG9mCmdldHRpbmcgcmlkIG9mIHRoZSBzb3VuZC9zb2MvZnNsL2lteC1zc2kuYyBkcml2ZXIsIHdo
aWNoIG9ubHkgc3VwcG9ydHMKdGhlIG5vbi1kdCBpbXggcGFydHMuCgpXZSBoYXZlIGJlZW4gdXNp
bmcgIHNvdW5kL3NvYy9mc2wvZnNsX3NzaS5jIGZvciB0aGUgZHQgaW14IGFuZCBwb3dlcnBjCnBh
cnRzLCBhbmQgdGhhdCdzIHByb2JhYmx5IHRoZSByZWFzb24gd2UgaGF2ZW4ndCBub3RpY2VkIHRo
aXMgYnVnLgoKUmVnYXJkcywKCkZhYmlvIEVzdGV2YW0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
