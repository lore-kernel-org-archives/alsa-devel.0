From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix reg_word_size for ak4104
Date: Thu, 20 Oct 2011 10:46:28 +0100
Message-ID: <CABS+qY0z9E6_UsUcN34+Kjsid_RnpCufHxJxhez_f7-VX49BwA@mail.gmail.com>
References: <1319079003.5380.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 2836D24719
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 11:46:29 +0200 (CEST)
Received: by mail-yx0-f177.google.com with SMTP id 36so2923840yxk.8
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2011 02:46:28 -0700 (PDT)
In-Reply-To: <1319079003.5380.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAgT2N0b2JlciAyMDExIDAzOjUwLCBBeGVsIExpbiA8YXhlbC5saW5AZ21haWwuY29tPiB3
cm90ZToKPiBBY2NvcmRpbmcgdG8gdGhlIHJlZ2lzdGVyIG1hcCBpbiBkYXRhc2hlZXQsIHRoZSBy
ZWdpc3RlcnMgYXJlIDggYml0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4ZWwubGlu
QGdtYWlsLmNvbT4KPiAtLS0KPiDCoHNvdW5kL3NvYy9jb2RlY3MvYWs0MTA0LmMgfCDCoCDCoDIg
Ky0KPiDCoDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvYWs0MTA0LmMgYi9zb3VuZC9zb2MvY29k
ZWNzL2FrNDEwNC5jCj4gaW5kZXggY2JmMGI2ZC4uZDNiMjlkYyAxMDA2NDQKPiAtLS0gYS9zb3Vu
ZC9zb2MvY29kZWNzL2FrNDEwNC5jCj4gKysrIGIvc291bmQvc29jL2NvZGVjcy9hazQxMDQuYwo+
IEBAIC0yNDcsNyArMjQ3LDcgQEAgc3RhdGljIHN0cnVjdCBzbmRfc29jX2NvZGVjX2RyaXZlciBz
b2NfY29kZWNfZGV2aWNlX2FrNDEwNCA9IHsKPiDCoCDCoCDCoCDCoC5wcm9iZSA9IMKgIMKgIMKg
IMKgYWs0MTA0X3Byb2JlLAo+IMKgIMKgIMKgIMKgLnJlbW92ZSA9IMKgIMKgIMKgIGFrNDEwNF9y
ZW1vdmUsCj4gwqAgwqAgwqAgwqAucmVnX2NhY2hlX3NpemUgPSBBSzQxMDRfTlVNX1JFR1MsCj4g
LSDCoCDCoCDCoCAucmVnX3dvcmRfc2l6ZSA9IHNpemVvZih1MTYpLAo+ICsgwqAgwqAgwqAgLnJl
Z193b3JkX3NpemUgPSBzaXplb2YodTgpLAo+IMKgfTsKPgo+IMKgc3RhdGljIGludCBhazQxMDRf
c3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCj4gLS0KPiAxLjcuNS40Cj4KCkFja2Vk
LWJ5OiBMaWFtIEdpcmR3b29kIDxscmdAdGkuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVs
QGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
