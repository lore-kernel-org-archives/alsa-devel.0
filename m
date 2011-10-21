From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm8996: Fix wrong mask for setting
	WM8996_AIF_CLOCKING_2
Date: Fri, 21 Oct 2011 17:51:24 +0100
Message-ID: <CABS+qY198r1f2OtTPi7miXNUiL8-eO5Ve0f=5HqPD7dPXXtGVQ@mail.gmail.com>
References: <1319165047.4352.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id EAF661037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 18:51:26 +0200 (CEST)
Received: by mail-gy0-f170.google.com with SMTP id 5so4631071gyd.29
	for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2011 09:51:24 -0700 (PDT)
In-Reply-To: <1319165047.4352.4.camel@phoenix>
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

T24gMjEgT2N0b2JlciAyMDExIDAzOjQ0LCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBTaWduZWQtb2ZmLWJ5OiBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPgo+IC0t
LQo+IMKgc291bmQvc29jL2NvZGVjcy93bTg5OTYuYyB8IMKgIMKgMiArLQo+IMKgMSBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
c291bmQvc29jL2NvZGVjcy93bTg5OTYuYyBiL3NvdW5kL3NvYy9jb2RlY3Mvd204OTk2LmMKPiBp
bmRleCAxZDdiMTc0Li42NDVjOTgwIDEwMDY0NAo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204
OTk2LmMKPiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3dtODk5Ni5jCj4gQEAgLTE5MjAsNyArMTky
MCw3IEBAIHN0YXRpYyBpbnQgd204OTk2X2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJl
YW0gKnN1YnN0cmVhbSwKPiDCoCDCoCDCoCDCoHNuZF9zb2NfdXBkYXRlX2JpdHMoY29kZWMsIGxy
Y2xrX3JlZywgV004OTk2X0FJRjFSWF9SQVRFX01BU0ssCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBscmNsayk7Cj4gwqAgwqAgwqAgwqBzbmRfc29jX3VwZGF0ZV9i
aXRzKGNvZGVjLCBXTTg5OTZfQUlGX0NMT0NLSU5HXzIsCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBXTTg5OTZfRFNQMV9ESVZfU0hJRlQgPDwgZHNwX3NoaWZ0LCBk
c3ApOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgV004OTk2X0RT
UDFfRElWX01BU0sgPDwgZHNwX3NoaWZ0LCBkc3ApOwo+Cj4gwqAgwqAgwqAgwqByZXR1cm4gMDsK
PiDCoH0KPiAtLQo+IDEuNy41LjQKPgoKQWNrZWQtYnk6IExpYW0gR2lyZHdvb2QgPGxyZ0B0aS5j
b20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
