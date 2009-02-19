From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Disable WM8731 line bypass by default
Date: Thu, 19 Feb 2009 19:02:40 +0000
Message-ID: <1235070160-10709-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090219190140.GA9707@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C0BBE244BB
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2009 20:02:47 +0100 (CET)
In-Reply-To: <20090219190140.GA9707@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

VGhpcyBhdm9pZHMgdGVtcG9yYXJpbHkgZW5hYmxpbmcgdGhlIG91cHV0IHN0YWdlcyBkdXJpbmcg
c3RhcnR1cCB3aGljaApjYW4gY2F1c2UgYXVkaWJsZSBlZmZldHMgaW4gdGhlIG91dHB1dCBzdGFn
ZXMuCgpSZXBvcnRlZC1ieTogRnJlZHJpayBSZWRnw6VyZCA8cmlrQHN2ZXAuc2U+ClNpZ25lZC1v
ZmYtYnk6IE1hcmsgQnJvd24gPGJyb29uaWVAb3BlbnNvdXJjZS53b2xmc29ubWljcm8uY29tPgot
LS0KIHNvdW5kL3NvYy9jb2RlY3Mvd204NzMxLmMgfCAgICA0ICsrKysKIDEgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3Nv
Yy9jb2RlY3Mvd204NzMxLmMgYi9zb3VuZC9zb2MvY29kZWNzL3dtODczMS5jCmluZGV4IDRjYWMz
MTkuLjllN2ViY2MgMTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mvd204NzMxLmMKKysrIGIv
c291bmQvc29jL2NvZGVjcy93bTg3MzEuYwpAQCAtNTk0LDYgKzU5NCwxMCBAQCBzdGF0aWMgaW50
IHdtODczMV9yZWdpc3RlcihzdHJ1Y3Qgd204NzMxX3ByaXYgKndtODczMSkKIAlyZWcgPSB3bTg3
MzFfcmVhZF9yZWdfY2FjaGUoY29kZWMsIFdNODczMV9SSU5WT0wpOwogCXdtODczMV93cml0ZShj
b2RlYywgV004NzMxX1JJTlZPTCwgcmVnICYgfjB4MDEwMCk7CiAKKwkvKiBEaXNhYmxlIGJ5cGFz
cyBwYXRoIGJ5IGRlZmF1bHQgKi8KKwlyZWcgPSB3bTg3MzFfcmVhZF9yZWdfY2FjaGUoY29kZWMs
IFdNODczMV9BUEFOQSk7CisJd204NzMxX3dyaXRlKGNvZGVjLCBXTTg3MzFfQVBBTkEsIHJlZyAm
IH4weDQpOworCiAJd204NzMxX2NvZGVjID0gY29kZWM7CiAKIAlyZXQgPSBzbmRfc29jX3JlZ2lz
dGVyX2NvZGVjKGNvZGVjKTsKLS0gCjEuNS42LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
