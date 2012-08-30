From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/22] ASoC: Ux500: Move MSP pinctrl setup
 into the MSP driver
Date: Thu, 30 Aug 2012 14:18:08 +0100
Message-ID: <20120830131807.GI14145@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
 <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
 <20120820115914.GP8450@gmail.com>
 <CACRpkdZse9Nq1acoAujV8ojhRKxykNX0ymcr51QAoanUbDW14g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C662C265D6B
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 15:18:12 +0200 (CEST)
Received: by eeke50 with SMTP id e50so618506eek.38
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 06:18:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdZse9Nq1acoAujV8ojhRKxykNX0ymcr51QAoanUbDW14g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Patrice CHOTARD <patrice.chotard@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBBdWcgMjcsIDIwMTIgYXQgMDQ6MDk6NDZQTSAtMDcwMCwgTGludXMgV2FsbGVpaiB3
cm90ZToKPiBPbiBNb24sIEF1ZyAyMCwgMjAxMiBhdCA0OjU5IEFNLCBMZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPiB3cm90ZToKPiA+IE9uIFR1ZSwgQXVnIDE0LCAyMDEyIGF0IDEwOjUx
OjAyQU0gKzAyMDAsIExpbnVzIFdhbGxlaWogd3JvdGU6Cj4gCj4gPj4gQnV0IHdhaXQuIFRoZXNl
IGFyZSBqdXN0IGxvY2FsIHN0YXRpY3MuIFN1cmVsdHkgeW91IGNhbiBwdXQgdGhlc2UgaW50bwo+
ID4+IHN0cnVjdCB1eDUwMF9tc3AgaW5zdGVhZD8gSGVyZSBpdCBsb29rcyBsaWtlIHRoZXNlIHdp
bGwgYmUgdXNlZCBmb3IKPiA+PiBhbGwgcG9ydHMsIHNvIE1TUDIgd2lsbCBlbmFibGUgdGhlIHBp
bnMgcmVxdWVzdGVkIGJ5IE1TUDEgZXRjCj4gPj4gY29tcGxldGVseSBicm9rZW4uIFNvIHB1dCBp
dCBpbnRvIHRoZSBzdHJ1Y3QgdXg1MDBfbXNwIHN0YXRlCj4gPj4gY29udGFpbmVyIGZyb20gdXg1
MDBfbXNwX2kycy5oIHdoZXJlIGl0IGJlbG9uZ3MuCj4gPj4KPiA+PiBSZWZlciB0byBkcml2ZXJz
L3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jIHdoZW4gaW4gdHJvdWJsZS4gVGhpcwo+ID4+IG9uZSBp
cyBhIGdvb2QgcGluY3RybCBleGFtcGxlLgo+ID4KPiA+IEhvdyBkbyB5b3Ugc2VlIHRoZSBNU1Ax
IGFuZCBNU1AzIHVzYWdlIHByb3RlY3Rpb24gd29ya2luZyBpZiBJIGhpZGUgaXQKPiA+IGFsbCBh
d2F5IGluIE1TUCBzcGVjaWZpYyBzdHJ1Y3RzPwo+IAo+IFVzYWdlIHByb3RlY3Rpb24/IFNvcnJ5
IG5vdCBmb2xsb3dpbmcuIFBsZWFzZSBlbGFib3JhdGUuLi4KCkRvbid0IHdvcnJ5IGFib3V0IGl0
LCBJIHRoaW5rIEkgc29ydGVkIGl0LgoKUGxlYXNlIHNlZSB0aGUgbGFzdGVzdCB2ZXJzaW9uIG9m
IHRoZSBwYXRjaCAoc2VudCBvbiAyNHRoIEF1ZykuCgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVC1F
cmljc3NvbiBMYW5kaW5nIFRlYW0gTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0
d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxv
ZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
