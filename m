From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: How to propagate parameters from FE to BE with
 compressed audio interfaces
Date: Wed, 14 Nov 2018 15:35:28 +0000
Message-ID: <1542209728.21696.53.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140040.outbound.protection.outlook.com [40.107.14.40])
 by alsa0.perex.cz (Postfix) with ESMTP id D171A2677E8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 16:35:29 +0100 (CET)
Content-Language: en-US
Content-ID: <333B0A6EA5581A4FB050E73F30486EE7@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "vkoul@kernel.org" <vkoul@kernel.org>, "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8sDQoNCnNvY19jb21wcl9zZXRfcGFyYW1zX2ZlIGNhbGxzwqBkcGNtX2JlX2RhaV9od19w
YXJhbXMgaW4gb3JkZXIgdG8gc2V0dXANCkJFIGh3X3BhcmFtcy4NCg0KSXMgdGhlcmUgYSB3YXkg
dG8gdHJhbnNmZXIgcGFyYW1ldGVycyBsaWtlIGZvciBleGFtcGxlIHRoZSByYXRlIGZyb20gRkUN
CnRvIEJFPw0KDQpJbiBzb2NfY29tcHJfc2V0X3BhcmFtc19mZSB0aGVyZSBpcyB0aGlzIGNvZGU6
DQoNCioNCiogQ3JlYXRlIGFuIGVtcHR5IGh3X3BhcmFtcyBmb3IgdGhlIEJFIGFzIHRoZSBtYWNo
aW5lIGRyaXZlciBtdXN0DQoqIGZpeCB0aGlzIHVwIHRvIG1hdGNoIERTUCBkZWNvZGVyIGFuZCBB
U1JDIGNvbmZpZ3VyYXRpb24uDQoqIEkuZS4gbWFjaGluZSBkcml2ZXIgZml4dXAgZm9yIGNvbXBy
ZXNzZWQgQkUgaXMgbWFuZGF0b3J5Lg0KKi8NCm1lbXNldCgmZmUtPmRwY21bZmVfc3Vic3RyZWFt
LT5zdHJlYW1dLmh3X3BhcmFtcywgMCwNCsKgIMKgIMKgIMKgc2l6ZW9mKHN0cnVjdCBzbmRfcGNt
X2h3X3BhcmFtcykpOw0KDQpTbywgaW5mb3JtYXRpb24gYWJvdXQgcGFyYW1ldGVycyBpcyBqdXN0
IGlnbm9yZWQuDQoNClRoZSBvbmx5IHdheSB3ZSBjYW4gc2V0dXAgaHdfcGFyYW1zIGZvciBCRSBp
cyB2aWHCoA0KYmVfaHdfcGFyYW1zX2ZpeHVwKCkgYnV0IHRoaXMgZnVuY3Rpb24gZG9lc24ndCBo
YXZlIGFueSBpbmZvcm1hdGlvbg0KZnJvbSBGRS4NCg0KTXkgdXNlIGNhc2UgaXMgc29tZXRoaW5n
IGxpa2UgdGhpczoNCg0KRkU6DQrCoCDCoCAtIGNwdTogRlNMIFNBSSBEQUkgaW50ZXJmYWNlDQrC
oCDCoCAtIHBsYXRmb3JtOiBEU1DCoA0KwqAgwqAgLSBjb2RlYzogZHVtbXkgY29kZWMNCkJFOg0K
wqAgwqAgLSBjcHU6IGR1bW15DQrCoCDCoCAtIHBsYXRmb3JtOiBkdW1teQ0KwqAgwqAgLSBjb2Rl
YzogY3M0Mjg4OC4NCg0KY29kZWMgY291bGQgaGFuZGxlIDQ0MTAwSHogYW5kIDQ4MDAwSHogc3Ry
ZWFtcywgYnV0IHRoZSBCRSBkb2Vzbid0IGhhdmUNCmFueSB3YXkgdG8ga25vdyB3aGF0IGlzIHRo
ZSByYXRlIGNwbGF5IHNldHMgdG8gRkUuDQoNCnRoYW5rcywNCkRhbmllbC4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
