From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 18:42:26 +0900
Message-ID: <1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com> <20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DEB71038EF
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 10:42:27 +0100 (CET)
Received: by vws18 with SMTP id 18so1114055vws.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 01:42:27 -0800 (PST)
In-Reply-To: <20100218093459.GB3315@rakim.wolfsonmicro.main>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBGZWIgMTgsIDIwMTAgYXQgNjozNSBQTSwgTWFyayBCcm93bgo8YnJvb25pZUBvcGVu
c291cmNlLndvbGZzb25taWNyby5jb20+IHdyb3RlOgo+IE9uIFRodSwgRmViIDE4LCAyMDEwIGF0
IDExOjE0OjU3QU0gKzA5MDAsIGphc3NpIGJyYXIgd3JvdGU6Cj4+IE9uIFdlZCwgRmViIDE3LCAy
MDEwIGF0IDEwOjE0IFBNLCBNYXJrIEJyb3duCj4+ID4gT24gV2VkLCBGZWIgMTcsIDIwMTAgYXQg
MDk6MTU6NTZQTSArMDkwMCwgamFzc2kgYnJhciB3cm90ZToKPgo+PiA+PiBUaGUgd29ya2Fyb3Vu
ZCB0byBlbmFibGUgYSBjcHVfZGFpIHRvIGJlIHVzZWQgaW4gbXVsdGlwbGUgZGFpX2xpbmtzIGlz
bid0Cj4KPj4gPiBXaGF0IHdvcmthcm91bmQ/Cj4KPj4gVGhlIHNhbWUgYXMgdGhhdCBmb3IgY29k
ZWNfZGFpLgo+PiBjcHVfZGFpIGlzIHVzZWQgZXhhY3QgdGhlIHNhbWUgd2F5IGFzIGNvZGVjX2Rh
aSBleGNlcHQgZm9yIHJ1bnRpbWUKPj4gcG9pbnRlciBhc3NpZ25tZW50IGluIHNvY19wY21fb3Bl
biBhcyBpIG1lbnRpb25lZCBhbHJlYWR5Lgo+Cj4gQ291bGQgeW91IHBsZWFzZSBiZSBtb3JlIHNw
ZWNpZmljIGFib3V0IHdoYXQgdGhlIHdvcmthcm91bmQgeW91IGFyZQo+IHJlZmVycmluZyB0byBp
cz8gwqBJJ20gZ2VudWluZWx5IG5vdCBjbGVhciB3aGF0IHlvdSBtZWFuIGhlcmUuCkluIG9yZGVy
IGZvciBhIGNvZGVjX2RhaSB0byBiZSB1c2VkIGluIG1vcmUgdGhhbiBvbmUgZGFpX2xpbmsKSSBj
aGVjayBmb3IgaXRzICdhY3RpdmUnIGNvdW50ZXIgYW5kIGNhbGwgc2h1dGRvd24sIHN0YXJ0dXAs
IG11dGUKYW5kIHNjaGVkdWxlX2RlbGF5ZWRfd29yayBvbmx5IGlmIG5vIG90aGVyIGRhaV9saW5r
IGlzCmFjdGl2ZWx5IHVzaW5nIHRoYXQgY29kZWNfZGFpLgoKPj4gU28sIGl0IHNlZW1zLCB0aGUg
bWVtYmVyICdzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lIConIMKgb2YgJ3N0cnVjdCBzbmRfc29jX2Rh
aScKPj4gaXMgbW9zdGx5IHVudXNlZC4gV2UgY2FuIGVhc2lseSBtb3ZlIGl0IHRvICdzdHJ1Y3Qg
c25kX3NvY19kYWlfbGluaycgb3IKPj4gZXZlbiBkcm9wIGl0IGFsdG9nZXRoZXIgdG8gcmVkdWNl
IHJlZHVuZGFuY3koSSBwcmVmZXIpLgo+IE1heSBhcyB3ZWxsIGRyb3AgaXQgb25jZSB0aGUgQXRt
ZWwgZHJpdmVycyBubyBsb25nZXIgbmVlZCBpdC4KT2ssIHdpbGwgc2VuZCBhIHBhdGNoIHRvbW9y
cm93IGZvciBqdXN0IHRoYXQuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
