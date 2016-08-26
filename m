From: =?ISO-8859-1?Q?J=F6rg?= Krause <joerg.krause@embedded.rocks>
Subject: Re: Toggle GPIO if ALSA playbacks begins or ends
Date: Fri, 26 Aug 2016 14:59:49 +0200
Message-ID: <1472216389.32160.7.camel@embedded.rocks>
References: <1472149668.24475.10.camel@embedded.rocks>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 411F4267A55
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 15:00:02 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 3sLLjp24lZzyZw
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 14:59:51 +0200 (CEST)
Received: from mail.embedded.rocks ([127.0.0.1])
 by localhost (mail.embedded.rocks [127.0.0.1]) (amavisd-new, port 10025)
 with ESMTP id 4CUfgP-cXVlY for <alsa-devel@alsa-project.org>;
 Fri, 26 Aug 2016 14:59:50 +0200 (CEST)
Received: from nzxt.fritz.box (xd9bfe01d.dyn.telefonica.de [217.191.224.29])
 (Authenticated sender: joerg.krause@embedded.rocks)
 by mail.embedded.rocks (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2016 14:59:50 +0200 (CEST)
In-Reply-To: <1472149668.24475.10.camel@embedded.rocks>
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

T24gRG8sIDIwMTYtMDgtMjUgYXQgMjA6MjcgKzAyMDAsIErDtnJnIEtyYXVzZSB3cm90ZToKPiBI
aSwKPiAKPiBJIGFtIGxvb2tpbmcgZm9yIGEgd2F5IHRvIHRvZ2dsZSBhIEdQSU8gaWYgQUxTQSBp
cyBhYm91dCB0byBwbGF5IG9yCj4gaGFzCj4gc3RvcHBlZCB0byB0dXJuIGFuIGV4dGVybmFsIGFt
cGxpZmllciBvbi9vZmYuCj4gCj4gQ2FuIGl0IGJlIGRvbmUgdXNpbmcgbGliYXNvdW5kIG9yIGNh
biBJIHVzZSBhIHBsdWdpbiBvciB3cml0ZSBvbmU/CgpBZnRlciBoYXZpbmcgYSBsb25nIG5pZ2h0
IGRpZ2dpbmcgdGhyb3VnaCBBTFNBJ3Mgc291cmNlZCBJIGdvdCBpdAp3b3JraW5nIHdyaXRpbmcg
YSBQQ00gaG9vayBsaWJyYXJ5LiBCYXNpY2FsbHksIGl0IGRvZXMgdGhlIGZvbGxvd2luZzoKCnN0
YXRpYyBpbnTCoHNuZF9wY21faG9va19ncGlvX2hvb2tfY2xvc2Uoc25kX3BjbV9ob29rX3QgKmhv
b2spCnsKCWludCBmZDsKCgkvKgoJICogU2V0IEdQSU8gTE9XCgkgKi8KCglyZXR1cm4gMDsKfQoK
aW50IF9zbmRfcGNtX2hvb2tfZ3Bpb19ob29rX2luc3RhbGwoc25kX3BjbV90ICpwY20sIHNuZF9j
b25maWdfdCAqY29uZikKewoJaW50IGZkOwoJaW50IGVycjsKCglzbmRfcGNtX2hvb2tfdCAqaF9j
bG9zZSA9IE5VTEw7CgoJZXJyID0gc25kX3BjbV9ob29rX2FkZCgmaF9jbG9zZSwgcGNtLCBTTkRf
UENNX0hPT0tfVFlQRV9DTE9TRSwKCQkJwqDCoMKgwqDCoMKgwqBzbmRfcGNtX2hvb2tfZ3Bpb19o
b29rX2Nsb3NlLCBOVUxMKTsKCWlmIChlcnIgPCAwKQoJCWdvdG8gX2VycjsKCgkvKiBJbml0IGFu
ZCBzZXQgR1BJTyBISUdICsKgIMKgIMKgIMKgIMKgKi8KCglyZXR1cm4gMDsKCl9lcnI6CglpZiAo
aF9jbG9zZSkKCQlzbmRfcGNtX2hvb2tfcmVtb3ZlKGhfY2xvc2UpOwoKCXJldHVybiBlcnI7Cn0K
U05EX0RMU1lNX0JVSUxEX1ZFUlNJT04oX3NuZF9wY21faG9va19ncGlvX2hvb2tfaW5zdGFsbCwK
U05EX0NPTkZJR19ETFNZTV9WRVJTSU9OX0hPT0spOwoKRm9yIHJlZmVyZW5jZSBteSBhc291bmQu
Y29uZjoKCnBjbS5zb2Z0dm9sIHsKwqDCoMKgwqB0eXBlIHNvZnR2b2wKwqDCoMKgwqBzbGF2ZSB7
CsKgwqDCoMKgwqDCoMKgwqBwY20gImdwaW9faG9vayIKwqDCoMKgwqB9CsKgwqDCoMKgY29udHJv
bCB7CsKgwqDCoMKgwqDCoMKgwqBuYW1lICJNYXN0ZXIiCsKgwqDCoMKgwqDCoMKgwqBjYXJkIDAK
wqDCoMKgwqB9Cn0KcGNtX2hvb2tfdHlwZS5ncGlvX2hvb2sgewrCoMKgwqDCoGxpYiAibGliYXNv
dW5kX2dwaW9faG9vay5zbyIKfQpwY20uc29mdHZvbF9ob29rIHsKwqDCoMKgwqB0eXBlIGhvb2tz
CsKgwqDCoMKgc2xhdmUgewrCoMKgwqDCoMKgwqDCoMKgcGNtICJodzowIgrCoMKgwqDCoH0KwqDC
oMKgwqBob29rcy4wIHsKwqDCoMKgwqDCoMKgwqDCoHR5cGUgImdwaW9faG9vayIKwqDCoMKgwqB9
Cn0KCkrDtnJnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
