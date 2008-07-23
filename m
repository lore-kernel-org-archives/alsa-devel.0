From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] V2,
	Convert bitfields in ASOC into full int width
Date: Wed, 23 Jul 2008 19:29:37 +0100
Message-ID: <20080723182937.GA25367@rakim.wolfsonmicro.main>
References: <20080723174302.14968.56684.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A842010380A
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 20:29:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723174302.14968.56684.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBKdWwgMjMsIDIwMDggYXQgMDE6NDM6MDJQTSAtMDQwMCwgSm9uIFNtaXJsIHdyb3Rl
Ogo+IENvbnZlcnQgYml0ZmllbGRzIGluIEFTT0MgaW50byBmdWxsIGludCB3aWR0aC4gVGhpcyBp
cyBhCj4gc2ltcGxlIG1lY2hhbmljYWwgY29udmVyc2lvbi4gVHdvIHBsYWNlcyBpbiB0aGUgREFQ
TSBjb2RlCj4gd2VyZSBmaXhlZCB0byBwcm9wZXJseSB1c2UgbWFzay4KCiAgQ0hFQ0sgICBzb3Vu
ZC9zb2Mvc29jLWNvcmUuYwppbmNsdWRlL3NvdW5kL3NvYy5oOjcxOjQ6IGVycm9yOiBFeHBlY3Rl
ZCA7IGVuZCBvZiB0eXBlIGRlY2xhcmF0aW9uCmluY2x1ZGUvc291bmQvc29jLmg6NzE6NDogZXJy
b3I6IGdvdCAuCnNvdW5kL3NvYy9zb2MtY29yZS5jOjI5NTo2OiBlcnJvcjogdW5kZWZpbmVkIGlk
ZW50aWZpZXIgJ1NORF9TT0NfQklBU19QUkVQQVJFJwpzb3VuZC9zb2Mvc29jLWNvcmUuYzozMDg6
NjogZXJyb3I6IHVuZGVmaW5lZCBpZGVudGlmaWVyICdTTkRfU09DX0JJQVNfU1RBTkRCWScKc291
bmQvc29jL3NvYy1jb3JlLmM6MzY5Ojc6IGVycm9yOiB1bmRlZmluZWQgaWRlbnRpZmllciAnU05E
X1NPQ19CSUFTX1NUQU5EQlknCnNvdW5kL3NvYy9zb2MtY29yZS5jOjQ0MToyODogZXJyb3I6IHVu
ZGVmaW5lZCBpZGVudGlmaWVyICdTTkRfU09DX0JJQVNfT04nCnNvdW5kL3NvYy9zb2MtY29yZS5j
OjQ0NDoxMTogZXJyb3I6IHVuZGVmaW5lZCBpZGVudGlmaWVyICdTTkRfU09DX0JJQVNfUFJFUEFS
RScKc291bmQvc29jL3NvYy1jb3JlLmM6NDU1OjQwOiBlcnJvcjogdW5kZWZpbmVkIGlkZW50aWZp
ZXIgJ1NORF9TT0NfQklBU19PTicKICBDQyAgICAgIHNvdW5kL3NvYy9zb2MtY29yZS5vCkluIGZp
bGUgaW5jbHVkZWQgZnJvbSBzb3VuZC9zb2Mvc29jLWNvcmUuYzozNDoKaW5jbHVkZS9zb3VuZC9z
b2MuaDo3MTogZXJyb3I6IGV4cGVjdGVkIGlkZW50aWZpZXIgb3Ig4oCYKOKAmSBiZWZvcmUg4oCY
LuKAmSB0b2tlbgppbmNsdWRlL3NvdW5kL3NvYy5oOjcxOiBlcnJvcjogZXhwZWN0ZWQgaWRlbnRp
ZmllciBvciDigJgo4oCZIGJlZm9yZSDigJh94oCZIHRva2VuCgpUaGUgZml4IHdhcyB0cml2aWFs
IGVub3VnaCBzbyBJJ3ZlIG1hZGUgYW5kIGFwcGxpZWQgaXQgKGFuZCBkb25lIHNvbWUKYnJpZWYg
dGVzdGluZyBvZiBteSBvd24pIC0gcGxlYXNlIGJlIG1vcmUgY2FyZWZ1bCBpbiBmdXR1cmUuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5h
bHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
