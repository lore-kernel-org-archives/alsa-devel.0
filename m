From: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH RFT] ASoC: mc13783: Fix wrong mask value
 used in mc13xxx_reg_rmw() calls
Date: Thu, 30 Apr 2015 09:17:52 +0200
Message-ID: <5541D720.9040002@epfl.ch>
References: <1430117495.28082.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp0.epfl.ch (smtp0.epfl.ch [128.178.224.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C3F82614B0
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 09:17:58 +0200 (CEST)
In-Reply-To: <1430117495.28082.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, SaschaHauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgpMZSAyNy4gMDQuIDE1IDA4OjUxLCBBeGVsIExpbiBhIMOpY3JpdCA6Cj4gbWMxM3h4
eF9yZWdfcm13KCkgd29uJ3QgY2hhbmdlIGFueSBiaXQgaWYgcGFzc2luZyAwIHRvIHRoZSBtYXNr
IGZpZWxkLgo+IFBhc3MgQVVESU9fU1NJX1NFTCBpbnN0ZWFkIG9mIDAgZm9yIHRoZSBtYXNrIGZp
ZWxkIHRvIHNldCBBVURJT19TU0lfU0VMCj4gYml0Lgo+CgpJJ20gc29ycnkgYnV0IEkgZG9uJ3Qg
aGF2ZSBhY2Nlc3MgdG8gdGhlIGhhcmR3YXJlIGFueW1vcmUuCk1heWJlIEZhYmlvIEVzdGV2YW0g
b3IgU2hhd24gR3VvIGNhbiB0ZXN0IGl0LgoKUmVnYXJkcywKClBoaWxpcHBlCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
