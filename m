From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Wed, 6 Sep 2017 23:18:54 +0200
Message-ID: <14a174b2-df3b-73f2-a5c2-7bd4ca9b0882@denx.de>
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
 <20170906194748.GA31334@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 38AD92673FE
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 23:18:58 +0200 (CEST)
In-Reply-To: <20170906194748.GA31334@Asurada-Nvidia>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

T24gMDkvMDYvMjAxNyAwOTo0NyBQTSwgTmljb2xpbiBDaGVuIHdyb3RlOgo+IE9uIFdlZCwgU2Vw
IDA2LCAyMDE3IGF0IDA4OjM1OjUwUE0gKzAyMDAsIMWBdWthc3ogTWFqZXdza2kgd3JvdGU6Cj4g
ICAKPj4gCWNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19TU0kyX0lQRz4sCj4+IAkJIDwmY2xr
cyBJTVg2UURMX0NMS19TU0kyPjsKPj4gCWNsb2NrLW5hbWVzID0gImlwZyIsICJiYXVkIjsKPiAK
Pj4+PiAgIAkJCWRhaWxpbmtfbWFzdGVyOiBjcHUgewo+Pj4+ICAgCQkJICAgIHNvdW5kLWRhaSA9
IDwmc3NpMj47Cj4+Pj4gCQkJICAgIGNsb2NrID0gPCZTU1NTPjsKPj4KPj4gCUlmIHBvc3NpYmxl
IEkgZG8gcHJlZmVyIGEgc29sdXRpb24sIHdoaWNoIHVzZXMgb25seSBEVFMuCj4+IFNpZGUgcXVl
c3Rpb24gLSBob3cgdG8gcmVmZXIgdG8gYmF1ZCBjbG9jayBmcm9tIFsxXT8KPiAKPiBKdXN0IGFk
ZCBhIHByb3BlcnR5IHRvIHRoaXMgY3B1IG5vZGUgbGlrZToKPiAJY2xvY2sgPSA8JmNsa3MgSU1Y
NlFETF9DTEtfU1NJMj47CgpPay4KCj4gCj4+Pj4gCQkJICAgIHN5c3RlbS1jbG9jay1mcmVxdWVu
Y3kgPSA8WFhYWD47Cj4gCj4gVGhpcyB3b3VsZCBub3QgYmUgbmVjZXNzYXJ5IHVubGVzcyB5b3Ug
d2FudCB0byBzcGVjaWZ5IGEgY2xvY2sgcmF0ZQo+IHNvIGFzIHRvIG92ZXJyaWRlIHRoZSBjbG9j
ayByYXRlIGNvbmZpZ3VyYXRpb24gaW4gaHdfcGFyYW1zKCkuCgpPay4KCj4gCj4+PiBUaGlzIGlz
IHRoZSByaWdodCBzb2x1dGlvbiBiYXNlZCBvbiBjdXJyZW50IHNpbXBsZS1jYXJkIGRyaXZlci4g
Rm9yCj4+PiBTU0kgKGhhdmluZyB0d28gY2xvY2tzKSwgeW91IGhhdmUgdG8gc3BlY2lmeSB0aGUg
YmF1ZCBjbG9jayBpbiB0aGUKPj4+IGNwdSBub2RlIGxpa2UgdGhhdC4gSSBiZWxpZXZlIHRoaXMg
aXMgd2hhdCB0aGUgc2ltcGxlLWNhcmQgZGVzaWduZXIKPj4+IGV4cGVjdGVkIHVzZXJzIHRvIGRv
IHNpbmNlIHRoZSBjcHUgbm9kZSBpcyB0aGUgZmlyc3QgcGxhY2UgdGhhdCB0aGUKPj4+IGRyaXZl
ciB0cmllcyB0byBsb29rIGF0Lgo+Pgo+PiBJIHdpbGwgZ2l2ZSBhIHNob290IHRoZSBvcHRpb24g
d2l0aCBhZGRpbmcgdGhlIGlwZyBjbG9jay4KPiAKPiBObywgbm90IGlwZyBjbG9jay4gWW91IHNo
b3VsZCB1c2UgdGhlIHNlY29uZCBjbG9jayAtLSBiYXVkIGNsb2NrLgoKWWVzLiBDb3JyZWN0IC0g
dGhlIGJhdWQgY2xvY2suCgo+IAoKCi0tIApCZXN0IHJlZ2FyZHMsCgpMdWthc3ogTWFqZXdza2kK
Ci0tCgpERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGlyZWN0
b3I6IFdvbGZnYW5nIERlbmsKSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41
LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55ClBob25lOiAoKzQ5KS04MTQyLTY2OTg5LTEw
IEZheDogKCs0OSktODE0Mi02Njk4OS04MCBFbWFpbDogd2RAZGVueC5kZQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
