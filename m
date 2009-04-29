From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Wed, 29 Apr 2009 17:14:13 +0800
Message-ID: <f17812d70904290214g110f2a5ax5da4af478688f3d1@mail.gmail.com>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
	<20090429072706.GA31566@n2100.arm.linux.org.uk>
	<20090429082152.GA2628@sirena.org.uk>
	<20090429084109.GB10541@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E03F243C6
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 11:14:14 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2090190qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 02:14:13 -0700 (PDT)
In-Reply-To: <20090429084109.GB10541@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCBBcHIgMjksIDIwMDkgYXQgNDo0MSBQTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4
CjxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyOSwgMjAwOSBh
dCAwOToyMTo1M0FNICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBXZWQsIEFwciAyOSwg
MjAwOSBhdCAwODoyNzowNkFNICswMTAwLCBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggd3JvdGU6
Cj4+ID4gT24gVHVlLCBBcHIgMjgsIDIwMDkgYXQgMDg6MDY6MDhQTSAtMDMwMCwgRGFuaWVsIFJp
YmVpcm8gd3JvdGU6Cj4+Cj4+ID4gPiBUaGUgU1BJIHN1YnN5c3RlbT8KPj4KPj4gPiBDYW4gdGhl
IFNQSSBzeXN0ZW0gY29wZSB3aXRoIHRoZSBvdGhlciBjaGlwIGJlaW5nIHRoZSBtYXN0ZXIgb2Yg
dGhlCj4+ID4gaW50ZXJmYWNlLiDCoEluIG90aGVyIHdvcmRzLCBjYW4gU1BJIHNpdCBhcm91bmQg
cHJpbWVkIGZvciBhIHRyYW5zZmVyLAo+PiA+IGFuZCBub3RpZnkgdGhlIHVzZXIgb2YgU1BJIHRo
YXQgbmV3IGRhdGEgaGFzIGFycml2ZWQ/Cj4+Cj4+ID4gSWYgbm90LCB0aGUgU1BJIHN1YnN5c3Rl
bSBpcyB0b3RhbGx5IHVuc3VpdGFibGUgZm9yIHRoaXMuCj4+Cj4+IEl0J3Mgc2xhdmUgb25seSBh
dCB0aGUgbWludXRlIC0gdGhlcmUncyBob2xlcyBpbiB0aGUgQVBJIHNvbWVvbmUgY291bGQKPj4g
ZmlsbCBpbiBidXQgdGhhdCdzIG5vdCBoYXBwZW5lZCB5ZXQuCj4KPiBXZWxsLCBJIGd1ZXNzIHNv
bWVvbmUgZWxzZSB3aWxsIGhhdmUgdG8gZG8gdGhhdDsgSSBkb24ndCBzcGVuZCBtdWNoIHRpbWUK
PiBvbiB0aGUgTFggc3R1ZmYsIGFuZCBzbyBpZiBpdCByZXF1aXJlcyBhbnkgdGltZSBjb25zdW1p
bmcgd29yaywgaXQgd29uJ3QKPiBiZSB3b3J0aCB0cnlpbmcgdG8gZ2V0IGl0IGludG8gbWFpbmxp
bmUuCj4KCkhvd2V2ZXIsIHRoZSBwYXRjaCBpdHNlbGYgZG9lc24ndCBsb29rcyBsaWtlIHRvIGJl
IGEgU1BJIHNsYXZlCihJIG1lYW4gZnJvbSB0aGUgdmlldyBvZiB0aGUgcHJvY2Vzc29yKS4KCidz
dHJ1Y3Qgc3BpX21lc3NhZ2UnIGRvZXMgc3VwcG9ydCBzaW11bHRhbmVvdXMgcngvdHggdHJhbnNm
ZXIKYW5kIG11bHRpcGxlIHN1Y2ggdHJhbnNmZXJzIGJlaW5nIHF1ZXVlZC4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
