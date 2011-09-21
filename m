From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: Staticise
	nuc900_dma_getposition()
Date: Wed, 21 Sep 2011 14:49:21 +0800
Message-ID: <CAKT61h-wY4HaexDXf2tN+PVo1Bxhn75AoA4n1tg_mC3A3aAuJw@mail.gmail.com>
References: <1316587205.2824.1.camel@phoenix> <1316587369.2824.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 743D3103A68
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 08:49:41 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1385462fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 23:49:41 -0700 (PDT)
In-Reply-To: <1316587369.2824.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

MjAxMS85LzIxIEF4ZWwgTGluIDxheGVsLmxpbkBnbWFpbC5jb20+Ogo+IEl0IGlzIG5vdCB1c2Vk
IG91dHNpZGUgdGhpcyBkcml2ZXIgc28gbm8gbmVlZCB0byBtYWtlIHRoZSBzeW1ib2wgZ2xvYmFs
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGdtYWlsLmNvbT4KPiAtLS0K
PiDCoHNvdW5kL3NvYy9udWM5MDAvbnVjOTAwLXBjbS5jIHwgwqAgwqAyICstCj4gwqAxIGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9zb3VuZC9zb2MvbnVjOTAwL251YzkwMC1wY20uYyBiL3NvdW5kL3NvYy9udWM5MDAvbnVjOTAw
LXBjbS5jCj4gaW5kZXggZTQ2ZDU1MS4uNGUzNjI2YiAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2Mv
bnVjOTAwL251YzkwMC1wY20uYwo+ICsrKyBiL3NvdW5kL3NvYy9udWM5MDAvbnVjOTAwLXBjbS5j
Cj4gQEAgLTIyNyw3ICsyMjcsNyBAQCBzdGF0aWMgaW50IG51YzkwMF9kbWFfdHJpZ2dlcihzdHJ1
Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwgaW50IGNtZCkKPiDCoCDCoCDCoCDCoHJl
dHVybiByZXQ7Cj4gwqB9Cj4KPiAtaW50IG51YzkwMF9kbWFfZ2V0cG9zaXRpb24oc3RydWN0IHNu
ZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sCj4gK3N0YXRpYyBpbnQgbnVjOTAwX2RtYV9nZXRw
b3NpdGlvbihzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKPiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRtYV9hZGRy
X3QgKnNyYywgZG1hX2FkZHJfdCAqZHN0KQo+IMKgewo+IMKgIMKgIMKgIMKgc3RydWN0IHNuZF9w
Y21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0cmVhbS0+cnVudGltZTsKPiAtLQo+IDEuNy40LjEK
PgoKdGhhbmtzIQoKQWNrZWQtIGJ5OiBXYW4gWm9uZ3NodW4gPG1jdW9zLmNvbUBnbWFpbC5jb20+
Cgo+Cj4KPgoKCgotLSAKV2FuIFpvbmdTaHVuLgp3d3cubWN1b3MuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
