From: "Bach, Andrea" <andrea.bach@dfs.de>
Subject: Question about the buffer length in the transfer
 callback of the PCM External Plugin
Date: Mon, 31 Oct 2016 09:01:02 +0000
Message-ID: <a68475dd084f4a45b224791224c7c244@LGNMSXB01.prod.bk.dfs>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.dfs.de (smtp2.dfs.de [194.49.205.202])
 by alsa0.perex.cz (Postfix) with ESMTP id BEA2226663B
 for <Alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 10:01:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.dfs.de (Postfix) with ESMTP id 4907710171
 for <Alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 09:01:04 +0000 (UTC)
Received: from smtp2.dfs.de ([127.0.0.1])
 by localhost (.dfs.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jpDUm4n0JNpE for <Alsa-devel@alsa-project.org>;
 Mon, 31 Oct 2016 09:01:02 +0000 (UTC)
Received: from lgnmfk02.prod.bk.dfs (lgnmfk02 [10.240.120.102])
 by smtp2.dfs.de (Postfix) with ESMTPS
 for <Alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 09:01:02 +0000 (UTC)
Received: from LGNMSXB01.prod.bk.dfs (lgnmsxb01.prod.bk.dfs [10.247.176.25])
 by lgnmfk02.prod.bk.dfs (Postfix) with ESMTP id DFA047C1FA
 for <Alsa-devel@alsa-project.org>; Mon, 31 Oct 2016 09:01:02 +0000 (UTC)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8sDQoNCmhvdyBjYW4gSSBjaGFuZ2UgdGhlIHNpemUgdGhhdCBpcyBwcm92aWRlZCBpbnNp
ZGUgdGhlIOKAnnRyYW5zZmVy4oCcLWNhbGxiYWNrIG9mIGFuIGV4dGVybmFsIFBDTSBwbHVnaW4/
DQoNCkJhY2tncm91bmQ6DQpJIG5lZWQgdG8gd3JpdGUgYSBmaWx0ZXIgcGx1Z2luIGFuZCBJIGhh
dmUgdG8gdXNlIGZvciBwcm9jZXNzaW5nIGEgY2h1bmsgc2l6ZSBvZiBwb3dlciBvZiB0d28gKDMy
LCA2NCwgb3IgMTI4IGJ5dGVzIOKApiB0aGF04oCZcyBiZWNhdXNlIG9mIHRoZSB1c2Ugb2YgRkZU
KS4gQnV0IEkgZ2V0IGluc2lkZSB0aGUgdHJhbnNmZXIgY2FsbGJhY2sgYSBidWZmZXIgb2YgbGVu
Z3RoIDEwMDAuIFRoYXQgd291bGQgYmUgb2sgaWYgSSBjb3VsZCBqdXN0IHJldHVybiBsZXQncyBz
YXkgIDk2MCBieXRlcyDigJMgYnV0IGFmdGVyIHNvbWUgc3RydWdnbGluZyBJIGhhdmUgc29tZSBk
b3VidCBhYm91dCBpdCBiZWNhdXNlIEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgQUxTQSBjYW5u
b3QgY2hhbmdlIHRoZSBiaXRyYXRlIGluc2lkZSBzdWNoIGEgcGx1Z2luIOKAkyB0aGUgZG9jdW1l
bnRhdGlvbiBzdGF0ZXMgaXQgY291bGQgbm90IGNoYW5nZSB0aGUgc2FtcGxlIHJhdGUg4oCTIGJ1
dCBhY3R1YWxseSBob3cgY2FuIEkgcmV0dXJuIGxlc3Mgb3IgbW9yZSBieXRlcyDigJMgc28gbWF5
YmUgdGhlIGJpdHJhdGUgc2hvdWxkIGFsc28gYmUgY29uc3RhbnQ/IE1heWJlIEkgbWlzdW5kZXJz
dG9vZCB0aGUgY29uY2VwdHMgb2YgQUxTQSBjb21wbGV0ZWx5Pw0KDQpLaW5kIHJlZ2FyZHMNCg0K
RHIuIEEuIEJhY2gsIFNvZnR3YXJlLUVudHdpY2tsdW5nIFNpbXVsYXRvcmVuDQpERlMgRGV1dHNj
aGUgRmx1Z3NpY2hlcnVuZyBHbWJIDQpGb3JzY2h1bmdzemVudHJ1bQ0KQW0gREZTLUNhbXB1cyA1
DQo2MzIyNSBMYW5nZW4NCjA2MTAzLTcwNy01NzA5DQoNCkRGUyBEZXV0c2NoZSBGbHVnc2ljaGVy
dW5nIEdtYkgNCkFtIERGUy1DYW1wdXMNCkQgLSA2MzIyNSBMYW5nZW4NCg0KVGVsLjogKzQ5LSgw
KTYxMDMtNzA3LTANCg0KU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBMYW5nZW4vSGVzc2VuDQpadXN0
w6RuZGlnZXMgUmVnaXN0ZXJnZXJpY2h0OiBBRyBPZmZlbmJhY2ggYW0gTWFpbiwgSFJCIDM0OTc3
DQpWb3JzaXR6ZW5kZSBkZXMgQXVmc2ljaHRzcmF0czogRHIuIE1hcnRpbmEgSGlucmljaGVyDQpH
ZXNjaMOkZnRzZsO8aHJlcjogUHJvZi4gS2xhdXMtRGlldGVyIFNjaGV1cmxlIChWb3JzLiksIFJv
YmVydCBTY2hpY2tsaW5nLCBEci4gTWljaGFlbCBIYW5uDQoNCkludGVybmV0OiBodHRwOi8vd3d3
LmRmcy5kZQ0KUHVibGljLUtleSBkZXIgREZTOiBodHRwOi8vd3d3LmRmcy5kZS9kZnMvcHVibGlj
X2tleS5hc2MNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
