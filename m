From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: ad74111: new
	codec driver
Date: Sat, 26 Mar 2011 13:52:48 -0400
Message-ID: <AANLkTinAs+3g1KHDyxBTDze8MnFZn3X7b5vuQSM+yLsN@mail.gmail.com>
References: <1301128426-2817-1-git-send-email-vapier@gentoo.org>
	<20110326122108.GD28537@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B6A810389F
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 18:53:09 +0100 (CET)
Received: by fxm5 with SMTP id 5so1288267fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 10:53:09 -0700 (PDT)
In-Reply-To: <20110326122108.GD28537@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCBNYXIgMjYsIDIwMTEgYXQgMDg6MjEsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gU2F0
LCBNYXIgMjYsIDIwMTEgYXQgMDQ6MzM6NDZBTSAtMDQwMCwgTWlrZSBGcnlzaW5nZXIgd3JvdGU6
Cj4+IMKgIMKgIMKgIHNlbGVjdCBTTkRfU09DX0FEMTk4MCBpZiBTTkRfU09DX0FDOTdfQlVTCj4+
IC0gwqAgwqAgc2VsZWN0IFNORF9TT0NfQURTMTE3WAo+PiDCoCDCoCDCoCBzZWxlY3QgU05EX1NP
Q19BRDczMzExIGlmIEkyQwo+PiArIMKgIMKgIHNlbGVjdCBTTkRfU09DX0FENzQxMTEKPj4gKyDC
oCDCoCBzZWxlY3QgU05EX1NPQ19BRFMxMTdYCj4KPiBBIGZldyBvZiB5b3VyIHBhdGNoZXMgaGF2
ZSB0aGlzIHNvcnQgb2YgYWRkaXRpb25hbCBjaGFuZ2UgaW4gdGhlbS4KPiBXaGlsZSB0aGUgY2xl
YW51cCBpcyBnb29kIGl0IHdvdWxkIGJlIGJldHRlciB0byBzcGxpdCBpdCBpbnRvIGEgc2VwYXJh
dGUKPiBwYXRjaC4gwqBTZWVpbmcgdGhlIHVucmVsYXRlZCBjaGFuZ2Ugc2xvd3MgZG93biByZXZp
ZXcgYW5kIGl0J2xsIGFsc28KPiBjcmVhdGUgZXh0cmEgbWVyZ2UgaXNzdWVzIHdoZW4gYXBwbHlp
bmcgb3IgY2hlcnJ5IHBpY2tpbmcgdGhlIGRyaXZlcgo+IGJhY2sgdG8gb2xkZXIga2VybmVscy4K
CmluIGdlbmVyYWwgaSBhZ3JlZSwgYnV0IGZvciBtb3ZpbmcgbGl0ZXJhbGx5IG9uZSBsaW5lIGkg
ZG9udCBnZW5lcmFsbHkKd29ycnkgYWJvdXQgaXQKCj4+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBhZDc0MTExX2NvZGVjX2RyaXZlciA9IHsKPj4gKyDCoCDCoCAuZHJpdmVyID0gewo+
PiArIMKgIMKgIMKgIMKgIMKgIMKgIC5uYW1lID0gImFkNzQxMTEtY29kZWMiLAo+Cj4gQWdhaW4s
IGRyb3AgdGhlIC1jb2RlYyB1bmxlc3MgdGhpcyBpcyBwYXJ0IG9mIGEgTUZELgoKd2hlbiBpIGxv
b2tlZCBhdCB0aGUgaGlzdG9yeSBvZiB0aGluZ3MsIGl0IHNlZW1lZCBsaWtlIGl0J3MgdGhlIEFT
b0MKbWFpbnRhaW5lcnMgc3RpY2tpbmcgIi1jb2RlYyIgb24gc3R1ZmYuICBzbyBzaG91bGQgaSBn
byB0aHJvdWdoCmV4aXN0aW5nIGRyaXZlcnMgYW5kIHJldmVydCB0aGF0IGJhY2sgPwotbWlrZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
