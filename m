From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
Subject: Get dB value using softvol plugin
Date: Wed, 04 May 2016 11:47:03 +0200
Message-ID: <1462355223.13036.16.camel@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B59C0261737
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 11:47:11 +0200 (CEST)
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
 by mout01.posteo.de (Postfix) with ESMTPS id 9147120BD2
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 11:47:08 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
 by dovecot03.posteo.de (Postfix) with ESMTPSA id 3r0Cqv2kZWz5vML
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 11:47:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded.rocks (Postfix) with ESMTP id 7183FEE0C6B
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 11:47:06 +0200 (CEST)
Received: from mail.embedded.rocks ([127.0.0.1])
 by localhost (mail.embedded.rocks [127.0.0.1]) (amavisd-new, port 10025)
 with ESMTP id INVojlacmGFd for <alsa-devel@alsa-project.org>;
 Wed,  4 May 2016 11:47:04 +0200 (CEST)
Received: from nzxt.fritz.box (x4d0c9d31.dyn.telefonica.de [77.12.157.49])
 (Authenticated sender: joerg.krause@embedded.rocks)
 by mail.embedded.rocks (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 11:47:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpJIGNvbmZpZ3VyZWQgbXkgc29mdHZvbCBwbHVnaW4gd2l0aCBhIG1pbl9kQiB2YWx1ZSBv
ZiAtNi4wLiBIb3dldmVyLCBpZgpJIHN0b3JlIHRoZSBzdGF0ZSB3aXRoIGFsc2FjdGwgc3RvcmUs
IHRoZSBjb21tZW50IHNlY3Rpb24gc2hvd3MgYSBkYm1pbgp2YWx1ZSBvZiAwLgoKSSBmaWd1cmVk
IG91dCB0aGF0IHRoZSBzb2Z0dm9sIHBsdWdpbiBhZGRzIHRoZSB0bHYgaW5mbyB3aGVuIGl0IGFk
ZHMKdGhlIHVzZXIgY3RsIGFuZCBzdG9yZXMgdGhlIGRiIHZhbHVlcyBpbsKgc25kX3BjbV9zb2Z0
dm9sX3QuIFdoeSBkaWZmZXIKdGhlIHZhbHVlcyBvZiB0aGUgdGx2IGFuZCB0aGUgdmFsdWVzIG9m
IHNuZF9wY21fc29mdHZvbF90PwoKTXkgZ29hbCBpcyB0byBnZXQgaW5mb3JtYXRpb24gb2YgdGhl
IGN1cnJlbnQgZEIgdmFsdWUgdXNlZCBieSB0aGUKc29mdHZvbCBwbHVnaW4sIGUuZy4gLTYuMGRC
IGZvciBhIHJhdyB2b2x1bWUgdmFsdWUgb2YgMjU1IGFuZCAtNTEuMGRCCmZvciAwLiBIb3dldmVy
LCBJIG9ubHkgZ2V0IHZhbHVlcyBmcm9tICswIHRvICs1MWRCCnVzaW5nwqBzbmRfY3RsX2NvbnZl
cnRfdG9fZEIoKS4gRG8gSSBtaXNzIHNvbWV0aGluZz8KCk5vdGUsIHRoYXQgSSBzdGFydGVkIGZy
b20gYSBjbGVhbiBhc291bmQuc3RhdGUuCgotLS0KClRoZSBzdGF0ZSBwcm9kdWNlZCBieSBhbHNh
Y3RsOgoKCWNvbnRyb2wuMSB7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWZhY2Ug
TUlYRVIKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuYW1lIE1hc3RlcgrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHZhbHVlLjAgMjU1CsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdmFsdWUuMSAyNTUKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
b21tZW50IHsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YWNjZXNzICdyZWFkIHdyaXRlIHVzZXInCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHR5cGUgSU5URUdFUgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjb3VudCAyCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJhbmdlICcwIC0gMjU1JwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0bHYgJzAwMDAwMDAxMDAwMDAwMDgwMDAwMDAwMDAw
MDAwMDE0JwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
Ym1pbiAwCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRi
bWF4IDUxMDAKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGJ2YWx1ZS4wIDUxMDAKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGJ2YWx1ZS4xIDUxMDAKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9CsKg
wqDCoMKgwqDCoMKgwqB9CgotLS0KClRoZSBvdXRwdXQgb2YgYXBsYXkgLUQgc29mdHZvbCAtdjoK
CiAgICBQbGF5aW5nIFdBVkUgJy90ZXN0LndhdicgOiBTaWduZWQgMTYgYml0IExpdHRsZSBFbmRp
YW4sIFJhdGUgNDQxMDAKICAgIEh6LCBTdGVyZW8KICAgIFNvZnQgdm9sdW1lIFBDTQogICAgQ29u
dHJvbDogTWFzdGVyCiAgICBtaW5fZEI6IC01NwogICAgbWF4X2RCOiAtNgogICAgcmVzb2x1dGlv
bjogMjU2CgotLS0KCk15IGFzb3VuZC5jb25mOgoKICAgIHBjbS4hZGVmYXVsdCB7CiAgICDCoMKg
wqDCoMKgwqB0eXBlIHBsdWcKICAgIMKgwqDCoMKgwqDCoHNsYXZlLnBjbSAic29mdHZvbCIKICAg
IMKgIH0KCiAgICBwY20uc29mdHZvbCB7CiAgICDCoMKgwqDCoMKgdHlwZSBzb2Z0dm9sCiAgICDC
oMKgwqDCoMKgwqBzbGF2ZSB7CiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjbSAiaHc6MCIKICAg
IMKgwqDCoMKgwqDCoH0KICAgIMKgwqDCoMKgwqDCoGNvbnRyb2wgewogICAgwqDCoMKgwqDCoMKg
wqDCoMKgwqBuYW1lICJNYXN0ZXIiCiAgICDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhcmQgMAogICAg
wqDCoMKgwqDCoMKgfQogICAgwqDCoMKgwqDCoG1pbl9kQiAtNTcuMAogICAgwqDCoMKgwqDCoG1h
eF9kQiAtNi4wCiAgICB9CiAgICBjdGwuIWRlZmF1bHQgewogICAgwqDCoMKgwqDCoMKgwqDCoHR5
cGUgaHcKICAgIMKgwqDCoMKgwqDCoMKgwqBjYXJkIDAKICAgIH0KICAgIGN0bC5zb2Z0dm9sIHsK
ICAgIMKgwqDCoMKgwqDCoMKgwqB0eXBlIGh3CiAgICDCoMKgwqDCoMKgwqDCoMKgY2FyZCAwCiAg
ICB9CgotLS0KCkJlc3QgcmVnYXJkcwpKw7ZyZyBLcmF1c2UKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
