From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Thu, 7 Sep 2017 17:39:16 -0700
Message-ID: <20170908003915.GA9464@Asurada-Nvidia>
References: <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
 <20170906173348.GA28104@Asurada-Nvidia>
 <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
 <20170906194748.GA31334@Asurada-Nvidia>
 <76aeecd9-bff8-7b25-ca10-73d0743f724e@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f53.google.com (mail-pg0-f53.google.com [74.125.83.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 52DCB266943
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 02:38:52 +0200 (CEST)
Received: by mail-pg0-f53.google.com with SMTP id v66so2173103pgb.5
 for <alsa-devel@alsa-project.org>; Thu, 07 Sep 2017 17:38:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <76aeecd9-bff8-7b25-ca10-73d0743f724e@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBTZXAgMDgsIDIwMTcgYXQgMDE6MTA6MTJBTSArMDIwMCwgxYF1a2FzeiBNYWpld3Nr
aSB3cm90ZToKCj4gPkp1c3QgYWRkIGEgcHJvcGVydHkgdG8gdGhpcyBjcHUgbm9kZSBsaWtlOgo+
ID4JY2xvY2sgPSA8JmNsa3MgSU1YNlFETF9DTEtfU1NJMj47Cj4gCj4gVGhpcyBkb2Vzbid0IHNv
bHZlIHRoZSBpc3N1ZToKCkkgaGF2ZSBhIHBhdGNoIGxvY2FsbHkgdGhhdCBzaG91bGQgYmUgYWJs
ZSB0byBzb2x2ZSB5b3VyIHByb2JsZW0uCkJ1dCBJIG5lZWQgdG8gZmlyc3QgdmVyaWZ5IG9uIG15
IGJvYXJkIHRvbmlnaHQgYW5kIHdpbGwgc2VuZCBpdApsYXRlciAod2lsbCBwdXQgeW91IGluIHRo
ZSBUTy9DQyBsaXN0KS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRl
dmVsCg==
