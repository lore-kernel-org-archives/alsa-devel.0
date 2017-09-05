From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk
 when it is equal to system freq
Date: Tue, 5 Sep 2017 20:20:51 -0300
Message-ID: <CAOMZO5BpEo2+kSrzkM90xS-h6i5Ozy8Wr2tn0pmhsXnY0x6Lrg@mail.gmail.com>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
 <20170905181108.GB23906@Asurada-Nvidia>
 <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A1EE26734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 01:20:53 +0200 (CEST)
Received: by mail-oi0-f48.google.com with SMTP id x190so17603069oix.3
 for <alsa-devel@alsa-project.org>; Tue, 05 Sep 2017 16:20:53 -0700 (PDT)
In-Reply-To: <cfb8f844-87aa-f1f3-bd55-4f2b60f3cf88@denx.de>
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

T24gVHVlLCBTZXAgNSwgMjAxNyBhdCA2OjEzIFBNLCDFgXVrYXN6IE1hamV3c2tpIDxsdWttYUBk
ZW54LmRlPiB3cm90ZToKCj4gJmkyYzEgewo+ICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDQw
MDAwMD47Cj4gICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ICAgICAgICAgcGlu
Y3RybC0wID0gPCZwaW5jdHJsX2kyYzE+Owo+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOwo+Cj4g
ICAgICAgICBjb2RlYzogdGZhOTg3OUA2QyB7Cj4gICAgICAgICAgICAgICAgICNzb3VuZC1kYWkt
Y2VsbHMgPSA8MD47Cj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAidGZhOTg3OSI7CgpU
aGlzIGNvZGVjIHNlZW1zIHRvIG1pc3MgZGV2aWNlIHRyZWUgc3VwcG9ydC4gRG9uJ3QgeW91IG5l
ZWQgc29tZXRoaW5nCmxpa2UgdGhpcz8KCi0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvdGZhOTg3OS5j
CisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvdGZhOTg3OS5jCkBAIC0zMTIsOSArMzEyLDE1IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCB0ZmE5ODc5X2kyY19pZFtdID0gewogfTsK
IE1PRFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCB0ZmE5ODc5X2kyY19pZCk7Cgorc3RhdGljIGNvbnN0
IHN0cnVjdCBvZl9kZXZpY2VfaWQgdGZhOTg3OV9vZl9tYXRjaFtdID0geworICAgICAgIHsgLmNv
bXBhdGlibGUgPSAibnhwLHRmYTk4NzkiLCB9LAorICAgICAgIHsgfQorfTsKKwogc3RhdGljIHN0
cnVjdCBpMmNfZHJpdmVyIHRmYTk4NzlfaTJjX2RyaXZlciA9IHsKICAgICAgICAuZHJpdmVyID0g
ewogICAgICAgICAgICAgICAgLm5hbWUgPSAidGZhOTg3OSIsCisgICAgICAgICAgICAgICAub2Zf
bWF0Y2hfdGFibGUgPSB0ZmE5ODc5X29mX21hdGNoLAogICAgICAgIH0sCiAgICAgICAgLnByb2Jl
ID0gdGZhOTg3OV9pMmNfcHJvYmUsCiAgICAgICAgLnJlbW92ZSA9IHRmYTk4NzlfaTJjX3JlbW92
ZSwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
