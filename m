From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH v4] ASoC:Add support for cs42l73 codec
Date: Wed, 19 Oct 2011 09:06:01 +0100
Message-ID: <CABS+qY1+dRRA62a5fSJRP+fvPk2Qdje28jRVRhnwaFMDsEpAmQ@mail.gmail.com>
References: <1318950707-14810-1-git-send-email-brian.austin@cirrus.com>
	<EE888F3C-2F08-4F08-928F-4319AD617E00@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id E1175243F7
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 10:06:08 +0200 (CEST)
Received: by mail-yx0-f174.google.com with SMTP id 4so1414323yxp.19
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 01:06:01 -0700 (PDT)
In-Reply-To: <EE888F3C-2F08-4F08-928F-4319AD617E00@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "<vinod.koul@linux.intel.com>" <vinod.koul@linux.intel.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<broonie@opensource.wolfsonmicro.com>" <broonie@opensource.wolfsonmicro.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gMTggT2N0b2JlciAyMDExIDE2OjQ2LCBBdXN0aW4sIEJyaWFuIDxCcmlhbi5BdXN0aW5AY2ly
cnVzLmNvbT4gd3JvdGU6Cj4KPiBPbiBPY3QgMTgsIDIwMTEsIGF0IDEwOjExIEFNLCBCcmlhbiBB
dXN0aW4gd3JvdGU6Cj4KPj4gU2lnbmVkLW9mZi1ieTpCcmlhbiBBdXN0aW4gPGJyaWFuLmF1c3Rp
bkBjaXJydXMuY29tPgo+PiBTaWduZWQtb2ZmLWJ5Okdlb3JnaSBWbGFldiA8am9lQG51Y2xldXN5
cy5jb20+Cj4+Cj4+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBDaXJydXMgTG9naWMgQ1M0
Mkw3Mwo+PiBsb3cgcG93ZXIgc3RlcmVvIGNvZGVjLgo+PiAtLS0KPj4gc291bmQvc29jL2NvZGVj
cy9LY29uZmlnIMKgIHwgwqAgMTIgKwo+PiBzb3VuZC9zb2MvY29kZWNzL01ha2VmaWxlIMKgfCDC
oCDCoDQgKwo+PiBzb3VuZC9zb2MvY29kZWNzL2NzNDJsNzMuYyB8IDEwNzAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gc291bmQvc29jL2NvZGVjcy9jczQy
bDczLmggfCDCoDIyNyArKysrKysrKysrCj4+IDQgZmlsZXMgY2hhbmdlZCwgMTMxMyBpbnNlcnRp
b25zKCspLCAwIGRlbGV0aW9ucygtKQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgc291bmQvc29jL2Nv
ZGVjcy9jczQybDczLmMKPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9jb2RlY3MvY3M0
Mmw3My5oCj4+Cj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL0tjb25maWcgYi9zb3Vu
ZC9zb2MvY29kZWNzL0tjb25maWcKPj4gaW5kZXggNDU4NDUxNC4uMjJhYjJmYyAxMDA2NDQKPj4g
LS0tIGEvc291bmQvc29jL2NvZGVjcy9LY29uZmlnCj4+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3Mv
S2NvbmZpZwo+PiBAQCAtMjgsNiArMjgsOCBAQCBjb25maWcgU05EX1NPQ19BTExfQ09ERUNTCj4+
IMKgIMKgIMKgIHNlbGVjdCBTTkRfU09DX0FMQzU2MjMgaWYgSTJDCj4+IMKgIMKgIMKgIHNlbGVj
dCBTTkRfU09DX0NRMDA5M1ZDIGlmIE1GRF9EQVZJTkNJX1ZPSUNFQ09ERUMKPj4gwqAgwqAgwqAg
c2VsZWN0IFNORF9TT0NfQ1M0Mkw1MSBpZiBJMkMKPj4gKyDCoCDCoCBzZWxlY3QgU05EX1NPQ19D
UzQyTDUyIGlmIEkyQwo+PiArIMKgIMKgIHNlbGVjdCBTTkRfU09DX0NTNDJMNzMgaWYgSTJDCj4+
IMKgIMKgIMKgIHNlbGVjdCBTTkRfU09DX0NTNDI3MCBpZiBJMkMKPj4gwqAgwqAgwqAgc2VsZWN0
IFNORF9TT0NfQ1M0MjcxIGlmIFNORF9TT0NfSTJDX0FORF9TUEkKPj4gwqAgwqAgwqAgc2VsZWN0
IFNORF9TT0NfQ1gyMDQ0Mgo+PiBAQCAtMTc1LDYgKzE3NywxNiBAQCBjb25maWcgU05EX1NPQ19D
UTAwOTNWQwo+PiBjb25maWcgU05EX1NPQ19DUzQyTDUxCj4+IMKgIMKgIMKgIHRyaXN0YXRlCj4+
Cj4+ICtjb25maWcgU05EX1NPQ19DUzQyTDUyCj4+ICsgwqAgwqAgdHJpc3RhdGUKPj4gKwo+PiAr
Y29uZmlnIFNORF9TT0NfQ1M0Mkw3Mwo+PiArIMKgIMKgIHRyaXN0YXRlCj4+ICsKPj4gK2NvbmZp
ZyBTTkRfU09DX0NTNDJMNzNfTUlDMlNERVQKPj4gKyDCoCDCoCBib29sCj4+ICsgwqAgwqAgZGVw
ZW5kcyBvbiBTTkRfU09DX0NTNDJMNzMKPj4gKwo+PiAjIENpcnJ1cyBMb2dpYyBDUzQyNzAgQ29k
ZWMKPj4gY29uZmlnIFNORF9TT0NfQ1M0MjcwCj4+IMKgIMKgIMKgIHRyaXN0YXRlCj4KPiBJIGdv
dCBhIGxpdHRsZSBhaGVhZCBvZiBteXNlbGYuIMKgU29ycnksIEknbGwgc2VuZCB2NSB3aXRoIE9O
TFkgQ1M0Mkw3MyBpbiB0aGUgY29uZmlncwoKWWVhaCwgSSB3YXMgYWJvdXQgdG8gYXNrIGFib3V0
IHRoYXQgOykKCkhhZCBhIHF1aWNrIGxvb2sgYW5kIGl0IHNlZW1zIE9LIHdpdGhvdXQgdGhlIENT
NDJMNTIgc3R1ZmYuCgpMaWFtCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
