From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Sun, 3 Sep 2017 12:29:53 -0300
Message-ID: <CAOMZO5Bifb8VcOLTd5dEY9KvnvY1jwVr4R4DVRT65Yzm7n6dpA@mail.gmail.com>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F2790266F0D
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 17:29:55 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id t75so30010663oie.3
 for <alsa-devel@alsa-project.org>; Sun, 03 Sep 2017 08:29:55 -0700 (PDT)
In-Reply-To: <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@denx.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCBTZXAgMywgMjAxNyBhdCAxMTo0MCBBTSwgxYF1a2FzeiBNYWpld3NraSA8bHVrbWFA
ZGVueC5kZT4gd3JvdGU6Cgo+IFRoaXMgaXMgdGhlIHBhcnQgb2YgZnNsX3NzaV9zZXRfYmNsaygp
IGZ1bmN0aW9uIHdoaWNoIGlzIGNhbGxlZCBhZnRlcgo+IGZzbF9zc2lfc2V0X2RhaV9zeXNjbGso
KSAod2hpY2ggc2V0cyBzc2lfcHJpdmF0ZS0+Yml0Y2xrX2ZyZXEgPSBmcmVxOykuCj4KPiBCZWZv
cmUgdGhlIGFmb3JlbWVudGlvbmVkIGNoZWNrIHdlIGRvIGhhdmU6Cj4KPiAgICAgICAgIGlmIChz
c2lfcHJpdmF0ZS0+Yml0Y2xrX2ZyZXEpCj4gICAgICAgICAgICAgICAgIGZyZXEgPSBzc2lfcHJp
dmF0ZS0+Yml0Y2xrX2ZyZXE7Cj4gICAgICAgICBlbHNlCj4gICAgICAgICAgICAgICAgIGZyZXEg
PSBwYXJhbXNfY2hhbm5lbHMoaHdfcGFyYW1zKSAqIDMyICoKPiBwYXJhbXNfcmF0ZShod19wYXJh
bXMpOwo+Cj4KPiBXaGljaCBhc3NpZ25zIGZyZXEgPSBiaXRjbGtfZnJlcSAoNjYgTUh6KQo+Cj4g
QW5kIHRoZW4gd2UgYnJlYWsgb24gdGhpcyBwYXJ0aWN1bGFyIGNoZWNrOgo+Cj4gNjZNSHogKiA1
ID4gNjYgTUh6Lgo+Cj4KPgo+IFRoZSBjdWxwcml0IElNSE8gaXMgdGhlICBzc2lfcHJpdmF0ZS0+
Yml0Y2xrX2ZyZXEgPSBmcmVxOyBpbiB0aGUKPiBmc2xfc3NpX3NldF9kYWlfc3lzY2xrKCksIHNp
bmNlIHdlIF9zaG91bGRfIHNldCBTU0kncyBJUCBibG9jayBjbG9jawo+IChzc2lfcHJpdmF0ZS0+
Y2xrKSwgbm90IHRoZSBiaXQgY2xvY2sgKEJDTEspLgo+Cj4KPiBUaGlzIHBhdGNoIGp1c3QgcXVp
dHMgZWFybHkgaWYgaXQgZGV0ZWN0cyBjaGFuZ2UsIHdoaWNoIGRvbid0IG5lZWQgdG8gYmUKPiBk
b25lLgoKVGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KClJldmlld2VkLWJ5OiBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
