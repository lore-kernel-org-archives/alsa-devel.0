From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Wed, 6 Sep 2017 12:47:49 -0700
Message-ID: <20170906194748.GA31334@Asurada-Nvidia>
References: <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
 <20170905225225.GA14132@Asurada-Nvidia>
 <ae1d3e2a-d618-05e2-1572-5593caff1ee0@denx.de>
 <20170906173348.GA28104@Asurada-Nvidia>
 <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 59893266A8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 21:47:26 +0200 (CEST)
Received: by mail-pf0-f169.google.com with SMTP id g13so14333512pfm.2
 for <alsa-devel@alsa-project.org>; Wed, 06 Sep 2017 12:47:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <69352458-2e90-a847-2c2f-bba259a32162@denx.de>
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

T24gV2VkLCBTZXAgMDYsIDIwMTcgYXQgMDg6MzU6NTBQTSArMDIwMCwgxYF1a2FzeiBNYWpld3Nr
aSB3cm90ZToKIAo+IAljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfU1NJMl9JUEc+LAo+IAkJ
IDwmY2xrcyBJTVg2UURMX0NMS19TU0kyPjsKPiAJY2xvY2stbmFtZXMgPSAiaXBnIiwgImJhdWQi
OwoKPiA+PiAgCQkJZGFpbGlua19tYXN0ZXI6IGNwdSB7Cj4gPj4gIAkJCSAgICBzb3VuZC1kYWkg
PSA8JnNzaTI+Owo+ID4+CQkJICAgIGNsb2NrID0gPCZTU1NTPjsKPiAKPiAJSWYgcG9zc2libGUg
SSBkbyBwcmVmZXIgYSBzb2x1dGlvbiwgd2hpY2ggdXNlcyBvbmx5IERUUy4KPiBTaWRlIHF1ZXN0
aW9uIC0gaG93IHRvIHJlZmVyIHRvIGJhdWQgY2xvY2sgZnJvbSBbMV0/CgpKdXN0IGFkZCBhIHBy
b3BlcnR5IHRvIHRoaXMgY3B1IG5vZGUgbGlrZToKCWNsb2NrID0gPCZjbGtzIElNWDZRRExfQ0xL
X1NTSTI+OwoKPiA+PgkJCSAgICBzeXN0ZW0tY2xvY2stZnJlcXVlbmN5ID0gPFhYWFg+OwoKVGhp
cyB3b3VsZCBub3QgYmUgbmVjZXNzYXJ5IHVubGVzcyB5b3Ugd2FudCB0byBzcGVjaWZ5IGEgY2xv
Y2sgcmF0ZQpzbyBhcyB0byBvdmVycmlkZSB0aGUgY2xvY2sgcmF0ZSBjb25maWd1cmF0aW9uIGlu
IGh3X3BhcmFtcygpLgoKPiA+VGhpcyBpcyB0aGUgcmlnaHQgc29sdXRpb24gYmFzZWQgb24gY3Vy
cmVudCBzaW1wbGUtY2FyZCBkcml2ZXIuIEZvcgo+ID5TU0kgKGhhdmluZyB0d28gY2xvY2tzKSwg
eW91IGhhdmUgdG8gc3BlY2lmeSB0aGUgYmF1ZCBjbG9jayBpbiB0aGUKPiA+Y3B1IG5vZGUgbGlr
ZSB0aGF0LiBJIGJlbGlldmUgdGhpcyBpcyB3aGF0IHRoZSBzaW1wbGUtY2FyZCBkZXNpZ25lcgo+
ID5leHBlY3RlZCB1c2VycyB0byBkbyBzaW5jZSB0aGUgY3B1IG5vZGUgaXMgdGhlIGZpcnN0IHBs
YWNlIHRoYXQgdGhlCj4gPmRyaXZlciB0cmllcyB0byBsb29rIGF0Lgo+IAo+IEkgd2lsbCBnaXZl
IGEgc2hvb3QgdGhlIG9wdGlvbiB3aXRoIGFkZGluZyB0aGUgaXBnIGNsb2NrLgoKTm8sIG5vdCBp
cGcgY2xvY2suIFlvdSBzaG91bGQgdXNlIHRoZSBzZWNvbmQgY2xvY2sgLS0gYmF1ZCBjbG9jay4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
