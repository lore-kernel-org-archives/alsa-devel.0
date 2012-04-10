From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: wm9712: Fix build due to missing
	definition of "runtime"
Date: Tue, 10 Apr 2012 18:48:47 -0300
Message-ID: <CAOMZO5CXtC8xAVB+6cSDeKMLNj6RfSjV7cA1LM0WCyL9oJoFqQ@mail.gmail.com>
References: <1334093587-18184-1-git-send-email-festevam@gmail.com>
	<20120410213809.GV7499@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E53B324573
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 23:48:47 +0200 (CEST)
Received: by eaak11 with SMTP id k11so52697eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 14:48:47 -0700 (PDT)
In-Reply-To: <20120410213809.GV7499@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBcHIgMTAsIDIwMTIgYXQgNjozOCBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgQXByIDEwLCAyMDEyIGF0
IDA2OjMzOjA3UE0gLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3JvdGU6Cj4+IEZpeCB0aGUgZm9sbG93
aW5nIGJ1aWxkIGVycm9yOgo+Pgo+PiBzb3VuZC9zb2MvY29kZWNzL3dtOTcxMi5jOjQ4MjozMjog
ZXJyb3I6ICdydW50aW1lJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikK
Pj4gc291bmQvc29jL2NvZGVjcy93bTk3MTIuYzo0OTk6MzM6IGVycm9yOiAncnVudGltZScgdW5k
ZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCj4KPiBPbiBzZWNvbmQgdGhvdWdo
dHMgbG9va2luZyBhdCB3aGF0IHRoZSBzZXR0aW5nIGlzIGJlaW5nIHVzZWQgZm9yCj4gYXBwbGll
ZC4uLiDCoHRoZSBjb2RlIGlzIHJhdGhlciBvZGQgaGVyZSwgdGhvdWdoLgo+Cj4gSW4gZ2VuZXJh
bCBjaGFuZ2VzIGxpa2UgdGhpcyB3aGljaCBtYWtlIG5vIGF0dGVtcHQgdG8gdW5kZXJzdGFuZCB3
aGF0Cj4gdGhleSdyZSBjaGFuZ2luZyBhcmUgYSBiYWQgaWRlYSAtIGRvbid0IGp1c3QgY3V0J24n
cGFzdGUgc29tZSBlcnJvcnMKPiBpbnRvIHlvdXIgY2hhbmdlbG9nLCBleHBsYWluIHdoYXQncyBn
b25lIHdyb25nIGFuZCB3aHkuIMKgSXQncyBsaWtlIHdoZW4KPiBwZW9wbGUganVzdCBpbml0aWFs
aXNlIGEgdmFyaWFibGUgdG8gc29tZSByYW5kb20gdmFsdWUgdG8gc2h1dCBhIHdhcm5pbmcKPiB1
cCB3aXRob3V0IHVuZGVyc3RhbmRpbmcgd2h5LCB0aGUgZmFjdCB0aGF0IHRoZSBlcnJvciBnb2Vz
IGF3YXkgZG9lc24ndAo+IG1lYW4gdGhhdCB0aGUgZml4IGlzIHNlbnNpYmxlLgoKT2ssIHRoaXMg
aXMgY3VycmVudGx5IGJyZWFraW5nIGlteF92NF92NV9kZWZjb25maWcgaW4gbGludXgtbmV4dCBh
bmQKd291bGQgbGlrZSB0byBnZXQgaXQgZml4ZWQuCgpJIHdpbGwgdHJ5IHRvIHVuZGVyc3RhbmQg
dGhpcyBicmVha2FnZSBiZXR0ZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
