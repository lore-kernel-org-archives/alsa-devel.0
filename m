From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH -next] soc: sgtl5000 uses regulator
	interfaces
Date: Tue, 15 Mar 2011 08:41:17 -0700
Message-ID: <20110315084117.1e3a3a61.randy.dunlap@oracle.com>
References: <20110304180027.20deb6c4.sfr@canb.auug.org.au>
	<20110304173357.23d36116.randy.dunlap@oracle.com>
	<20110305112936.GA30187@opensource.wolfsonmicro.com>
	<AANLkTikivW3+V4QYh9Nt9FGXTefZiN9WbpAvGVeBJHNN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DE9F24525
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 16:41:28 +0100 (CET)
In-Reply-To: <AANLkTikivW3+V4QYh9Nt9FGXTefZiN9WbpAvGVeBJHNN@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gU2F0LCA1IE1hciAyMDExIDIwOjQxOjM4ICswODAwIFplbmcgWmhhb21pbmcgd3JvdGU6Cgo+
IE9uIFNhdCwgTWFyIDUsIDIwMTEgYXQgNzoyOSBQTSwgTWFyayBCcm93bgo+IDxicm9vbmllQG9w
ZW5zb3VyY2Uud29sZnNvbm1pY3JvLmNvbT4gd3JvdGU6Cj4gPiBPbiBGcmksIE1hciAwNCwgMjAx
MSBhdCAwNTozMzo1N1BNIC0wODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4gPj4gRnJvbTogUmFu
ZHkgRHVubGFwIDxyYW5keS5kdW5sYXBAb3JhY2xlLmNvbT4KPiA+Pgo+ID4+IHNndGw1MDAwIHVz
ZXMgcmVndWxhdG9yIGludGVyZmFjZXMsIHNvIG1ha2Ugc2VsZWN0aW5nIGl0IGRlcGVuZAo+ID4+
IG9uIFJFR1VMQVRPUi4KPiA+Pgo+ID4+IHNndGw1MDAwLmM6KC50ZXh0KzB4NGFlMzMpOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGByZWd1bGF0b3JfdW5yZWdpc3RlcicKPiA+PiBzZ3RsNTAwMC5j
OigudGV4dCsweDRhZjQxKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcmRldl9nZXRfZHJ2ZGF0
YScKPiA+PiBzZ3RsNTAwMC5jOigudGV4dCsweDRiMTkxKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgcmVndWxhdG9yX3JlZ2lzdGVyJwo+ID4KPiAKPiBoae+8jCBUaGFua3MgZm9yIHRoZSByZXBv
cnQuCj4gCj4gPiBTaW5jZSB0aGUgcmVndWxhdG9yIG9uIHRoZSBkZXZpY2UgaXMgb3B0aW9uYWwg
dGhpcyBpc24ndCB0aGUgYmVzdCBmaXgsCj4gPiB0aGUgY29kZSBzaG91bGQgYmUgdXBkYXRlZCB0
byBzdXBwb3J0IGJ1aWxkaW5nIHdpdGhvdXQgcmVndWxhdG9yLgo+IAo+IEkgd2lsbCBmaXggdGhl
IGNvZGUuIElmIHJlZ3VsYXRvciBub3QgZW5hYmxlZCwgYW5kIHRoZSBvcHRpb25hbAo+IHJlZ3Vs
YXRvciBub3QgcHJvdmlkZWQgZXh0ZXJuYWxseSwKPiBhIHdhcm5pbmcgbWVzc2FnZSB3aWxsIHBy
aW50IG91dCwgYW5kIGludGVybmFsIHJlZ3VsYXRvciB3aWxsIHNldAo+IGRpcmVjdGx5IGJ5IHdy
aXRlIHJlZ2lzdGVyLgo+ID4gLS0KCnBpbmcuICBUaGlzIGJ1aWxkIGVycm9yIHN0aWxsIGhhcHBl
bnMgaW4gbGludXgtbmV4dCAyMDExLjAzMTUuCgotLS0KflJhbmR5CioqKiBSZW1lbWJlciB0byB1
c2UgRG9jdW1lbnRhdGlvbi9TdWJtaXRDaGVja2xpc3Qgd2hlbiB0ZXN0aW5nIHlvdXIgY29kZSAq
KioKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
