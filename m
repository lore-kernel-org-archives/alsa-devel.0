From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Thu, 30 Apr 2009 10:31:53 +0800
Message-ID: <f17812d70904291931o7bbf4df6g2827bdb28920f82b@mail.gmail.com>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
	<20090428222035.GG29277@n2100.arm.linux.org.uk>
	<1240959968.30410.1.camel@brutus>
	<20090429072706.GA31566@n2100.arm.linux.org.uk>
	<20090429082152.GA2628@sirena.org.uk>
	<20090429084109.GB10541@n2100.arm.linux.org.uk>
	<f17812d70904290214g110f2a5ax5da4af478688f3d1@mail.gmail.com>
	<20090429185151.GC21459@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 25881103897
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 04:31:54 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1190595qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 19:31:53 -0700 (PDT)
In-Reply-To: <20090429185151.GC21459@n2100.arm.linux.org.uk>
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

T24gVGh1LCBBcHIgMzAsIDIwMDkgYXQgMjo1MSBBTSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4
CjxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyOSwgMjAwOSBh
dCAwNToxNDoxM1BNICswODAwLCBFcmljIE1pYW8gd3JvdGU6Cj4+IE9uIFdlZCwgQXByIDI5LCAy
MDA5IGF0IDQ6NDEgUE0sIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eAo+PiA8bGludXhAYXJtLmxp
bnV4Lm9yZy51az4gd3JvdGU6Cj4+ID4gT24gV2VkLCBBcHIgMjksIDIwMDkgYXQgMDk6MjE6NTNB
TSArMDEwMCwgTWFyayBCcm93biB3cm90ZToKPj4gPj4gT24gV2VkLCBBcHIgMjksIDIwMDkgYXQg
MDg6Mjc6MDZBTSArMDEwMCwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IHdyb3RlOgo+PiA+PiA+
IE9uIFR1ZSwgQXByIDI4LCAyMDA5IGF0IDA4OjA2OjA4UE0gLTAzMDAsIERhbmllbCBSaWJlaXJv
IHdyb3RlOgo+PiA+Pgo+PiA+PiA+ID4gVGhlIFNQSSBzdWJzeXN0ZW0/Cj4+ID4+Cj4+ID4+ID4g
Q2FuIHRoZSBTUEkgc3lzdGVtIGNvcGUgd2l0aCB0aGUgb3RoZXIgY2hpcCBiZWluZyB0aGUgbWFz
dGVyIG9mIHRoZQo+PiA+PiA+IGludGVyZmFjZS4gwqBJbiBvdGhlciB3b3JkcywgY2FuIFNQSSBz
aXQgYXJvdW5kIHByaW1lZCBmb3IgYSB0cmFuc2ZlciwKPj4gPj4gPiBhbmQgbm90aWZ5IHRoZSB1
c2VyIG9mIFNQSSB0aGF0IG5ldyBkYXRhIGhhcyBhcnJpdmVkPwo+PiA+Pgo+PiA+PiA+IElmIG5v
dCwgdGhlIFNQSSBzdWJzeXN0ZW0gaXMgdG90YWxseSB1bnN1aXRhYmxlIGZvciB0aGlzLgo+PiA+
Pgo+PiA+PiBJdCdzIHNsYXZlIG9ubHkgYXQgdGhlIG1pbnV0ZSAtIHRoZXJlJ3MgaG9sZXMgaW4g
dGhlIEFQSSBzb21lb25lIGNvdWxkCj4+ID4+IGZpbGwgaW4gYnV0IHRoYXQncyBub3QgaGFwcGVu
ZWQgeWV0Lgo+PiA+Cj4+ID4gV2VsbCwgSSBndWVzcyBzb21lb25lIGVsc2Ugd2lsbCBoYXZlIHRv
IGRvIHRoYXQ7IEkgZG9uJ3Qgc3BlbmQgbXVjaCB0aW1lCj4+ID4gb24gdGhlIExYIHN0dWZmLCBh
bmQgc28gaWYgaXQgcmVxdWlyZXMgYW55IHRpbWUgY29uc3VtaW5nIHdvcmssIGl0IHdvbid0Cj4+
ID4gYmUgd29ydGggdHJ5aW5nIHRvIGdldCBpdCBpbnRvIG1haW5saW5lLgo+PiA+Cj4+Cj4+IEhv
d2V2ZXIsIHRoZSBwYXRjaCBpdHNlbGYgZG9lc24ndCBsb29rcyBsaWtlIHRvIGJlIGEgU1BJIHNs
YXZlCj4+IChJIG1lYW4gZnJvbSB0aGUgdmlldyBvZiB0aGUgcHJvY2Vzc29yKS4KPj4KPj4gJ3N0
cnVjdCBzcGlfbWVzc2FnZScgZG9lcyBzdXBwb3J0IHNpbXVsdGFuZW91cyByeC90eCB0cmFuc2Zl
cgo+PiBhbmQgbXVsdGlwbGUgc3VjaCB0cmFuc2ZlcnMgYmVpbmcgcXVldWVkLgo+Cj4gVGhlIHRy
YW5zZmVycyBoYXBwZW4gdW5kZXIgY29udHJvbCBvZiBQQ09OIG5vdCB0aGUgUFhBOyBQQ09OIGFz
c2VydHMgYQo+IEdQSU8gdG8gYWN0aXZhdGUgdGhlIERNQSB0byBjb250cm9sIHdoZW4gdGhlIHRy
YW5zZmVyIGhhcHBlbnMuCj4KClRoYXQncyB0b28gYmFkIHRoZW4uIERvZXMgdGhhdCBHUElPIGFj
dCBsaWtlIGEgY2hpcCBzZWxlY3Qgb3IgaXQncyBqdXN0IGEKc2lnbmFsIHRvIGluZm9ybSB0aGUg
aG9zdCB0byBkbyBhIHRyYW5zZmVyPyBBbmQgaXQgYWxzbyBkZXBlbmRzIG9uIHRoZQpTQ0xLIGRp
cmVjdGlvbi4KCklmIHRoZSBHUElPIGJlaGF2ZXMgbGlrZSBhbiBJUlEgdG8gaW5mb3JtIHRoZSBo
b3N0IGZvciBhIHRyYW5zZmVyLCBtYXliZQp0aGUgZHJpdmVyIGNhbiBhcnJhbmdlIGEgdHJhbnNm
ZXIgaW5pdGlhdGVkIGJ5IHRoYXQgZXZlbnQuCgo+IFdlIGNhbiBub3QganVzdCBzdGFydCB0aGUg
U1NQIGZvciBhIDMyIGJ5dGUgdHJhbnNmZXIgYW5kIGhvcGUgaXQgaGFwcGVucy4KPiBQQ09OIGhh
cyB0byBiZSB0b3RhbGx5IGluIGNvbnRyb2wuCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbHNhLWRldmVsCg==
