From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Commit 8f7206d69a ("ASoC: imx-wm8962: Remove global
 variables") looks strange
Date: Mon, 26 Feb 2018 14:21:00 +0000
Message-ID: <1519654860.13463.95.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0046.outbound.protection.outlook.com [104.47.0.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FD3226754A
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 15:21:04 +0100 (CET)
Content-Language: en-US
Content-ID: <E9B3D7535B9C9E449826E970FBD47BF5@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "festevam@gmail.com" <festevam@gmail.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGkgRmFiaW8sDQoNCkxlb25hcmQgKENjJ2VkKSBub3RpY2VkIHRoYXQgY29tbWl0IGluICRzdWJq
ZWN0IGxvb2tzIHZlcnkgc3RyYW5nZS4NCg0KRm9yIGV4YW1wbGU6DQoNCkBAIC0xMzksNyArMTQw
LDcgQEAgc3RhdGljIGludCBpbXhfd204OTYyX2xhdGVfcHJvYmUoc3RydWN0IHNuZF9zb2NfY2Fy
ZCAqY2FyZCkNCsKgew0KwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1l
ICpydGQ7DQrCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19kYWk7DQot
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW14X3ByaXYgKnByaXYgPSAmY2FyZF9wcml2Ow0KK8KgwqDC
oMKgwqDCoMKgc3RydWN0IGlteF9wcml2ICpwcml2ID0gc25kX3NvY19jYXJkX2dldF9kcnZkYXRh
KGNhcmQpOw0KwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBpbXhfd204OTYyX2RhdGEgKmRhdGEgPSBz
bmRfc29jX2NhcmRfZ2V0X2RydmRhdGEoY2FyZCk7DQoNClNvLCBub3cgZGF0YSBhbmQgcHJpdiBw
b2ludCB0byB0aGUgc2FtZSBtZW1vcnkgYXJlYSBidXQgdGhleSBhcmUgY29tcGxldGVseQ0KZGlm
ZmVyZW50IHN0cnVjdHVyZXMhDQoNClVubGVzcyB3ZSBhcmUgbWlzc2luZyBzb21ldGhpbmcgdGhp
cyBpcyBvYnZpb3VzbHkgYSBidWcuIEkgd2lsbCB0cnkgdG8gaGF2ZSBhIGxvb2sgYXQNCnRoZSBl
bmQgb2YgdGhlIHdlZWssIGJ1dCBhbnkgY29tbWVudHMgYXJlIHdlbGNvbWUuDQoNCkkgdGhpbmsg
dGhlIGZpeCB3b3VsZCBiZSB0byBoYXZlIG9uZSBnbG9iYWwgcHJpdiBzdHJ1Y3R1cmUgYW5kIHRv
IHVuaWZ5wqBpbXhfd204OTYyX2RhdGENCndpdGjCoGlteF9wcml2Lg0KDQp0aGFua3MsDQpEYW5p
ZWwuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
