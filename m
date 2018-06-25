From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
 support
Date: Mon, 25 Jun 2018 13:50:59 +0200
Message-ID: <1529927459.2900.32.camel@baylibre.com>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk>
 <1529926289.2900.26.camel@baylibre.com>
 <20180625114445.GG9413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id E6CB72676D8
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 13:51:00 +0200 (CEST)
Received: by mail-wr0-f195.google.com with SMTP id w10-v6so13363283wrk.9
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 04:51:00 -0700 (PDT)
In-Reply-To: <20180625114445.GG9413@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCAyMDE4LTA2LTI1IGF0IDEyOjQ0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IE9u
IE1vbiwgSnVuIDI1LCAyMDE4IGF0IDAxOjMxOjI5UE0gKzAyMDAsIEplcm9tZSBCcnVuZXQgd3Jv
dGU6Cj4gCj4gPiBTYW1lIGNvbW1lbnQgYXMgb24gSVJDLCB5b3UgZHJpdmVyIGxvb2tzIHZlcnkg
c2ltaWxhciB0byB0aGUgb25lIEkgcG9zdGVkIGEKPiA+IHdoaWxlIGJhY2sgKHNvdW5kL3NvYy9j
b2RlY3MvZGlvMjEyNS5jKQo+ID4gQ291bGQgeW91IGp1c3QgYWRkIHlvdXIgY29tcGF0aWJsZSB0
byB0aGUgbGlzdCBpbiB0aGUgZXhpc3RpbmcgZHJpdmVyID8KPiA+IElzIHRoZXJlIGFueXRoaW5n
IEkgbWlzc2VkIHdoaWNoIG1ha2VzIHRoZW0gaW5jb21wYXRpYmxlID8KPiAKPiBJdCdzIHByb2Jh
Ymx5IGEgZ29vZCBpZGVhIHRvIHJlbmFtZSB0aGF0IGRyaXZlciBzbyBpdCdzIGEgYml0IG1vcmUK
PiBkaXNjb3ZlcmFibGUgLSB5b3UncmUgYWJzb2x1dGVseSByaWdodCB0aGF0IGl0J3MgdmVyeSBz
aW1pbGFyIGFuZCBkb2luZwo+IGJhc2ljYWxseSB0aGUgc2FtZSB0aGluZyBidXQgSSdkIGNvbXBs
ZXRlbHkgZm9yZ290dGVuIHRoYXQgaXQgZXhpc3RlZCA6LwoKQWdyZWVkICwgdGhlIG5hbWUgaXMg
cG9vcmx5IGNob3Nlbi4gSSBkaWQgbm90IHRob3VnaHQgaXQgd2FzIGEgZ2VuZXJpYyBuZWVkIGF0
CnRoZSB0aW1lLgoKTmljb2zDsiwgZG8geW91IHdhbnQgdG8gZG8gdGhlIHJlbWFtZSA/IG9yIHdv
dWxkIHlvdSBwcmVmZXIgbWUgdG8gZG8gaXQgPwoKQ2hlZXJzCkplcm9tZQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
