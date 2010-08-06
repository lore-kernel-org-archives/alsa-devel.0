From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: S3C64XX: Fix to support BCLK,
	LRCLK rates 	setting
Date: Fri, 6 Aug 2010 13:25:59 +0900
Message-ID: <AANLkTim2g4=j0TdYZb7QCbyZVJvhxMsCFa4yFokJCu1W@mail.gmail.com>
References: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
	<1281054999-18243-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id C145024441
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 06:26:08 +0200 (CEST)
Received: by vws20 with SMTP id 20so6407480vws.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 21:26:04 -0700 (PDT)
In-Reply-To: <1281054999-18243-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBBdWcgNiwgMjAxMCBhdCA5OjM2IEFNLCBTZXVuZ3doYW4gWW91biA8c3cueW91bkBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4gVGhpcyBwYXRjaCBmaXggdG8gc3VwcG9ydCBCQ0xLIGFuZCBM
UkNMSyByYXRlcyBzZXR0aW5nIGFzCj4gd204NTgwIE1hc3RlciBtb2RlLiBBZnRlciBhcHBseSB0
aGlzIHBhdGNoLCBMUkNMSyBhbmQgQkNMSwo+IHNpZ25hbCBhcHBlYXJzIGNvcnJlY3RseSBmcm9t
IHdtODU4MCBpbiBzb21lIGZyZXEuLCA4a0h6Cj4gYW5kIDExLjAyNWtIeiwgb24gU01ESyBib2Fy
ZC4KPgo+IFNpZ25lZC1vZmYtYnk6IFNldW5nd2hhbiBZb3VuIDxzdy55b3VuQHNhbXN1bmcuY29t
Pgo+IC0tLQo+IMKgc291bmQvc29jL3MzYzI0eHgvc21kazY0eHhfd204NTgwLmMgfCDCoCDCoDQg
KystLQo+IMKgMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL3MzYzI0eHgvc21kazY0eHhfd204NTgwLmMgYi9z
b3VuZC9zb2MvczNjMjR4eC9zbWRrNjR4eF93bTg1ODAuYwo+IGluZGV4IDM5YmI3MDEuLmYzZGJk
ZmIgMTAwNjQ0Cj4gLS0tIGEvc291bmQvc29jL3MzYzI0eHgvc21kazY0eHhfd204NTgwLmMKPiAr
KysgYi9zb3VuZC9zb2MvczNjMjR4eC9zbWRrNjR4eF93bTg1ODAuYwo+IEBAIC0xMjQsMTEgKzEy
NCwxMSBAQCBzdGF0aWMgaW50IHNtZGs2NHh4X2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJz
dHJlYW0gKnN1YnN0cmVhbSwKPiDCoCDCoCDCoCDCoGlmIChyZXQgPCAwKQo+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIHJldDsKPgo+IC0gwqAgwqAgwqAgcmV0ID0gc25kX3NvY19kYWlf
c2V0X2Nsa2RpdihjcHVfZGFpLCBTM0NfSTJTVjJfRElWX0JDTEssIGJmcyk7Cj4gKyDCoCDCoCDC
oCByZXQgPSBzbmRfc29jX2RhaV9zZXRfY2xrZGl2KGNvZGVjX2RhaSwgV004NTgwX0JDTEtfUkFU
RSwgYmZzKTsKPiDCoCDCoCDCoCDCoGlmIChyZXQgPCAwKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIHJldDsKPgo+IC0gwqAgwqAgwqAgcmV0ID0gc25kX3NvY19kYWlfc2V0X2Nsa2Rp
dihjcHVfZGFpLCBTM0NfSTJTVjJfRElWX1JDTEssIHJmcyk7Cj4gKyDCoCDCoCDCoCByZXQgPSBz
bmRfc29jX2RhaV9zZXRfY2xrZGl2KGNvZGVjX2RhaSwgV004NTgwX0xSQ0xLX1JBVEUsIHJmcyk7
Cj4gwqAgwqAgwqAgwqBpZiAocmV0IDwgMCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biByZXQ7CgpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRl
dmVsLzIwMDktU2VwdGVtYmVyLzAyMTAwNS5odG1sCmlzIHdoYXQgSSBtZWFudCBhIGZldyBkYXlz
IGFnbyB3aGVuIEkgc2FpZCBpdCBzaG91bGQgYmUgZG9uZSBwcm9wZXJseS4KCkFsc28sIEkgYW0g
bm90IHN1cmUgaWYgd2UgY2FuIGRvIHdpdGhvdXQgc2V0dGluZyBSRlMsQkZTIG9uIENQVSBzaWRl
CmV2ZW4gaW4gc2xhdmUgbW9kZS4gV2UgbmVlZCB0byBjb25maXJtLgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
