From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm8996: Avoid a redundant
 i2c_get_clientdata call in wm8996_i2c_remove
Date: Mon, 24 Oct 2011 13:04:52 +0100
Message-ID: <CABS+qY00AkNJ2HbpK59Qjph_EPD7=caVyagTVE8okHrb74cnpA@mail.gmail.com>
References: <1319427072.5773.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id 75A042457A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 14:04:56 +0200 (CEST)
Received: by ggnq2 with SMTP id q2so5034488ggn.41
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 05:04:54 -0700 (PDT)
In-Reply-To: <1319427072.5773.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gMjQgT2N0b2JlciAyMDExIDA0OjMxLCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPgo+IC0t
LQo+IMKgc291bmQvc29jL2NvZGVjcy93bTg5OTYuYyB8IMKgIMKgMiArLQo+IMKgMSBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy93bTg5OTYuYyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204OTk2LmMKPiBp
bmRleCA2NDVjOTgwLi4zMjMyNGM5IDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204
OTk2LmMKPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3dtODk5Ni5jCj4gQEAgLTMxNDQsNyArMzE0
NCw3IEBAIHN0YXRpYyBfX2RldmV4aXQgaW50IHdtODk5Nl9pMmNfcmVtb3ZlKHN0cnVjdCBpMmNf
Y2xpZW50ICpjbGllbnQpCj4gwqAgwqAgwqAgwqBzbmRfc29jX3VucmVnaXN0ZXJfY29kZWMoJmNs
aWVudC0+ZGV2KTsKPiDCoCDCoCDCoCDCoGlmICh3bTg5OTYtPnBkYXRhLmxkb19lbmEgPiAwKQo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ3Bpb19mcmVlKHdtODk5Ni0+cGRhdGEubGRvX2VuYSk7
Cj4gLSDCoCDCoCDCoCBrZnJlZShpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KSk7Cj4gKyDCoCDC
oCDCoCBrZnJlZSh3bTg5OTYpOwo+IMKgIMKgIMKgIMKgcmV0dXJuIDA7Cj4gwqB9Cj4KCkFja2Vk
LWJ5OiBMaWFtIEdpcmR3b29kIDxscmdAdGkuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
