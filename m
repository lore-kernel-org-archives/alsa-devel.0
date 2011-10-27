From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Clear
 BIT_CLK_MASTER and WORD_CLK_MASTER bits for for slave mode
Date: Thu, 27 Oct 2011 10:17:06 +0100
Message-ID: <CABS+qY1jO8KzMF5S7B9tgk50SPtEALy04ML+3aPKyi3UfRQ=QQ@mail.gmail.com>
References: <1319704549.2673.2.camel@phoenix> <1319704722.2673.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id C0CBE246FB
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 11:17:08 +0200 (CEST)
Received: by mail-gx0-f169.google.com with SMTP id h4so2556777ggn.28
	for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2011 02:17:06 -0700 (PDT)
In-Reply-To: <1319704722.2673.5.camel@phoenix>
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
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

T24gMjcgT2N0b2JlciAyMDExIDA5OjM4LCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBBY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldDoKPgo+IFBhZ2UwIC8gUmVnaXN0ZXI4
OiBBdWRpbyBTZXJpYWwgRGF0YSBpbnRlcmZhY2UgQ29udHJvbCBSZWdpc3RlciBBCj4gQklUIDc6
IEJpdCBDbG9jayBEaXJlY3Rpb25hbCBDb250cm9sCj4gwqAgwqAgwqAgwqAwOiBCaXQgY2xvY2sg
aXMgYW4gaW5wdXQgKHNsYXZlIG1vZGUpCj4gwqAgwqAgwqAgwqAxOiBCaXQgY2xvY2sgaXMgYW4g
b3V0cHV0IChtYXN0ZXIgbW9kZSkKPgo+IEJJVCA2OiBXb3JkIENsb2NrIERpcmVjdGlvbmFsIENv
bnRyb2wKPiDCoCDCoCDCoCDCoDA6IFdvcmQgY2xvY2sgaXMgYW4gaW5wdXQgKHNsYXZlIG1vZGUp
Cj4gwqAgwqAgwqAgwqAxOiBXb3JkIGNsb2NrIGlzIGFuIG91dHB1dCAobWFzdGVyIG1vZGUpCj4K
PiBDdXJyZW50IGNvZGUgc2V0cyBCSVRfQ0xLX01BU1RFUiBhbmQgV09SRF9DTEtfTUFTVEVSIGJp
dHMgZm9yIG1hc3RlciBtb2RlLAo+IGJ1dCBkb2VzIG5vdCBjbGVhciB0aGVzZSBiaXRzIGZvciBz
bGF2ZSBtb2RlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGdtYWlsLmNv
bT4KPiAtLS0KPiDCoHNvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljM3guYyB8IMKgIMKgMSArCj4g
wqAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL3RsdjMyMGFpYzN4LmMgYi9zb3VuZC9zb2MvY29k
ZWNzL3RsdjMyMGFpYzN4LmMKPiBpbmRleCBhNzdmNmVhLi4xNGNiNTUzIDEwMDY0NAo+IC0tLSBh
L3NvdW5kL3NvYy9jb2RlY3MvdGx2MzIwYWljM3guYwo+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3Mv
dGx2MzIwYWljM3guYwo+IEBAIC0xMDIxLDYgKzEwMjEsNyBAQCBzdGF0aWMgaW50IGFpYzN4X3Nl
dF9kYWlfZm10KHN0cnVjdCBzbmRfc29jX2RhaSAqY29kZWNfZGFpLAo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnJlYWs7Cj4gwqAgwqAgwqAgwqBjYXNlIFNORF9TT0NfREFJRk1UX0NCU19DRlM6
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhaWMzeC0+bWFzdGVyID0gMDsKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmYWNlX2FyZWcgJj0gfihCSVRfQ0xLX01BU1RFUiB8IFdPUkRfQ0xLX01B
U1RFUik7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazsKPiDCoCDCoCDCoCDCoGRlZmF1
bHQ6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVJTlZBTDsKPiAtLQo+IDEuNy41
LjQKPgo+Cj4KPgoKQm90aAoKQWNrZWQtYnk6IExpYW0gR2lyZHdvb2QgPGxyZ0B0aS5jb20+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
