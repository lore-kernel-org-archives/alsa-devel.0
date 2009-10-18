From: "=?utf-8?q?R=C3=A9mi?= Denis-Courmont" <rem@videolan.org>
Subject: How to close ALSA device nodes?
Date: Sun, 18 Oct 2009 19:06:25 +0300
Message-ID: <200910181906.25790.rem@videolan.org>
Reply-To: remi@remlab.net
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yop.chewa.net (yop.chewa.net [91.121.105.214])
	by alsa0.perex.cz (Postfix) with ESMTP id D0D0C10380A
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 18:06:26 +0200 (CEST)
Received: from basile.remlab.net (cs27062183.pp.htv.fi [89.27.62.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: remi)
	by yop.chewa.net (Postfix) with ESMTPSA id 986F9694
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Oct 2009 18:06:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CUhlbGxvLAoKSSdtIGdldHRpbmcgYSBidWcgcmVwb3J0IGFnYWluc3QgVkxDIG1lZGlhIHBsYXll
ciB3aGVyZWJ5IEFMU0Egc291bmQgb3V0cHV0IApzdG9wcyB3b3JraW5nIHdoZW4gdGhlIHNjcmVl
bnNhdmVyIGlzIGluaGliaXRlZC4gSXQgdHVybnMgb3V0IHRoYXQgVkxDIGlzIApsZWFraW5nIGFu
eSBmaWxlIGRlc2NyaXB0b3Igb3BlbiB0aHJvdWdoIEFMU0EtbGliIGludG8gY2hpbGQgcHJvY2Vz
c2VzLiBUaGUgCmV4YWN0IHNhbWUgaXNzdWUgd2FzIGFscmVhZHkgcmFpc2VkIGJ5IG1wbGF5ZXIu
Li4gNiB5ZWFycyBhZ286Cmh0dHA6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9hbHNhLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldC9tc2cwNjI0OS5odG1sCgpJbiBvdGhlciBjYXNlcyAoVjRMLCBP
U1MsIERWQiwgRFZELCBzb2NrZXRzLCBldmVuIHJlZ3VsYXIgZmlsZXMuLi4pLCBWTEMgd291bGQg
Cm9wZW4gdGhlIGRldmljZSBub2RlcyB3aXRoIE9fQ0xPRVhFQyBmbGFnIChpZiBzdXBwb3J0ZWQg
Ynkga2VybmVsIGFuZCBsaWJjKSAKYW5kIGZhbGxiYWNrIHRvIHNldHRpbmcgRkRfQ0xPRVhFQyB2
aWEgZmNudGwoKS4gVGhlbiB0aGUgZGVzY3JpcHRvciBpcyAKYXV0b21hdGljYWxseSwgYW5kIGlu
IHRoZSBlYXJsaWVyIGNhc2UsIHRocmVhZC1zYWZlbHksIGNsb3NlZCB3aGVuZXZlciBWTEMgLQpm
b3JrcyBhbmQtIGV4ZWNzLiBXaXRoIEFMU0EtbGliLCBJIGNhbm5vdCBmaWd1cmUgYW55IHdheSB0
byBhY2hpZXZlIHRoYXQuLi4KCkZyb20gdGhlIGVhcmxpZXIgdGhyZWFkLCBJIHJlY2tvbiB0aGF0
IEFMU0EgZGV2ZWxvcGVycyBjb25zaWRlciB0aGF0IHRoaXMgaXMgCmFuIHVwcGVyLWxheWVyIGlz
c3VlLiBNYXliZSBzbywgYnV0IHRoZW4gaG93IGlzIHRoZSB1cHBlci1sYXllciBzdXBwb3NlZCB0
byAKZmluZCB3aGljaCBmaWxlIGRlc2NyaXB0b3JzIEFMU0EtbGliIGhhcyBvcGVuZWQgLSBpZiBh
bnk/IENvbnZlcnNlbHksIGlmIEFMU0EtCmxpYiB3b24ndCB0ZWxsIHdoaWxlIGZpbGUgZGVzY3Jp
cHRvcnMgaXQgaXMgdXNpbmcsIHdoYXQgY291bGQgcG9zc2libHkgYmUgdGhlIAp1c2UgY2FzZSBm
b3Igbm90IGNsb3NpbmcgdGhvc2Ugb24gZXhlYz8KCkJlc3QgcmVnYXJkcywKCi0tIApSw6ltaSBE
ZW5pcy1Db3VybW9udApodHRwOi8vd3d3LnJlbWxhYi5uZXQvCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
