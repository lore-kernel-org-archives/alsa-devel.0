From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm8400: Fix setting Fout clock
 divider for FLL Control 4
Date: Mon, 24 Oct 2011 13:04:10 +0100
Message-ID: <CABS+qY2wt_Rq74uO2OpPFkquX-noPUU1tiZ9wcs9fzpJ6EYC=w@mail.gmail.com>
References: <1319294907.2678.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id C11C02457A
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 14:04:12 +0200 (CEST)
Received: by mail-yx0-f179.google.com with SMTP id 30so1926638yxk.10
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2011 05:04:10 -0700 (PDT)
In-Reply-To: <1319294907.2678.2.camel@phoenix>
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

T24gMjIgT2N0b2JlciAyMDExIDE1OjQ4LCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBXaGF0IHdlIHdhbnQgaGVyZSBpcyB0byBjbGVhciB0aGUgV004NDAwX0ZMTF9PVVRE
SVZfTUFTSyBiaXRzIHRoZW4KPiBPUiB3aXRoIGZhY3RvcnMub3V0ZGl2Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQXhlbCBMaW4gPGF4ZWwubGluQGdtYWlsLmNvbT4KPiAtLS0KPiDCoHNvdW5kL3NvYy9j
b2RlY3Mvd204NDAwLmMgfCDCoCDCoDIgKy0KPiDCoDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3Mv
d204NDAwLmMgYi9zb3VuZC9zb2MvY29kZWNzL3dtODQwMC5jCj4gaW5kZXggZGMxM2JlMi4uZjI5
YmMyNiAxMDA2NDQKPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3dtODQwMC5jCj4gKysrIGIvc291
bmQvc29jL2NvZGVjcy93bTg0MDAuYwo+IEBAIC0xMDU5LDcgKzEwNTksNyBAQCBzdGF0aWMgaW50
IHdtODQwMF9zZXRfZGFpX3BsbChzdHJ1Y3Qgc25kX3NvY19kYWkgKmNvZGVjX2RhaSwgaW50IHBs
bF9pZCwKPiDCoCDCoCDCoCDCoHdtODQwMF93cml0ZShjb2RlYywgV004NDAwX0ZMTF9DT05UUk9M
XzMsIGZhY3RvcnMubik7Cj4KPiDCoCDCoCDCoCDCoHJlZyA9IHdtODQwMF9yZWFkKGNvZGVjLCBX
TTg0MDBfRkxMX0NPTlRST0xfNCk7Cj4gLSDCoCDCoCDCoCByZWcgJj0gV004NDAwX0ZMTF9PVVRE
SVZfTUFTSzsKPiArIMKgIMKgIMKgIHJlZyAmPSB+V004NDAwX0ZMTF9PVVRESVZfTUFTSzsKPiDC
oCDCoCDCoCDCoHJlZyB8PSBmYWN0b3JzLm91dGRpdjsKPiDCoCDCoCDCoCDCoHdtODQwMF93cml0
ZShjb2RlYywgV004NDAwX0ZMTF9DT05UUk9MXzQsIHJlZyk7Cj4KPiAtLQo+IDEuNy41LjQKPgo+
Cj4KPgoKQWNrZWQtYnk6IExpYW0gR2lyZHdvb2QgPGxyZ0B0aS5jb20+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
