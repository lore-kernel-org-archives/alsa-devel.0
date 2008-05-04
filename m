From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.25.1] S3C2410 i2s programming error
Date: Sun, 04 May 2008 15:31:55 +0100
Message-ID: <1209911515.3923.5.camel@odin>
References: <481DB377.2050208@elpa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED8852454E
	for <alsa-devel@alsa-project.org>;
	Sun,  4 May 2008 16:32:01 +0200 (CEST)
In-Reply-To: <481DB377.2050208@elpa.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ing. Davide Rizzo" <davide@elpa.it>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>, ben-linux <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCAyMDA4LTA1LTA0IGF0IDE1OjAwICswMjAwLCBpbmcuIERhdmlkZSBSaXp6byB3cm90
ZToKPiBTM0MyNDEwIGkycyBkcml2ZXIgY3VycmVudGx5IG1hbmFnZXMgb25seSBpMnMgcHJvdG9j
b2wgKGFuZCBub3QgbGVmdCAKPiBqdXN0aWZpZWQgb25lKSBhbmQgc2xhdmUgbW9kZS4KPiBXaXRo
IHRoaXMgc21hbGwgcGF0Y2gsIG90aGVyIG1vZGVzIGFyZSBwb3NzaWJsZS4KPiBEYXZpZGUKPiAK
PiAKPiBwbGFpbiB0ZXh0IGRvY3VtZW50IGF0dGFjaG1lbnQgKHMzYzI0eHgtaTJzLnBhdGNoKQo+
IFRoaXMgcGF0Y2ggdG8gY29ycmVjdGx5IG1hbmFnZSBjb2RlY3MgaW4gc2xhdmUgbW9kZSBhbmQg
bGVmdC1qdXN0aWZpZWQgZm9ybWF0Cj4gCj4gU2lnbmVkLW9mZi1ieTogRGF2aWRlIFJpenpvIDxk
YXZpZGVAZWxwYS5pdD4KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IC0tLSBsaW51eC0yLjYu
MjUuMS9zb3VuZC9zb2MvczNjMjR4eC9zM2MyNHh4LWkycy5jCTIwMDgtMDQtMTcgMDQ6NDk6NDQu
MDAwMDAwMDAwICswMjAwCj4gKysrIGxpbnV4LTIuNi4yNS4xLmVscGEvc291bmQvc29jL3MzYzI0
eHgvczNjMjR4eC1pMnMuYwkyMDA4LTA1LTA0IDA5OjIzOjM0LjAwMDAwMDAwMCArMDIwMAo+IEBA
IC0yMjQsNiArMjI0LDcgQEAgc3RhdGljIGludCBzM2MyNHh4X2kyc19zZXRfZm10KHN0cnVjdCBz
bgo+ICAJCWlpc21vZCB8PSBTM0MyNDEwX0lJU01PRF9TTEFWRTsKPiAgCQlicmVhazsKPiAgCWNh
c2UgU05EX1NPQ19EQUlGTVRfQ0JTX0NGUzoKPiArCQlpaXNtb2QgJj0gflMzQzI0MTBfSUlTTU9E
X1NMQVZFOwo+ICAJCWJyZWFrOwo+ICAJZGVmYXVsdDoKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiBA
QCAtMjM0LDYgKzIzNSw3IEBAIHN0YXRpYyBpbnQgczNjMjR4eF9pMnNfc2V0X2ZtdChzdHJ1Y3Qg
c24KPiAgCQlpaXNtb2QgfD0gUzNDMjQxMF9JSVNNT0RfTVNCOwo+ICAJCWJyZWFrOwo+ICAJY2Fz
ZSBTTkRfU09DX0RBSUZNVF9JMlM6Cj4gKwkJaWlzbW9kICY9IH5TM0MyNDEwX0lJU01PRF9NU0I7
Cj4gIAkJYnJlYWs7Cj4gIAlkZWZhdWx0Ogo+ICAJCXJldHVybiAtRUlOVkFMOwo+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KCu+7v0Fja2VkLWJ5OiBMaWFtIEdpcmR3b29kIDxsZ0BvcGVuc291cmNlLndvbGZzb25taWNy
by5jb20+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
