From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 11:14:57 +0900
Message-ID: <1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com> <20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 51BAB1038B2
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 03:14:58 +0100 (CET)
Received: by vws18 with SMTP id 18so1008815vws.38
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 18:14:57 -0800 (PST)
In-Reply-To: <20100217131421.GB11510@rakim.wolfsonmicro.main>
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

T24gV2VkLCBGZWIgMTcsIDIwMTAgYXQgMTA6MTQgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBXZWQsIEZlYiAxNywgMjAxMCBh
dCAwOToxNTo1NlBNICswOTAwLCBqYXNzaSBicmFyIHdyb3RlOgo+PiBPbiBXZWQsIEZlYiAxNywg
MjAxMCBhdCA3OjUyIFBNLCBNYXJrIEJyb3duCj4KPj4gPiBXaGF0IG1vZGlmaWNhdGlvbnMgYXJl
IHlvdSBsb29raW5nIGZvciBoZXJlPyDCoEFTb0MgZG9lc24ndCBtYWtlIGFueQo+PiA+IGVmZm9y
dCB0byBhdm9pZCByZXVzZSBvZiBEQUlzIGluIG11bHRpcGxlIGxpbmtzIC0gaXQgZG9lc24ndCBh
Y3RpdmVseSBkbwo+PiA+IGFueXRoaW5nIHRvIGhlbHAgaGVyZSBidXQgZXF1YWxseSB3ZWxsIGl0
J3Mgbm90IHN1cHBvc2VkIHRvIGdldCBpbiB0aGUKPj4gPiB3YXkuCj4KPj4gVGhlIHdvcmthcm91
bmQgdG8gZW5hYmxlIGEgY3B1X2RhaSB0byBiZSB1c2VkIGluIG11bHRpcGxlIGRhaV9saW5rcyBp
c24ndAo+Cj4gV2hhdCB3b3JrYXJvdW5kPwpUaGUgc2FtZSBhcyB0aGF0IGZvciBjb2RlY19kYWku
CmNwdV9kYWkgaXMgdXNlZCBleGFjdCB0aGUgc2FtZSB3YXkgYXMgY29kZWNfZGFpIGV4Y2VwdCBm
b3IgcnVudGltZQpwb2ludGVyIGFzc2lnbm1lbnQgaW4gc29jX3BjbV9vcGVuIGFzIGkgbWVudGlv
bmVkIGFscmVhZHkuCgo+PiBnb2luZyB0byB3b3JrIGFzIHN1Y2ggYmVjYXVzZSBvZiBjcHVfZGFp
LT5ydW50aW1lID0gcnVudGltZSBkb25lCj4+IGluIHNvY19wY21fb3Blbi4KPj4gTHVja2lseSBm
b3IgY29kZWNfZGFpLCB3ZSBjYW4gdXNlIHRoZSBzYW1lIGluIG1vcmUgdGhhbiBvbmUgZGFpX2xp
bmsuCj4KPiBSaWdodCwgT0sgLSBDUFUgREFJcyBkb24ndCBjb21lIHVwIHNvIG11Y2ggc28gSSd2
ZSBub3Qgbm90aWNlZCB0aGF0LgpUaG91Z2gsIGZyb20gd2hhdCBJIGhhdmUgc2VlbiwgZXhjZXB0
IGF0bWVsLXBjbS5jLCBubyBkcml2ZXIgcmVhZHMKc25kX3BjbV9ydW50aW1lIGZyb20gdGhlIGNw
dV9kYWkuIEFuZCBhdG1lbC1wY20uYyBjYW4gYmUgZWFzaWx5Cm1vZGlmaWVkIHRvIGFjY29tbW9k
YXRlIGFueSBjaGFuZ2UuClNvLCBpdCBzZWVtcywgdGhlIG1lbWJlciAnc3RydWN0IHNuZF9wY21f
cnVudGltZSAqJyAgb2YgJ3N0cnVjdCBzbmRfc29jX2RhaScKaXMgbW9zdGx5IHVudXNlZC4gV2Ug
Y2FuIGVhc2lseSBtb3ZlIGl0IHRvICdzdHJ1Y3Qgc25kX3NvY19kYWlfbGluaycgb3IKZXZlbiBk
cm9wIGl0IGFsdG9nZXRoZXIgdG8gcmVkdWNlIHJlZHVuZGFuY3koSSBwcmVmZXIpLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxp
bmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1w
cm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
